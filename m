From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer
Date: Tue, 1 Dec 2009 08:16:42 -0800
Message-ID: <20091201161642.GD21299@spearce.org>
References: <25718488.post@talk.nabble.com> <20091127234110.7b7e9993.rctay89@gmail.com> <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st> <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st> <20091201160150.GB21299@spearce.org> <be6fef0d0912010812i54531ce0n18e4615c3f408569@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Storsj? <martin@martin.st>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:21:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVPk-00050t-E0
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbZLAQQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbZLAQQ5
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:16:57 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:53139 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbZLAQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:16:56 -0500
Received: by gxk26 with SMTP id 26so2474756gxk.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:17:02 -0800 (PST)
Received: by 10.101.132.22 with SMTP id j22mr2170217ann.6.1259684219537;
        Tue, 01 Dec 2009 08:16:59 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 36sm103982yxh.49.2009.12.01.08.16.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 08:16:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <be6fef0d0912010812i54531ce0n18e4615c3f408569@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134221>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Wed, Dec 2, 2009 at 12:01 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > In theory, since the cURL session stays active, we would have
> > received the 401 authentication error during the initial
> > "GET $GIT_DIR/info/refs?service=git-$service" request, and the subsequent
> > "POST $GIT_DIR/git-$service" requests would automatically include the
> > authentication data.
> >
> > That's theory. ?Reality doesn't always agree with my theories. ?:-)
> 
> that's because the curl session where the 401 was received (and thus
> successful authentication takes place) is closed.
> 
> I sent out a patch series recently which contains a patch to maintain
> at least one curl session throughout a http session (from http_init()
> to http_cleanup()), you can see this here:
> 
>   http://www.spinics.net/lists/git/msg118190.html

Right, this patch looked sane to me.  It didn't touch code I recently
have touched myself, so I didn't bother to ACK, but if it helps,
Acked-by: Shawn O. Pearce <spearce@spearce.org>.

-- 
Shawn.
