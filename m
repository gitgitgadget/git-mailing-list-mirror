From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] usage.c: remove unused functions
Date: Thu, 25 Sep 2008 07:51:34 -0700
Message-ID: <20080925145134.GL3669@spearce.org>
References: <20080925184104.6117@nanako3.lavabit.com> <200809251348.42789.trast@student.ethz.ch> <20080925124836.GI10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>, Jonas Fonseca <fonseca@diku.dk>,
	Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 16:53:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KisD6-000615-2k
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 16:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbYIYOvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 10:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbYIYOvf
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 10:51:35 -0400
Received: from george.spearce.org ([209.20.77.23]:40491 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbYIYOvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 10:51:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B806B3835F; Thu, 25 Sep 2008 14:51:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080925124836.GI10360@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96773>

Petr Baudis <pasky@suse.cz> wrote:
> On Thu, Sep 25, 2008 at 01:48:37PM +0200, Thomas Rast wrote:
> > Nanako Shiraishi wrote:
> > > This removes three functions that are not used anywhere.
> > [...]
> > > -void set_usage_routine(void (*routine)(const char *err) NORETURN)
> > > -void set_error_routine(void (*routine)(const char *err, va_list params))
> > > -void set_warn_routine(void (*routine)(const char *warn, va_list params))
> > 
> > These blame to the following commit:
> > 
> >   commit 39a3f5ea7c0352a530338d30d4e618f6b4db84e4
> >   Author: Petr Baudis <pasky@suse.cz>
> > 
> >       Customizable error handlers
...
> > So apparently the intent was that they would only be used from outside
> > Git.  I don't know whether anyone still plans to do that, but they're
> > certainly not "just" unused.
> 
> I don't think it will be a big deal to remove these functions, though it
> does feel like a little bit of a step backwards in the libgit efforts.
> There are some programs that already link to Git, like CGit - I wonder
> if some of them don't use them (CGit itself doesn't).

IMHO these are useless for a "libgit".  However both tig and
cgit link to the non-existant libgit.a, so they may be using
these routines.  I've CC'd their authors and am not applying this
particular change without an ACK from them.

-- 
Shawn.
