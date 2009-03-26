From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: Re: Question: Is it possible to host a writable git repo over both
 http and ssh?
Date: Wed, 25 Mar 2009 22:27:03 -0500
Message-ID: <49CAF607.1020905@gmail.com>
References: <49CA6A17.6050903@gmail.com> <20090326021259.GA5835@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 04:28:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmgGQ-0003kG-My
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbZCZD0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbZCZD0o
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:26:44 -0400
Received: from pp0.asolutions.com ([66.236.120.143]:44359 "EHLO
	pp0.asolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbZCZD0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:26:43 -0400
Received: from [192.168.132.157] (vpn-mikegaffney.asolutions.com [192.168.132.157])
	by pp0.asolutions.com (8.14.1/8.14.1) with ESMTP id n2Q3QcoG016945;
	Wed, 25 Mar 2009 22:26:38 -0500
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090326021259.GA5835@coredump.intra.peff.net>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7400:2.4.4,1.2.40,4.0.166 definitions=2009-03-26_01:2009-03-25,2009-03-25,2009-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0811170000 definitions=main-0903250186
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114713>

Does this go for JGit as well?

-Mike

Jeff King wrote:
> On Wed, Mar 25, 2009 at 12:29:59PM -0500, Mike Gaffney wrote:
> 
>> I am trying to setup a git repo internally at my work. I would like to  
>> make the repo accessable via https for both read and write so that we may 
>> access it from customer locations which don't allow anything but https. I 
>> would also like to host it via SSH because that protocol is much faster. I 
>> know that when you push with http it runs 'git update-server-info', would 
>> I have to make the ssh pushes do the same? Will this even work?
> 
> Yes, it should work just fine. All pushes, no matter how they arrive at
> the repository, will need to run "git update-server-info", which is what
> allows "dumb" protocols like http to read from the repository. The
> default post-update hook does this; you just need to enable it by "cd
> .git/hooks && mv post-update.sample post-update".
> 
> -Peff

-- 
-Mike Gaffney (http://rdocul.us)
