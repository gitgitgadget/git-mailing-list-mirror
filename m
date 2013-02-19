From: Mildred Ki'Lya <mildred-ml@mildred.fr>
Subject: Feature idea : notes to track status of a commit, which remotes it
 is shared to
Date: Tue, 19 Feb 2013 10:38:09 +0100
Message-ID: <51234801.5050208@mildred.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 10:59:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jzG-0001Xn-FT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758236Ab3BSJ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:59:22 -0500
Received: from fon38-4-88-185-152-87.fbx.proxad.net ([88.185.152.87]:44924
	"EHLO ashley.mildred.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757087Ab3BSJ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 04:59:21 -0500
X-Greylist: delayed 1264 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2013 04:59:21 EST
Received: from [2a01:e35:2f7b:8350:51ad:4eea:5ada:9b61]
	by ashley.mildred.fr with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.77)
	(envelope-from <mildred@mildred.fr>)
	id 1U7jeQ-0006nX-GF
	for git@vger.kernel.org; Tue, 19 Feb 2013 10:38:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216589>

Hi,

This is my first time on this list (and by the way, I'm not subscribed, 
so please Cc me to the replies). I have an idea that could be useful to 
make rewriting history safer and easier to new users (I'm training some 
of them). I thought I could share this idea, but perhaps someone already 
thought about it. And I'm not providing code.

The idea is to basically track automatically (in notes, either in the 
notes namespace or in another namespace) which repository/remote 
contains a commit. When doing git log, we'd see lines with each commit, 
something like:



commit b044e6d0f1a1782820b052348ab0db314e2db3ca
Author: Myself <myself@localhost.localdomain>
Date:   Tue Nov 20 16:46:38 2012 +0100

     This is the commit description

Published on:
     origin
     git@git.host.com:pub/repo.git


Then, we could have all the history rewriting commands (such as rebase 
or pull --rebase) die when rewriting commits that are already published 
anywhere. We could make an exception for a --force/-f flag or 
configuration option, or commits published in another local repository 
owned by the same user.

In most setups, it could be useful to tell users they can safely rebase 
without worrying about published commits as Git is tracking it for them. 
Of course this is not an absolute security, but it's a good start.

What do you think?

Mildred
