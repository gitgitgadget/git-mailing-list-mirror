From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] cherry-pick/revert: transparently refresh index
Date: Mon, 1 Nov 2010 09:09:15 +0100
Message-ID: <201011010909.15198.j6t@kdbg.org>
References: <20101031174430.GA30236@arf.padd.com> <20101031195933.GA21240@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 09:09:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCpSJ-0003zI-Qj
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 09:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab0KAIJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 04:09:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:20529 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934Ab0KAIJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 04:09:20 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 93BEDA7EB7;
	Mon,  1 Nov 2010 09:09:15 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4D2AC19F5C0;
	Mon,  1 Nov 2010 09:09:15 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20101031195933.GA21240@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160469>

On Sonntag, 31. Oktober 2010, Jonathan Nieder wrote:
> +test_expect_success 'revert on stat-dirty working tree' '
> +	git clone . repo &&
> +	(
> +		cd repo &&
> +		git checkout initial
> +	) &&
> +	cp -R repo copy &&
> +	(
> +		cd copy &&
> +		git cherry-pick added
> +	)

On Windows, this doesn't test what it should test because we do not look at 
the inode number (currently). Please use test-chmtime to change stat 
information.

-- Hannes
