From: =?UTF-8?Q?mjucde?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Re:_Can_I_retrieve_changes_from_deleted_stash=3F?=
Date: Mon, 05 Oct 2009 14:50:40 +0200
Message-ID: <49b3d318.78c3c971.4ac9eba0.1181@o2.pl>
References: <c18a43e.55008170.4ac9e127.2a972@o2.pl> <200910051430.17559.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Thomas_Rast?= <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 05 14:53:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mun3k-0008Qr-8r
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 14:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbZJEMvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 08:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbZJEMvU
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 08:51:20 -0400
Received: from rekin26.go2.pl ([193.17.41.76]:34744 "EHLO rekin26.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550AbZJEMvT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 08:51:19 -0400
X-Greylist: delayed 2681 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2009 08:51:19 EDT
Received: from rekin26.go2.pl (rekin26.go2.pl [127.0.0.1])
	by rekin26.go2.pl (Postfix) with ESMTP id 3E37435D7BC;
	Mon,  5 Oct 2009 14:50:42 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.37])
	by rekin26.go2.pl (Postfix) with SMTP;
	Mon,  5 Oct 2009 14:50:41 +0200 (CEST)
In-Reply-To: <200910051430.17559.trast@student.ethz.ch>
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129559>

Thomas Rast <trast@student.ethz.ch> wrote:

> Daniel wrote:
> > I did:
> > 
> > $ git stash
> > $ git pop
> > 
> > $ git checkout -- <modified files>
> > 
> > Now I don't have changes I stashed. I guess the blobs with stashed
> > files should be somewhere?  Is there any way I can get back my changes?
> > I tried to use git-reflog, but I'm not sure how can I find the files
> > I need.
> 
> The problem is that the stash itself is a reflog, so there is no extra
> safety layer.
> 
> Recent versions of the git-stash(1) manpage[*] document a command that
> helps find the stashes: if you do not explicitly name them, the they
> will be called "WIP on <subject>" and can thus be found with
> 
>   git fsck --unreachable |
>   grep commit | cut -d\  -f3 |
>   xargs git log --merges --no-walk --grep=WIP
> 
> 
> [*] you can find a bleeding edge version at
> 
>   http://www.kernel.org/pub/software/scm/git/docs/git-stash.html
> 
> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch
> 

Thanks, that did the trick :)
