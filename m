From: Eric Raible <raible@gmail.com>
Subject: Re: [msysgit? bug] crlf double-conversion on win32
Date: Tue, 13 Oct 2009 22:17:53 +0000 (UTC)
Message-ID: <loom.20091014T001602-378@post.gmane.org>
References: <38cfaa83fdf80dec3a3d81ed3e0de0e2.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 00:40:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxq2A-0003bs-72
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 00:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933974AbZJMW1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 18:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbZJMW1O
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 18:27:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:46024 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402AbZJMW1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 18:27:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mxpmg-0007Jj-83
	for git@vger.kernel.org; Wed, 14 Oct 2009 00:23:58 +0200
Received: from adsl-63-197-71-184.dsl.snfc21.pacbell.net ([63.197.71.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 00:23:58 +0200
Received: from raible by adsl-63-197-71-184.dsl.snfc21.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 00:23:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.197.71.184 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.25 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130227>

Yann Dirson <y.dirson <at> e-sidor.com> writes:

> 
> With a msysgit 1.6.4 package, I got stuck after someone copied a CRLF file
> to a Linux box and committed it.
> 
> In that situation, the win32 client in autocrlf mode keeps telling that
> the files are locally modified, even after eg "git reset --hard".  Without
> touching the crlf setting (which I believe should not ever be necessary),
> this can be corrected by committing the faulty files after dos2unix'ing
> them, and using "git fetch && git reset --hard origin/master" ("git pull
> --rebase" refuses to do the job since it believes there are local
> changes).

See http://thread.gmane.org/gmane.comp.version-control.git/122823/focus=122862

In which Junio suggests:
$ rm .git/index
$ git reset --hard

in order to "restore sanity to your work tree"
