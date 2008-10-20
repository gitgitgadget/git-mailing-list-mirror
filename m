From: Marc Weber <marco-oweber@gmx.de>
Subject: git add --patch newfile doesn't add newfile to cache ?
Date: Mon, 20 Oct 2008 16:36:36 +0200
Message-ID: <20081020143636.GB3988@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 22:32:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrvtJ-0007Yu-2Y
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 16:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbYJTOgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 10:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYJTOgk
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 10:36:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:48410 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751321AbYJTOgk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 10:36:40 -0400
Received: (qmail invoked by alias); 20 Oct 2008 14:36:37 -0000
Received: from pD9E0B8FA.dip.t-dialin.net (EHLO nixos) [217.224.184.250]
  by mail.gmx.net (mp040) with SMTP; 20 Oct 2008 16:36:37 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/2cAIzmCn2NC1nFqUfOvgqYb8UMZZpXUxh4Wg3CL
	ASdsAbDR5FiJpK
Received: by nixos (sSMTP sendmail emulation); Mon, 20 Oct 2008 16:36:36 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98701>

Is this desired behaviour?

Testcase:

        #!/bin/sh
        # this script creates testGitAddPatch and will run the testcase there
         
        rm -fr testGitAddPatch
        mkdir testGitAddPatch
        cd testGitAddPatch
         
        git init
        echo test > test
        git add --patch test
        echo "running status, nothing has been added"
        git status
        git --version
 
My output
 
        marc@mail: /tmp/git ]$ sh test.sh
        Initialized empty Git repository in /tmp/git/testGitAddPatch/.git/
        No changes.
        running status, nothing has been added
        # On branch master
        #
        # Initial commit
        #
        # Untracked files:
        #   (use "git add <file>..." to include in what will be committed)
        #
        #       test
        nothing added to commit but untracked files present (use "git add" to
        track)
        git version 1.6.0.2.GIT

Marc Weber
