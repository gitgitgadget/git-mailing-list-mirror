From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 00:31:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040029040.9822@pacific.mpi-cbg.de>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>  <alpine.DEB.1.00.0902032350130.9822@pacific.mpi-cbg.de>  <94a0d4530902031456u1e1753e2rc34786ebdce6e774@mail.gmail.com>  <alpine.DEB.1.00.0902040002360.9822@pacific.mpi-cbg.de>
 <94a0d4530902031525o11e512barfc2f50c33a520474@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 00:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUkm-0000Pi-UX
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbZBCXao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbZBCXao
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:30:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:59669 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754883AbZBCXan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:30:43 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:30:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 04 Feb 2009 00:30:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JrTh0tATJ9dQeGPSqxjLdGanj23sHUozVpcOFte
	QdTAUJoMLf/SjX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530902031525o11e512barfc2f50c33a520474@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108277>

Hi,

On Wed, 4 Feb 2009, Felipe Contreras wrote:

> On Wed, Feb 4, 2009 at 1:05 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 4 Feb 2009, Felipe Contreras wrote:
> >
> >> On Wed, Feb 4, 2009 at 12:53 AM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> > However, a test case would be nice...
> >>
> >> What would the the test case check?
> >
> > That 'GIT_CONFIG=bla GIT_EDITOR=echo git config -e' and 'GIT_DIR=blub 
> > GIT_EDITOR=echo git config -e' do the right thing.  Maybe even 
> > --global, but that would also be a good test that "git config --global 
> > -e" does not fail when there is no original file.
> 
> Hmm, I'm not sure what issues this test case would find. If there's a 
> problem with launch_editor that's something other test case should find.

The purpose of the test case is not to find problems now, but ensure that 
what the patch is intended to do does not get broken by subsequent 
patches.

> If there's no original file it's up to the editor to create one, if for 
> some reason the editor fails at doing that it's a problem of the editor, 
> and there's not much 'git config -e' could do except show an error, and 
> that's what launch_editor would do. Same thing if the editor is wrong 
> (GIT_EDITOR=blah).

I was more thinking about 'git config --global -e' complaining that it 
could not find a non-existant file _before_ launching the editor.

Likewise, GIT_EDITOR=echo was meant to output the filename, not to edit 
the file.

Ciao,
Dscho
