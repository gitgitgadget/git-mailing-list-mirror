From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Remove empty directories in recursive merge
Date: Fri, 26 Sep 2008 07:58:43 +0200
Message-ID: <48DC7A13.7000907@viscovery.net>
References: <87k5d1v71l.fsf@cup.kalibalik.dk> <20080925201245.GB3959@blimp.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 07:59:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj6Mv-0003WT-EG
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 07:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbYIZF6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 01:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbYIZF6s
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 01:58:48 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16904 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbYIZF6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 01:58:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kj6Lk-0000NE-Cz; Fri, 26 Sep 2008 07:58:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E22016B7; Fri, 26 Sep 2008 07:58:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080925201245.GB3959@blimp.localhost>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96828>

Alex Riesen schrieb:
> +test_expect_success 'merge removes empty directories' '
> +
> +	git reset --hard master &&
> +	git checkout -b rm &&
> +	git rm d/e &&
> +	git commit -mremoved-d/e &&
> +	git checkout master &&
> +	git merge -s recursive rm &&
> +	test_must_fail test -d d

FWIW, 'test_must_fail' is intended for git commands only. Here,

	! test -d d

would be just fine.

> +'
> +
>  test_done

-- Hannes
