From: Tommi Virtanen <tv@eagain.net>
Subject: Re: is gitosis secure?
Date: Thu, 5 Feb 2009 00:04:19 -0800
Message-ID: <20090205080419.GD1970@eagain.net>
References: <200812090956.48613.thomas@koch.ro> <1228813453.28186.73.camel@maia.lan> <873afgsul8.fsf@mid.deneb.enyo.de> <200901180650.06605.bss@iguanasuicide.net> <20090203213135.GA1970@eagain.net> <20090204121204.GA12393@cuci.nl> <20090204182650.GC1970@eagain.net> <20090205075243.GA29080@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:06:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzFD-0000zO-0T
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757652AbZBEIEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbZBEIEX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:04:23 -0500
Received: from eagain.net ([208.78.102.120]:36994 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528AbZBEIEW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:04:22 -0500
Received: from musti.eagain.net (unknown [69.84.6.92])
	by eagain.net (Postfix) with ESMTPS id 43FDB5655B;
	Thu,  5 Feb 2009 08:04:21 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 1FE725080DA; Thu,  5 Feb 2009 00:04:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20090205075243.GA29080@cuci.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108523>

On Thu, Feb 05, 2009 at 08:52:43AM +0100, Stephen R. van den Berg wrote:
> It would help if there were a 10 to 60 line synopsis of what it does
> in the critical cases.  I mean, I don't care about features, but I care
> about the critical parts that interact with the shell and ssh.  In order
> to audit that I need a concise 60 line max piece of code or text where
> I can get all the info from.  1000 lines for that is too much.

I'm kinda bad about trusting any kind of design documents. The code
isn't going to match the design document for many months, anyway. That
also means I'm more likely to put effort into having the code be
readable, than in *separately* describing it.

What do you think are the "critical cases"?

run_hook: reads config files and writes ~/.ssh/authorized_keys.

serve: takes untrusted user input, checks ACLs, execs git-shell.

Honestly, apart from details of how the ACLs are implemented etc,
that's pretty simple.

Some of the code structure is historical baggage, e.g. the ACL
mechanism can map repo names on the fly, but it should still be pretty
simple to just read through and get the picture.

I have no real interest in writing up how SSH's authorized_keys works.
That belongs in OpenSSH, anyway.

-- 
:(){ :|:&};:
