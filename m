From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] convert filter: supply path to external driver
Date: Mon, 20 Dec 2010 09:04:11 +0100
Message-ID: <4D0F0DFB.20502@viscovery.net>
References: <20101218223822.GA18902@arf.padd.com> <20101219212925.GA7393@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 09:04:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUajO-0003aN-8u
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 09:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab0LTIEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 03:04:25 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52455 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753912Ab0LTIEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 03:04:24 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PUaj5-0008N2-Gw; Mon, 20 Dec 2010 09:04:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5308B1660F;
	Mon, 20 Dec 2010 09:04:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20101219212925.GA7393@arf.padd.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163987>

Am 12/19/2010 22:29, schrieb Pete Wyckoff:
> Filtering to support keyword expansion may need the name of
> the file being filtered.  In particular, to support p4 keywords
> like
> 
>     $File: //depot/product/dir/script.sh $
> 
> the smudge filter needs to know the name of the file it is
> smudging.
> 
> Add a "%s" conversion specifier to the gitattribute for filter.
> It will be expanded with the path name to the file when invoking
> the external filter command.

What happens if there are any shell special characters in the path name
(or spaces, for that matter). Does this shell-escape the substituted path
name anywhere in the call chain?

-- Hannes
