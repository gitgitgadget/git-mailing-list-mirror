From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: weird fatal on push when post-receive hook exists but is empty
Date: Wed, 21 Apr 2010 11:28:18 +0200
Message-ID: <4BCEC532.5040807@viscovery.net>
References: <g2x2e24e5b91004200921mc5b0ffoc1c1ec2af25f71c@mail.gmail.com> <4BCEBB50.7020003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 11:28:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4WEO-00025b-9Z
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 11:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582Ab0DUJ2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 05:28:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44844 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab0DUJ2W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 05:28:22 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O4WEF-0003rh-7A; Wed, 21 Apr 2010 11:28:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E6CFB1660F;
	Wed, 21 Apr 2010 11:28:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BCEBB50.7020003@drmicha.warpmail.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145424>

Am 4/21/2010 10:46, schrieb Michael J Gruber:
> What are we doing differently?

Your box has a different scheduler. I doesn't run (or exit) the script
soon enough that the parent (receive-pack) can get SIGPIPE when it writes
refs to the script's stdin.

-- Hannes
