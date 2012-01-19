From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] Git bisect not finding the right commit
Date: Thu, 19 Jan 2012 09:23:01 +0100
Message-ID: <4F17D2E5.7000400@viscovery.net>
References: <87r4yw8j4i.fsf@franz.ak.mind.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andreas J. Koenig" <andreas.koenig.7os6VVqR@franz.ak.mind.de>
X-From: git-owner@vger.kernel.org Thu Jan 19 09:23:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnnH5-0000gK-Q6
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 09:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab2ASIXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 03:23:08 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55921 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab2ASIXG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 03:23:06 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RnnGw-0006E7-If; Thu, 19 Jan 2012 09:23:02 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3E47D1660F;
	Thu, 19 Jan 2012 09:23:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <87r4yw8j4i.fsf@franz.ak.mind.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188794>

Am 1/19/2012 4:29, schrieb Andreas J. Koenig:
> 	- A -> B      ->     C - D ->
> 	         \         /
> 	          - E - F -
> 
> A v5.15.5
> B v5.15.5-20-gfd76d40
> C v5.15.5-81-gcfe287a
> D v5.15.5-159-ga71d67b
> E v5.15.4-110-g27b29ec
> F v5.15.4-169-g3582575

I haven't looked at the actual history, but given the names of the commits
as produced by git-describe, I doubt that your history graph sketched
above is correct. Doesn't it look more like this:

      A -- B -- C -- D --
     /         /
 -- X -- E -- F

where X is v5.15.4?

To find a commit between A and B, you must declare F as "good".

-- Hannes
