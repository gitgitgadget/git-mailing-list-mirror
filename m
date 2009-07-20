From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: how to reorder commits
Date: Mon, 20 Jul 2009 17:37:47 +0200
Message-ID: <adf1fd3d0907200837k63f21504v3d660f9503962fcf@mail.gmail.com>
References: <f46c52560907200807heed4bbfkde15cccd2ae8151d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSuw8-00077Z-Nf
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbZGTPht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 11:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbZGTPhs
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:37:48 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:3537 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZGTPhs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 11:37:48 -0400
Received: by an-out-0708.google.com with SMTP id d40so3711152and.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 08:37:47 -0700 (PDT)
Received: by 10.100.154.17 with SMTP id b17mr6230284ane.45.1248104267687; Mon, 
	20 Jul 2009 08:37:47 -0700 (PDT)
In-Reply-To: <f46c52560907200807heed4bbfkde15cccd2ae8151d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123617>

2009/7/20 Rustom Mody <rustompmody@gmail.com>:
> I have a sequence of commits. I tried to reorder the top two in this way.
> $ git rebase -i HEAD^^
>
> flip the two pick lines and exit vi
>
> I find my file full of conflict markers.

"git rebase" applies the changes between the commit and the parent,
and if the changes have conflicts this is what you get.

> So what is the way of doing:
> HEAD becomes current HEAD^
> HEAD^ becomes current HEAD

$ git branch old
$ git reset --hard HEAD~2
$ git read-tree old
$ git commit -C old
$ git read-tree old^
$ git commit -C old^

But normally you reorder "changes", not trees.

HTH,
Santi
