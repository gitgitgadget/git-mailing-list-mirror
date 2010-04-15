From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 10:49:19 +0200
Message-ID: <4BC6D30F.5020004@viscovery.net>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org> <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net> <7vochlkvtg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 10:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2KlP-00039P-Oq
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 10:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521Ab0DOItZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 04:49:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7990 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449Ab0DOItY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 04:49:24 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O2KlD-0002eq-Pg; Thu, 15 Apr 2010 10:49:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8575D1660F;
	Thu, 15 Apr 2010 10:49:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vochlkvtg.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144963>

Am 4/15/2010 9:40, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Does not help what? What is the problem?
> 
> You will lose the record from HEAD reflog that records the fact that you
> were at the tip of "next" less than "reflogexpire" but more than
> "reflogexpireunreachable" time ago, if you run "gc" while on "master".
> 
> Such a pruning does not have much to do with the real reason why
> expireunreachable would be a useful thing (namely, to prune failed
> histories that have been rewound away faster than the history that
> survived from reflog of individual branches).

But what is the benefit?

We expire reflogs so that we can garbage-collect objects. If
expire-unreachable is ignored for HEAD, then the objects of failed
experiments survive due to HEAD's reflog until reflog.expire is reached.
If this is what you want, why do we have expire-unreachable at all?

-- Hannes
