From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: Re: push fail
Date: Mon, 17 Mar 2014 13:34:24 +0000 (UTC)
Message-ID: <loom.20140317T142900-203@post.gmane.org>
References: <CAH_OBie+KrSjtqLinbv8sJAOCu26j8xVzBQJHdHTB44V07GsXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 14:35:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPXh2-00018i-UV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 14:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933481AbaCQNe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 09:34:56 -0400
Received: from plane.gmane.org ([80.91.229.3]:48891 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756489AbaCQNev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 09:34:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WPXgn-0000pH-BP
	for git@vger.kernel.org; Mon, 17 Mar 2014 14:34:49 +0100
Received: from nat-labs-cs.cs.pub.ro ([nat-labs-cs.cs.pub.ro])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 14:34:49 +0100
Received: from dragos.foianu by nat-labs-cs.cs.pub.ro with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 14:34:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 141.85.225.204 (Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244250>

shawn wilson <ag4ve.us <at> gmail.com> writes:

> 
> How do I get more info here (and hopefully resolve this)?
> 
>  % git push
> To ssh://server/foo/repo.git
>  ! [rejected]        test -> test (non-fast-forward)
> error: failed to push some refs to 'ssh://server/foo/repo.git'
> 

"non-fast-forward" means that someone else pushed to branch test before you
did and your push would end up overwriting their changes. Make sure you
merge your local branch with the remote branch:

git pull origin test

It might also be a result of local destructive changes made by "git rebase".
If you're absolutely certain you will not mess up the remote branch you can
add the "--force" parameter when you push.
