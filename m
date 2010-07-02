From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Fri, 02 Jul 2010 07:49:43 +0200
Message-ID: <4C2D7DF7.8030408@viscovery.net>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de> <7vy6dx90uk.fsf@alter.siamese.dyndns.org> <4C2AE04E.9090901@viscovery.net> <7v1vbn417d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 07:49:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUZ8P-0006YD-10
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 07:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab0GBFtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 01:49:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:27836 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755012Ab0GBFts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 01:49:48 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OUZ8C-00040V-5b; Fri, 02 Jul 2010 07:49:44 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BE9341660F;
	Fri,  2 Jul 2010 07:49:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <7v1vbn417d.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150109>

Am 7/1/2010 18:27, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Would it be possible to update the timestamp of preimage every time it is
>> used (e.g., in rerere.c:merge()), and check for that?
> 
> It would be _possible_, but we are _not_ modifying the file at that point,
> so somehow that solution feels very wrong, no?

rr-cache is basically a static database. The fact that we have a file
named 'thisimage' is just an abuse - to put a temporary file somewhere.
Therefore, depending on lockfile infrastructure to change timestamps for
us while manipulating 'thisimage' should feel no less wrong, don't you
think so?

-- Hannes
