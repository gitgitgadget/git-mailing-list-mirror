From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Error on git clone
Date: Wed, 06 Oct 2010 12:51:55 +0200
Message-ID: <4CAC54CB.5020208@viscovery.net>
References: <571212.33119.qm@web114615.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 12:52:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3RbQ-0007YT-Us
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 12:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996Ab0JFKv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 06:51:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20200 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752287Ab0JFKv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 06:51:58 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P3RbH-0006yR-IF; Wed, 06 Oct 2010 12:51:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 469BF1660F;
	Wed,  6 Oct 2010 12:51:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <571212.33119.qm@web114615.mail.gq1.yahoo.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158280>

Am 10/6/2010 12:34, schrieb Hocapito Cheteamo:
> $ git fetch
> Enter passphrase for key 'C:\.....\privateKey':
> remote: Counting objects: 478, done.
> remote: Compressing objects: 100% (303/303), done.
> Receiving objects: 100% (478/478), 96.57 MiB | 166 KiB/s, done.
> Resolving deltas: 100% (21/21), done.
> From github.com:XXX/YYY
>  * [new branch]      master     -> origin/master

Ok, download works as expected. You don't have to repeat these steps
anymore. Keep a copy of sss3\.git around so that you can go back to this
state when necessary.

> $ git checkout -b master origin/master
> Checking out files: 43%
> tagging': Invalid argumenttory at 'public/images/tagging

The error message is this one:

cannot create directory at '%s'

Do you have a file/directory with a CR in it? When you run this:

 git -p ls-tree -r origin/master

and look for public/images, do you see this:

"public/images/tagging\rtagging"

(including the double-quotes)? If so, ask your upstream to fix the
repository; you can't checkout the data as is on Windows.

Alternatively, you could use a sparse checkout that excludes the
questionable file. Read "Sparse checkout" in
http://www.kernel.org/pub/software/scm/git/docs/git-read-tree.html

-- Hannes
