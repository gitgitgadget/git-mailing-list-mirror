From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Truncating and cleaning a imported git repositary to make it
 more usable
Date: Mon, 31 Mar 2008 08:17:38 +0200
Message-ID: <47F08202.9030206@viscovery.net>
References: <1206707716.9819.15.camel@malory>	 <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>	 <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com>	 <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com>	 <47ED204E.3020602@viscovery.net> <b2cdc9f30803290647n31bd6db5r4f346360989c2dcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 08:18:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgDLd-00053w-Fd
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 08:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYCaGRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 02:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbYCaGRm
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 02:17:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33922 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbYCaGRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 02:17:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JgDJx-0000X5-B1; Mon, 31 Mar 2008 08:16:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 55FB66B7; Mon, 31 Mar 2008 08:17:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <b2cdc9f30803290647n31bd6db5r4f346360989c2dcd@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78558>

Alex Bennee schrieb:
> Hmm thats odd. Despite having successfully run the filter my repo is
> still the same size. git-fsck --full shows loads of dangling commits
> but I'm guessing because the repo is packed they don't get dropped. Is
> it possible to repack the whole repo or do you have to manually unpack
> the packs and re-pack?

Yes. Run git repack -a -d -f or create a local clone using the file protocol:

   git clone file://$(pwd)/this that

(If you don't use the file protocol, git clone just hard-links the
repository, and you again don't get the reduced size.)

-- Hannes
