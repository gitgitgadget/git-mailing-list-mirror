From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Wed, 13 Jul 2005 13:36:47 -0700
Message-ID: <20050713203647.GA11403@taniwha.stupidest.org>
References: <20050712190552.GA7178@taniwha.stupidest.org> <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org> <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org> <20050713200724.GN9915@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:48:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dso9k-0007qu-FZ
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVGMUoO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVGMUjU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 16:39:20 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:56774 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262791AbVGMUgy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 16:36:54 -0400
Received: from pimout3-ext.prodigy.net (pimout3-int.prodigy.net [207.115.4.218])
	by ylpvm29.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j6DKaQgb000803
	for <git@vger.kernel.org>; Wed, 13 Jul 2005 16:36:26 -0400
X-ORBL: [63.202.173.158]
Received: from stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout3-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j6DKama7100768;
	Wed, 13 Jul 2005 16:36:48 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 92E68529BBC; Wed, 13 Jul 2005 13:36:47 -0700 (PDT)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050713200724.GN9915@kiste.smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2005 at 10:07:24PM +0200, Matthias Urlichs wrote:

> You lose if the link is relative and the symlink is not in the
> current directory.

Cogito doesn't create such links in my (limited_ experience.  Why
would anyone else do that?

> You also lose on systems where the empty filename is synonymous with
> the current directory.

Well, return code from readlink should be tested there.


[...]

> You should remove "DEST first. Otherwise, under Linux, you'll
> magically create the file the symlink points to, which may not be
> what you want to do.

That behavior *is* desirable in this case.


Anyhow, the fact this is so complicated and getting more so makes me
think it's misdirected :-(
