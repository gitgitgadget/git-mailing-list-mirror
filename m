From: "Gaer, A." <Andreas.Gaer@baslerweb.com>
Subject: AW: git performance after directory copy
Date: Mon, 20 Sep 2010 13:37:23 +0200
Message-ID: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B85B@ahr075s.basler.corp>
References: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp> <vpq62y0hh63.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 20 13:37:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxegh-0005wN-FP
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 13:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249Ab0ITLh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 07:37:26 -0400
Received: from mail01.baslerweb.com ([80.156.24.166]:23301 "EHLO
	mail01.baslerweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290Ab0ITLh0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 07:37:26 -0400
Received: from mail.baslerweb.com ([80.156.24.162])
  by mail01-out.baslerweb.com with ESMTP; 20 Sep 2010 13:38:10 +0200
Received: (from smtpd@127.0.0.1) by mail.baslerweb.com (8.13.4/8.13.4)
	id o8KBbOmA012592; Mon, 20 Sep 2010 13:37:24 +0200
Received: from unknown [80.156.24.166] by gateway id /processing/kw1IKOVB; Mon Sep 20 13:37:24 2010
Received: from unknown (HELO AHR075S.basler.corp) ([172.16.20.75])
  by mail01-out.baslerweb.com with ESMTP; 20 Sep 2010 13:38:09 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <vpq62y0hh63.fsf@bauges.imag.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git performance after directory copy
Thread-Index: ActYqh+KvO9aJmoXScOrsBbA5j9U4gACPe9g
X-SecurE-Mail-Gateway: Version: 5.00.3.1 (smtpd: 6.53.8.7) Date: 20100920113724Z
Content-class: urn:content-classes:message
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156616>

Hello all,

thanks Matthieu for your tip. "git diff" without "autorefreshindex"
shows that all files have different stat info. Calling "git update-index
--refresh" seems to be the right cure.

What I find a little bit confusing is that "git status" does not warn
about such a situation, or even "repair" it. As I said, I wanted to move
the project directories of several developers to a new partition without
too much interference and the first try didn't succeed because people
complained about "bad" "git status" performance (people get used to git
rocket-fast performance very soon ;-).

Maybe this was introduced in the 1.7 release: "git status" is not "git
commit --dry-run" anymore. "git commit --dry-run" does behave as you
expect: first call takes a little bit longer, subsequent calls are fast
again.

BTW, I tested on a system with git version 1.7.1 installed, but release
notes do not suggest any changes in that respect in 1.7.2 or 1.7.3.

Regards,
 Andreas.
