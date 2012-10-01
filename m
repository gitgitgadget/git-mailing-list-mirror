From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: "submodule" mistake and a problem
Date: Mon, 01 Oct 2012 13:42:57 +0200
Message-ID: <506981C1.3030504@viscovery.net>
References: <CAHVO_92=5u-i+-d__5k7Uoq5pF4iACq9GuBSj4U5MepbKV_jdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howardsmiller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 13:43:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIeP4-0006bb-QY
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 13:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab2JALnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 07:43:04 -0400
Received: from so.liwest.at ([212.33.55.24]:50475 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab2JALnC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 07:43:02 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TIeOo-0001WP-NP; Mon, 01 Oct 2012 13:42:58 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7847F1660F;
	Mon,  1 Oct 2012 13:42:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAHVO_92=5u-i+-d__5k7Uoq5pF4iACq9GuBSj4U5MepbKV_jdA@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206729>

Am 10/1/2012 12:41, schrieb Howard Miller:
> - I have an existing (long standing) project in git with an upstream in github
> - I added a subdirectory which I had forgotten was itself a git
> project (i.e. it has its own .git directory)
> - I committed the subdirectory (git add /path/to/subdir;  git commit -m ....)
> - I pushed the latest version upstream
> 
> .....at this point I realised that only the directory name had been pushed. SO...
> 
> - git rm /path/to/subdir resulted in fatal: pathspec
> '/path/to/subdir/' did not match any files
> - so I deleted it manually, re-copied the directory and removed its
> ..git directory
> 
> ....I now cannot add or commit the directory. Git just ignores it. I
> have grepped and searched and kind find no reference to this directory
> anywhere. I am completely stumped.
> 
> Can anybody help? I don't want this to be a git subdirectory, I just
> want to be able to add the files (without the .git directory)

Perhaps:

  git rm -f --cached path/to/subdir   # remove from index, keep files
  git add path/to/subdir

-- Hannes
