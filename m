From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated
 logging	by
Date: Wed, 13 Aug 2008 08:41:53 +0200
Message-ID: <48A28231.6090105@op5.se>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl> <20080812212534.6871.19377.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 08:44:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTA5T-0007Vi-0A
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 08:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbYHMGmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 02:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbYHMGml
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 02:42:41 -0400
Received: from mail.op5.se ([193.201.96.20]:39644 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379AbYHMGml (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 02:42:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A771124B003D;
	Wed, 13 Aug 2008 08:45:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KBdkpilkT6Lh; Wed, 13 Aug 2008 08:45:52 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id E77AE24B0003;
	Wed, 13 Aug 2008 08:45:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080812212534.6871.19377.stgit@aristoteles.cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92181>

Stephen R. van den Berg wrote:
> +		/* Since stderr is set to linebuffered mode, the
> +		 * logging of different processes will not overlap
> +		 */
> +		fprintf(stderr, "[%d] ", (int)getpid());
> +		vfprintf(stderr, err, params);
> +		fputc('\n', stderr);

stderr is unbuffered. It's stdout that is linebuffered.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
