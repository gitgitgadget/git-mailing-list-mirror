From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Why can't git open empty branches ?
Date: Wed, 11 Apr 2012 16:16:37 +0200
Message-ID: <4F859245.908@ira.uka.de>
References: <4F855E6B.4010504@danisch.de> <20120411105906.GA19823@burratino> <4F8565BC.1070701@danisch.de> <vpq7gxmzf75.fsf@bauges.imag.fr> <4F856F67.4000609@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Hadmut Danisch <hadmut@danisch.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 16:15:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHyL0-0001hh-1w
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 16:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab2DKOPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 10:15:53 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35763 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752813Ab2DKOPx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 10:15:53 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SHyKo-0007yQ-JH; Wed, 11 Apr 2012 16:15:51 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SHyKn-00007l-OY; Wed, 11 Apr 2012 16:15:46 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4F856F67.4000609@danisch.de>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1334153751.569487000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195182>

Hi Hadmut ;-)

On 11.04.2012 13:47, Hadmut Danisch wrote:
> Creating independent branches by pushing two separates into a single
> remote bare is a nice idea, but if I understood git correctly, the very
> first commit in a repos is always to the master branch, where you have

AFAIK the only thing that makes master the initial branch is the file 
.git/HEAD that points to master after you "git init". This is not hardcoded.

 > So your proposal might work perfectly, but in my eyes it is error
 > prone and not user friendly.

Serious errors should not happen since the bare repo on the server is 
created with the flag denyNonFastForwards. So even if you had a master 
branch in both repos, only one of them, the first one, would succeed in 
pushing to the server, a push of the second one would give you an error 
message. Maybe not user friendly, but safe.
