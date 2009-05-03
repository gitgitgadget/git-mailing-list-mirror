From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 8/6] Fix zero context insert and delete hunk headers to match CGit
Date: Sun, 3 May 2009 10:25:52 +0200
Message-ID: <200905031025.53084.robin.rosenberg.lists@dewire.com>
References: <20090503000540.GN23604@spearce.org> <20090503001423.GO23604@spearce.org> <8763gjdn6r.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun May 03 10:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0X2o-0001Gl-KO
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 10:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbZECIZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2009 04:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbZECIZ5
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 04:25:57 -0400
Received: from mail.dewire.com ([83.140.172.130]:4027 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbZECIZz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 04:25:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E247180027D;
	Sun,  3 May 2009 10:25:54 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Layl9FnPXJQI; Sun,  3 May 2009 10:25:54 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 4BFDE800277;
	Sun,  3 May 2009 10:25:54 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <8763gjdn6r.fsf@catnip.gol.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118168>

s=F6ndag 03 maj 2009 02:50:36 skrev Miles Bader <miles@gnu.org>:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >   And here is that hack.  It just feels wrong to me that I need
> >   to subtract 1 from the Edit region's line numbers, *only* when
> >   context is 0, in order to get the same output as CGit.
>=20
> A big comment saying "this may look a bit funny, but it's the standar=
d's
> fault: [text from std...]" might help salve the wound...

1) I agree. This need to be commented in the code.

2) Do we need to fix it? I.e. is there a problem or just two different =
results,
where one is correct, the other incorrect but harmless.

3) We should have a convention like C Git for marking known breakages.
One option is FIXME, another it so go JUnit 4 and abuse the expected ex=
ception=20
annotation (using it for declaring OK exceptions is pretty bad use anyw=
ay I think,
so we might use it for something better), or perhaps the @Ignore annota=
tion which
is meant specifically for this and other cases. A FIXME can be implemen=
ted right
away.

-- robin
