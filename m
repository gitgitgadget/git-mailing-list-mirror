From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] pack-objects: protect against disappearing packs
Date: Fri, 14 Oct 2011 16:35:23 +0200
Message-ID: <4E9848AB.3010802@viscovery.net>
References: <20111014012320.GA4395@sigill.intra.peff.net> <4E97DF63.104@viscovery.net> <20111014130703.GB7808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git-dev@github.com,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 16:35:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REirE-0000Qy-R6
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 16:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab1JNOf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 10:35:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59850 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216Ab1JNOf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 10:35:28 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1REir6-00074Y-FP; Fri, 14 Oct 2011 16:35:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1F2D51660F;
	Fri, 14 Oct 2011 16:35:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <20111014130703.GB7808@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183579>

Am 10/14/2011 15:07, schrieb Jeff King:
> Within a single process, I don't think so. This change impacts only
> pack-objects, which always runs as a separate process, and never deletes
> packs itself. The most likely problematic code path would be "git
> repack -d", but it waits for pack-objects to complete successfully
> before removing any packs.

Thanks. The test suite didn't find any issues on Windows.

-- Hannes
