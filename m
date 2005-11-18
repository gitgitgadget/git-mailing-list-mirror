From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Fix a bug in get_all_permutations.
Date: Fri, 18 Nov 2005 22:53:24 +0100
Message-ID: <437E4D54.60901@etek.chalmers.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home> <437C819C.4040507@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Fri Nov 18 22:53:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdEAO-0003mu-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbVKRVxD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Nov 2005 16:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbVKRVxB
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:53:01 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:24285 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1161269AbVKRVxA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 16:53:00 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 437DDFC2000174AC; Fri, 18 Nov 2005 22:52:53 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: junkio@cox.net
In-Reply-To: <437C819C.4040507@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12268>

This line was missing in the previous patch for some reason.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>

---

 pack-redundant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 5b820842ce0afb836ddbeded3a3f9e8d0ba223f9
e65d77b8ece9f6e463de0ceeaf6812a2df6d7d96
diff --git a/pack-redundant.c b/pack-redundant.c
index 3655609..3e3f33a 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -291,6 +291,7 @@ struct pll * get_all_permutations(struct
 		hint[0] =3D new_pll;
 		new_pll->next =3D NULL;
 		new_pll->pl =3D list;
+		new_pll->pl_size =3D 1;
 		return new_pll;
 	}
=20
---
0.99.9.GIT
