From: Josef Wolf <jw@raven.inka.de>
Subject: Problems using perl's Git.pm module
Date: Thu, 2 Dec 2010 12:40:03 +0100
Message-ID: <20101202114003.GA26070@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 13:00:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO7qA-0006VQ-Ue
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439Ab0LBMAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 07:00:40 -0500
Received: from quechua.inka.de ([193.197.184.2]:55533 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab0LBMAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 07:00:40 -0500
X-Greylist: delayed 1231 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2010 07:00:40 EST
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1PO7WC-0002pP-2x; Thu, 02 Dec 2010 12:40:08 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 9F33576336; Thu,  2 Dec 2010 12:40:03 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162693>

Hello folks,

I am trying to use perl's Git.pm module, but for some reason, it keeps
bailing out:

  jw@raven:~/testrepos> git st
  # On branch master
  nothing to commit (working directory clean)
  
  jw@raven:~/testrepos> ./test.pl
  # On branch master
  nothing to commit (working directory clean)
  status failed w/ code 1 at ./test.pl line 9
  
  jw@raven:~/testrepos> cat test.pl
  #! /usr/bin/perl
  
  use strict;
  use warnings;
  use Git;
  
  my $repo = Git->repository (Directory => '.');
  git_cmd_try { $repo->command_noisy('status') }
                       '%s failed w/ code %d';
  
  print "Never reach this line\n";
  
  jw@raven:~/testrepos> 

Any ideas why the status command keeps bailing out on an entire clean
repository?
