From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
	transports.
Date: Tue, 1 Dec 2009 11:30:09 -0800
Message-ID: <20091201193009.GM21299@spearce.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com> <20091201165245.GF21299@spearce.org> <20091201171908.GA15436@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Dec 01 20:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFYQX-00025k-Ix
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 20:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbZLATaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 14:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbZLATaI
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 14:30:08 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:60617 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbZLATaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 14:30:08 -0500
Received: by gxk26 with SMTP id 26so2661200gxk.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 11:30:14 -0800 (PST)
Received: by 10.101.180.19 with SMTP id h19mr2811104anp.137.1259695814138;
        Tue, 01 Dec 2009 11:30:14 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 34sm184427yxf.11.2009.12.01.11.30.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 11:30:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091201171908.GA15436@Knoppix>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134253>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> On Tue, Dec 01, 2009 at 08:52:45AM -0800, Shawn O. Pearce wrote:
> 
> > Or better, why this is even necessary?
> 
> I have seen requests for gits:// (and in fact, I have plans to
> implement that protocol).
> 
> For instance, to support new types of authentication for smart transports
> without patching client git binaries (SSH has lots of failure modes that
> are quite nasty to debug) or abusing GIT_PROXY (yuck). 

So the bulk of this series is about making a proxy for git://
easier to tie into git?

Forgive me if I sound stupid, but for gits:// shouldn't that just
be a matter of git_connect() forking a git-remote-gits process
linked against openssl?  Or, maybe it just runs `openssl s_client`?

Why go through all of this effort of making a really generic proxy
protocol system when the long-term plan is to just ship native
gits:// support as part of git-core?
 
-- 
Shawn.
