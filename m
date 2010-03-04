From: jateeq <jawad_atiq@hotmail.com>
Subject: Re: How do I get the correct modification status after running git
 diff?
Date: Thu, 4 Mar 2010 08:11:13 -0800 (PST)
Message-ID: <27782895.post@talk.nabble.com>
References: <27782430.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 17:11:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnDe1-0007ro-Ly
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 17:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab0CDQLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 11:11:15 -0500
Received: from kuber.nabble.com ([216.139.236.158]:48907 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab0CDQLN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 11:11:13 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NnDdp-0006ke-3y
	for git@vger.kernel.org; Thu, 04 Mar 2010 08:11:13 -0800
In-Reply-To: <27782430.post@talk.nabble.com>
X-Nabble-From: jawad_atiq@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141531>


Ok, so I think I know what I was doing wrong... i wasn't comparing the
working tree with the last commit (HEAD), although I still don't know what
exactly I was comparing the working tree with. On reading the manual a
little more carefully, I realised the command should have been: 

git diff -M --name-status HEAD

This solves the problem of newly added files, but doesn't show 'R' for
renamed files even after I ask git to detect renamed files - just shows that
the renamed file was deleted (doesn't detect that the new renamed file was
added). So I would still appreciate some input here.

Renaming flie:
mv randomfile.xml random.xml

Diffing:
git diff -M --name-status HEAD

Output:
D      randomfile.xml

Thanks, 
jawad

-- 
View this message in context: http://old.nabble.com/How-do-I-get-the-correct-modification-status-after-running-git-diff--tp27782430p27782895.html
Sent from the git mailing list archive at Nabble.com.
