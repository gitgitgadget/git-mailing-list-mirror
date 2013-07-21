From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/5] add git-contacts helper
Date: Sun, 21 Jul 2013 06:52:37 -0400
Message-ID: <1374403962-48361-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 12:53:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0rGf-0003TJ-Pq
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 12:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab3GUKxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 06:53:11 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35862 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855Ab3GUKxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 06:53:10 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so12621589iec.7
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=MN8Vx71pwpsXxpyPxnz85E0wibD5WK4jIQtJfoxNAsE=;
        b=RSPyRcvtxIVB/2cVDYyqsqYvCZb+fWAOnhHsQiW7Zo6vFZdXbcztRJCJSrfxpGMjqG
         S/7ko5CTMoTQvj4p2jG6+xGAWf8ELWowvDEwib17x/ht8hWTDBsDtfvpGabOGLl23KQJ
         Y8fTlk6SpuF/WdmnloDwGOgy8ZlQ4u6t51ss3QXueaAIJjaggSVrYSNYkvfmcwqArYqS
         hq+uaPqtNGCfBGtCzcAUvFIzKpoblqc/gU7LWStIijKoJrNel5Cstnpt5S/65dnUsw6K
         /Rhw4CoBvwLDopEvi3gl0t5nfNbZS0KIL+79fZ2xYIEfm9hiIkT5nPCOhSyVQqDX9m9a
         +DnQ==
X-Received: by 10.50.111.170 with SMTP id ij10mr7360047igb.9.1374403989723;
        Sun, 21 Jul 2013 03:53:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id d14sm50204105igz.6.2013.07.21.03.53.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 03:53:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.803.gd114dc6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230920>

This is v3 of the Perl rewrite of Felipe Contreras' git-related v9
patch series [1] which was written in Ruby.  v2 of this series is
here [2].

v3 adds git mailmap support and documentation.  It requires
check-mailmap [3] functionality (es/check-mailmap in 'pu'), though it
does not otherwise depend upon it textually.

Patch 1/5: Same as v2 except that the variable holding the commit
    counts for each contact has been renamed and changed from a hash
    to a hash reference in order to simplify patch 4/5.

Patch 2/5: Same as v2.

Patch 3/5: Same as v2.

Patch 4/5: New. Add mailmap support.

Patch 5/5: New. Add documentation.

Possible future directions and considerations:

* Make participation parameters (minimum-percent, blame since-date,
  -C level) configurable.

* Optimize by enhancing git-blame to accept multiple -L's.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/226065/
[2]: http://thread.gmane.org/gmane.comp.version-control.git/229533/
[3]: http://git.661346.n2.nabble.com/PATCH-v3-0-2-add-git-check-mailmap-command-td7591791.html

Eric Sunshine (5):
  contrib: add git-contacts helper
  contrib: contacts: add ability to parse from committish
  contrib: contacts: interpret committish akin to format-patch
  contrib: contacts: add mailmap support
  contrib: contacts: add documentation

 contrib/contacts/git-contacts     | 188 ++++++++++++++++++++++++++++++++++++++
 contrib/contacts/git-contacts.txt |  94 +++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100755 contrib/contacts/git-contacts
 create mode 100644 contrib/contacts/git-contacts.txt

-- 
1.8.3.3.803.gd114dc6
