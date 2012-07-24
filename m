From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v3 5/7] i18n: am: mark more strings for translation
Date: Wed, 25 Jul 2012 07:00:02 +0800
Message-ID: <CANYiYbG==N8RAz0rWrgbxMOLPzX6P3WoaeiEdbGwVi0ab-XUHw@mail.gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
	<d3711733085d683d9a63cff6f615ef3114f2d3c0.1343112786.git.worldhello.net@gmail.com>
	<20120724181600.GH2939@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:00:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sto5M-0002DP-QV
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 01:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab2GXXAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 19:00:05 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41182 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab2GXXAD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 19:00:03 -0400
Received: by gglu4 with SMTP id u4so100455ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 16:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oM1yuENfqh/IhrO1EblgXuUPupmzi1+1i0fLVzHhn80=;
        b=WbNf3Kc5yLrVhYWqCBYvEuGtaAdEXyUjuDM5Gq5QPVwgQUCxA+tiFxk1pHGNUsZP//
         3y06HeV5TGiX7blCtaj3lfeFAroh0jkJM5QPcHhwXWh0nNR9LOEJyYtuGXQtdLaBh9MG
         qEMcmVxOVT/wyOV2NkjCpSkBdSWWmQx0GjAFL2Bz5jpwY4KQ2HjSxBshqBn9lJYO+uMe
         8lzmzZt+8sKrMfyoTwapKHSA3EE7pMxDQP0WIlU+5I5ubP8VdbAPIxFmP75JqPFxtPFJ
         JVwEkE0cV5xsTzx7Q4b50n5QEWVCmzUu2NonjIDdhFW8HDV6S3e5goQK05C90Z4qDNIZ
         kP2A==
Received: by 10.43.59.71 with SMTP id wn7mr19115361icb.0.1343170802579; Tue,
 24 Jul 2012 16:00:02 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Tue, 24 Jul 2012 16:00:02 -0700 (PDT)
In-Reply-To: <20120724181600.GH2939@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202082>

2012/7/25 Jonathan Nieder <jrnieder@gmail.com>:
>>       -b|--binary)
>> -             echo >&2 "The $1 option has been a no-op for long time, and"
>> -             echo >&2 "it will be removed. Please do not use it anymore."
>> +             echo >&2 $(gettext "The -b option has been a no-op for long time, and
>> +it will be removed. Please do not use it anymore.")
>
> ... that this changes the message when the --binary option is passed.
> Before this patch, it says
>
>         The --binary option has been a no-op for a long time, and ...
>
> After the patch, it says
>
>         The -b option has been a no-op for a long time, and ...
>
> Intentional?  That may be a good change or a bad one (I haven't
> thought clearly about it), but it seems at least worth mentioning.
> Cc-ing Thomas in case he has advice.

It's intentional.

 * First, if a variable in the message, we could not use gettext,
   for the variable will be expanded (evaluated) and never match
   the entry in po file.

 * Second, if there is a positional parameter ($1, $2,...) in the
   message, we could not use eval_gettext either. Because
   eval_gettext may be a wapper for gettext, and the positional
   parameter would loose it's original context.

-- 
Jiang Xin
