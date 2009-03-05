From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http authentication via prompts
Date: Thu, 5 Mar 2009 11:55:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903051149280.6524@intel-tinevez-2-302>
References: <49AF25BF.5060706@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:58:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfBH1-0007Az-IH
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbZCEKzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbZCEKzl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:55:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:44698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751190AbZCEKzk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:55:40 -0500
Received: (qmail invoked by alias); 05 Mar 2009 10:55:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp022) with SMTP; 05 Mar 2009 11:55:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/AIp5QXHbACpu90PkuLDaIU+F+H/5hVNTQRHP60e
	RqM16OcspEFfMj
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49AF25BF.5060706@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112294>

Hi,

Disclaimer: if you are offended by constructive criticism, or likely to 
answer with insults to the comments I offer, please stop reading this mail 
now (and please do not answer my mail, either). :-)

Still with me?  Good.  Nice to meet you.

Just for the record: responding to a patch is my strongest way of saying 
that I appreciate your work.

On Wed, 4 Mar 2009, Mike Gaffney wrote:

> Currently git over http only works with a .netrc file which required 
> that you store your password on the file system in plaintext. This 
> commit adds to configuration options for http for a username and an 
> optional password. If a http.username is set, then the .netrc file is 
> ignored and the username is used instead. If a http.password is set, 
> then that is used as well, otherwise the user is prompted for their 
> password.

>From the subject, I would have expected a way to type in the password 
instead of storing it.  (Think getpass()... which would pose problems 
with Windows support, of course.)

FWIW by having it in .git/config (which is most likely more world-readable 
than $HOME/.netrc ever will be) does not provide any security over .netrc.

And I doubt that http.username is a good choice: what if you have multiple 
http:// URLs with different usernames/passwords?  So would it not make 
more sense to make this remote.<name>.user and ...password?

Ciao,
Dscho
