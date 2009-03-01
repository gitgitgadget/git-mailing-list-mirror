From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [PATCH 0/2] git-pull: Allow --stat and --no-stat to be used with --rebase
Date: Sun,  1 Mar 2009 22:28:26 +0100
Message-ID: <1235942908-5419-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 22:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdtBl-0004Gx-EL
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792AbZCAVZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 16:25:34 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755657AbZCAVZd
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:25:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:28403 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbZCAVZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 16:25:32 -0500
Received: by fg-out-1718.google.com with SMTP id 16so868648fgg.17
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 13:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=/6fKlcED5/jF0pp5r+zC1GA9USkuwEmUoOC07uQlu9A=;
        b=WE0+/zspDMfCS6aX9yWI2e3Zx3FocGgXqZxsNIx0kLJnyVlcaw5x83PQF+VfiNH/Tl
         Cszy55Y0a535cp0NgD94nfHR12hLcy1RZIc9V3LWVx5dG2xjQXzUYU4FYPNbpFCWUSn0
         Sk2rg+xu6oMuS12sIZpfpGm8s5HzgK3+62XOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EIF2s4upZRpRcnsctC85VfCk5kKTy1yH9okCUrofwQAYmueIMKD1dcfS5k3ZjrkQjP
         wMqYd5NTeU6QvVrsDP5ZPAWxJY22aM7vNp25A/JanY1CpRifFQiodaJRguR7JQeAeSnc
         7BV0uuvUm4Dr7iUpYLeAc69AkdHm3X/iIlGPA=
Received: by 10.86.66.19 with SMTP id o19mr5852594fga.7.1235942730104;
        Sun, 01 Mar 2009 13:25:30 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 12sm4792572fgg.33.2009.03.01.13.25.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 13:25:29 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 65BBC468001; Sun,  1 Mar 2009 22:28:27 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc2.11.g80931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111874>

These two small patches teach git-rebase to understand --stat, and git-=
pull
to forward --stat to git-rebase when used with --rebase. Comments welco=
me!

Tor Arne Vestb=C3=B8 (2):
  git-rebase: Add --stat and --no-stat for producing diffstat on rebase
  git-pull: Allow --stat and --no-stat to be used with --rebase

 Documentation/git-rebase.txt |   17 ++++++++++++++++-
 git-pull.sh                  |   10 +++++-----
 git-rebase.sh                |   25 ++++++++++++++++++-------
 t/t3406-rebase-message.sh    |   23 ++++++++++++++++++++++-
 4 files changed, 61 insertions(+), 14 deletions(-)
