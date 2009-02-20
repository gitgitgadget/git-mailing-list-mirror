From: Nayfe <nefethael@hotmail.com>
Subject: How to deliver dependant patches separatly ?
Date: Fri, 20 Feb 2009 04:58:50 -0800 (PST)
Message-ID: <22120045.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 14:00:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaUzM-0000hm-S8
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 14:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbZBTM6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 07:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbZBTM6v
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 07:58:51 -0500
Received: from kuber.nabble.com ([216.139.236.158]:46790 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbZBTM6u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 07:58:50 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LaUxu-0008Ln-1a
	for git@vger.kernel.org; Fri, 20 Feb 2009 04:58:50 -0800
X-Nabble-From: nefethael@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110840>


Hi, 
Let me explain my problem : 

I work for companyC. We work for companyB that works for companyA.
	CA ==> CB ==> CC

CA gives CB somes features to implement (fix, evolutions).
CB gives CC these features.
CC do the work then delivers to CB the patches.
Then CB decides to deliver or NOT the patches.

CA has a very long term integration workflow and want to select 
the patches they pay and not every patches made. 

CA --featX--> CB --featX--> CC
CA --featY--> CB --featY--> CC
              CB <--featX-- CC
              CB <--featY-- CC
CA <--featY-- CB
(featX not delivered)

The problem is when featX and featY are two dependant patches
and one patch is not delivered. 

In that case, we need to develop two independant patches in order 
to allow CA to switch between featX and featY.

But, CB is responsible for integration of patches for CA, and the person in
charge 
is not enough close to code to understand how to resolve merge conflicts.

CA and CB workflows can't be modified and they want us (CC) 
to give patches without merge conflicts problems.

The only solution we found is to create a branch for each feature (normal :)
) 
and a branch for every combinaisons : ( featX, featY, featZ, featXY, featXZ,
featYZ, featXYZ )
and the integrator just have to select the combinaison he wants.

I personnaly found that solution quite annoying, but can't find another
solution.
If you understood my problem, do you have a better solution (other than
leaving CC) ? ;)
thanks.
-- 
View this message in context: http://www.nabble.com/How-to-deliver-dependant-patches-separatly---tp22120045p22120045.html
Sent from the git mailing list archive at Nabble.com.
