From: Gustav =?utf-8?b?SMOlbGxiZXJn?= <gustav@gmail.com>
Subject: [PATCH 0/2] Setting git tree of a patch (improved version)
Date: Mon, 24 May 2010 20:52:09 +0200
Message-ID: <20100524184908.30884.65042.stgit@sambuntu>
References: <AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	kha@treskal.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 20:52:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGclS-0006Nj-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 20:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab0EXSwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 May 2010 14:52:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45381 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab0EXSwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 14:52:16 -0400
Received: by wyb29 with SMTP id 29so1784268wyb.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:to:from:cc:date
         :message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=Wtic9ZbhYbvRoWz+gU5HYpFdAEFr8ZR+AC1q5LRKt7w=;
        b=jwbWIHiUeuRchzOILvbv9oNYNfodkx0bqK2WZ2qxDG/pT4BW07aRaKOh1KkHyMkJPc
         JWSpSa75kXQ5OVTYQpHv39UdFOpk+oT8QxnY5NiuUd2JqTPWF6HXOccdGad+kSWRc9nJ
         AnuNuvl6kwIUhYToz03TsSvq5PwFhdD0wfWzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=siqCoeJacnRiOUePYYIqUmKvejpsRgMBNDaDIDV6sV4ST/r2QRxRSSP95WudsgsSVa
         zXvm4TWWf1YoqM5I0oYldgtf9N7wyagp7zI5orUcSIiHEFo+1kxtkVsLnuctQ2vTZ/aL
         BNhTECzg+5bsCrLw8mz6HCTWq7KnIo59M9xSc=
Received: by 10.216.170.83 with SMTP id o61mr3536521wel.37.1274727134693;
        Mon, 24 May 2010 11:52:14 -0700 (PDT)
Received: from [127.0.1.1] (c-97d7e255.66-15-64736c12.cust.bredbandsbolaget.se [85.226.215.151])
        by mx.google.com with ESMTPS id 16sm2046479ewy.3.2010.05.24.11.52.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 11:52:14 -0700 (PDT)
In-Reply-To: <AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
User-Agent: StGit/0.15-96-g5d79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147640>

I solved (I think) how to accept (and verify the correctness of) a
tree-ish as argument for 'edit --set-tree'. The first patch in the
series adds support to Repository.rev_parse() for doing that.

The main (the second) is essentially the same as before.

I moved the --set-tree option to be last in the list of options,
making it even more obscure-looking.

---

Gustav H=C3=A5llberg (2):
      Repository.rev_parse: support commits, trees, and blobs
      edit: Allow setting git tree of a patch


 stgit/commands/edit.py |   39 ++++++++++++++++++++++++++++-----------
 stgit/lib/git.py       |   10 ++++++----
 t/t3300-edit.sh        |   15 +++++++++++++++
 3 files changed, 49 insertions(+), 15 deletions(-)

--=20
