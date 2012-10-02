From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: erratic behavior commit --allow-empty
Date: Tue, 02 Oct 2012 10:26:06 +0200
Message-ID: <506AA51E.9010209@viscovery.net>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 10:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIxo9-0005Dg-K5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 10:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab2JBI0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 04:26:12 -0400
Received: from so.liwest.at ([212.33.55.24]:25859 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511Ab2JBI0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 04:26:11 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TIxnq-0000is-SC; Tue, 02 Oct 2012 10:26:06 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 988751660F;
	Tue,  2 Oct 2012 10:26:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206792>

Am 10/2/2012 9:51, schrieb Angelo Borsotti:
> This is the log of the second execution:
> 
> $ emptycommit
> + rm -rf local
> + mkdir local
> + cd local
> + git init
> Initialized empty Git repository in d:/gtest/local/.git/
> + echo aaa
> + git add f1
> warning: LF will be replaced by CRLF in f1.
> The file will have its original line endings in your working directory.
> + git commit -m A
> [master (root-commit) 1b86218] A
> warning: LF will be replaced by CRLF in f1.
> The file will have its original line endings in your working directory.
>  1 file changed, 1 insertion(+)
>  create mode 100644 f1
> + git checkout --orphan feature
> Switched to a new branch 'feature'
> + git commit -m A --allow-empty
> [feature (root-commit) 1b86218] A
> warning: LF will be replaced by CRLF in f1.
> The file will have its original line endings in your working directory.
>  1 file changed, 1 insertion(+)
>  create mode 100644 f1
> + git rev-list --all --pretty=oneline
> 1b8621851f6ae2943347da655661e9d5dc978208 A
> 
>>>>>> note that git commit -m A --allow-empty DOES NOT create a commit

Note that git commit -m A --allow-empty *DID* create a commit. Only, that
it received the same name (SHA1) as the commit you created before it
because it had the exact same contents (files, parents, author, committer,
and timestamps). Obviously, your script was executed sufficiently fast
that the two commits happend in the same second.

-- Hannes
