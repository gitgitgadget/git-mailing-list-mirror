From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Minor : Make ObjectId, RemoteConfig Serializable
Date: Sun, 8 Feb 2009 03:13:21 +0100
Message-ID: <200902080313.21785.robin.rosenberg.lists@dewire.com>
References: <320075ff0902060702n7573aaecu9054626ee9a6991@mail.gmail.com> <320075ff0902061315g3f8b9c9bj92f528e700d59c50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 03:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVzCg-0003zU-DS
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 03:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbZBHCN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 21:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbZBHCN7
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 21:13:59 -0500
Received: from mail.dewire.com ([83.140.172.130]:15090 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbZBHCN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 21:13:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C3E65147E89B;
	Sun,  8 Feb 2009 03:13:52 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOiu9+QIFZwb; Sun,  8 Feb 2009 03:13:31 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 001DD800258;
	Sun,  8 Feb 2009 03:13:24 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <320075ff0902061315g3f8b9c9bj92f528e700d59c50@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108911>

fredag 06 februari 2009 22:15:29 skrev Nigel Magnay:
> Make AnyObjectId and RemoteConfig Serializable.
> When using jgit as a library in other tools, it's helpful to be able
> to use the nice, tested bits of jgit rather than String, but need to
> be able to serialize them.

A problem (big problem) with serialization is that it often leads to
fragile interfaces. One might want to have precise control over
the serialization so a change in the implementation doesn't affect
compatibility. Serializing AnyObjectId should not depend on the
implementation de jour. Second, how do we handle subclasses?

But maybe leaving it this way would be our way of saying that
the interface may break at any time, promise.

-- robin
