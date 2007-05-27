From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 12:46:00 +0200
Message-ID: <20070527104600.GA23554@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 12:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsGGJ-0004MG-IK
	for gcvg-git@gmane.org; Sun, 27 May 2007 12:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbXE0KqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 27 May 2007 06:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXE0KqG
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 06:46:06 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:59942 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbXE0KqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 06:46:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id BE4217B83666;
	Sun, 27 May 2007 12:46:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2wqKgJX492o9; Sun, 27 May 2007 12:46:00 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 6D8E57B8365F; Sun, 27 May 2007 12:46:00 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48527>

Dana How wrote:
> (1c) Do not deltify naughty blobs.  Naughty blobs are those
>      blobs marked "nodelta" or very large blobs.

I don't like the idea to exclude any blobs from delta by default, if
the delta could be done. If the "very large blobs" are text files with
very few difference, they deltifiy very well.

Additionlly, how do you want to define "very large blobs"?=20

=46or a system with eg. 256MB of RAM, deltifiny a blob with some hundre=
d
MBs is a problem whereas it is no problem, if you have some GB of RAM.

mfg Martin K=F6gler
