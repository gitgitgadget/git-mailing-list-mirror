From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [xfs-masters] git://oss.sgi.com broke
Date: Mon, 06 Oct 2008 19:34:30 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-10-06-19-34-30+trackit+sam@rfc1149.net>
References: <20081003121903.6c9a7ebc.akpm@linux-foundation.org>
	<48EA3D63.2080703@thebarn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: xfs-masters@oss.sgi.com, git@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Daniel Berlin <"dberlin atdberlindotorg"@rfc1149.net>
To: Russell Cattelan <cattelan@thebarn.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 19:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmu03-0002CH-HA
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbYJFRen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 13:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbYJFRen
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 13:34:43 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:42830 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbYJFRem (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 13:34:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id BB028E04D4;
	Mon,  6 Oct 2008 19:34:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hc7dvM2dEO4T; Mon,  6 Oct 2008 19:34:31 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id 3EDF7E0BCC;
	Mon,  6 Oct 2008 19:34:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 55421C40BC;
	Mon,  6 Oct 2008 19:34:30 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O3kk2N1TSijV; Mon,  6 Oct 2008 19:34:30 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 2B1E9C40BD; Mon,  6 Oct 2008 19:34:30 +0200 (CEST)
In-Reply-To: <48EA3D63.2080703@thebarn.com> (Russell Cattelan's message of "Mon\, 06 Oct 2008 11\:31\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97609>

>>>>> "Russell" == Russell Cattelan <cattelan@thebarn.com> writes:

Russell> I'm using 1.5.6.4 on my remote client and it did a clone
Russell> just fine.  Ahh but indeed a fetch failed ...  But it also
Russell> fails with using v1.5.6.5 of git-daemon ...

I also have an error with "fetch" (while it works with "clone") on

  git://gcc.gnu.org/git/gcc.git

The error I get is from index-pack.c:get_index_from_pack():

% git fetch
remote: Generating pack...
remote: Done counting 6230 objects.
remote: Result has 3856 objects.
remote: Deltifying 3856 objects...
remote:  100% (3856/3856) done
remote: Total 3856 (delta 3234), reused 7 (delta 5)
Receiving objects: 100% (3856/3856), 6.99 MiB | 50 KiB/s, done.
fatal: premature end of pack file, 1858 bytes missing
fatal: index-pack failed

(the "premature end of pack file" message comes from a patch I
just submitted, before that it was a bogus error message due
to an improper use of errno)

I am using the latest spearce/next GIT, I don't know what version
runs on the FSF machine. Daniel, do you have this info?

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
