From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Wed, 15 Aug 2007 18:47:58 +0200
Message-ID: <1b46aba20708150947g395895dfw5adf0aa308839321@mail.gmail.com>
References: <20070814164453.400b9c55@localhost>
	 <1b46aba20708150811o3a6fa14ew72e925c93d158ec4@mail.gmail.com>
	 <20070815131704.6cb76dbe@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:48:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILM2i-0001u5-Nq
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 18:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbXHOQsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 12:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753866AbXHOQsC
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 12:48:02 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:31535 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbXHOQsA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 12:48:00 -0400
Received: by nz-out-0506.google.com with SMTP id s18so804013nze
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 09:47:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mgUC68uEmbLAfnJL04XUBIMlTTNTTa4I0e2CuuoZEEjhKi1i4P+O5IEIQo0I5/IP5DuO4APK0G/UhzNpFT4QTQSBi80edEjHSZcCVXXqPcGfpZiZJ55fuSQ6p9aMPch0Mtg1kG/kzly8FJ8CROsbG/fqrsK9ORVTCiPmguxBuXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c/ctoJtuaYqCrAYolICoXAZsfjX/blm+GsrdEFD2gsxByIg1itZ7lGhegkwoQu7CU+DdLbkgDFKyHmmwdY/uEUF9evedQE0jFs3pPGX1erZ4UFGdqXd39OUUSQMpn7D9iEp8j+pnFiCNpRXZJcHwqAWA+SlL60PZYHwVBxXU4bU=
Received: by 10.114.38.2 with SMTP id l2mr241589wal.1187196478988;
        Wed, 15 Aug 2007 09:47:58 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Wed, 15 Aug 2007 09:47:58 -0700 (PDT)
In-Reply-To: <20070815131704.6cb76dbe@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55923>

2007/8/15, Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>:
>
>  Hi Carlos,
>
> Em Wed, 15 Aug 2007 17:11:02 +0200
> "Carlos Rica" <jasampler@gmail.com> escreveu:
>
> | 2007/8/14, Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>:
> | >
> | > This is a wrapper for mkstemp() that performs error checking and
> | > calls die() when an error occur.
> |
> | I think that it is related with the git_mkstemp() function in path.c.
>
>  Yeah, you right.
>
> | Perhaps we should use xmkstemp inside that function too, since
> | it is only used in diff.c and after the call it also dies when fd<0.
>
>  Actually, git_mkstemp() is also called by your builtin-verify-tag.c
> program and the function which calls it (run_gpg_verify()) doesn't
> die() on error.

Oh, yeah, I had an old version here. I even don't know if there is need
for verifying more than one tag in one command. When more than
one tag is verified, the return value says nothing about what tag or
tags failed, it is just the same as it would be if the program exited
on the first not verifiable tag, so perhaps it could do that.
