From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 01/14] Detect path names which overflow the name
	length field in the index
Date: Tue, 19 Aug 2008 12:57:35 -0700
Message-ID: <20080819195735.GA24212@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org> <1219103602-32222-2-git-send-email-spearce@spearce.org> <200808192032.44078.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:58:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVXLk-0006pl-RA
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbYHST5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbYHST5g
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:57:36 -0400
Received: from george.spearce.org ([209.20.77.23]:60948 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYHST5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:57:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 409C438375; Tue, 19 Aug 2008 19:57:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808192032.44078.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92917>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> tisdagen den 19 augusti 2008 01.53.09 skrev Shawn O. Pearce:
> > C Git allows a path name to be longer than 4095 bytes by storing 4095
> > into the path name length field within flags and then searching for a
> > null terminator at the end of the path name, instead of relying on the
> > length indicatior.  We cannot do this (easily) from an InputStream so
> > we are currently going to just abort with an exception if we find such
> > an extremely long path name.
> 
> What's hard? read bytes until we get a 0 shouldn't be hard. It has no
> special meaning to an InputStream.

Yea, I forgot this stream is a BufferedInputStream and that pulling
bytes one at a time isn't that much of a problem.  I'll rework this
patch and post a v2 today.

-- 
Shawn.
