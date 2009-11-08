From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 4/4] format-patch: Add "--no-stat" as a synonym for "-p"
Date: Sun, 08 Nov 2009 15:11:06 -0800
Message-ID: <1257721866.1734.47.camel@swboyd-laptop>
References: <4AF544DF.6070404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Bj=F6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 00:11:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Guk-0000gd-AY
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 00:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbZKHXLG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 18:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755647AbZKHXLG
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 18:11:06 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:44896 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634AbZKHXLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 18:11:05 -0500
Received: by ywh40 with SMTP id 40so2154310ywh.33
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=JeN7NNhUOdDZKVgDNr4UnKtf80B5+TDgAgS90zy2WIQ=;
        b=CCgab6TQeIEUyc7ojlv5Y1ChL1B74PthgmuivyUvZNrg0DW/eTAqqiQsUvo+evpbG+
         2S3Alfe1PV3UCSHBx5a1/rxJeH/Hgne98PsP1BZPBfXdWPj+VhxMsVA4i8iXnMMkccXM
         mNix4oehFlUW79Lp2i0Xev616yX+0Z3Y8S/A0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=hzTGkSLbB+YAdzlHeCBMYrX+HHBc+jn5hnkP0iTr3VZkul7VdHI6UjrZ+C1Y7HXnZp
         7/VE8wrygMeNHMbfqLidpGLhuXuaa6GPCBjiBww49MgujO1muH8AadHRrlBvrTEK2JxE
         IXOeKaKEk9NFaQNZEtaZqZPdsxQfBhn0PtP7Y=
Received: by 10.91.103.17 with SMTP id f17mr13232300agm.114.1257721870359;
        Sun, 08 Nov 2009 15:11:10 -0800 (PST)
Received: from ?192.168.0.195? (cpe-72-129-49-143.socal.res.rr.com [72.129.49.143])
        by mx.google.com with ESMTPS id 8sm975235yxb.7.2009.11.08.15.11.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 15:11:09 -0800 (PST)
In-Reply-To: <4AF544DF.6070404@gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132428>

On Sat, 2009-11-07 at 10:58 +0100, Bj=C3=B6rn Gustavsson wrote:
> diff --git a/builtin-log.c b/builtin-log.c
> index 9df8dac..968a038 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -925,7 +925,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
>  			"show patch format instead of default (patch + stat)"),
>  		OPT_BOOLEAN(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
>  			    "don't include a patch matching a commit upstream"),
> -		OPT_BOOLEAN('p', NULL, &use_patch_format,
> +		OPT_BOOLEAN('p', "no-stat", &use_patch_format,
>  			"show patch format instead of default (patch + stat)"),
>  		OPT_GROUP("Messaging"),
>  		{ OPTION_CALLBACK, 0, "add-header", NULL, "header",


I think this needs to have the OPT_NO_NEG flag so users can't say
--no-no-stat.
