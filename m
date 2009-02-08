From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: gc considered dangerous
Date: Sun, 8 Feb 2009 20:37:53 +0100
Message-ID: <200902082037.54042.robin.rosenberg.lists@dewire.com>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com> <200902081704.59439.robin.rosenberg.lists@dewire.com> <BD926B5C-60C2-4A62-9BBC-E31CB26B9BAC@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 20:39:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWFVD-0008Co-Jx
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 20:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbZBHTiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 14:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbZBHTiB
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 14:38:01 -0500
Received: from mail.dewire.com ([83.140.172.130]:20288 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000AbZBHTiA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 14:38:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BE9D1147E880;
	Sun,  8 Feb 2009 20:37:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8CBFkYnEu23S; Sun,  8 Feb 2009 20:37:56 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3CA13147E7FE;
	Sun,  8 Feb 2009 20:37:56 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <BD926B5C-60C2-4A62-9BBC-E31CB26B9BAC@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109003>

s=F6ndag 08 februari 2009 19:24:33 skrev Steffen Prohaska:
> If you have a backup of the corrupted repository right after it got
> corrupted, you can create an index by running "git index-pack" on
> the pack that is lacking an index.  This might rescue the lost
> branches.

Yep, but the problem was that git gc was run again on the corrupted rep=
o
so there was only the idx left. (L)Users...

Couldn't we make repack refuse to repack if it discovered left-overs fr=
om
a failed repack, or at least make it use the old pack files as referenc=
e instead
of ignoring them? Leaving too many objects is, after all, much better t=
han
destroying the repo.

-- robin
