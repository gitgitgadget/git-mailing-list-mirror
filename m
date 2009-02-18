From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] 1/2 : (reworked) Externalizable/Serializable Items
Date: Wed, 18 Feb 2009 15:27:45 -0800
Message-ID: <20090218232745.GP22848@spearce.org>
References: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com> <200902182159.51027.robin.rosenberg.lists@dewire.com> <20090218214859.GN22848@spearce.org> <200902190021.33382.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nigel Magnay <nigel.magnay@gmail.com>, Git ML <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 00:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZvqt-0001wM-DC
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 00:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbZBRX1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 18:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbZBRX1r
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 18:27:47 -0500
Received: from george.spearce.org ([209.20.77.23]:37490 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZBRX1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 18:27:46 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B2AC0381FF; Wed, 18 Feb 2009 23:27:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902190021.33382.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110595>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> onsdag 18 februari 2009 22:48:59 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > 
> > Non-Java reading a Java serialization stream?  Seriously?
> 
> No, that was my objection to using writeObject, as that make
> it a Java-only stream, but then it might not be worth doing
> it via the serialization mechanism.

IMHO, if we are talking about either java.io.Serializable or
java.io.Externalizable, there's no point in considering a non
Java peer.

If you want a non-Java format, we'd need to consider a much
more neutral encoding, like Google's protobuf, or *shudder*
XML/JSON, or cooking up our own format.

That wasn't this thread started with.  The original poster just
wanted an easy way to serialize some basic data types from JGit,
as part of some higher level stream being done in the container
application.  Since that higher level stream is a apparently a
Java object serialization stream, we just need to match that.

-- 
Shawn.
