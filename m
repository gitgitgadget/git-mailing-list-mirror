From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer
Date: Tue, 1 Dec 2009 08:01:50 -0800
Message-ID: <20091201160150.GB21299@spearce.org>
References: <25718488.post@talk.nabble.com> <20091127234110.7b7e9993.rctay89@gmail.com> <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st> <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin Storsj? <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:02:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVB0-0004VC-5B
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbZLAQBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZLAQBu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:01:50 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39555 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbZLAQBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:01:48 -0500
Received: by yxe17 with SMTP id 17so4679488yxe.33
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:01:54 -0800 (PST)
Received: by 10.101.134.6 with SMTP id l6mr2483461ann.67.1259683314499;
        Tue, 01 Dec 2009 08:01:54 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 7sm98880yxd.44.2009.12.01.08.01.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 08:01:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134216>

Martin Storsj? <martin@martin.st> wrote:
> When using multi-pass authentication methods, the curl library may need
> to rewind the read buffers used for providing data to HTTP POST, if data
> has been output before a 401 error is received.

In theory, since the cURL session stays active, we would have
received the 401 authentication error during the initial
"GET $GIT_DIR/info/refs?service=git-$service" request, and the subsequent
"POST $GIT_DIR/git-$service" requests would automatically include the
authentication data.

That's theory.  Reality doesn't always agree with my theories.  :-)
 
>  remote-curl.c |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
