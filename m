From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 18 Mar 2016 00:39:54 -0400
Message-ID: <CAPig+cQg2gYbr26X6PPQ6bobkxbufSSNtA1T94kdyEKQwHZXBw@mail.gmail.com>
References: <1458233370-8343-1-git-send-email-mehul.jain2029@gmail.com>
	<1458233370-8343-2-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQHbGAB=XCVWtC1MuubWUFc0tT-+ZGD+hW18whJP_U0_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 05:40:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agmCe-0000Gh-0W
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 05:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbcCREj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 00:39:57 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36029 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbcCREjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 00:39:55 -0400
Received: by mail-vk0-f67.google.com with SMTP id j65so8577109vkg.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 21:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=HHIShTrCiB6T7FtZ31etA7PwSglxxhB2gSLfxURwc1w=;
        b=XPsHBfjy1mGysdOUtWS0vdj6AO7gtzoMUtCrYBS9zdFyc6jVTCX2HmRxrdPxZuFNRV
         q0kmf/6kY6fb4XXk1cUmG+UuprGZLl6nTtK7JePSAfLJ2qEIkz0uTdCKb5PWrJfMswsh
         LO+XUBTgMqDzdlPbp6ZHsEIGMIhLaLL955pN2GiNgyt115QdXk8KytdqhKnKuER0L4gi
         jUWwT4LgZq1EpGJnMVPUVM4IWW3rRf8NYYrO0svW8a1XDUF2oYogXFojyAswJOfxyQj1
         KniYEI8Vof/+0hZKJpcZ2I/ku5nSvOuPFCpSPgYYZj13nGoCtd1EEs8V8lEd5IFPNuIn
         AcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HHIShTrCiB6T7FtZ31etA7PwSglxxhB2gSLfxURwc1w=;
        b=WtIOdIYGjuzIOrnEV4VCCMXYRx8ySNQINwoIHHoEZg3XO61rfelYMpeTL5nGStf0Le
         27x8XNqI/xqktxc/a+WVcPoh6sWMNakrCEw3abeLz/FS4z3Uh6kGAr1iA9Lmcx7Mo0E6
         wzw3mfAPe0FKwbBJjniOL0Jt4DNNtu7yGnKEUKa/jo/Sj27sj6gf96XKI5flPioI65X4
         0o6yvo+cEUwtLMvRRb3SZQADAJK5h8izEmyM7/ppQNOnpc+bpqaLGLxYq+I0t7+MO1pw
         BYBjosyi2uIFahyCwHk0/kzsHre6ZBAlyhXCIOlsYFbH0SvZDvcDjxZAuEFfleuQJZad
         5mRw==
X-Gm-Message-State: AD7BkJKgnZ0FNEdCLGZQe0C0ecNQWFySXJVma6Y5pVi0WB0Z6LxxR7mLG/Z++5sQoN30dc9AH3Tp6n1lCyriBw==
X-Received: by 10.31.47.135 with SMTP id v129mr15336241vkv.115.1458275994672;
 Thu, 17 Mar 2016 21:39:54 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 17 Mar 2016 21:39:54 -0700 (PDT)
In-Reply-To: <CAPig+cQHbGAB=XCVWtC1MuubWUFc0tT-+ZGD+hW18whJP_U0_Q@mail.gmail.com>
X-Google-Sender-Auth: Xqy0qzO5n5937WhASb7NbeNIj0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289184>

On Fri, Mar 18, 2016 at 12:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Mar 17, 2016 at 12:49 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
>> @@ -801,6 +804,7 @@ static int run_rebase(const unsigned char *curr_head,
>>         argv_array_pushv(&args, opt_strategy_opts.argv);
>>         if (opt_gpg_sign)
>>                 argv_array_push(&args, opt_gpg_sign);
>> +       argv_array_push(&args, opt_autostash ? "--autostash" : "--no-autostash");
>
> At this point, we know that opt_autostash can't be -1 (thus
> incorrectly triggering use of --autostash) because the conditional in
> cmd_pull() set it to the value of config_autostash (either 0 or 1) if
> the user did not specify it on the command-line. Okay. Makes sense.

Actually, this is going to pass --autostash or --no-autostash to
git-rebase unconditionally won't it? This seems kind of undesirable
due to the unnecessarily tight coupling it creates between the two
commands. I wasn't paying close attention to the earlier discussion,
but wasn't the idea that you should pass one of these two options
along to git-rebase only if the user explicitly asked to do by saying
so on the command line?

In other words:

* invoke "git-rebase --autostash" only if the user typed "git pull
--rebase --autostash"

* invoke "git-rebase --no-autostash" only if the user typed "git pull
--rebase --no-autostash"

* invoke "git rebase" if the user typed bare "git pull --rebase"
