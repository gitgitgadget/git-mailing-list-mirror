From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Clarify documentation of git-cvsserver, particularly in
 relation to git-shell
Date: Sat, 19 Apr 2008 16:43:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804191620380.20708@eeepc-johanness>
References: <39292ba40804151233k2dd9300as5611e65ab6fcd81d@mail.gmail.com> <1208293415-19212-1-git-send-email-scc@ScottCollins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Scott Collins <scc@ScottCollins.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:29:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnFEQ-0005NP-CM
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 17:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYDSPnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 11:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbYDSPnM
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 11:43:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:37653 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751958AbYDSPnK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 11:43:10 -0400
Received: (qmail invoked by alias); 19 Apr 2008 15:43:07 -0000
Received: from R2c2d.r.pppool.de (EHLO eeepc-johanness.st-andrews.ac.uk) [89.54.44.45]
  by mail.gmx.net (mp035) with SMTP; 19 Apr 2008 17:43:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+oJk5prJ+yGN+RH1VyFPPGTa9Rn+X7LHwh7hfd3
	AecnCi9susJKuS
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1208293415-19212-1-git-send-email-scc@ScottCollins.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79911>

Hi,

On Tue, 15 Apr 2008, Scott Collins wrote:

> Currently, for SSH clients restricted to git-shell, CVS_SERVER should
> not be changed: git-shell understands the default value of 'cvs' to mean
> git-cvsserver and actually _doesn't_ understand the command
> 'git-cvsserver'.

How about a new paragraph here?

> This makes it totally transparent to CVS users, but the
> original wording here perhaps less so to the person setting-up CVS
> access.  Previous wording mentioning GIT_AUTHOR, GIT_COMMITTER variables
> may not have made clear we really meant GIT_AUTHOR_(NAME|EMAIL), etc.

Likewise here.

> Add a bit of text to differentiate cvs -d (setting CVSROOT) from cvs co
> -d (setting the name of the newly checked out directory).  Removed an
> extra 'Example:' string.
> 
> Signed-off-by: Scott Collins <scc@ScottCollins.net>
> ---
>  Documentation/git-cvsserver.txt |   27 +++++++++++++++------------
>  1 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
> index 9cec802..44734e8 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -106,11 +106,13 @@ Note: Newer CVS versions (>= 1.12.11) also support specifying
>  CVS_SERVER directly in CVSROOT like
>  
>  ------
> -cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name>
> +cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name> -d <dir_name>

I am not really sure.  Normal usage AFAIAC is without -d.

>  ------
>  This has the advantage that it will be saved in your 'CVS/Root' files and
>  you don't need to worry about always setting the correct environment
> -variable.
> +variable.  SSH users restricted to git-shell don't need to override the default
> +with CVS_SERVER (and probably shouldn't) as git-shell understands 'cvs' to mean
> +git-cvsserver.

Please make these lines shorter.

> @@ -141,25 +143,26 @@ allowing access over SSH.
>          enabled=1
>  ------
>  --
> -3. On the client machine you need to set the following variables.
> -   CVSROOT should be set as per normal, but the directory should point at the
> -   appropriate git repo. For example:
> +3. If you didn't specify the CVSROOT/CVS_SERVER directly in the checkout command,
> +   automatically saving it in your 'CVS/Root' files, then you need to set them
> +   explicitly in your environment.  CVSROOT should be set as per normal, but the
> +   directory should point at the appropriate git repo.  As above, for SSH clients
> +   _not_ restricted to git-shell, CVS_SERVER should be set to git-cvsserver.

Please make the lines shorter.

Also, I seem to recall that "didn't" is considered colloquial speech, 
while you should write "did not" in written documentation.

Another thing: "CVSROOT should be set as per normal" strikes me as a 
little short on concrete, helpful details.

Thanks, Dscho
