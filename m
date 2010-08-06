From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] prune: allow --dry-run for -n and --verbose for -v
Date: Fri, 6 Aug 2010 16:04:29 -0500
Message-ID: <20100806210429.GA6495@burratino>
References: <4C5C7055.3090100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Aug 06 23:06:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhU7B-0008Ke-MS
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880Ab0HFVGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 17:06:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43772 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964818Ab0HFVF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:05:58 -0400
Received: by iwn33 with SMTP id 33so1596954iwn.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hobijZcuwBQ96VkMLc5mlKK51h0+6X3u51O/w+3PC3Q=;
        b=q14j3fXPVzvVs74755K3KM/wA70C7cL75FNlw9qSB5A9jFDXW2tFcOwWnO+iuEgNNE
         xwEqN4yw81p8DR6Bb3xjLojkPls1Qlk3QKcaggum18s+0q8MtMCj/jRP6noTsLYLVBDs
         KTuYgCLW9U6QGHv7Fv9CZd7diQ6Nx6ww8X/W8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=amefA/IFI4jCOrmamluwT+ZaF+oL8xiexcuPR9pxaF9C17zxFghnwVGgQ9kfux08Ll
         n+t6GyNU8oG3Zbly3iYK6Xoy3Rtxy1JlME8pSWgCQW2bixzUsv++gnfIgMib/cV3g/Ff
         8XmLNnNtct7D0a7wmAdpt4WI5s8Sm2PelejUg=
Received: by 10.231.15.70 with SMTP id j6mr14269516iba.141.1281128757598;
        Fri, 06 Aug 2010 14:05:57 -0700 (PDT)
Received: from burratino ([66.99.1.133])
        by mx.google.com with ESMTPS id r3sm1538003ibk.13.2010.08.06.14.05.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 14:05:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C5C7055.3090100@lsrfire.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152811>

Ren=E9 Scharfe wrote:

> +++ b/builtin/prune.c
> @@ -125,10 +125,9 @@ int cmd_prune(int argc, const char **argv, const=
 char *prefix)
>  {
>  	struct rev_info revs;
>  	const struct option options[] =3D {
> -		OPT_BOOLEAN('n', NULL, &show_only,
> +		OPT_BOOLEAN('n', "dry-run", &show_only,

=46or the curious: avoiding OPT__DRY_RUN allows us to give a better
description:

>  			    "do not remove, show only"),

which makes sense to me.  Thanks.
