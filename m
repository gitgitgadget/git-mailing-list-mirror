From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Thu, 5 May 2016 17:28:35 -0700
Message-ID: <CAGZ79kYB5-66tA5zoSpUTHVa-rdn551DXxVoiQ6KhOWadhAzLg@mail.gmail.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbmW5U+uFCnBhz4r2-ciGsWSwXHU5Va2r-MEca=iacfgQ@mail.gmail.com>
	<xmqqpot06oys.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 02:28:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayTdJ-0006cq-F1
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 02:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbcEFA2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 20:28:38 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33564 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbcEFA2h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 20:28:37 -0400
Received: by mail-ig0-f182.google.com with SMTP id c3so4871879igl.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 17:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GiupwtQmyWH9sXfmdyaK9kbC33iEq6BxH5rlQYLTsyo=;
        b=iHB4k2ExSiLqdtqtrC5QFI/OVqZDOZjxd3OJcPQVuVHRAFykCCtEN6nviNqKIi2mGJ
         /R3LBe0M45gTjb5zr//+b2Qlg8TyvSCDJddTA/RC2e2rdadnv38v9aXozF2zB9J/7beg
         0rOg/2XrF88w+XYiAW1h7ijSa46rL7cQgU3FCVkNPwKNlOweIeIJaoX1KR8G/kjlK5QD
         GcFJWGzwCsD4Ct/kYh1HhpjQ8FziMvLlBYIvGhl3F/khPbdI0T3RH4n2VjgXcaxpp23s
         85pPnZk1hY6YJhJNC2CgjWcRPd2QmAlXnNx63uvgV0jFaqsEOK+Vka8a4zb/Sb9UDI6b
         LzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GiupwtQmyWH9sXfmdyaK9kbC33iEq6BxH5rlQYLTsyo=;
        b=cAKcOOVjdnEMnbh+cFzG3sbBuw1GDAG6UtsiL6RzA7XhURxEFyA0igx8l+4889kTpc
         4ATydPM+3gvzMi9JLNqA4aZytlC0r/0F9ysAYqYfw/ZoLoHpv4N8klgbIxUfcV5OB4ps
         YdUfY3AzCZcuuAinXZfvTK3154wS1eqfUUZMZV+eeEPEOLTMLwELYT20QOSoA/kKXooO
         +F0hukqejk1imi9wpFamOanspKnwnTv4kSTtxmOffBg9NujJLGJwrMDKO+0pm4GXhcgA
         E9E7ZmUyX4cx3RH9XPflTJfOWw7fegJ4/5XNOYYqJ+Xouu2crdnKXexf7MsyXmEsnvCg
         VsSw==
X-Gm-Message-State: AOPr4FX1urOHa1SbNQcp84Ch8k2Oz/IxJA1AgZ5Ivq8PdpACxv7UKvOxVQS1TyuFGhXYp2vnlHmc35qoKWOvOaGQ
X-Received: by 10.50.250.165 with SMTP id zd5mr10269igc.85.1462494515621; Thu,
 05 May 2016 17:28:35 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 17:28:35 -0700 (PDT)
In-Reply-To: <xmqqpot06oys.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293731>

On Thu, May 5, 2016 at 4:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> That was my first reaction as well. However after a while of thought I actually
>> like that bug. Consider the possibilities how gitk/git-gui or other subsystems
>> can be developed. When accepting a patch for that you can either apply the
>> patch in the outer or inner repository, depending on what the sender used.
>>
>> I am not so sure if it is a bug plain and simple, but devolved into a
>> "feature" now.
>
> I'd freely admit that I have not considered its possible upsides at
> all.  When deep/in/ is an unrelated repository, and running either
>
>     git add deep/in/the
>     git add deep/in/the/tree

I think that doesn't work (I did not test), but the crucial part is to add
a trailing '/'. E.g.  `git add deep/in/the/` adds the 'the/**' tree of
the nested
repository.

>
> would add deep/in/the/tree/is-a-leaf.txt to my index, but if I did
>
>     git add deep/in
>
> I'd lose that and suddenly everything there turns into a submodule.

Yes.

    git add deep/in # adds a submodule

however:

    git add deep/in/ # adds all files of the sub-"repo"  as indpendent files
    git commit -a -m "new files"
    git -C deep/in reset --hard HEAD^
    git diff
    # shows a difference in deep/in/the/tree/is-a-leaf.txt

>
> And that is enough for me to declare that it is not worth my time to
> consider possible upside of that hole.  Can you tell offhand what
> would happen if you do "git add deep" (before adding deep/in as a
> submodule) without experimenting?
>

Not really. My expectation is to add everything *but* the deep/in/ repo
as this is not exercising the bug/feature.
