From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Wed, 27 Mar 2013 22:52:15 +0000
Message-ID: <20130327225215.GS2286@serenity.lan>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
 <20130327203535.GA5220@sigill.intra.peff.net>
 <878v58worp.fsf@linux-k42r.v.cablecom.net>
 <7vy5d8jz0y.fsf@alter.siamese.dyndns.org>
 <20130327220723.GR2286@serenity.lan>
 <7vobe4jxpr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Matthew Blissett <matt@blissett.me.uk>,
	David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:53:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzDL-00073C-2Y
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500Ab3C0Wwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:52:35 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:43774 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab3C0Wwe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:52:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 60B566064E2;
	Wed, 27 Mar 2013 22:52:34 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GLv9jihJIwmh; Wed, 27 Mar 2013 22:52:34 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id F343A6064E7;
	Wed, 27 Mar 2013 22:52:17 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vobe4jxpr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219348>

On Wed, Mar 27, 2013 at 03:15:44PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Wed, Mar 27, 2013 at 02:47:25PM -0700, Junio C Hamano wrote:
> >> > * jk/difftool-dir-diff-edit-fix (2013-03-14) 3 commits
> >> >   (merged to 'next' on 2013-03-19 at e68014a)
> >> >  + difftool --dir-diff: symlink all files matching the working tree
> >> >  + difftool: avoid double slashes in symlink targets
> >> >  + git-difftool(1): fix formatting of --symlink description
> >> 
> >> I lost track of various discussions on "difftool" and its "symlink
> >> so that the user can edit working tree files in the tool".
> >
> > Would it be easiest if I send a new series incorporating
> > jk/difftool-dirr-diff-edit-fix and the proposed change to not overwrite
> > modified working tree files, built on top of t7800-modernize?
> 
> I am somewhat reluctant to rewind a topic that has been cooking in
> 'next' for over a week (the above says 19th).  Rebuilding the
> style-fixes on top of the above is fine---that topic is much
> younger.

Sadly that's easier said than done, since it just introduces further
conflicts as jk/difftool-dir-diff-edit-fix doesn't include
da/difftool-fixes (now in master).

So I think the best thing may be to:

    1) take only the middle patch from jk/t7800-modernize for now (which
       fixes a test failure on Windows and shouldn't conflict with
       anything else) and discard the other two patches there, to be
       re-sent after other topics in flight graduate

    2) add the "don't overwrite modified working tree files" patch built
       on top of jk/difftool-dir-diff-edit-fix (presumably as a new
       topic)
