From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Gforge's cvssh.pl script and git
Date: Wed, 18 Feb 2009 14:24:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181417510.6274@intel-tinevez-2-302>
References: <2c0671440902180124v50570270gc40b745d4a8b1245@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bosko Ivanisevic <bosko.ivanisevic@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmQv-0001Wh-Tt
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbZBRNYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbZBRNYV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:24:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:44230 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752423AbZBRNYT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:24:19 -0500
Received: (qmail invoked by alias); 18 Feb 2009 13:24:17 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 18 Feb 2009 14:24:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+m3/pNlGCmp6DkrBegLGZMXpBrKBinAI9gH6YxoT
	r89gXdO6i0vbdN
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <2c0671440902180124v50570270gc40b745d4a8b1245@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110534>

Hi,

On Wed, 18 Feb 2009, Bosko Ivanisevic wrote:

> In the company I'm working someone has restricted access to all users
> to only use cvs via cvssh.pl script (source at the end of message)
> taken from gforge. This script is set as a shell for all users. Now I
> would like to change it so I can run git too. I've tried by adding
> 'git', 'git-upload-pack', 'git-receive-pack' and 'git-shell' in the
> array @allowed_commands. After that if I try to clone existing
> repository with:
> 
> git clone ssh://testuser@server_name/tmp/test.git
> 
> I get following error:
> 
> fatal: ''/tmp/test.git'': unable to chdir or not a git archive
> fatal: The remote end hung up unexpectedly
> 
> I first thought that testuser doesn't have permissions to read
> directory /tmp/test.git so I changed mode and gave r+w permissions
> recursively on that folder, but result was same.

r+w?  Not a+rwx?

And only on /tmp/test.git/, or also on /tmp/?

A better way would be to use 'sudo -u testuser git ls-remote 
/tmp/test.git' if sudo is available (you haven't revealed useful 
information about the host).

> There is no way I can avoid this perl script (company policy) but I
> can change it. Problem is that I do not know Perl so much and I do not
> know what git is exactly doing behind the scene when it is run via
> ssh.

I'd use 'system("some shell >&2");' to try to debug it.

Hth,
Dscho
