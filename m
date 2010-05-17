From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitk (or tcl/tk) slow to start?
Date: Mon, 17 May 2010 13:51:02 +0200
Message-ID: <4BF12DA6.9090709@drmicha.warpmail.net>
References: <19441.8527.606063.296769@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon May 17 13:51:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODyqi-0006No-EL
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 13:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059Ab0EQLvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 07:51:01 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43551 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352Ab0EQLvA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 07:51:00 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0DA0CF7607;
	Mon, 17 May 2010 07:50:55 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 17 May 2010 07:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=W23yZ9nWBem0Hh1Tc/FEeOk9PJY=; b=ekEHvzIP9OZ2U/l+gt5mszt2M/Pk0kOq2EzV5Uw39XV4ue3TN3Cf47Z9Q8Nw9DvHJDQjsfRd2aj+Bad4NSl8adRUO1eJ1O03e2F670gRY+OiuzMI4Mc2g1ia3p4uoWVwtPpJAruuuDbDaFlbhFEG/JU3tpnZ+1Oj5g4mzcTBaOM=
X-Sasl-enc: dTDhCo1tmKI9V224mEtqA1eNgXsVLubYrj7LUny0E0Nu 1274097054
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 77E4A55BA9;
	Mon, 17 May 2010 07:50:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <19441.8527.606063.296769@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147227>

Eli Barzilay venit, vidit, dixit 17.05.2010 12:58:
> Every time I run gitk when I didn't use it for a while, it takes a
> long time to start (more than 30 seconds) with no visible cpu load.  I
> tried to strace it, and the result shows that the time is spent
> stat()ing my whole /usr/lib directory:
> 
>   ...
>   stat("/usr/lib/libelf-0.131.so", {st_mode=S_IFREG|0755, st_size=87496, ...}) = 0
>   stat("/usr/lib/libungif.so.4", {st_mode=S_IFREG|0755, st_size=2444, ...}) = 0
>   stat("/usr/lib/libtiff.so.3.8.2", {st_mode=S_IFREG|0755, st_size=360268, ...}) = 0
>   ...
> 
> Is this expected?  Anything that can be done to avoid it?

I don't expect stat'ing /usr/lib to take 30s. How large is it (file size
and count)?

> [This is using a new git version (1.7.1), but it's an old OS (Fedora
> 7), so maybe tcl/tk is buggy?]
> 

ver += 6 - epsilon ; /* :) */

Michael
