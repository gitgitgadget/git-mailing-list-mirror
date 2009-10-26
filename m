From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/2] pre-generated completion fix and RFC
Date: Mon, 26 Oct 2009 13:31:54 -0700
Message-ID: <1256589116-6998-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:32:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2WEb-0008VF-MT
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 21:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbZJZUb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 16:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbZJZUb7
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 16:31:59 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41351 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbZJZUb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 16:31:58 -0400
Received: by fxm18 with SMTP id 18so12431506fxm.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=K/DmEi8InnaeLMtLV1FUo2UgzE82rmosJYFuTnhnhWI=;
        b=Y3yX5XFziU6ryPQO5ZlrcOCyPyMftynEFM2duWeoib5cgamKZHxf+kzHyhfV4F4qsz
         SIzdUWatWzfYDzHKHl/7y/bqYwL+C8cYV0i+5DIyIFM3kdasoQTk6AeLxYESKTn0TW8i
         KFBDSvOjHwAPdHtmvTDP3Lwvx2xfXYdH5B3iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CYRb1vwxOuia4noLxR4bNCKtnE8VpoF91IfRO1uLanHQKtR/afLE1hRYnxXJlx9iJp
         up0DBc5zzJuC7Okht+hkT9TWdOdCk2hC7NazUiT4JgTkhnhPujZJpmFjppAlbimwnSVY
         XnlMToxXEbzIGrKfu2It2XjbepRuSSyn0KNR0=
Received: by 10.103.86.8 with SMTP id o8mr1972134mul.19.1256589122614;
        Mon, 26 Oct 2009 13:32:02 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id n10sm514037mue.17.2009.10.26.13.31.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 13:32:01 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 26 Oct 2009 13:31:56 -0700
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131266>

I should have looked at the actual generated completion before hastily
sending my last fix. Looks like we get the merge strategies twice in the
merge strategy list.

The second patch is a quick hack to have completion lazily load again
while still allowing pre-generated completion.

These are on top of next.

Stephen Boyd (2):
  completion: ignore custom merge strategies when pre-generating
  completion: allow use without compiling

 contrib/completion/git-completion.bash.generate |    1 +
 contrib/completion/git-completion.bash.in       |  132 +++++++++++++++++++++--
 2 files changed, 124 insertions(+), 9 deletions(-)
