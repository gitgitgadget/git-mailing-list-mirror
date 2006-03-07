From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Libify puzzle
Date: Tue, 7 Mar 2006 12:00:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603071151520.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Mar 07 12:00:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGZvM-0007CQ-3O
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 12:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbWCGLAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 06:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbWCGLAF
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 06:00:05 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:27604 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752140AbWCGLAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 06:00:04 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id DFF611415
	for <git@vger.kernel.org>; Tue,  7 Mar 2006 12:00:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id D13C25E03
	for <git@vger.kernel.org>; Tue,  7 Mar 2006 12:00:02 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B46681F3A
	for <git@vger.kernel.org>; Tue,  7 Mar 2006 12:00:02 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17332>

Hi,

I was just thinking a bit about teaching git-blame about renames, and hit 
a problem: When rev-list stops because none of the parents has the file of 
interest, the program should look if the parents contained a similar file 
which got deleted. But the commit's parents were explicitely culled!

The problem seems to affect more programs when we try to libify them: What 
used to be a pipe between two programs, can no longer just set 
save_commit_buffer = 0 in the first stage, since the second might depend 
on the buffer.

Would the correct solution be something like reparse_commit(commit)?

Ciao,
Dscho
