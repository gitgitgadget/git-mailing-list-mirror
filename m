From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Thu, 28 Oct 2010 14:46:49 -0400
Message-ID: <20101028144649.0f7b13b6@MonteCarlo>
References: <20101027131506.4da06c6d@MonteCarlo>
	<20101027173132.GA15657@burratino>
	<20101027225318.GB1877@neumann>
	<20101027205217.3f28b9d1@MonteCarlo>
	<20101028005455.GC31501@burratino>
	<20101028081445.27cc603b@MonteCarlo>
	<m31v7ai9c2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 20:47:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXVF-0000nC-8G
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761372Ab0J1SrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:47:01 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:60563 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab0J1SrA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:47:00 -0400
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PBXUx-00069f-O8; Thu, 28 Oct 2010 11:46:51 -0700
Received: from MonteCarlo (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 35836101F82;
	Thu, 28 Oct 2010 14:46:50 -0400 (EDT)
In-Reply-To: <m31v7ai9c2.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; i486-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - morn.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160208>

On Thu, 28 Oct 2010 09:15:45 -0700 (PDT)
Jakub Narebski <jnareb@gmail.com> wrote:

> Peter van der Does <peter@avirtualhome.com> writes:
> > On Wed, 27 Oct 2010 19:54:55 -0500
> > Jonathan Nieder <jrnieder@gmail.com> wrote:
> > 
> > > Peter van der Does wrote:
> > > 
> > > > The bash completion script could still be included with the
> > > > core, but we can offer different versions for different shells.
> > > 
> > > Why?  That's three times the maintenance work.
> > 
> > The cons of everything in one script:
> > - If the script needs an update the submitter has to take in account
> >   the different coding standards each shell has. Examples of this
> > have been given in the commit message of 06f44c3 (completion: make
> >   compatible with zsh, 2010-09-06)
> > 
> > - The script could end up with a slew of if statements to see which
> >   shell the script is running in and taking some action.
> > 
> > - Shells don't share all the same functions, the script could be
> > filled with functions not needed in other shells. the zsh patch
> > includes one, the Bash 4 patch includes several.
> > 
> > The pros of everything in one script:
> > - Small changes, like adding an extra option to a git command for
> >   completion only have to implemented in one script.
> 
> What about having separate scripts, but sourcing common library that
> doesn't do completion, but just provides list of possible completions?
> This would be best of both worlds, I think.
> 

That would be the best solution.

I believe it's very hard to accomplish though.
The options for completion are determined within each completion
function, and depending on the option a decision on what to offer the
user is made.
The way to decide which option is given and what to offer differs, some
functions use for/next loops, some use case <var>.

-- 
Peter van der Does

GPG key: E77E8E98

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes
