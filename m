From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rehabilitate 'git index-pack' inside the object store
Date: Tue, 21 Oct 2008 11:02:07 -0400
Message-ID: <20081021150206.GA20263@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home> <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 17:05:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsIlZ-0007Pm-Be
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 17:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYJUPCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 11:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYJUPCL
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 11:02:11 -0400
Received: from peff.net ([208.65.91.99]:4159 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbYJUPCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 11:02:09 -0400
Received: (qmail 22557 invoked by uid 111); 21 Oct 2008 15:02:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Oct 2008 11:02:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Oct 2008 11:02:07 -0400
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98789>

On Tue, Oct 21, 2008 at 09:57:04PM +0700, Nguyen Thai Ngoc Duy wrote:

> (e.g. running "git apply" or "git bundle" from inside .git). Maybe we
> should let setup_*_gently() do read-only stuff only and let its
> consumers to handle cwd. I recall Jeff has plan about worktree setup
> rework, though could not find the thread. Will think more of it
> tomorrow.

If by "plan" you mean "intense desire to see it fixed", then yes, I have
a plan. But there isn't a concrete plan yet, and I'm not sure when I'll
get to it. I have a vague assumption that we should move in the
direction of just setting up as much of the environment as possible
(finding git dir, finding work tree, reading config, etc) as soon as
possible, but not producing any error messages or dying as a result.
Then those commands which want to enforce that some setup has occurred
can easily do so.

-Peff
