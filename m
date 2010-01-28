From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 12:20:56 -0800 (PST)
Message-ID: <4b61f1a8.02c3f10a.6608.ffff8a5f@mx.google.com>
References: <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com> <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 21:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaarY-0006Of-IF
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 21:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304Ab0A1UVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 15:21:04 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297Ab0A1UVD
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 15:21:03 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:24760 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301Ab0A1UU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 15:20:59 -0500
Received: by qw-out-2122.google.com with SMTP id 8so213073qwh.37
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 12:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:references;
        bh=g5pQ07FuTuBSu8RGBcxbnha2p2bxCkffgAInT3GJHXI=;
        b=RLli+rTT9QxqaeevKwjCGy5F1QYLZXpFaVcs6t4/gVuVUk3UCTmqAUl4HWHvzAVtwj
         TmFV3n7qTHRBspxMPITL5ZeWQbOz3zA5ZqM1sKjarTgR08ZxMAotHpFLC67BAfsCAhNh
         QdJhTjnpSAk1MmTZM/Jz7sZLN/5h98XTrsYb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:references;
        b=n8EYcOOxvs1wN6ge1sY8A03rhxogdYWll9Q5WNvpl+Mi20tnA27EUbJtEDoikrHrOa
         A7/2p4F+Q03O7ypgJRu6rDf9Ini8sTXMEw0GsVETPX7p/XS0lwTgq5HocvJYEnQa/lDE
         9Pyk1MBrxIWYng42MqfWB2ipzoCpR0S4Uc73Q=
Received: by 10.224.27.130 with SMTP id i2mr6550082qac.189.1264710058328;
        Thu, 28 Jan 2010 12:20:58 -0800 (PST)
Received: from gmail.com (gpftor3.privacyfoundation.de [62.141.58.13])
        by mx.google.com with ESMTPS id 2sm3177664qwi.37.2010.01.28.12.20.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 12:20:56 -0800 (PST)
In-Reply-To: <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138266>

On Thu, Jan 28, 2010 at 2:03 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> However, I've been thinking for a while that it would be useful to
> have =C3=BCbercommits (they don't exist) that are treated like single
> commits but that actually encapsulate multiple continguous commits.

In fact, the commit message body is already being used to create
unofficial =C3=BCbercommits. Consider a common merge commit from a
clone of Linus's Linux repo:

    commit e80b1359858df17b0034bdf7d1b6f3e0d5b97257
    Merge: 341031c b27d515
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Thu Jan 21 08:50:04 2010 -0800
   =20
        Merge branch 'perf-fixes-for-linus' of git://git.kernel.org/pub=
/scm/linux/kernel/git/tip/linux-2.6-tip
       =20
        * 'perf-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/=
kernel/git/tip/linux-2.6-tip:
          perf: x86: Add support for the ANY bit
          perf: Change the is_software_event() definition
          perf: Honour event state for aux stream data
          perf: Fix perf_event_do_pending() fallback callsite
          perf kmem: Print usage help for unknown commands
          perf kmem: Increase "Hit" column length
          hw-breakpoints, perf: Fix broken mmiotrace due to dr6 by refe=
rence change
          perf timechart: Use tid not pid for COMM change

It seems like this kind of useful information should be a more
integral part of the metadata.

Indeed, it seems like commit messages are often used for metadata
that git perhaps *should* handle natively, like sign-offs and
multiple Authors, etc.

Of course, I'm betting that git doesn't handle such things
officially because it would require more general data structures
(especially for variable numbers of Authors) and thus slower
algorithms.

Sincerely,
Michael Witten
