From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git ls-files handles paths differently in Windows and Mac
 (probably Linux)
Date: Tue, 12 Oct 2010 17:24:06 +0200
Message-ID: <AANLkTik39Rmjje67KeBYeJ6FkuOxp88e1nBPxXarBZf8@mail.gmail.com>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com>
	<AANLkTimB6s_yt6L59xpqsWO_yBsZxuVCiExFoSm9FcN1@mail.gmail.com>
	<C29949EA-5717-4BA3-936E-354FCB107877@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 17:24:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5gi5-0000AQ-H6
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 17:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367Ab0JLPYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 11:24:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45416 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315Ab0JLPYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 11:24:07 -0400
Received: by vws2 with SMTP id 2so1526327vws.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=LKJtU0K+JPob94a3b05RGU9lz1ZiOntRWLfQro+Gq2Y=;
        b=vp8mqbvsR0esiMlLCiGytQLDCVM81RpYBBb3nZxPfYVk5E7jxYkrvJgMHLqtLVF1Cs
         OYByGVukqOy6SSww+4+bHKXYmiSSE6uxhNxTEIlswTHNqbdwAnIOg4jvWNB5BVG8RpHY
         VCVMwF7rOtK0t5jKciLncfv2SpagIbw9XoTgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YqOPEgOiQUGS7cW/fTe+fergcXVbY16L63qaLqa5Xn/4mheJczuuISsKuX8+Q5z9fH
         sxq/hvQRuLby0ecNjUiGx9ffRoujCFHwfLcWxp+a+kvNWfUDNO9oVaM6TIjV3lUISN5G
         BZq3J2MbCCMZc4F1AdD5F4iRePtlOPZWDyuiQ=
Received: by 10.229.186.210 with SMTP id ct18mr6415715qcb.225.1286897046238;
 Tue, 12 Oct 2010 08:24:06 -0700 (PDT)
Received: by 10.229.87.212 with HTTP; Tue, 12 Oct 2010 08:24:06 -0700 (PDT)
In-Reply-To: <C29949EA-5717-4BA3-936E-354FCB107877@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158855>

On Tue, Oct 12, 2010 at 14:59, Kirill Likhodedov
<Kirill.Likhodedov@jetbrains.com> wrote:
>>> The behavior of ls-files is inconsistent in Windows and Mac.
>>>
>>> I want to see which files were changed in the specific directory of my working tree, so I call ls-files:
>>>> git ls-files -douvm --exclude-standard -- MYDIR
>>>
>>
>> Well, it is an... unconventional way to do that. May I suggest you consider
>> using "git diff --name-status" or just "git status" next time?
>
> My tests show that "git ls-files -douvm" is faster than "git diff --name-status".

I find it hard to believe (the tool was definitely not mean for this).

> "git status" doesn't fit, because it's porcelain (btw, git diff is also porcelain) and its output may change in time;

There is always "git diff-files", but I doubt the output of "git diff
--name-status" will change soon.
Besides, if you have to just check if the tree under a path is changed
you can always use
--exit-code or --quiet to "git diff", it will speed them up.
