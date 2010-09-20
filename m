From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git performance after directory copy
Date: Mon, 20 Sep 2010 11:45:45 +0200
Message-ID: <4C972D49.9040306@drmicha.warpmail.net>
References: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gaer, A." <Andreas.Gaer@baslerweb.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 11:45:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxcwT-00045y-Fe
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 11:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab0ITJpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 05:45:40 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59573 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756091Ab0ITJpj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 05:45:39 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BBF6F7B78;
	Mon, 20 Sep 2010 05:45:38 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 20 Sep 2010 05:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=wMw2QnMLsvsDaecrFZ/tYuUIX+Q=; b=dYDGw84bsMU5ZmHvTTGeKqkWBUnzTYu/k7L4UN96X5ZaoUCpMkw7dlWIF4XvMQm7yUhN0QWP/Bj8bSCuUIVjhDgzvhLCWtBfPwrNSw55L7e+T9CpqL9mWPVMUUDtqICxWHp/bJf72dgYh8r0drZuuNL11j3/tgY1Xr1fQxhtep4=
X-Sasl-enc: 2cnJGM2uvvO+f3BZCHNo/RovYwxhDLXSSGgXVuovUpOM 1284975938
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4529B403CC8;
	Mon, 20 Sep 2010 05:45:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156608>

Gaer, A. venit, vidit, dixit 20.09.2010 11:20:
> Hello all,
> 
> while moving a project directory around I stumbled over an interesting
> phenomenon. On a copied source directory "git status" seems to be about
> 3 times slower than on the original directory. Only after a "git reset"
> both copies behave the same again. Is this connected to the timestamps
> of files & directories? Actually I would like to move the project
> directories of several software developers to a new partition and
> forcing them all to "git reset" in all of their repos is a little bit
> annoying. Any suggestions how to "repair" the repos less intrusive?
> 

Since you clone from A to B, then copy from B several times, why don't
you clone from A several times instead?

If it's really about moving across file-system boundaries, then I don't
think there's a way around: you need to refresh the index with the
changed inodes information.

Michael
