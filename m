From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC 0/2] Store remote information in .git/config
Date: Mon, 21 Nov 2005 14:52:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511211358440.13512@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 21 14:55:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeC6b-0003VP-Hi
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 14:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVKUNwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 08:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVKUNwr
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 08:52:47 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64654 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932075AbVKUNwq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 08:52:46 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id BCFAE14051C
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:52:45 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9CF25B371C
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:52:45 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id D9123B5293
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:52:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id ACCA41404FE
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 14:52:44 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12442>

Hi,

these two patches implement the migration of remote information into the 
config file. They need the patch I sent out earlier to allow hierarchical
section names (i.e. names containing dots). A config file can look like 
this:

	[remote.junio]
		url = http://www.kernel.org/pub/scm/git/git.git
		pull = master:junio
		pull = todo:todo
		pull = +pu:pu

The second patch makes git automatically migrate existing remote 
information into the config file.

Ciao,
Dscho
