From: David <bouncingcats@gmail.com>
Subject: Re: interactive rebase results across shared histories
Date: Fri, 26 Feb 2016 23:38:38 +1100
Message-ID: <CAMPXz=on8ONkzDYWEEGFqqKhRoBb9zYBqmYDBsKWagdwFRPRdA@mail.gmail.com>
References: <87io1j6laz.fsf@gmail.com>
	<56C91D21.90306@moritzneeb.de>
	<87io1f5nsi.fsf@gmail.com>
	<56CCE3C2.1050608@moritzneeb.de>
	<87egc358ou.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Seb <spluque@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 13:39:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZHfi-0006bz-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 13:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbcBZMim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 07:38:42 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35837 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcBZMik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 07:38:40 -0500
Received: by mail-wm0-f42.google.com with SMTP id c200so70593904wme.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 04:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qx6ZHEtOmf+u/pBIQF2//g/1kt0nndxGTF+mde2Pg+4=;
        b=X/XjWOpj6hvm/n+8k2u8rpXTcj1A3hls1l2UWPsx72XBbESSRsbYytfdjBbiqO2g/f
         FkcwQXWoKhY2ynMNly59q68W/1ZMzIdX7Fudg4zHrLiwz+cBekMv/pcbY+xI0NYSl5uB
         XydhyfL1L/o0ABuv/pqgGXtE+hxJVf+aVC/+sAuluHiyJgFT+Wbm/ekYhmj+3qw+/kH5
         JcCpEul3AsTA4KlxDqRGJduDDXlmAxqwFT9ZLE3w8GCHQaCf2SZNTFf7mQ2hnGumLLJU
         w87OLAKx6IcU0yOBL36PxvKz4kVHOMP39VLXq0RySAgMZW7hsfkq2zc52Cp/844lSnju
         E8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qx6ZHEtOmf+u/pBIQF2//g/1kt0nndxGTF+mde2Pg+4=;
        b=fgsAfKwe3SSB3KA9qyR2CoEbNMfkteigpCC5V48+1m0v0Zb7c6hXZLZrtWKgscYJXt
         nOk6vFMdEhHR1eWaOrBphJkReseGT/qQratWG/IXm+764i41f0ne7RZIS/V82I5VqWU+
         hf1UwISSIVY0j3srjLBAWtFa2zgfJi2HYt/hkmju6UkF7BoXeDEPbr3N96Y2uQisRAkD
         Yn1rPvf8+vCIFJI4WwRTj40ek3eGWM981Wgg4bSiZHKeexYAMGRG6LJ3UDGfmrMB0omh
         sWaufLn66HMexFrt8A6T/2a3l/8Kfnq/JfzKJ9vYxfmvEHJzRvxZwjPuu9UYJlZbqV6/
         hPOQ==
X-Gm-Message-State: AD7BkJI5v/A5YfMa21ghfn4O3OdH97yQFpf8xxbCebfxD6TV6myAASQzFRpCj3qsCI5XvFrzUsb1ji8C1P4xZw==
X-Received: by 10.194.192.36 with SMTP id hd4mr1394650wjc.85.1456490318832;
 Fri, 26 Feb 2016 04:38:38 -0800 (PST)
Received: by 10.194.30.136 with HTTP; Fri, 26 Feb 2016 04:38:38 -0800 (PST)
In-Reply-To: <87egc358ou.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287574>

On 24 February 2016 at 10:05, Seb <spluque@gmail.com> wrote:
> On Tue, 23 Feb 2016 23:57:06 +0100,
> Moritz Neeb <lists@moritzneeb.de> wrote:
>
> [...]
>
>>> OK, I've followed this advice and looked at the dependency graphs in
>>> gitk before and after rebasing, I've managed to obtain what I was
>>> after.  The repository now has two branches: master and topic.
>>> However, Gitk reveals a problem with a string of commits that are not
>>> part of any branch:
>
>>> A---B---H---I (master) \ C---D---E (loose string of commits) \
>>> D'---E'---F---G (topic)
>
>>> How do I remove these loose commits (C, D, E)?
>
>
>> what you might be after is "git gc". But I never used it, it was not
>> neccesary for me. I would let the automatic garbage collection drop my
>> dangling commits. It's safer - who knows when you will still want to
>> restore your recent "loose string of commits".
>
>> How exactly are the loose commits causing trouble?
>
> Sure enough, these dangling commits were removed automatically without
> any intervention.  All is good.

This discussion could end there without problem. But if you want to
understand a little more thoroughly, read on ...

First, for basic git use, please stop being concerned about when or whether
dangling commits are removed or not. For basic git use, it is unimportant
(except for advanced use like disaster recovery).

By default, git waits a while (couple of weeks I think?) and then removes
dangling commits silently.

Why remove them? Because dangling commits are commits that git has
been instructed to forget about and discard, because no reference
(like a branch or tag) points to them.

And because they are unimportant, gitk chooses not to show them;
whenever you refresh or restart gitk, it won't show any dangling commits.

Why does git wait before discarding them entirely? Because advanced
users might want to do something clever with them.

So your dangling commits (after rebase) are probably not removed for a
couple of weeks. If you were to somehow recreate a reference to them,
then gitk will show them again. But otherwise it treats them as unworthy
of being shown.

So how did you ever see the dangling commits? I think it is because gitk
was aware of them because it had a reference to them before the rebase.
So if you keep gitk open it still shows them afterwards even though the
reference is gone. And if I recall correctly, if you refresh or restart gitk,
they will disappear from its display.
