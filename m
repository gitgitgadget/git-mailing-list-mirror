From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: git pull works remotely but not locally
Date: Thu, 27 May 2010 14:35:07 +0100
Message-ID: <4BFE750B.5030007@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 27 15:35:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHdEz-0003CS-IE
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 15:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748Ab0E0NfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 09:35:10 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:35469 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822Ab0E0NfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 09:35:09 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id EA8C2DEC3D
	for <git@vger.kernel.org>; Thu, 27 May 2010 14:35:07 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id Swkx5eyVcmzP for <git@vger.kernel.org>;
	Thu, 27 May 2010 14:35:07 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id B9F22DEC3C
	for <git@vger.kernel.org>; Thu, 27 May 2010 14:35:07 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147854>

Dear All

I have just set up my first git repository, and I'm trying things out 
before using it for real.  To start with I'm using a centralised 
workflow with the main repos on a server, and workers checking work out 
and in.  I'm using the smart http backend.  I can contact the repos 
remotely via http or locally using the filesystem.  However, git pull is 
not working in the local case.  Please can someone offer help with (a) 
file permissions, and (b) difference between git pull, and git fetch; 
git merge (which works):

The basics seem to be working OK remotely: ie contacting the server over 
http:

         git clone http://username@12.34.56.78/git/projectname.git

What I mean is push and pull are working.

When working on the server itself I'm using

         git clone  /var/www/git/projectname.git

Most things seem to work the same, but git pull does not work:

         $ git pull
         fatal: cannot exec 'git-pull': Permission denied

fetch followed by merge seems to have the desired effect, e.g.:

    $ git fetch
    remote: Counting objects: 5, done.
    remote: Compressing objects: 100% (2/2), done.
    remote: Total 3 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
     From /var/www/git/projectname
        6b40c1f..4ffb389  master     -> origin/master

    $ git merge origin
    Updating 6b40c1f..4ffb389
    Fast-forward
      notes.txt |    1 +
      1 files changed, 1 insertions(+), 0 deletions(-)


So, my questions are:

(a)  Why isn't git pull working in the second case?  What permissions am 
I missing?
(b)  Does git fetch; git merge origin do the same thing as git pull?

With thanks and best wishes

Ivan


-- 
============================================================
Ivan A. Uemlianin
Speech Technology Research and Development

                     ivan@llaisdy.com
                      www.llaisdy.com
                          llaisdy.wordpress.com
                      www.linkedin.com/in/ivanuemlianin

     "Froh, froh! Wie seine Sonnen, seine Sonnen fliegen"
                      (Schiller, Beethoven)
============================================================
