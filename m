From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 7/7] cvsserver: Use the user part of the email in log and annotate results
Date: Tue, 25 Mar 2008 10:26:21 +0100
Message-ID: <20080325092621.GN25732@mail-vs.djpig.de>
References: <cover.1206393086.git.dash@foobox.net> <01e5947cde524f4eb97a86785d0e1f28e2d040e0.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
To: Damien Diederen <dash@foobox.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:27:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je5RD-0000Lm-N3
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 10:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbYCYJ0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 05:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYCYJ0j
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 05:26:39 -0400
Received: from pauli.djpig.de ([78.46.38.139]:36795 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbYCYJ0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 05:26:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id DC63A90073;
	Tue, 25 Mar 2008 10:26:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xumg7Oz4ljXS; Tue, 25 Mar 2008 10:26:23 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 7DBDD90071;
	Tue, 25 Mar 2008 10:26:22 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1Je5QD-0005sm-OJ; Tue, 25 Mar 2008 10:26:21 +0100
Content-Disposition: inline
In-Reply-To: <01e5947cde524f4eb97a86785d0e1f28e2d040e0.1206393086.git.dash@foobox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78163>

On Mon, Mar 24, 2008 at 11:50:55PM +0100, Damien Diederen wrote:
> +# Generate a CVS author name from Git author information, by taking
> +# the first eight characters of the user part of the email address.
> +sub cvs_author
> +{
> +    my $author = shift;
> +
> +    $author =~ s/.*<([^>]+)\@[^>]+>$/$1/;
> +    $author =~ s/^(.{8}).*/$1/;

IMHO substr($author, 0, 8) would be easier to read here. (It is also
much faster according to some quick benchmarks I just ran)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
