From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Thu, 26 Jan 2012 10:16:22 +0100
Message-ID: <4F2119E6.8010109@viscovery.net>
References: <20120126073547.GA28689@sigill.intra.peff.net> <20120126073752.GA30474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 10:16:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqLRh-00077X-1h
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 10:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab2AZJQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 04:16:30 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13309 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab2AZJQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 04:16:28 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RqLRP-0001ak-B5; Thu, 26 Jan 2012 10:16:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 126251660F;
	Thu, 26 Jan 2012 10:16:23 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120126073752.GA30474@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189146>

Am 1/26/2012 8:37, schrieb Jeff King:
> This patch introduces an include directive for config files.

Nice. I haven't had a need for it, yet, but the concept looks good.

> +test_expect_success 'recursive relative paths' '
> +	mkdir subdir &&
> +	echo "[test]three = 3" >subdir/three &&
> +	echo "[include]path = three" >subdir/two &&
> +	echo "[include]path = subdir/two" >base &&
> +	echo 3 >expect &&
> +	git config -f base test.three >actual &&
> +	test_cmp expect actual
> +'

Isn't it rather "chained relative paths"? Recursive would be if I write

  [include]path = .gitconfig

in my ~/.gitconfig. What happens in this case?

-- Hannes
