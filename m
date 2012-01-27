From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Fri, 27 Jan 2012 08:27:16 +0100
Message-ID: <4F2251D4.9060005@viscovery.net>
References: <20120126073547.GA28689@sigill.intra.peff.net> <20120126074208.GD30474@sigill.intra.peff.net> <7vbopq2mk9.fsf@alter.siamese.dyndns.org> <20120126230054.GC12855@sigill.intra.peff.net> <7vsjj20yog.fsf@alter.siamese.dyndns.org> <20120127004902.GA15257@sigill.intra.peff.net> <7vd3a51zlb.fsf@alter.siamese.dyndns.org> <20120127054216.GA23633@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 08:27:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqgDe-0002Wv-JS
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 08:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab2A0H1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 02:27:23 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20027 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015Ab2A0H1W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 02:27:22 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RqgDN-0000VJ-8f; Fri, 27 Jan 2012 08:27:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 004AF1660F;
	Fri, 27 Jan 2012 08:27:16 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120127054216.GA23633@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189202>

Am 1/27/2012 6:42, schrieb Jeff King:
> That being said, I think it would be nicer for projects to carry meta
> information like this out-of-tree in a special ref. It's just simpler to
> work with, and it means the project's source isn't polluted with extra
> junk.

Really? I doubt that carrying configuration in a special ref outside the
normal contents will have any practical relevance:

To manage such a config file would mean to switch to a branch with
entirely different contents. But before you can test the new configuration
in action, you have to commit, switch branches, which exchanges the
worktree completely; and if the config change didn't work out, repeat the
process (and if we are talking about source code repository, this usally
includes a complete rebuild). Sure, you could keep the config branch in a
separate repository, but, again, how do you test an updated configuration?
It is not funny, and nobody will go this route.

Which raises doubts about the usefulness of the include.ref feature.

-- Hannes
