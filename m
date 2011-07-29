From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: refs/replace advice
Date: Fri, 29 Jul 2011 17:49:53 +0200
Message-ID: <4E32D6A1.8020304@viscovery.net>
References: <20110729153122.GA4535@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 17:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmpK7-0000dR-SD
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 17:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab1G2Pt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 11:49:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40444 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab1G2Pt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 11:49:57 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QmpJy-00071c-9u; Fri, 29 Jul 2011 17:49:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 09EF81660F;
	Fri, 29 Jul 2011 17:49:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <20110729153122.GA4535@padd.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178156>

Am 7/29/2011 17:31, schrieb Pete Wyckoff:
> I'm trying to use "git replace" to avoid cloning the entire set
> of duplicate commits across a slow inter-site link.  Like this:
> 
>     ...---A----B----C   site1/top
>                      \
>                       D---E---F  site1/proj
> 
>     ...---A'---B'---C'  site2/top
> 
> It is true that "git diff C C'" is empty:  they are identical.
...
> I thought maybe I could "git fetch --depth=N" where N would cover
> the range A'..site2/top, then replace.  But testing with "git
> fetch --depth=3" still wants to fetch 100k objects.

On site2, don't you want to 'git fetch --depth=N site1' such that F down
to at least C (but not much more) is fetched, and then apply the graft or
replacement on site2?

-- Hannes
