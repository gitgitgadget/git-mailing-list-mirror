From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/5] completion: compgen/compadd cleanups
Date: Sat, 17 Nov 2012 02:38:13 +0100
Message-ID: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 02:39:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZXN2-0004Op-Gm
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 02:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab2KQBie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 20:38:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39206 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2KQBid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 20:38:33 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1411525bkw.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 17:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=C724WJQsw2EKIrN7vfWyrwU1dSrjBNs8ZLVj0nd+3k8=;
        b=RFS9nO86ihyfs8gIVPFYXV0QbdHY47eA7cygcaf6Mng78ULkskNzEySkDna0tS81Wi
         mEKpC8wGDjFMSn/Nc8MBKvP+zpTLkh3/T8A5ptFe7QnbTvOEBSE1MpMpJCTeqKtIPXUQ
         Vrfi94LJX97mppGx+/oWLtbbJWUymVZ+nizuNGiTv4JcU5J7HYDEFsrHnT9VBxhuRjo7
         xnLSm0XdmxFmO9w+0sCJaVt2KvyR4neeaWR2FboyWqwyHnOx7gmGGuclpSDZ7w8mlXgD
         XVCPSwTwwKbew2OB5LKE51by+LCb8fRbouXGv+uSs2WPWbjItpVcweV+/Nzuy/e56xyV
         N2Zg==
Received: by 10.204.3.206 with SMTP id 14mr2690465bko.120.1353116312011;
        Fri, 16 Nov 2012 17:38:32 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id ht18sm2007709bkc.14.2012.11.16.17.38.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Nov 2012 17:38:30 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209927>

Hi,

These were hinted by SZEDER, so I went ahead and implemented the changes trying
to keep in mind the new zsh completion werapper. The resulting code should be
more efficient, and a known breakage is fixed.

The first two patches come from another patch series for convenience.

Take them with a pinch of salt.

Felipe Contreras (5):
  completion: get rid of empty COMPREPLY assignments
  completion: add new __gitcompadd helper
  completion: trivial test improvement
  completion: get rid of compgen
  completion: refactor __gitcomp_1

 contrib/completion/git-completion.bash | 68 +++++++++++++---------------------
 t/t9902-completion.sh                  |  3 +-
 2 files changed, 27 insertions(+), 44 deletions(-)

-- 
1.8.0
