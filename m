From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Initialize notes trees if %N is used and no --show-notes given
Date: Tue, 6 Apr 2010 13:52:21 +0200
Message-ID: <201004061352.21945.trast@student.ethz.ch>
References: <20100405115548.GA19971@macbook.lan.lan> <201004061127.01471.trast@student.ethz.ch> <20100406111904.GA46425@macbook.lan.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Tue Apr 06 13:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz7Kj-0003ID-G5
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 13:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab0DFLwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 07:52:25 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:11395 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754913Ab0DFLwY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 07:52:24 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 6 Apr
 2010 13:52:23 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 6 Apr
 2010 13:52:22 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100406111904.GA46425@macbook.lan.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144130>

Johannes Gilger wrote:
> 
> The first option would be confusing. I, for one, would simply put %N in
> my log and never really know that existing notes aren't displayed. I
> wasn't even sure my git.git checkout had notes, so I created one myself.
> A better behaviour would be to not expand %N if notes are disabled, so a
> user gets some kind of feedback that %N isn't working.
> 
> I'd really like %N to do the initialization. There is no other
> placeholder which requires an extra option to work, if I see it
> correctly.

%g[dDs] expand to nothing unless the log command walks reflogs, so
there is some precedent.

One thing I didn't consider in my other mail was that --pretty
automatically disables notes.  I think in my plan (%N expands to
nothing with --no-notes) this would have to change to the effect that
--pretty only disables the *normal* note-showing code, but still
initializes according to the same rules.

I'll have to check whether that amounts to the same as "silent
initialization".

> As for the builtin formats I was under the impressions that they worked
> completely outside the parser for placeholders, so one would not use
> '%N' in a builtin format, and %N initializing the notes would not
> conflict with --no-notes and builtin formats.

That's true, which is why I said "notionally".

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
