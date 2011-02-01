From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 1 Feb 2011 13:42:06 +0100
Message-ID: <201102011342.06910.trast@student.ethz.ch>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <20110201014807.GA2722@sigill.intra.peff.net> <alpine.LFD.2.00.1101312238170.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	<git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 13:42:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkFYn-0006Vv-7a
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 13:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756790Ab1BAMmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 07:42:11 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:31063 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756781Ab1BAMmK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 07:42:10 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 1 Feb
 2011 13:42:03 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 1 Feb
 2011 13:42:08 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <alpine.LFD.2.00.1101312238170.8580@xanadu.home>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165801>

Nicolas Pitre wrote:
> What I see in the root of the Git source 
> tree is a huge clutter of source files, binary files, scripts, and 
> subdirectories all mixed together.  If you know by hart where things are 
> because you've been hacking on them for the last 5 years then of course 
> you might not see the point.  But since I didn't work much on Git 
> lately, things are not as obvious to me as they used to be.  Looking 
> back at it now with some distance, this tree looks like a mess and it is 
> really annoying to work with.

But judging by that assessment, shouldn't we strive to make it
*easier* to find things?

In particular a prospective git hacker would not care whether
something is a source file or a script (you seem to imply the
opposite).  He would instead expect to find git-foo implemented in
something named of that sort, so we could probably help him by mapping

  git-foo.sh      ->   git-foo.sh
  builtin/bar.c   ->   git-bar.c
  baz.c           ->   lib/baz.c
  baz.o           ->   build/baz.o (or whatever, just elsewhere)
  baz.gcov        ->   build/baz.gcov (ditto)


(I'm no huge fan of src/ either, but this should be orthogonal.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
