From: Phil Sainty <psainty@orcon.net.nz>
Subject: Since 2.7.0 git branch displays symbolic references as ref -> ref
 instead of ref -> branch
Date: Sun, 3 Apr 2016 14:54:22 +1200
Message-ID: <570085DE.9000002@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 05:01:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amYIE-0006bC-J7
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 05:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbcDCDBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 23:01:34 -0400
Received: from mail.orcon.net.nz ([219.88.242.56]:59275 "EHLO
	mail.orcon.net.nz" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750819AbcDCDBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 23:01:33 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Apr 2016 23:01:33 EDT
Received: from [192.168.20.100] (host-203-94-61-82.xdsl.kinect.net.nz [203.94.61.82] (may be forged))
	(authenticated bits=0)
	by mail.orcon.net.nz (8.14.3/8.14.3/Debian-9.4) with ESMTP id u332sNB9030346
	for <git@vger.kernel.org>; Sun, 3 Apr 2016 14:54:24 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
X-Bayes-Prob: 0.0001 (Score 0: No Bayes scoring rules defined, tokens from: outbound)
X-Spam-Score: -1.71 () [Hold at 3.00] FREEMAIL_FROM:0.001,RDNS_NONE:1.274,TO_NO_BRKTS_NORDNS:0.001,T_TO_NO_BRKTS_FREEMAIL:0.01,CC(NZ:-3)
X-CanIt-Geo: ip=203.94.61.82; country=NZ; latitude=-41.0000; longitude=174.0000; http://maps.google.com/maps?q=-41.0000,174.0000&z=6
X-CanItPRO-Stream: base:outbound
X-Canit-Stats-ID: 01QBCSnC3 - 9305118c19a2 - 20160403 (trained as not-spam)
X-Scanned-By: CanIt (www . roaringpenguin . com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290622>

Given the following symbolic reference:

$ git symbolic-ref refs/heads/m refs/heads/master


Correct in 2.6.6:

$ PATH=~/git/git-2.6.6:$PATH git branch
   m -> master
* master


Wrong in 2.7.0:

$ PATH=~/git/git-2.7.0:$PATH git branch
   m -> m
* master


Still wrong in current version 2.8.0:

$ PATH=~/git/git-2.8.0:$PATH git branch
   m -> m
* master



As the new output isn't very useful, I assume this is an
unintentional bug/regression.

The 2.6.6 output has been used since at least version 1.7.12.4
(when I first started making use of this ability).


-Phil
