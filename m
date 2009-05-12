From: Andrew Schein <andrew@andrewschein.com>
Subject: git default behavior seems odd from a Unix command line point of view
Date: Tue, 12 May 2009 11:18:25 -0400
Message-ID: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 17:18:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3tkf-0001qw-Rl
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 17:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbZELPS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 11:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbZELPS1
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 11:18:27 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44983 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZELPS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 11:18:26 -0400
Received: by fxm2 with SMTP id 2so37031fxm.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 08:18:26 -0700 (PDT)
Received: by 10.103.214.13 with SMTP id r13mr5346018muq.37.1242141505929; Tue, 
	12 May 2009 08:18:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118903>

Hi all -

I am recently working within git after some experience with mercurial.
 I am observing what I believe to be an odd default behavior from the
perspective of UNIX command line tools.  I thought I'd share in case
this hasn't occurred to git maintainers or in case somebody has
developed good workaround practices.

ais@ace:bio[1]$ pwd
/home/ais/repo/nps/projects/bio
ais@ace:bio$ git status
# On branch master
nothing to commit (working directory clean)
ais@ace:bio[1]$ git commit -a
# On branch master
nothing to commit (working directory clean)
ais@ace:bio[1]$


The [1] in my prompt indicates the exit code of the git commands. What
I find odd is that even with the -q option, you get this verbose
output.  Also, you get  a non-zero exit status (which I would expect
only on a failure such as presence of an unresolved conflict).  My git
usage is to have a number of small repositories and use a shell script
to loop over them and perform a sync with a centralized server.
Having all this wordy output on a "no sync necessary" scenario seems
counter the desired properties of output only when work is taking
place or when an error occurs.

Have others developed git practices to sync a bunch or repositories
without all this verbose output on a "no change" scenario?

Andy

-- 
Andrew I. Schein
www.andrewschein.com
