From: Teemu Likonen <tlikonen@iki.fi>
Subject: remote/clone bug: Stale tracking branch HEAD
Date: Sun, 16 Mar 2008 19:21:49 +0200
Message-ID: <200803161921.49274.tlikonen@iki.fi>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se> <1205604534.7589.20.camel@gentoo-jocke.transmode.se> <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 18:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JawZ5-0002um-Jb
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 18:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbYCPRVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 13:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbYCPRVw
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 13:21:52 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:46859 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750987AbYCPRVw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2008 13:21:52 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A0022B07A; Sun, 16 Mar 2008 18:21:50 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77367>

Junio C Hamano kirjoitti:

> We are going into 1.5.5-rc feature freeze tonight, and squashing
> these bugs now are of the highest priority.  Please keep the bug
> reports and fixes flowing.

I hope this bug won't find it's way to the release:

http://article.gmane.org/gmane.comp.version-control.git/77188


In short: After 'git clone' the command 'git remote show origin' shows a 
stale tracking branch HEAD:

  Stale tracking branch (use 'git remote prune')
      HEAD

'git remote prune origin' removes branch 'master'; you can see this 
with "git remote show origin":

  New remote branch (next fetch will store in remotes/origin)
      master

'git fetch' fetches 'master' again but the stale tracking branch HEAD 
appears again.
