From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] t5403.1: simplify commit creation
Date: Wed, 12 Oct 2011 16:14:23 +0200
Message-ID: <4E95A0BF.2060003@viscovery.net>
References: <1318412105-13595-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 16:14:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDzZp-0004yk-Ip
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 16:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267Ab1JLOO3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 10:14:29 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:23477 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab1JLOO2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 10:14:28 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RDzZg-00044a-CQ; Wed, 12 Oct 2011 16:14:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1BD9B1660F;
	Wed, 12 Oct 2011 16:14:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <1318412105-13595-1-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183368>

Am 10/12/2011 11:35, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>  test_expect_success setup '
>  	echo Data for commit0. >a &&
>  	echo Data for commit0. >b &&
> -	git update-index --add a &&
> -	git update-index --add b &&
> -	tree0=3D$(git write-tree) &&
> -	commit0=3D$(echo setup | git commit-tree $tree0) &&
> -	git update-ref refs/heads/master $commit0 &&
> +	git add a b &&
> +	git commit -m setup &&
>  	git clone ./. clone1 &&
>  	git clone ./. clone2 &&
>  	GIT_DIR=3Dclone2/.git git branch new2 &&

I don't think this change is necessary. It doesn't hurt to use plumbing
commands here and there in the test suite to exercise them to a degree
that they deserve.

-- Hannes
