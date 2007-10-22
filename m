From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Add color to git-add--interactive diffs (Total
	different idea to solve the problem)
Date: Mon, 22 Oct 2007 22:47:19 +0200
Message-ID: <20071022204719.GA23348@xp.machine.xx>
References: <1192351494.7226.18.camel@athena>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@gmail.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Tom Tobin <korpios@korpios.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 22:47:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik4BY-000252-2x
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 22:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbXJVUr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 16:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbXJVUrZ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 16:47:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:46210 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750700AbXJVUrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 16:47:24 -0400
Received: (qmail invoked by alias); 22 Oct 2007 20:47:22 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp058) with SMTP; 22 Oct 2007 22:47:22 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+Ro9QLgfuRS8FchWqd2apmgdmP9cy00xAWyolnkD
	ZBIvjPyFByDwY+
Content-Disposition: inline
In-Reply-To: <1192351494.7226.18.camel@athena>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62045>

On Sun, Oct 14, 2007 at 03:44:54AM -0500, Tom Tobin wrote:
> (This is repost; my damned mail client wrapped a line in the patch last
> time, and now I've got that under control.  My apologies!)  :(
> 
> Seeing the recent discussion and code regarding adding color to
> git-add--interactive, I thought I'd throw in my recent attempt at
> colorizing the diffs.  (This doesn't handle anything else, such as the
> prompts.)
> 
> After banging my head against parsing colorized output of git-add-files,
> I gave up and implemented internal colorization keying off of the
> color.diff configuration.
> 
> Hopefully this can be of some use towards fully colorizing
> git-add--interactive; I'll admit up front that Perl isn't my primary
> language, so I apologize in advance for whatever stupidities I've
> introduced.  ;) 
> 
> Signed-off-by: Tom Tobin <korpios@korpios.com>

[...skiping patch ...]

Tossing around ideas, so feel free to ignore me.

Wouldn't it make more sense to implement the diff coloring inside git apply
so that you could use something like

        diff file1 file2|git apply --color

to make the generated diff with colors [1]? It already implements the
same semantic for generating a diffstat, using

        diff file1 file2|git apply --stat

so we would get a generic diff colorizing tool and you could use inside
git add -i the diff without color and just print it out with the
git apply --color filter. So if someone implements another tool which
needs color handling he could use this output filter.

-Peter

[1]: there is a programm colordiff which does exactly this, but AFAIK git
     colorization has more features.
