From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: CR codes from git commands
Date: Wed, 21 Jan 2009 23:34:37 -0800
Message-ID: <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	 <alpine.LNX.1.00.0901212319310.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 08:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPu6n-0007r6-Ak
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 08:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbZAVHek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 02:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250AbZAVHej
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 02:34:39 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:56097 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbZAVHei (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 02:34:38 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1880817ywe.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 23:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w/SYAysrjn1ZJRB0geoddOBEfirP63opYEoVD9D+Dys=;
        b=NcsD0jp/1hxFz1lGRox6ChDEu5mODfnx60TMr4CX11siHUgTUPt7PyRmI9fE3fcOX0
         9jO/k3YE+YoMzjzTsYfOGP9hOhsrYjQB8newT/pq00HKvQHcGWJowLhVILEdSOq1GPs/
         DSIGhu7ucnF/0a8NbJEgNS8wDq7m8jARiTFI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DBzcIMIZ5okiNABMEmdKw1VCiz3znPPwDMbmJBbbI/n5QMagvjHZd45G9naE35eOyd
         4qla7chqLcgl8uMrXhPKGVLFGDvDe2b9g0Wrg7usUVbgK4q08/7C6S5luglO0UQOR233
         pXpT5VBhcYcMmIJ8I0UwYxxKsGhYcHVyP/o0I=
Received: by 10.90.83.18 with SMTP id g18mr529103agb.18.1232609677472; Wed, 21 
	Jan 2009 23:34:37 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0901212319310.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106731>

On Wed, Jan 21, 2009 at 8:47 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> It's kind of unclear what you're trying to do here. I'm guessing that
> you're trying to run git with stdio directed to a /dev/tty device, where
> isatty() is true, but which doesn't interpret ASCII control characters as
> such. We're not detecting that you can't use a pager on this, and so you
> have to use PAGER=cat (which might not be a bad idea for things like
> "man", either). With some clues about the environment, we should be able
> to do something about this.
>
> You're also trying to send the progress output to a log file that you can
> look at the end of (presumably in a more capable terminal). It should be
> possible (with an option) to get git to output progress info to a non-tty,
> and not use the CRs if the output isn't a tty.
>
> Or do you want to use a tty that can't handle CRs, and get newlines
> instead of CRs? (If I'd git on the first computer I used, it would have
> printed the progress bar over and over in place and probably torn a hole
> in the paper, but I haven't used that one in over 20 years.)

Hi Daniel,

Ideally, yes I would want no CR's but LF's instead (but others who do
not use my environment may actually like the way it is now, and I seek
not to disturb that use case).  I could live without the progress
lines (lines that print repeatedly over in one place on normal
terminals), but adding " 2>&1 | cat" to every command line just to get
the CR's to go away, is non-workable for me.

The environment I'm running git under is the Shell mode inside GNU
Emacs. I can't tell you what type of terminal it is, because I believe
that is defined deep in the guts of Emacs. Having read your reply
above, I'm now wondering whether this is an Emacs issue versus a git
issue. If it is an Emacs issue, then I am truly embarrassed for having
wasted everyones time with it.

Brent
