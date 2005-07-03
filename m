From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Mon, 4 Jul 2005 01:03:26 +0200
Message-ID: <20050703230326.GF18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 01:20:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpDlE-0008Ay-Jj
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 01:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVGCXUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 19:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGCXUI
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 19:20:08 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:55487 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261567AbVGCXT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 19:19:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id E665533ED3
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 01:19:57 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 27D1433E7D
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 01:19:56 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 130D74C33D
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 01:19:56 +0200 (CEST)
Received: (qmail 22485 invoked by uid 500); 3 Jul 2005 23:03:26 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050630152125.GO10850@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2005 at 05:21:25PM +0200, Matthias Urlichs wrote:
> Sven Verdoolaege:
> > Could you try to make the resulting repository compatible
> > with a repository generated with the old cvs2git ?
> > 
> I believe I did... at least it worked that way two days ago. ;-)
> 

I've found another difference.

On -p -z,60 -d :ext:anoncvs@savannah.gnu.org:/cvsroot/libtool libtool
on the gord branch,
the old cvs2git would create

[..]
commit 9d829ba90211956c53ebd40d2ba5daa454bedf03
tree e5aab59ed74c6e9fa1686dd914e2c7f7526f3bb6
parent 22acdc03db3de37ce19fac68babc1f2ec0011a42
author gord <gord> Tue, 01 Apr 1997 18:29:23 +0000
committer gord <gord> Tue, 01 Apr 1997 18:29:23 +0000

    *** empty log message ***

commit 22acdc03db3de37ce19fac68babc1f2ec0011a42
tree 4f8d0cc71683897d1332b485e59d164ff6a233c2
parent 27236f713eec57889949b0498cfaf446735b670d
author gord <gord> Tue, 01 Apr 1997 18:29:23 +0000
committer gord <gord> Tue, 01 Apr 1997 18:29:23 +0000


[..]
whereas your script creates:

[..]
commit f9450d4e45bdd760183383a4f698a70136e17f03
tree e5aab59ed74c6e9fa1686dd914e2c7f7526f3bb6
parent a8b919fa4784e5845f7cf61f53251804945c1b35
author gord <gord> Tue, 01 Apr 1997 18:29:23 +0000
committer gord <gord> Tue, 01 Apr 1997 18:29:23 +0000


commit a8b919fa4784e5845f7cf61f53251804945c1b35
tree b82881ae63c0cef645cd2d50050d2961d2c8871d
parent 27236f713eec57889949b0498cfaf446735b670d
author gord <gord> Tue, 01 Apr 1997 18:29:23 +0000
committer gord <gord> Tue, 01 Apr 1997 18:29:23 +0000

    *** empty log message ***

[..]

Note how the patchsets with the same date have somehow
been reversed.  Any ideas ?

I've also found another typo in your script; see my repo.

skimo
