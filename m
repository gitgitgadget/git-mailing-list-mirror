From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Error: Unable to append to logs/HEAD: Permission denied
Date: Mon, 17 May 2010 15:35:57 +0200
Message-ID: <4BF1463D.9040408@drmicha.warpmail.net>
References: <1274051912050-5063068.post@n2.nabble.com> <4BF0F63A.1080005@drmicha.warpmail.net> <1274084247216-5064104.post@n2.nabble.com> <4BF10623.5000705@drmicha.warpmail.net> <1274094574729-5064574.post@n2.nabble.com> <4BF12B11.2090002@drmicha.warpmail.net> <1274098383422-5064764.post@n2.nabble.com> <4BF135D8.70106@drmicha.warpmail.net> <1274100503553-5064900.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git_user101 <m.aqadjanimemar@student.ru.nl>
X-From: git-owner@vger.kernel.org Mon May 17 15:36:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE0Ub-0001SD-Ac
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 15:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab0EQNgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 09:36:18 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43602 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755303Ab0EQNgR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 09:36:17 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2F93AF6427;
	Mon, 17 May 2010 09:35:51 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 17 May 2010 09:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=jaMIQsImHFx0H4gFfzRF9lCYj40=; b=ugzeXwRmdCQYDVDRhgOmNs3F22C2mdZO+immAMYGzuggilcv4I8eP+t69m3r/sPRhvazmamP7DAwfnQyCxQ8D0pr0DLR4K4jn3RNy6p4MnqeTnofvbfLDvUXBQOPghoi2Nb8OOO5IHQ3d0JZS8OfeJOc1hGYSJvxDMGy5G4U5QU=
X-Sasl-enc: NdABzf6hljw105s9fIfoex7jLjRETF486AQJReiXkcMa 1274103350
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7295F4D03F3;
	Mon, 17 May 2010 09:35:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1274100503553-5064900.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147236>

git_user101 venit, vidit, dixit 17.05.2010 14:48:
> 
> The push is succeed but I get this error every time. This is de complete
> message:
> 
> user@desktop:~/Documents/LRSystems$ git push 
> user@server's password: 
> Counting objects: 5, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 302 bytes, done.
> Total 3 (delta 2), reused 0 (delta 0)
> To ssh://user@server:port/repositories/LRSystems
>    1143c0..50b610  master -> master
> error: failed to push some refs to
> 'ssh://user@server:port/repositories/LRSystems'
> user@desktop:~/Documents/LRSystems$
> 
> As you can see the push is done but I get the error.

Is the repo on the server side in a good state? I.e., if you do

git status
git fsck
git show-ref

in the server side repo, is there something strange?
Another thing worth trying would be to

git clone --shared --mirror LRSystems LRSystems-new

and check whether pushing to that freshly set-up repo works.

Michael
