From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: git fast-import/fast-export
Date: Sat, 6 Mar 2010 16:02:18 +0100
Message-ID: <fabb9a1e1003060702r671b57f4m9308863f566d5fbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>, Git List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Sc
X-From: git-owner@vger.kernel.org Sat Mar 06 22:28:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15j-0004YU-B2
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab0CFPCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:02:39 -0500
Received: from mail-px0-f171.google.com ([209.85.216.171]:45669 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab0CFPCi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:02:38 -0500
Received: by pxi1 with SMTP id 1so1514020pxi.16
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 07:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=OKYuTPWCuTMdNQLgHTNcEiXKt3WERCJdwHpcZQNa09U=;
        b=jHXv7knv+A4dC0Zg/2LLelTbRAnNiEQpPZv9ax0SnNu795suTSbmoUmglbUTntvwXs
         9pDfjOXrdB7CPMzGJZ1bg5BXO4Zg+JVOOyKyOcXZdetz76FxXjeLuzJxT7t+fXIhcul5
         EfWa5XL8YmEnn98Hvcb6/c7fSteKM6Skce9Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=tCOto1sQsYnwEMBRh+lZwdB8pGVj5+zxdhPK2v37FU9oi2raie37JrZbwehJVXIQlF
         SHMEkIuGHXh3uP3nxamJP3CKPzr3vLhq5yKdZtwHPXNHYOKWwvU16dsXyUGsv/CQe4ec
         i/y/xdo7UzN03PjRUaS4YecmavMAGRlN6pgHw=
Received: by 10.143.24.18 with SMTP id b18mr1652115wfj.16.1267887758073; Sat, 
	06 Mar 2010 07:02:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heya,

As you can read on the wiki [0] I am hoping to mentor a GSoC student
this year to work on git-remote-svn, a remote-helper for svn
implemented in C. If successful git will be able to work natively with
svn repositories, no offense to Eric, but git-svn is a tad sub-optimal
;). To do this I think the best way to go forward is to implement the
helper by hooking up a fast-import/fast-export frontend to libsvn.
Since it will be implemented in C (partially for speed, but also so
that it will be usable on Windows as well), the current fast-import.c
and builtin-fast-export.c could be of great use. Neither files have an
explicit license, (although builtin-fast-import.c says copyright by
Dscho) which puts them under the GPLv2. The libsvn bindings are apache
licensed, so we need something licensed either under the apache
license, or something compatible with that.

So my question, would it be possible to relicense fast-import.c and
builtin-fast-export.c under "GPLv2 or later" instead of the current
"GPLv2"? That way we can use (parts of) the code in the svn helper,
which will (probably) be licensed as "GPLv2 or later" as well.

[0] http://git.wiki.kernel.org/index.php/SoC2010Ideas#A_remote_helper_for_svn

-- 
Cheers,

Sverre Rabbelier
