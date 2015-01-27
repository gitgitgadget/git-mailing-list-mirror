From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: t5539 broken under Mac OS X
Date: Tue, 27 Jan 2015 02:44:14 +0100
Message-ID: <CABPQNSYZMS+feX=jSxwOhr+P8isroct2=Dcw18LSjCYZUvug=A@mail.gmail.com>
References: <54B68D99.2040906@web.de> <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
 <54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net>
 <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com> <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
 <20150115222719.GA19021@peff.net> <xmqqa91j6537.fsf@gitster.dls.corp.google.com>
 <20150115235752.GB25120@peff.net> <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 02:45:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFvDC-00010X-Bs
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 02:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbbA0Bo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 20:44:58 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42058 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295AbbA0Boz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 20:44:55 -0500
Received: by mail-ie0-f173.google.com with SMTP id tr6so12468160ieb.4
        for <git@vger.kernel.org>; Mon, 26 Jan 2015 17:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kIKtxNDYVLAqmVlsXBjxzzE8T1YQssCDlQ4SlCgldDI=;
        b=p3OW/liUMNmTyIZ72JRqS0Xjy6PJ2/UM0XGfI7MmpcZP8fdZMWvLOTC2iU7NeHW55h
         Iq4E0rWAAq03sKR78gJJGXstcvYISHnZkC5+xfxdoBdm8rQU0hlLGC1TRemcMPsPN5e7
         TU9Slj2zUEsepSHvOI1J0Rm+Rx+651QnqvWXxO/YuVaQGBLPpkTEIs8EgkZyf5aMkmSa
         MSrJ/Ahe2zXZjAP0bmFsBRFtz8ZLVDIjy+GNF8z5Z4tZOyBqw+l8J3FbkrHM6mswvbkN
         L3Sw8tUlrV3zMWvdhQMxzwmkhRSnF8BbV4qV8E94hyLuquMxxrbzoL5KGzUHklWjuSwk
         xlNg==
X-Received: by 10.107.151.80 with SMTP id z77mr21551315iod.51.1422323095133;
 Mon, 26 Jan 2015 17:44:55 -0800 (PST)
Received: by 10.64.240.139 with HTTP; Mon, 26 Jan 2015 17:44:14 -0800 (PST)
In-Reply-To: <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263052>

On Fri, Jan 16, 2015 at 1:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Exactly. I am happy to submit a patch, but I cannot think of any
>> mechanisms besides:
>>
>>   1. Calling `id`, which I suspect is very not portable.
>>
>>   2. Writing a C program to check getuid(). That's portable for most
>>      Unixes. It looks like we already have a hacky wrapper on mingw that
>>      will always return "1".
>>
>> Is (2) too gross?
>
> Not overly gross compared to some existing test-*.c files, I would
> say.
>
> I wondered what 'perl -e 'print $>' would say in mingw, and if that
> is portable enough, though.

$ perl -e 'print $>'
500
