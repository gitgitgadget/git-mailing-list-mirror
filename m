From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated commits
Date: Wed, 27 May 2015 13:41:10 -0400
Message-ID: <CAPig+cTTDtL+zkjU0iasN2+q=C0P8npEVOuyHBaUN4cFB4ibZQ@mail.gmail.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<CAPig+cQJMSjS=fiwMHE93efSsa2QYQ8TphyyfcLg7kAXRi_+cw@mail.gmail.com>
	<579982712.39028.1432732759119.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 19:41:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxfKO-0002Rk-Us
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 19:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbbE0RlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 13:41:12 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38471 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbE0RlL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 13:41:11 -0400
Received: by igbjd9 with SMTP id jd9so4679010igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CmpzdnXKIKBkoHfBmtiR4RahBJsR5FCX5U0whZLzJlY=;
        b=hirtHWY589hc6AQO40LE8nemWmJojo7/fvyYN6u7kEqOIPhrXMhcMOT+6dUcIg624S
         3TZ1IinGzil9siWmZT6yyZ2+9MZ2vEVCu04VowQnqsWOkP1YgRB1Mz8X4aBz+UEAivXT
         it0cyjaa6Xlc6M1eanQzVlDthxd5CeNUX6t+JWVMXkveMgQK1GGnuMe8PYUTSzrNV/r2
         XQpFh97JevcOAEakSVJLHWetdKOPhR/4j7Qil2yl/1tQD/HFZQH173g0RrooXKolmXWe
         iZULd1Tdvi1oqY+7VbySj7ZWPgjRAcsc7JDPIFKcPqsSs1U4RwrgwS3OMc0fVd4HWUkQ
         kD6g==
X-Received: by 10.50.66.234 with SMTP id i10mr5962058igt.22.1432748471024;
 Wed, 27 May 2015 10:41:11 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 27 May 2015 10:41:10 -0700 (PDT)
In-Reply-To: <579982712.39028.1432732759119.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: JJmfyZnFL3AHjA46kJ9u55o1R7c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270062>

On Wed, May 27, 2015 at 9:19 AM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Eric Sunshine<sunshine@sunshineco.com> writes:
>> > +       # To uppercase
>> > +       checkLevel=$(echo "$checkLevel" | tr '[:lower:]' '[:upper:]')
>>
>> Is there precedence elsewhere for recognizing uppercase and lowercase
>> variants of config values?
>
> It seems to be commonly used when parsing options in the C files
> through strcasecmp.  For exemple, in config.c:818 :
> if (!strcmp(var, "core.safecrlf")) {
>         if (value && !strcasecmp(value, "warn")) {
>                 [...]
> However we didn't see any precedence in shell files. Do you think we
> should remove it?

Precedence in C code is good enough for me, and it makes sense for
your new code to follow suit by being insensitive to case (as you have
already done).

However, it would be a good idea to be consistent in your use of
uppercase/lowercase in the commit message, documentation, and code,
rather than having a mix. I'd suggest sticking with lowercase
throughout since lowercase is more commonly used in the codebase (and
just easier to read).
