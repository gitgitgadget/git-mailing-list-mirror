From: Yann Dirson <dirson@bertin.fr>
Subject: Re: Itches with the current rev spec
Date: Mon, 29 Apr 2013 17:37:26 +0200
Organization: Bertin Technologies
Message-ID: <20130429173726.04cb5ac5@chalon.bertin.fr>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
 <20130426101946.433f2d12@chalon.bertin.fr> <517A3E47.6010606@viscovery.net>
 <7v7gjpxjw0.fsf@alter.siamese.dyndns.org>
 <CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
 <7v8v45vvuy.fsf@alter.siamese.dyndns.org>
 <CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 17:37:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWq91-0001YS-LR
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 17:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869Ab3D2Phb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 11:37:31 -0400
Received: from blois.bertin.fr ([195.68.26.9]:33310 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756851Ab3D2Pha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 11:37:30 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 41CEB6AB19
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:37:26 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 1C8E56AB16
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:37:25 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MM000HEFWQCF960@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 29 Apr 2013 17:37:25 +0200 (CEST)
In-reply-to: <CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8250-7.0.0.1014-19832.000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222803>

On Mon, 29 Apr 2013 20:38:03 +0530 Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> 3. "Range" is not an inherent property of A..B or A...B.  There are no
> "revision ranges".

Well, that could be seen as a problem, the .. syntax being commonly associated
with the concept of range.

> 4. Every command is free to interpret positive and negative commits as
> it sees fit.  Since there is no ordering, it must never treat one
> negative commit differently from another negative commit, or one
> positive commit differently from another positive commit.
> 
> show takes a list of positive commits and shows all of them.
> 
> log will show all the commits reachable from positive commits, and
> exclude all the commits reachable from negative commits.  Here, the
> "list of commits" are interpreted differently from the show case.
> 
> diff can either take two positive commits or one positive + one
> negative commit.  In the latter case, it swaps the arguments and
> treats both as positive commits.
> 
> rebase can take one negative commit and one positive commit.  The
> commits reachable from the positive commit, but not from the negative
> commit are replayed onto the negative commit.  Now, we can use --onto=
> to override the commit onto which to replay.  But the fundamental
> constraint remains: rebase _cannot_ make this --onto= parameter part
> of the normal rev spec (we only have two types of commits: positive
> and negative to which we can assign different meanings).
> --

Don't forget the particular situation of cherry-pick, which shows a situation
where we may want to specify a set of single commits and ranges, but for which
the current mechanisms cause a problem.

See: http://thread.gmane.org/gmane.comp.version-control.git/199994/focus=200058


-- 
Yann Dirson - Bertin Technologies
