From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Add horizontal scrollbar to the diff view
Date: Sat, 8 Mar 2008 16:41:10 +1100
Message-ID: <18386.9974.50409.525039@cargo.ozlabs.ibm.com>
References: <20080305225123.GA8485@localdomain>
	<7vy78wgyu1.fsf@gitster.siamese.dyndns.org>
	<18383.51154.695501.543720@cargo.ozlabs.ibm.com>
	<20080308015357.GU8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, kaitanie@cc.helsinki.fi,
	newsletter@dirk.my1.cc, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 06:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXrov-0005TU-SD
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 06:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbYCHFlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 00:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYCHFlP
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 00:41:15 -0500
Received: from ozlabs.org ([203.10.76.45]:48071 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867AbYCHFlO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 00:41:14 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2E5ADDDF4F; Sat,  8 Mar 2008 16:41:13 +1100 (EST)
In-Reply-To: <20080308015357.GU8410@spearce.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76548>

Shawn O. Pearce writes:

> git-gui does this scrollbar on-demand thing in its revision list meta-widget,
> which is lib/choose_rev.tcl.  The procedure in question is this, and it gets
> installed as:

That's a nice idea, doing it in _sb_set.  However, since the text
widget adjusts the horizontal scroll bar depending on what's visible,
that would mean the scroll bar would appear and disappear as you
scrolled vertically through the text, which would be disconcerting.
So for a text I think it's better to have the scrollbar there
permanently.

Also, I wonder if you could use pack forget instead of destroying the
scrollbar?

Paul.
