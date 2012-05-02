From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 06/10] archive-tar: stream large blobs to tar file
Date: Wed, 02 May 2012 16:34:17 +0200
Message-ID: <4FA145E9.9080808@lsrfire.ath.cx>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com> <1335965122-17458-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 16:34:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPadM-0008H6-SP
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab2EBOeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 10:34:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:58208 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460Ab2EBOeT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 10:34:19 -0400
Received: from [192.168.2.105] (p4FFD98FB.dip.t-dialin.net [79.253.152.251])
	by india601.server4you.de (Postfix) with ESMTPSA id C52D02F804F;
	Wed,  2 May 2012 16:34:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335965122-17458-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196826>

Am 02.05.2012 15:25, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 527c9e7..421c356 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -84,6 +84,13 @@ test_expect_success \
>       'git archive vs. git tar-tree' \
>       'test_cmp b.tar b2.tar'
>
> +test_expect_success 'git archive on large files' '
> +    git config core.bigfilethreshold 1 &&
> +    git archive HEAD >b3.tar &&
> +    git config --unset core.bigfilethreshold &&
> +    test_cmp b.tar b3.tar
> +'
> +
>   test_expect_success \
>       'git archive in a bare repo' \
>       '(cd bare.git&&  git archive HEAD) >b3.tar'

Nit: You could use test_config and wouldn't have to worry about=20
unsetting.  Or run "git -c core.bigfilethreshold=3D1 archive HEAD".

Ren=C3=A9
