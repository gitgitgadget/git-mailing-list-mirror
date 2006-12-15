X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] git-show: grok blobs, trees and tags, too
Date: Fri, 15 Dec 2006 10:18:58 +0100
Message-ID: <8aa486160612150118y44744533t16af6d3086ac6b21@mail.gmail.com>
References: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 09:19:12 +0000 (UTC)
Cc: git@vger.kernel.org, junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dd9uckGWoZkrcw9ASR0+XicG4kYlbPMwJu+dKsRncV3W+ilRAQbq5Wt+i3lX5HdJBKbm5PXql6WVboX9H7+zZjjb2463eFgZ1HvXFsQDRk6XB9NQymXd7zwUfYgX03o4o6PrCUlGmvjWHZkMvTWLukVcWghSd2l5QhPJoOLVnYo=
In-Reply-To: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34483>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv9Dg-0004Sj-1h for gcvg-git@gmane.org; Fri, 15 Dec
 2006 10:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751346AbWLOJTA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 04:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWLOJS7
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 04:18:59 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:45325 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751346AbWLOJS6 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 04:18:58 -0500
Received: by wx-out-0506.google.com with SMTP id h27so642749wxd for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 01:18:58 -0800 (PST)
Received: by 10.70.50.18 with SMTP id x18mr616385wxx.1166174338373; Fri, 15
 Dec 2006 01:18:58 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Fri, 15 Dec 2006 01:18:58 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> Since git-show is pure Porcelain, it is the ideal candidate to
> pretty print other things than commits, too.

I think "git show ${tag}" should be more like "git show ${commit}",
that is, with the tagger and date information and the indent, as:

$ git show v1.4.4.2
tag v1.4.4.2
Tagger: Junio C Hamano <junkio@cox.net>
Date: ${Date}

    GIT 1.4.4.2
    -----BEGIN PGP SIGNATURE-----
    Version: GnuPG v1.4.5 (GNU/Linux)

    iD8DBQBFdx8+wMbZpPMRm5oRAsOXAJsGY8DIYey1TZlEXIGq5+8MNgEl1QCfQC0f
    c5SmdLmAm2KPsCf+bCuoK+k=
    =oDuA
    -----END PGP SIGNATURE-----
commit 49ed2bc4660c7cd0592cf21cc514080574d06320
...

>
> +EXAMPLES
> +--------
> +
> +git show v1.0.0::
> +       Shows the tag `v1.0.0`.

and the commit (or object) it references.

I would add:

git show v1.0.0^{}::
      Shows only the commit referenced by the tag `v1.0.0`.


