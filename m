From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/72] gettextize: git-clone "Cloning into" message
Date: Mon, 21 Feb 2011 03:19:35 -0600
Message-ID: <20110221091921.GB23238@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-8-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 10:19:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrRvo-0008N1-Ve
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 10:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab1BUJTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 04:19:43 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57714 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab1BUJTn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 04:19:43 -0500
Received: by iwn8 with SMTP id 8so1681097iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 01:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RBDyd50XKEMkmcVDfjfuZ+nmCoFAzJjn8LPTPohNYz4=;
        b=tFOeJzDGR2TmX/u71VNm5blVMGyVhm9baPPmOKHeiD7gKz3pHwlLE0Wt+gVtqoHjfJ
         spBLma3/ox92RB76UswG1Syc2kMsTpjVwEkySrdpNCA/Dd0vDDbeO2kDgq9YheABeRWx
         f3wJ6VRzi3fex5GKfESZ5tewtWUAX/ckHS9hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xJq+mmoG6mmLuExQCl5Ad1D6j0jPX8oM/MgEfTSN/86sx/m/jEbgJAY3c949qdQ/2T
         Wn/gR6BesWbFRNZrkuz+VjkX+WLg4kJTQywbWabu2DY48+bY2sX2D6EkYiHyeyFuV+Oe
         EMHQiUZ2Zj8sNEvZe2IXxQRmZHWazuNG5UcWE=
Received: by 10.231.153.195 with SMTP id l3mr986948ibw.150.1298279982367;
        Mon, 21 Feb 2011 01:19:42 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id i16sm4985667ibl.12.2011.02.21.01.19.40
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 01:19:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298143495-3681-8-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167448>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -468,9 +468,12 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>  		die(_("could not create leading directories of '%s'"), git_dir);
>  	set_git_dir(make_absolute_path(git_dir));
> =20
> -	if (0 <=3D option_verbosity)
> -		printf("Cloning into %s%s...\n",
> -		       option_bare ? "bare repository " : "", dir);
> +	if (0 <=3D option_verbosity) {
> +		if (option_bare)
> +			printf(_("Cloning into bare repository %s\n"), dir);
> +		else
> +			printf(_("Cloning into %s\n"), dir);
> +	}

An ellipsis seems to have been lost.  I wonder if there is some easy
(automated, ideally) way to check these patches.
