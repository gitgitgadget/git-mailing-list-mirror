From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v2 2/3] Documentation: complete config list from other manpages
Date: Fri, 22 Oct 2010 08:19:24 +0200
Message-ID: <201010220819.25901.jnareb@gmail.com>
References: <cover.1287690696.git.trast@student.ethz.ch> <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:19:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Aya-0006S1-8J
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab0JVGTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 02:19:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46775 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab0JVGTd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:19:33 -0400
Received: by fxm16 with SMTP id 16so374316fxm.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IDyWu2846rH2M7lukuXOdQkbL890qr+0UI5uvyZr9u4=;
        b=XpDXPfjl+450K9+CvXj6P0JXy1R4bMyWK4lO3YvIgfYDMEECtNrncG8lM+bjr3OgRI
         pJvoXyKP2xkyb5zo9ClS6oJvjGhf7VqNymV8vC4WJMwzZSx9aTxb2GyymQa6hC2Lwj7t
         OUEHjNa5NS5k7qzNGRfeDV2qcdBmCfbOctgPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PEeUhZ/4DLpoRwp/39jAU94lI+qUjr8xqSE0ta2UkVYeV7m0q69slT3YzJ5k9ThReI
         cDlF7cjBxInzwEOZFvw1D18qn+mhzG53wJYfndUaNwYunER3SZGAFnxPrTHwwge6XNuR
         NYIdX+CE7CYsjpPAGZDomuA5eirSE4g8xNr3k=
Received: by 10.103.138.16 with SMTP id q16mr2667484mun.117.1287728372117;
        Thu, 21 Oct 2010 23:19:32 -0700 (PDT)
Received: from [192.168.1.13] (abwn200.neoplus.adsl.tpnet.pl [83.8.237.200])
        by mx.google.com with ESMTPS id y19sm1257688fau.17.2010.10.21.23.19.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:19:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159648>

Dnia pi=B1tek 22. pa=BCdziernika 2010 07:02, Thomas Rast napisa=B3:
> Add an autogeneration script that inserts links to other manpages
> describing config variables, as follows:
>=20
> * parse config-vars-src.txt (as it now needs to be renamed) to find
>   out its current contents
>=20
> * parse each manpage source (following includes) for config variable
>   headers (the blocks are ignored)
>=20
> * assemble a new config-vars.txt that completes the original list wit=
h
>   "See linkgit:git-foo[1]" entries for all variables that were not in
>   it.
>=20
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Documentation/Makefile              |    9 +-
>  Documentation/config-vars-src.txt   | 1747 +++++++++++++++++++++++++=
++++++++++
>  Documentation/config-vars.txt       | 1747 -------------------------=
----------
>  Documentation/make-config-list.perl |  131 +++
>  4 files changed, 1886 insertions(+), 1748 deletions(-)
>  create mode 100644 Documentation/config-vars-src.txt
>  delete mode 100644 Documentation/config-vars.txt
>  create mode 100755 Documentation/make-config-list.perl

Could you please resend this patch using rename detection=20
(git format-patch -M)?  It would make it clear what the difference
between config-vars and config-vars-src is, if any.

--=20
Jakub Narebski
Poland
