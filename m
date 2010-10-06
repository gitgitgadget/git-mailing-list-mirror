From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Fetch by SHA missing
Date: Wed, 06 Oct 2010 08:02:52 +0200
Message-ID: <4CAC110C.2000804@viscovery.net>
References: <alpine.LNX.2.01.1010052136280.21719@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Wed Oct 06 08:03:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3N5i-0004HL-Hq
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 08:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757006Ab0JFGC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 02:02:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5725 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755474Ab0JFGC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 02:02:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P3N5Z-0004jG-Bg; Wed, 06 Oct 2010 08:02:53 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EB5B11660F;
	Wed,  6 Oct 2010 08:02:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <alpine.LNX.2.01.1010052136280.21719@obet.zrqbmnf.qr>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158267>

Am 10/5/2010 21:37, schrieb Jan Engelhardt:
> Hi,
> 
> 
> it is possible to select single heads/tags for download, but this does 
> not work with SHA IDs as of 1.7.1.
> 
> $ git fetch linus 3c06806e690885ce978ef180c8f8b6f8c17fb4b4:x
> fatal: Couldn't find remote ref 3c06806e690885ce978ef180c8f8b6f8c17fb4b4
> $ git fetch linus refs/heads/master
> remote: Counting objects: 1254, done.
> remote: Compressing objects: 100% (234/234), done.
> remote: Total 709 (delta 562), reused 602 (delta 475)
> Receiving objects: 100% (709/709), 112.41 KiB, done.
> Resolving deltas: 100% (562/562), completed with 212 local objects.
> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>  * branch            master     -> FETCH_HEAD

That's by design:

http://thread.gmane.org/gmane.comp.version-control.git/73368/focus=73994

That is, when you accidentally push secret data, you can rewind your refs
on the server. Even though the objects still live on the server (until
they are garbage-collected) nobody will be able to fetch your secret stuff
even if they happen to know the SHA1.
