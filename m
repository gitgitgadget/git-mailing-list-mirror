From: "Ulrik Sverdrup" <ulrik.sverdrup@gmail.com>
Subject: Re: [PATCH] git-archive: ignore prefix when checking file attribute
Date: Thu, 10 Apr 2008 00:58:26 +0200
Message-ID: <a1b6cb1b0804091558r42b365cbjf216b3a5167588cf@mail.gmail.com>
References: <a1b6cb1b0804081435w24074d1aq177e8c1a5e1af0f8@mail.gmail.com>
	 <47FD31C3.8070001@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 10 00:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjjG4-0002OS-73
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 00:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbYDIW62 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 18:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbYDIW62
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 18:58:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:40861 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbYDIW62 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2008 18:58:28 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2509785fgb.17
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 15:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+GisrFtDAzbmq4zeUCS0m3a86IpNXHa4YK6YdtIggoY=;
        b=NmaKVGcXmdjcPtW4vg1yP0rN7ZnnMd/mpyV0APUL9jDxIGLLHQU1WuOdUHPYz1Rc8WT4iG1c22mx+alSURch911ZqmiY3d50QS3ds9kdyk+QnmBf1O4y9r/mZ+tGg6Xk0/zoxyYSf18GJReF53DYI21BRHTHeRnn4ANYj4JHveI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qEswwEIT3l2C0d3Pj1x9yyAiqySgX1nzJ8DzOD0RhuwYmIEpinUwuMw9TfR8tFw1hhFN+X8vs2HFl1xemlX5iAOuJnOSV/sE908Xutp08CpLloVfnSGIISR4KI8jhws3GXKY41xibTXlzxLs6cNvoe2nCPupjuZ05FSNubLxhoM=
Received: by 10.82.154.5 with SMTP id b5mr1179530bue.10.1207781906175;
        Wed, 09 Apr 2008 15:58:26 -0700 (PDT)
Received: by 10.82.116.11 with HTTP; Wed, 9 Apr 2008 15:58:26 -0700 (PDT)
In-Reply-To: <47FD31C3.8070001@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79146>

2008/4/9, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Ulrik Sverdrup noticed that git-archive doesn't correctly apply the a=
ttribute
>  export-subst when the option --prefix is given, too.
>
>  When it checked if a file has the attribute turned on, git-archive w=
ould try
>  to look up the full path -- including the prefix -- in .gitattribute=
s.  That's
>  wrong, as the prefix doesn't need to have any relation to any existi=
ng
>  directories, tracked or not.
>
>  This patch makes git-archive ignore the prefix when looking up if va=
lue of the
>  attribute export-subst for a file.
>
>  Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
>  ---
>  Ulrik, does this patch fix the problem for you?  It applies to v1.5.=
4.4 and
>  v1.5.5 equally.


Thanks for the patch Ren=E9!

=46irst I reproduced my problem on vanilla git v1.5.5, and it is still
there as in v.1.5.4.4.
I applied this patch and that fixed my issue, testing both tar and zip.

Ulrik Sverdrup
