From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Fri, 20 Mar 2009 15:17:42 +0100
Message-ID: <81b0412b0903200717k5a9c3423m865961b7021c76f3@mail.gmail.com>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>
	 <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>
	 <20090319214001.GA6253@blimp.localdomain>
	 <alpine.DEB.1.00.0903200025170.10279@pacific.mpi-cbg.de>
	 <81b0412b0903200130s594ce3beyae21eb0b5cc8fe0@mail.gmail.com>
	 <alpine.DEB.1.00.0903201015270.10279@pacific.mpi-cbg.de>
	 <81b0412b0903200639v6d99067csb7715d9a5a3f0ba4@mail.gmail.com>
	 <49C39EFE.8040507@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 15:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkfZJ-0000pb-81
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 15:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbZCTORq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 10:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbZCTORq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 10:17:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:47984 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbZCTORp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 10:17:45 -0400
Received: by yw-out-2324.google.com with SMTP id 5so992115ywb.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i9rstbQugV1DKeu0HGywRXzo1fLI/qJqEdiNXAf8FKg=;
        b=MDRCdOD6lH86zT/3GfNxC/Rs1K7dSArK5QnhgjR2E1OPyqOwws2UBzs3R4GmiMwNZO
         NhOpGj8yZv1/BDj+90+ZVdxAnr6EWJ2hV67/MkxZL0NaKWjwBAa60JNgBAbLpOoOrAaf
         7k2Fe3AxH8c18nLq3TLZSzyvsiGa6vkxYelRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DZmNNSZwE5mmhQTbQTcJM9YU07/VKZv53DTGuLXIH0uqKeSJ15E6Y4l50HFDLlaoZc
         +cXCEFlhglPpgrpJKHR98V3TSBQvsB5XFUcBe2V99OLqkQFcmSKVSm27gA3C3qEqYWqU
         MVLv8ED2RS4bjJYhGCIO1+hoQ2DiW7/bjiE64=
Received: by 10.100.141.5 with SMTP id o5mr3723484and.85.1237558662507; Fri, 
	20 Mar 2009 07:17:42 -0700 (PDT)
In-Reply-To: <49C39EFE.8040507@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113961>

2009/3/20 Rogan Dawes <lists@dawes.za.net>:
> Alex Riesen wrote:
>> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>> On Fri, 20 Mar 2009, Alex Riesen wrote:
>>>
>>>> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>>>> Now, we _do_ have msysGit, you _do_ have shown the capability to =
fix
>>>>> issues when they arise, so I do _not_ see any obstacle why you sh=
ould
>>>>> not go msysGit, rather than staying with the pain of trying to st=
ay
>>>>> POSIX-compatible, but not quite all the time.
>>>> I understand. It is not pure POSIX compatibility I seek. I just ca=
n't
>>>> use MinGW port, because I absolutely must use the cygwin environme=
nt
>>>> (for "hysterical" reasons) and they don't play well together (trie=
d,
>>>> yes. Conflicting libraries, but you already know that).
>>> Maybe we can work on those conflicting libraries? =C2=A0After all, =
we do have a
>>> "rebase.exe" tool now (for all those as puzzled by the naming as I =
was:
>>> the rebase.exe tool can shift the memory range used by a .dll so th=
at it
>>> does not overlap with that one of another .dll).
>>
>> As long as they can be made to coexist I'm fine. Wasn't the problem
>> that MinGW/MSYS used cygwin1.dll if it were in PATH? Or was it
>> something else with their supporting libraries?
>>
>> My other problem is that the cygwin programs, and the worst of all -=
 a
>> proprietary compiler based on cygwin, must be in PATH. AFAIR, the
>> presence of cygwin in PATH broken shell scripting.
>
> How about a wrapper that fixes the PATH before exec'ing git? i.e.
> removes cygwin and the compiler.
>

=46or shame... I never tried :-/
