From: Scott Schmit <i.grok@comcast.net>
Subject: Re: git branch command is incompatible with bash
Date: Tue, 28 Jul 2015 20:23:33 -0400
Message-ID: <20150729002333.GB23501@odin.ulthar.us>
References: <20150727121253.GC17338@2vizcon.com>
 <55B69E68.90306@kdbg.org>
 <xmqqh9opgtjz.fsf@gitster.dls.corp.google.com>
 <55B72F09.3030000@kdbg.org>
 <xmqq4mkogvb7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Anatol Rudolph <a.rudolph@2vizcon.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 02:23:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKF9u-00018h-CF
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 02:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbbG2AXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 20:23:41 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:45105 "EHLO
	resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751895AbbG2AXk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2015 20:23:40 -0400
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
	by resqmta-po-11v.sys.comcast.net with comcast
	id y0Pg1q00352QWKC010PgNr; Wed, 29 Jul 2015 00:23:40 +0000
Received: from odin.ULTHAR.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by resomta-po-09v.sys.comcast.net with comcast
	id y0Pb1q0092Ekl48010PeiC; Wed, 29 Jul 2015 00:23:39 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ULTHAR.us (8.15.1/8.14.5) with ESMTP id t6T0NY80003990;
	Tue, 28 Jul 2015 20:23:34 -0400
Received: (from draco@localhost)
	by odin.ulthar.us (8.15.1/8.15.1/Submit) id t6T0NXEN003987;
	Tue, 28 Jul 2015 20:23:33 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mkogvb7.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1438129420;
	bh=r63EHZGNoXGa5KYJJ97lLfXGDVKAU5pQMj009MlSubI=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=E9fPvazBqIkHNYQJ56klHn5OgNUQndjTCiwclXGiIJ3EXIT4mbGNaOFuoKcOqfB1G
	 hn1Mh6OagS0UGRJ1FDlDCVZnwev084J5mv+z9ljeUB0m+hm4sAgi9I7Q6H4dLNZoT+
	 o/rd8CaPSFhlpT2O897I8YdVKuU7dBy7UCpUcUVuOJYzFpGqGnAOR0DGc8TEg32Rsd
	 teSwsbG8ibvb+4jPEQr+PnhtsnhoyMK6zWRr/wiYErDN1WFRp42qZZMC438t9+0LHP
	 NaIIhO3FVLgpX+MHr7q7b06I1d88FUFyWGFiH00zpxiYCcIFo4pnggt8HKPs88Oa9L
	 N9T2z9BCzpybw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274867>

On Tue, Jul 28, 2015 at 08:23:40AM -0700, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > Are you trying to say that the result of 'rev-parse --abbrev-ref HEAD'
> > is suboptimal and that of 'symbolic-ref --short HEAD' is OK?
> 
> My "Interesting" was primarily about that I wasn't aware of the
> "--abbrev-ref" option.
> 
> Yes, I am sure some time ago I accepted a patch to add it, but I
> simply do not see the point, especially because the "--short" option
> to symbolic-ref feels much more superiour.  "What branch am I on?"
> is about symbolic refs, rev-parse is about revisions.

Sometimes my question is "what branch am I on?" -- in which case
symbolic-ref is adequate.

Other times, my question is "where am I/what did I check out?" which is
usually a branch, sometimes a tag, and sometimes a commit hash.  We
don't have a one-stop-shop command to answer that question in all cases,
which is unfortunate.

git status answers, but that's not plumbing.  git-prompt manages to do a
fairly good job, but the logic is by no means straightforward.

-- 
Scott Schmit
