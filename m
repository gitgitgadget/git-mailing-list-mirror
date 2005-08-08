From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: A simple script to do the reverse of git-push
Date: Mon, 8 Aug 2005 23:25:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508082318400.2911@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463794688-963876772-1123536349=:2911"
X-From: git-owner@vger.kernel.org Mon Aug 08 23:27:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2F85-0003cP-HB
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 23:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVHHVZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVHHVZv
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 17:25:51 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65155 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932267AbVHHVZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 17:25:50 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 5EBB2E32BA
	for <git@vger.kernel.org>; Mon,  8 Aug 2005 23:25:49 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 4274CB34F9
	for <git@vger.kernel.org>; Mon,  8 Aug 2005 23:25:49 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 20FA9AC856
	for <git@vger.kernel.org>; Mon,  8 Aug 2005 23:25:49 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 11278E32BA
	for <git@vger.kernel.org>; Mon,  8 Aug 2005 23:25:49 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794688-963876772-1123536349=:2911
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi list,

I mentioned in another mail that I needed the opposite of git-push, namely 
getting all heads, and if they are strict parents of the local refs, just 
update them.

Well, Junio pointed out that it's easy using the available tools, and he 
was right. The result is attached (and tested...).

This script makes it easy to work with a central repository, multiple 
heads and users, in a CVS style: to start your day, you call the attached 
script, and after you have committed something, you can do a push on the 
repository. Sometimes, the push fails, then you have to pull that branch 
in order to merge it before trying a push again.

BTW, if you are lazy, like me, you just pull from Junio once in a while 
and do a "make test". Turns out there is a missing dependency though:

peek-remote.o: cache.h

which in my case lead to a git-peek-remote program which was unable to 
peek any ref.

Ciao,
Dscho

---1463794688-963876772-1123536349=:2911
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=git-fetch-all-heads-script
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0508082325490.2911@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Description: 
Content-Disposition: attachment; filename=git-fetch-all-heads-script

IyEvYmluL3NoDQoNCi4gZ2l0LXNoLXNldHVwLXNjcmlwdCB8fCBkaWUgIk5v
dCBhIGdpdCBhcmNoaXZlIg0KDQouIGdpdC1wYXJzZS1yZW1vdGUgIiRAIg0K
cmVwbz0iJF9yZW1vdGVfcmVwbyINCg0KZ2l0LWxzLXJlbW90ZS1zY3JpcHQg
LS1oZWFkcyAiJHJlcG8iIHwgd2hpbGUgcmVhZCBzaGExIHJlZm5hbWU7IGRv
DQoJc2hvcnRuYW1lPSQoYmFzZW5hbWUgJHJlZm5hbWUpDQoJaWYgWyAtZSAk
R0lUX0RJUi8kcmVmbmFtZSBdOyB0aGVuDQoJCWlmIFsgJHNoYTEgPSAkKGNh
dCAkR0lUX0RJUi8kcmVmbmFtZSkgXTsgdGhlbg0KCQkJZWNobyAkc2hvcnRu
YW1lIHVwIHRvIGRhdGUuIDE+JjINCgkJCWNvbnRpbnVlDQoJCWZpDQoJZmkN
Cg0KCWdpdC1jYXQtZmlsZSBjb21taXQgJHNoYTEgPi9kZXYvbnVsbCAyPiYx
IHx8DQoJZ2l0LWZldGNoLXNjcmlwdCAkcmVwbyAkc2hvcnRuYW1lDQoNCglp
ZiBbICEgLWUgJEdJVF9ESVIvJHJlZm5hbWUgXTsgdGhlbg0KCQllY2hvIEdv
dCBuZXcgaGVhZCAkc2hvcnRuYW1lIDE+JjINCgkJZWNobyAkc2hhMSA+ICRH
SVRfRElSLyRyZWZuYW1lDQoJZWxzZQ0KCQlvcmlnc2hhMT0kKGNhdCAkR0lU
X0RJUi8kcmVmbmFtZSkNCgkJaWYgWyAteiAiJChnaXQtcmV2LWxpc3QgJG9y
aWdzaGExIF4kc2hhMSkiIF07IHRoZW4NCgkJCWVjaG8gVXBkYXRlZCBoZWFk
ICRzaG9ydG5hbWUgMT4mMg0KCQkJZWNobyAkc2hhMSA+ICRHSVRfRElSLyRy
ZWZuYW1lDQoJCWVsc2UNCgkJCXNhdmVyZWY9JEdJVF9ESVIvRkVUQ0hfSEVB
RF8kc2hvcnRuYW1lDQoJCQllY2hvIEVycm9yOiAkc2hvcnRuYW1lIG5vdCBh
IGNoaWxkIG9mIHJlbW90ZSBoZWFkIDE+JjINCgkJCWVjaG8gIglTYXZlZCBy
ZW1vdGUgaGVhZCB0byAkc2F2ZXJlZiIgMT4mMg0KCQkJZWNobyAkc2hhMSA+
ICRzYXZlcmVmDQoJCWZpDQoJZmkNCmRvbmUNCg0K

---1463794688-963876772-1123536349=:2911--
