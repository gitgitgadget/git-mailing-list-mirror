From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH] git-compat-util.h: use apparently more common __sgi macro 
	to detect SGI IRIX
Date: Wed, 2 Jun 2010 11:56:56 +0200
Message-ID: <AANLkTinvmNM_nKQnZNgQMWstrevG4RfcjW7RdCILVLYF@mail.gmail.com>
References: <20100514093838.421864000@mlists.thewrittenword.com>
	<4gJWLBIdRVtK7gq22o-LadCixyvOA-9FlEvk-ZrCHyUsGwArvR9oPkV-qlez-T-Nsn0v6UO633Y@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, drafnel@gmail.com,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	"Gary V. Vaughan" <gary@thewrittenword.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 02 11:57:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJkh6-000858-CV
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 11:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab0FBJ47 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 05:56:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40895 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab0FBJ46 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 05:56:58 -0400
Received: by fxm8 with SMTP id 8so1686194fxm.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=JF00JNx29wUp+XPhzOHkog332mvUUbjDbzREmVeuwNQ=;
        b=l5qX6QhdwukM3URiZOQl59zfSHDExbgWwvEuZSAZDdpsVOBbLBbvT+RyXbSvm5cs7K
         IsOu6BQdkyvxfLqqNfhVf6VAsZ3Lrb+bV0/m4DBUqXJl0Pmo0ose2+QLfDAaXFIb0XC2
         FrZ56gzGL3wCpCowhfwgF5355qWsOYxy8SyMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=jQiLE1ht6VlT5T3cbN3hPdSzaOaKYRebjL7hdCawLhWyBeITIX53yjMXgcXHF3Nuql
         L5+3nhwQDgTSbyR6hKs637TLXMZ5yHlrWBDQTn5dKF1w7fCVICPx+d4DFvNZXP1yQ8im
         PPyE5ZnrH0Vc6+5koDEK8I2EucqIvUGwxEyH8=
Received: by 10.239.132.65 with SMTP id 1mr580331hbq.25.1275472616868; Wed, 02 
	Jun 2010 02:56:56 -0700 (PDT)
Received: by 10.239.156.209 with HTTP; Wed, 2 Jun 2010 02:56:56 -0700 (PDT)
In-Reply-To: <4gJWLBIdRVtK7gq22o-LadCixyvOA-9FlEvk-ZrCHyUsGwArvR9oPkV-qlez-T-Nsn0v6UO633Y@cipher.nrlssc.navy.mil>
X-Google-Sender-Auth: tPAKSE0KfKAh9CC_efyBjLCs2E8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148238>

On Wed, Jun 2, 2010 at 03:55, Brandon Casey <casey@nrlssc.navy.mil> wro=
te:
> From: Gary V. Vaughan <git@mlists.thewrittenword.com>
>
> IRIX 6.5.26m does not define the 'sgi' macro, but it does define an '=
__sgi'
> macro. =A0Since later IRIX versions (6.5.29m) define both macros, and=
 since
> an underscore prefixed macro is preferred anyway, use '__sgi' to dete=
ct
> compilation on SGI IRIX.

Yes, __sgi is the one to use. It's been there on all the SGI systems
I've used, at least back to IRIX 5.3 (I don't recall for sure about
4.0.5 but my guess is yes). 'sgi' is often there too, also on IRIX 6.2
(with the old MIPS compiler), but on both 6.2 and 6.5 it goes away if
you use certain other options, e.g. -ansi. __sgi, on the other hand,
is always there - it doesn't depend on any other compiler options.

-Tor
