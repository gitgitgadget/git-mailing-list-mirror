From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to put tree into index
Date: Wed, 20 Nov 2013 13:41:10 +0100
Message-ID: <528CADE6.3020604@viscovery.net>
References: <20131120154714.39fc5202@snail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alexander GQ Gerasiov <gq@cs.msu.su>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 13:41:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj760-0005X4-K3
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 13:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab3KTMlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 07:41:15 -0500
Received: from so.liwest.at ([212.33.55.18]:2070 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab3KTMlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 07:41:14 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Vj75j-0006p3-Cm; Wed, 20 Nov 2013 13:41:11 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 22B5B16613;
	Wed, 20 Nov 2013 13:41:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131120154714.39fc5202@snail>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238077>

Am 11/20/2013 12:47, schrieb Alexander GQ Gerasiov:
> 1. I have repository with tree like this:
> 
> dir1/
> 	file1
> 	file2
> 	file3
> 
> dir2/
> 	subdir1/
> 		some files
> 
> 
> 2. Current branch is B.
> 
> 3. I want to get dir1 from branch A, and save it's content on current
> branch (B) as dir2/subdir1

> So my question is
> How to put into index tree-object with known sha1 and given name?

git rm -r --cached dir2/subdir1 &&
git read-tree --prefix=dir2/subdir1/ A:dir1

Note the trailing slash.

> PS I was able to do what I need when copied files, not tree-itself.
> Just add -r to git ls-tree, and put into index blobs/files, not tree.
> But I'm interested: is it possible to put tree-object into index?

No, because the index does not store trees, only blobs.

-- Hannes
