From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] typo DWIMery with alias broken (cd to random dir)
Date: Tue, 26 Jan 2016 19:50:41 +0700
Message-ID: <CACsJy8C2ucbGxM0pJUA84bk=_uJaD7TsRr+tDOjuMpHOmXTk+w@mail.gmail.com>
References: <56A72235.9080602@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 13:51:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO35Z-0003yJ-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 13:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965483AbcAZMvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 07:51:14 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33483 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964914AbcAZMvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 07:51:12 -0500
Received: by mail-lf0-f45.google.com with SMTP id m198so104225972lfm.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 04:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cQNvlMXxFM6tPUans4FNKTcXncVksda1uA5yLgMCpQQ=;
        b=PfUnZmQyev6O0nnKHMdrB3cBBFwOuLqXxIA/uzraHhkPBpKElLv+KwhRkgvNq7D0mb
         9OTh3kW8e2hWO+k9xv1kzCg4z3a4DBvx+PWe+/39yACNKdggcuRD9iD4NZQD4srFarF9
         G/clAN/KOkxIqtHx1NkGXDYF0bxMl4zthCcp8SkzfsYrotIp1PRBR4KANZpsQREkbPmG
         /3neFGG6UiKn9CNYc7xTR52qK5Bmn6Uts02A3xZP7QzQ/k471MYJMwjHYqNEK9eyc4Ce
         Be8gyj59P0v+se+ISCzVzzfjp3WFbMTLIIXHQ+OT07HVWlBSF0O1eTZi+8wVEw1gsfy3
         oKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=cQNvlMXxFM6tPUans4FNKTcXncVksda1uA5yLgMCpQQ=;
        b=Yajzg4Jnwbdlcx2m3FaYGYWxjqMw0to+jhz25pwQmbBsqV0lzs1185M2BtkebG6H7l
         WQPspl6d5NPqI/TYzTQ7HpxJyirw4gBlMUSGMo8vDMbdrE8CnX1DQsP0TUpDhlVo6ux4
         2HfYq88hfA5tbEv75Dor0zoo2VPiaTRx6DMEACSbKBQe0BVGtmCguGkcHk/+3ZQMRy5F
         9R0IdGPO7QOPK5ohboD5ILYx+1+wDv2/o6dXuL6Wdk6Tt+CViz104MxCW63HAOAAtp38
         ioLbjx06yL5BjWazsq3tz9zROCuiaP98bCZSB5MNywU1me1vpdXfzgXEGPx8leqLbZGv
         oYng==
X-Gm-Message-State: AG10YOTq2u5INxubIwzSSgcQpdXkJ31Zi9wkieWROyO+y9vkUeM2edBUMleh9acpk+3hlJu25LccTom1Ein4RQ==
X-Received: by 10.25.208.213 with SMTP id h204mr9058856lfg.112.1453812670778;
 Tue, 26 Jan 2016 04:51:10 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 26 Jan 2016 04:50:41 -0800 (PST)
In-Reply-To: <56A72235.9080602@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284810>

On Tue, Jan 26, 2016 at 2:37 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Hi there,
>
> with current next (989ee58 plus local additions) it seems that typo
> DWIMery with aliases is broken, see below.
>
> It appears that the typo DWIMery is broken only when there is a unique
> automatic DWIM substitution for a mistyped alias.
>
> I haven't bisected yet, but I suspect this to be related to recent
> changes regarding the environment in which commands/aliases are started
> (though this happens without extra work trees), so I'm cc'ing an expert
> in that area. Funny, though, that my user name shows up...
>
> I think the reason is that git.c's handle_alias() (or something else)
> calls restore_env() multiple times, and restore_env frees orig_cwd such
> that subsequent restore_env(0) with external_alias=0 tries to cd to a
> random location.
>
> I have no idea whether orig_cwd=0 after freeing or something else would
> be the proper fix.

I think the key is to reset saved_env_before_alias to zero in
restore_env(). With that flag remains set, the second save_env turns
no-op. orig_cwd should be reset too, but that's minor. It's working
for me. I'll send a patch later.
-- 
Duy
