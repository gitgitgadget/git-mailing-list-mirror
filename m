From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 14/14] wt-status.c: Initialise variable to suppress msvc warning
Date: Fri, 10 Dec 2010 16:05:13 +0100
Message-ID: <AANLkTikE34sk_bsAZSmq-9MaV-RE+GCJgNszm2o2qHGD@mail.gmail.com>
References: <4CFA92A2.4030801@ramsay1.demon.co.uk> <20101204205206.GB3170@burratino>
 <4D011D30.4070405@ramsay1.demon.co.uk> <7vmxoeg3wp.fsf@alter.siamese.dyndns.org>
 <AANLkTi=SzDhoQnLeKUvWe7A6r-7MT-DTLuDGLprqid9X@mail.gmail.com> <AANLkTinty08S2vT9ZSVQW03yL5uzrmqW7k_Ozad-q-E2@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 16:05:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR4XW-0002kW-Q2
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 16:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777Ab0LJPFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 10:05:36 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:60042 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762Ab0LJPFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 10:05:35 -0500
Received: by fxm18 with SMTP id 18so3833956fxm.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 07:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=meGHPbI2NltZGK6dyQrLb7YpWyYNEK1DEx/m3nOYRy0=;
        b=msfycPnYTVHMT55iSFYTPzV7y9dSIYj+M5lcCY389UA/mwAmEBPgnUMw84OpYGGL97
         YGdu8yxkoOgSfxrfU6xtFqJSVGmDRZtYzmxPUC2vjryXOHC7v4StP+N5EiEPEQU6no5C
         1kL61gK/fTncTaWNdb5yAoarsp4rbc69DGPPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=cThnZUejQwD+1npJi3lMGzGjpBL+vnNZ1gqr1V2KUJiHxyrQ2c2E95i7fcAYyVz1X3
         0sk1c2gIPdxxCvDfba1cqXPJ28cVe23sOreP40YKMbrCbs/WLZPKXmnJQvNtLh402d1O
         rOZMCAaYFVkOLVuhQr+a0E56kxjo1Bi5i0Fng=
Received: by 10.223.72.195 with SMTP id n3mr1012839faj.132.1291993533914; Fri,
 10 Dec 2010 07:05:33 -0800 (PST)
Received: by 10.223.95.202 with HTTP; Fri, 10 Dec 2010 07:05:13 -0800 (PST)
In-Reply-To: <AANLkTinty08S2vT9ZSVQW03yL5uzrmqW7k_Ozad-q-E2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163418>

On Fri, Dec 10, 2010 at 2:35 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Thu, Dec 9, 2010 at 20:46, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>
>> On Thu, Dec 9, 2010 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>>
>>>> Junio, could you please drop patches 5-14 from the series; the first four patches
>>>> are the important ones and I'd rather they didn't get held up. Thanks!
>>>
>>> Have these four patches been Acked by interested parties?
>>>
>>> I think I saw 1/N and 2/N acked by Erik and 4/N acked by SSchuberth and
>>> J6t, but any words on 3/N?
>>>
>>> Not that I deeply care nor have environment to test changes to [3/N], but
>>> I am wondering if these need conditional definition to futureproof (e.g.
>>> what happens when the header you are using the definition _I64_MIN from,
>>> or some other headers, started defining these constats?).
>>
>> I'm not sure if I follow this entirely. _I64_MIN is defined by
>> limits.h on Windows, and limits.h has a header-guard (or "#pragma
>> once" as Microsoft-code tends to prefer).
>>
>> Oh, right. You mean if someone else starts defining INTMAX_MAX etc? If
>> someone includes an stdint/inttypes-implementation while including
>> git-compat-util.h, we're going to have a boat-load of similar issues
>> anyway. I think guarding them is something that's better left to when
>> we encounter the problem (if ever).
>
> FYI: In contrast to previous versions, Visual Studio 2010 ships with a
> stdint.h header which defines INTMAX_MAX etc. However, that stdint.h
> is not included by limits.h (in fact, not by *any* other shipping
> header file, as it seems), so we should not run into any trouble even
> with VS2010.
>

Very interesting, thanks. Did you try to compile Git on VS2010? This
sounds like a reason for me to install VS2010 on one of my machines...
:)
