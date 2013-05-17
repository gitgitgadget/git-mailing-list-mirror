From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on
 Mac OS X
Date: Fri, 17 May 2013 10:20:13 -0700
Message-ID: <CAJDDKr6VmpF_11mmd5jJOWxHovhnUCmRG_LjN8wQemrPP9=Wdg@mail.gmail.com>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
	<CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
	<CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
	<7vbo891ra8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:20:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOKL-0004MK-0b
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362Ab3EQRUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:20:15 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46561 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336Ab3EQRUN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:20:13 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so3753383pab.41
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=dSVFLo61X1ot0sfQ8JW/DuMX9aoStxSqxHtVAMUqs8M=;
        b=TGVQz6BfAA9mhzgFdNtK+ayS2Bue95FQm+iFejpyiXMvFgCKCMy3X41wY988el5nx8
         pqwgyOztKy6fzgkqhAfMNT7x93VL85a0KEyPIVshpPsLXZ/0u1G0tUVf+uAAFnV4GCAV
         K/l0foI/dSF9avMFF/Iu3WAYUTt5e18t5E0d33PeyK7ghpuc7M3s9adq+Vyg6vfpfnWb
         g4Yv79Zoxm9PqCn08yJH7QW8Ms2NRYhwsYaswuSvm/AMPGQNhL9Y8OuuUS8C0KEAvh2+
         pThFZGpkJ7vjAeSLOSZpOE2Qr7YcTRM4T3IokqiqLbN14Ge6rvdECbZQ3xqYLvKrgchW
         kzMA==
X-Received: by 10.67.5.131 with SMTP id cm3mr48917723pad.80.1368811213119;
 Fri, 17 May 2013 10:20:13 -0700 (PDT)
Received: by 10.70.55.106 with HTTP; Fri, 17 May 2013 10:20:13 -0700 (PDT)
In-Reply-To: <7vbo891ra8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224713>

On Fri, May 17, 2013 at 9:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Do you have advice on how we should proceed?  :sigh: sorry for wasting
>> so much maintainer time on this series already.  If you need any
>> resends or anything please let me know.  This time I'll wait for a
>> strong opinion before firing off patches.
>>
>> My opinion: yeah, v5's ([NO_]APPLE_COMMON_CRYPTO) was probably where
>> we should have stopped painting.  Hindsight is 20/20.  Luckily it
>> never left "pu".
>
> I could do this easily:
>
>     $ git checkout da/darwin ;# b72ac20a6f73b
>     $ git format-patch --stdout -2 |
>       sed -e 's|COMMON_DIGEST_FOR_OPENSSL|APPLE_COMMON_CRYPTO|g' >P.mbox
>     $ git checkout HEAD^^ ;# 29de20504e
>     $ git am P.mbox
>     $ git diff da/darwin HEAD ;# sanity check
>     $ git log da/darwin.. ;# sanity check
>     $ git branch -f da/darwin
>
> if you nicely ask ;-)

gitster please ;-)

--
David
