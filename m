From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fast-export: quote paths in output
Date: Fri, 05 Aug 2011 13:12:06 +0200
Message-ID: <4E3BD006.6010005@viscovery.net>
References: <20110805105526.GA22480@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Gregory <j.gregory@epigenesys.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 05 13:12:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpIKD-0002AQ-Kp
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 13:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab1HELMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 07:12:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22356 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751612Ab1HELMP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 07:12:15 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QpIJz-0004wI-Bn; Fri, 05 Aug 2011 13:12:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1956E1660F;
	Fri,  5 Aug 2011 13:12:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <20110805105526.GA22480@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178788>

Am 8/5/2011 12:55, schrieb Jeff King:
> +test_expect_success 'fast-export quotes pathnames' '
> +	git init crazy-paths &&
> +	(cd crazy-paths &&
> +	 >"$(printf "path with\\nnewline")" &&
> +	 >"path with \"quote\"" &&
> +	 >"path with \\backslash" &&
> +	 >"path with space" &&

Please construct the tree object using git-update-index's --cacheinfo or
--index-info rather than using actual files and git add so that the test
can pass on filesystems that do not allow newlines, quotes, or
backslashes(!) in filenames.

-- Hannes
-- 
"Atomic objects are neither active nor radioactive." --
Programming Languages -- C++, Final Committee Draft (Doc.N3092)
