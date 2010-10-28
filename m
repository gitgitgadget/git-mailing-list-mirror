From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Thu, 28 Oct 2010 08:14:45 -0400
Message-ID: <20101028081445.27cc603b@MonteCarlo>
References: <20101027131506.4da06c6d@MonteCarlo>
	<20101027173132.GA15657@burratino>
	<20101027225318.GB1877@neumann>
	<20101027205217.3f28b9d1@MonteCarlo>
	<20101028005455.GC31501@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 14:15:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBRNt-0002t5-PX
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 14:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685Ab0J1MPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 08:15:04 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:43048 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542Ab0J1MPB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 08:15:01 -0400
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PBRNX-0001Hx-Si; Thu, 28 Oct 2010 05:14:48 -0700
Received: from MonteCarlo (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 03BE0101F82;
	Thu, 28 Oct 2010 08:14:45 -0400 (EDT)
In-Reply-To: <20101028005455.GC31501@burratino>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160173>

On Wed, 27 Oct 2010 19:54:55 -0500
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Peter van der Does wrote:
> 
> > The bash completion script could still be included with the core,
> > but we can offer different versions for different shells.
> 
> Why?  That's three times the maintenance work.

The cons of everything in one script:
- If the script needs an update the submitter has to take in account
  the different coding standards each shell has. Examples of this have
  been given in the commit message of 06f44c3 (completion: make
  compatible with zsh, 2010-09-06)

- The script could end up with a slew of if statements to see which
  shell the script is running in and taking some action.

- Shells don't share all the same functions, the script could be filled
  with functions not needed in other shells. the zsh patch includes
  one, the Bash 4 patch includes several.

The pros of everything in one script:
- Small changes, like adding an extra option to a git command for
  completion only have to implemented in one script.


The maintenance of the various scripts would be done by people who have
a full understanding of the shell for which the script is written
for.
I kind of see this suggestion as building the git package for a Linux
distribution, Windows or Mac. Debian and Ubuntu have some patches
that are not included in the core to make git work better on those
distributions. The maintenance is done by the people who have in depth
knowledge of that distribution.


-- 
Peter van der Does

GPG key: E77E8E98

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes
