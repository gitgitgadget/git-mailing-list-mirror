From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/4] notes: "add -c" refuses to open an editor with non-blobs
Date: Thu, 10 May 2012 17:26:36 +0200
Message-ID: <4FABDE2C.30406@viscovery.net>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com> <1336658701-9004-1-git-send-email-pclouds@gmail.com> <1336658701-9004-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 17:26:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSVGR-0003Ul-3V
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760099Ab2EJP0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 11:26:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31978 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759186Ab2EJP0m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 11:26:42 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SSVGv-00084d-7Y; Thu, 10 May 2012 17:27:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 191CF1660F;
	Thu, 10 May 2012 17:26:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1336658701-9004-3-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197583>

Am 5/10/2012 16:04, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> +test_expect_success 'non-blobs cannot be edited using editor' '
> +	EDITOR=3Dcat test_must_fail git notes add -f -c HEAD^{tree}

	(
		test_set_editor cat &&
		test_must_fail git notes add -f -c HEAD^{tree}
	)

Ditto in 3/4 and 4/4.

(The problem is not that test_set_editor must be used, but that VAR=3Dv=
alue
in front of a shell function invocation does not do what you want it to=
 do
unless your shell is buggy.)

> +'

-- Hannes
