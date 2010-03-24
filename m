From: Tim Mazid <timmazid@hotmail.com>
Subject: [BUG?] git stash pop results in conflict
Date: Wed, 24 Mar 2010 13:01:21 +1100
Message-ID: <SNT124-W41E7349234C70B82E8D6BFC4250@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 03:01:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuFuS-0006aD-7W
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 03:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab0CXCBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 22:01:23 -0400
Received: from snt0-omc3-s28.snt0.hotmail.com ([65.55.90.167]:12236 "EHLO
	snt0-omc3-s28.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751752Ab0CXCBW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 22:01:22 -0400
Received: from SNT124-W41 ([65.55.90.135]) by snt0-omc3-s28.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Mar 2010 19:01:21 -0700
X-Originating-IP: [211.30.173.126]
Importance: Normal
X-OriginalArrivalTime: 24 Mar 2010 02:01:21.0828 (UTC) FILETIME=[E69C4640:01CACAF5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143063>


Hi,
 
I'm not sure if this is a bug or if it should be thus.
 
Basically, a 'git stash --keep-index' followed immediately by a 'git stash pop' (no changes made) will result in a conflict.
 
Steps to reproduce:
 
 
Put
 
"AAA
BBB
CCC"
 
into file 'test'
 
$ git add test
$ git commit -m "A"
 
Append lines
 
"DDD
EEE
FFF
GGG"
 
into file 'test'
 
$ git add -p
 
Press 'e' and remove the "FFF" and "GGG" files from the patch, to stage only the "DDD" and "EEE" files.
 
$ git stash --keep-index
$ git stash pop
 
CONFLICT
 
 
I hope that's clear enough.
 
Cheers,
Tim. 		 	   		  
_________________________________________________________________
Link all your email accounts and social updates with Hotmail. Find out now.
http://windowslive.ninemsn.com.au/oneinbox?ocid=T162MSN05A0710G