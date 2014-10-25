From: Henning Moll <newsScott@gmx.de>
Subject: flatten-merge history
Date: Sat, 25 Oct 2014 14:31:53 +0200
Message-ID: <544B9839.7000302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 25 20:53:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi6Sp-0002pg-SJ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 20:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbaJYSxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 14:53:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:62668 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbaJYSxT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 14:53:19 -0400
Received: from [192.168.178.33] ([88.217.115.1]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MWwp6-1XenWQ0FoS-00VuDH for <git@vger.kernel.org>;
 Sat, 25 Oct 2014 14:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:3PIx6NkRXnoC1rYAutmS3o0Uiyk/Dt5Bgs0l3+ieWpxtWUSWp42
 nIkAY7pfG5Kw+lYLTWOWshptNaM4n+0l5Su16yYf9XgT1SQYQ+en1CCJzw9cYF1rBaVLsJV
 gbiqTYdrGXwWGGr8KswbnrZEE0DRjXdIxbq3ZEPPGHWZ+X3L4kNrIlfXadGCUctW9e/GArc
 6OUWMd3bo/L2P0hwMawmw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

suppose the following history

     P - - - Q - - - - - R       <-extern

A -- - B - - - C - D - - - E   <-master
          \           \
           M ...       \         <-b1
                        \
                         W ...   <-b2


Note that master and extern do not have a common parent. Both histories 
are 'distinct', they do not share common files, so there can't be any 
merge conflicts. What i want to achieve is this history:

     P - - - Q - - - - - R       <-extern

A -P'- B'- Q'- C'- D'- R'- E'  <-master
          \           \
           M'...       \         <-b1
                        \
                         W'...   <-b2

The two histories should be merged in chronological order.
So while master reflects P-Q-R, b2 should only reflect P-Q and b1 should 
only reflect P.

All my current attempts (surgery with git replace or interactive rebase 
combined with merging) were not successfull.

Any ideas?

Best regards
Henning
