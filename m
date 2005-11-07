From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: HTTP push
Date: Mon, 7 Nov 2005 03:35:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511070328230.25684@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 07 03:36:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYwrB-0005Ea-RR
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 03:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVKGCff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 21:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVKGCff
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 21:35:35 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11227 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932291AbVKGCfe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 21:35:34 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id B465D13EE45
	for <git@vger.kernel.org>; Mon,  7 Nov 2005 03:35:33 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9BB059F1B7
	for <git@vger.kernel.org>; Mon,  7 Nov 2005 03:35:33 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 8886492461
	for <git@vger.kernel.org>; Mon,  7 Nov 2005 03:35:33 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 6C15B13EE45
	for <git@vger.kernel.org>; Mon,  7 Nov 2005 03:35:33 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11249>

Hi,

I played a little with git-http-push. There are some strange things going 
on: whenever I commented out the calls to curl_multi_remove_handle() and 
curl_multi_cleanup(), all was well. Whenever I did not, there was either a 
segfault, or an endless loop.

Also, I had to update my curl, because http-push *absolutely* needs 
CURLOPT_HTTPGET. I tried to fake it with any combination of 
CURLOPT_{NOBODY,POST,PUT,UPLOAD}, but failed. (Yes, that means that you 
won't have to deal any longer with my patches to support older curl 
versions...)

Note: all my tests are from an iBook (client) to an Intel Linux (server).

I will run some tests on another client with valgrind (that will wait 
until tomorrow; it's 3.30am local time, so I head to bed).

Ciao,
Dscho
