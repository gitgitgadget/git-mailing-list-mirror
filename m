From: Roberto Eduardo Decurnex Gorosito <decurnex.roberto@gmail.com>
Subject: Re: `git log relative_path_to_object` does not respect the
 --work-tree path
Date: Tue, 30 Sep 2014 09:42:15 -0300
Message-ID: <CABj5xzdXZRorQu=8CBiYFt058kVQVzfFXSYzXDYofFN06u4Hpw@mail.gmail.com>
References: <CABj5xzc0bVfyzR5PD5K3STSvdvWEOYeMkayB=GTfKbfij+G5Zw@mail.gmail.com>
 <20140929205612.GQ1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 14:42:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYwlN-0003J2-4r
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 14:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbaI3Mmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 08:42:37 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:47107 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaI3Mmg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 08:42:36 -0400
Received: by mail-la0-f48.google.com with SMTP id q1so8340056lam.21
        for <git@vger.kernel.org>; Tue, 30 Sep 2014 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uHX4kz7MtyXZCM9WPfqyMzcWA4XBwyovQNSAmvwk0bk=;
        b=kovfAfAYDvVxEPc4ZOdsQNhkxniowdurALaP25IA9Om/8IfoL1Aod+8ekvqHYeVSwo
         EHHmIfRYDiBXCOyt8OpaLkRjMg4moBmG53y4tBeaUySIHA6Ozr79BmX1DQv9C7Tgti65
         jVIeKWyyi0Orz656KaF2XZDE8KRkWFgiT2beAKu3zf9eGzfLkof1+hD3d7rYCHvSuzbl
         fnAYbACHP270VQtP6jh8kA6MArAL68I2PLzdrgBMLgQVThzJxa8t5p6MR/kVloelkVQ1
         EE/edwOIS06FSaIsrAnNa57agT5oZruVnQSZFcYAgPbo4EmltOUvz9LSOelWtmdcjcBr
         ke1A==
X-Received: by 10.152.36.37 with SMTP id n5mr10974550laj.93.1412080955366;
 Tue, 30 Sep 2014 05:42:35 -0700 (PDT)
Received: by 10.25.42.131 with HTTP; Tue, 30 Sep 2014 05:42:15 -0700 (PDT)
In-Reply-To: <20140929205612.GQ1175@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257667>

Ok. Yes, it 's kind of tricky. But the `-- <path>` does both things.

`-- <path>` looks for the relative path within the current directory
but defaults to the work-tree root if your current directory does not
belong to the repo.

About `git -C <dir>`, awesome feature, I love that, but it's not my
point. (and I'm actually maintaining the ruby-git gem, supporting git
>= 1.6 T_T)

I really appreciate your feedback.

Regards,
--
Roberto Decurnex

On Mon, Sep 29, 2014 at 5:56 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Roberto,
>
> Roberto Eduardo Decurnex Gorosito wrote:
>
>> When passing objects to the `git log`, by just naming them or using
>> the `--objects` option, relative paths are evaluated using the current
>> working directory instead of the current working tree path.
>
> Why should they be relative to the worktree root?  When you use
> relative paths within a worktree, they are not relative to the
> worktree root.  For example, the following works within a clone of
> git.git:
>
>         $ cd Documentation
>         $ git log git.txt
>
> You might be looking for 'git -C <directory>', which chdirs to the
> named directory so paths are relative to there.
>
> Hope that helps,
> Jonathan
