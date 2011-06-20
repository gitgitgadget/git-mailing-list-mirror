From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH 1/6] Bring notes.c template handling in line with
 commit.c.
Date: Mon, 20 Jun 2011 20:48:42 +0200
Message-ID: <20110620184842.GN2921@home.lan>
References: <201106151253.57908.johan@herland.net>
 <201106192323.09511.johan@herland.net>
 <7vpqm9e8rn.fsf@alter.siamese.dyndns.org>
 <201106200941.54883.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 20:48:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYjWr-0007za-66
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 20:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab1FTSsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 14:48:52 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:57623 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985Ab1FTSsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 14:48:51 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 0F059D48096;
	Mon, 20 Jun 2011 20:48:43 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.76)
	(envelope-from <ydirson@free.fr>)
	id 1QYjWc-0007Wy-Mi; Mon, 20 Jun 2011 20:48:42 +0200
Content-Disposition: inline
In-Reply-To: <201106200941.54883.johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176084>

On Mon, Jun 20, 2011 at 09:41:54AM +0200, Johan Herland wrote:
> On Monday 20 June 2011, Junio C Hamano wrote:
> > Johan Herland <johan@herland.net> writes:
> > > On Saturday 18 June 2011, Yann Dirson wrote:
> > >> Signed-off-by: Yann Dirson <ydirson@free.fr>
> > > 
> > > Please mention in the commit message that the commit merely replaces
> > > write_or_die()/int fd with the corresponding stdio functionality, and
> > > that there is no (intended) change in behavior. It was not apparent
> > > from your commit message that you had not made any other changes.
> > > 
> > > Otherwise the patch looks OK.
> > 
> > I had an impression that you would lose a lot of error checking, unless
> > you are careful, if you go from write_or_die() to stdio.
> 
> Yeah, write_or_die() dies on failure, while with fwrite/fprintf I guess one 
> needs to check the return value, and handle errors accordingly.

It appears I based my code on buildin/commit.c from 1.7.4.1 - I just
did not realize that this part changed much in between with 098d0e0e.
I'll look into that.

> An alternative solution would be to drop this patch, and instead use 
> strbuf_addf() to get the format printing functionality needed in PATCH 3/6.

I have thought about that, but that will make the i18n process for the
template much more awkward - and we probably don't want to reimplement
stdio formatting for strbuf.

-- 
Yann.
