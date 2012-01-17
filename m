From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix regression)
Date: Wed, 18 Jan 2012 01:04:12 +0200
Message-ID: <CAMP44s3GMGMD5Y9Z=Uu_e55_eZOG2zY76u8B=ORKsMx6yoXW5Q@mail.gmail.com>
References: <20120114152030.GX30469@goldbirke>
	<1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2nYMmfC36+pGaYfOZUQy3fLMYDuaSriPYjHBeApmsRVg@mail.gmail.com>
	<CAMP44s0T15idhwb6Eae5vdMxf25KK9MhY57mBf+BFN=OSC6Lhg@mail.gmail.com>
	<7vzkdmqebh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 00:04:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnI4h-0006sq-8c
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 00:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233Ab2AQXEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 18:04:14 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50699 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756213Ab2AQXEO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 18:04:14 -0500
Received: by lahc1 with SMTP id c1so1843959lah.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 15:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xc2aYeXPhWkHwa+a3dUeh8C2SvhVZQmoK34bCfl+4T0=;
        b=ghpL1tx1MIXFmT+rGuawE2US58UKtYN4DCJU4Wby3mHPoRCePkkqdOCxaj61xUcVUT
         2oamILBuDSerhX7x0vzy7/62dD9qXMkuPxP68oSsin/hupbfVe38eAgdYz8hjXVEetQn
         cbycfPcG4ygvT3JS00VQ0lv1LpR9bmLJxWv6M=
Received: by 10.152.103.169 with SMTP id fx9mr4648712lab.10.1326841452791;
 Tue, 17 Jan 2012 15:04:12 -0800 (PST)
Received: by 10.112.86.7 with HTTP; Tue, 17 Jan 2012 15:04:12 -0800 (PST)
In-Reply-To: <7vzkdmqebh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188726>

On Tue, Jan 17, 2012 at 10:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Jan 17, 2012 at 9:18 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Sat, Jan 14, 2012 at 8:55 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>>>> Commit a31e626 (completion: optimize refs completion) introduced a
>>>> regression for ZSH users: ref names were completed with a quoted trailing
>>>> space (i.e. "git checkout ma" completes to "git checkout master\ "). The
>>>> space is convenient for bash users since we use "-o nospace", but a
>>>> quoted space is worse than nothing. The absence of trailing space for ZSH
>>>> is a long-standing issue, that this patch is not fixing. We just fix the
>>>> regression by not appending a space when the shell is ZSH.
>>>
>>> I have this issue with the script from v1.7.8.3, and I think it
>>> started with a zsh update.
>>
>> Yeah, works fine with zsh 4.3.11, not 4.3.14 or 15.
>
> As I was planning to queue Matthieu's patch as-is as a regression fix
> before v1.7.9-rc2, I would appreciate if you can clarify this report a
> bit. Do you mean with the patch more recent versions of zsh still does not
> like the workaround and adds quoted space at the end?

I am saying I am seeing the issue (or at least the same symptom) even
before a31e626 with recent zsh versions. I will try a patched version
of the script and a31e626, but I'm guessing the result would be the
same.

-- 
Felipe Contreras
