From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH/RFC] alias: use run_command api to execute
 aliases
Date: Fri, 7 Jan 2011 15:51:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1101071551190.15247@pacific.mpi-cbg.de>
References: <1294341187-3956-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1101070216390.1542@bonsai2> <AANLkTi=6wG6khBAqLA8nki5-wbxQB-oYUAgMSqT-egpt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 15:51:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbDfS-0000HL-FF
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 15:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab1AGOvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 09:51:45 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:51340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752172Ab1AGOvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 09:51:45 -0500
Received: (qmail invoked by alias); 07 Jan 2011 14:51:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 07 Jan 2011 15:51:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190m9YTqg10O20ae8kO2GyDhY4d0ageT96/12uznz
	n85/6EG4w+ElIt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <AANLkTi=6wG6khBAqLA8nki5-wbxQB-oYUAgMSqT-egpt@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164716>

Hi,

On Fri, 7 Jan 2011, Erik Faye-Lund wrote:

> On Fri, Jan 7, 2011 at 2:17 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 6 Jan 2011, Erik Faye-Lund wrote:
> >
> >> On Windows, system() executes with cmd.exe instead of /bin/sh. This 
> >> means that aliases currently has to be batch-scripts instead of 
> >> bourne-scripts. On top of that, cmd.exe does not handle single 
> >> quotes, which is what the code-path currently uses to handle 
> >> arguments with spaces.
> >>
> >> To solve both problems in one go, use run_command_v_opt() to execute 
> >> the alias. It already does the right thing prepend "sh -c " to the 
> >> alias.
> >
> > Would this not break setups where aliases were defined to execute 
> > batch scripts?
> >
> > If this is true, I'm of two minds here.
> 
> It would indeed, but I wouldn't worry TOO much about it. We've clearly 
> told the users that Git for Windows is a tool that you have to be 
> willing to work on to use.
> 
> But I'm kind of of two minds here myself, but for a slightly different 
> reason: I think Git for Windows SHOULD use cmd.exe to execute scripts. 
> We should be able to lose the msys-environment and still have the basic 
> functionality working. In that sense, this is a step in the wrong 
> direction. But I'd rather have all code use the same code-path to 
> execute scripts, and make a bit switch to cmd.exe together with porting 
> all supplied scripts to batch-files some time in the future.

Okay, strike my objections, I agree now. Feel free to apply!

Thanks,
Dscho
