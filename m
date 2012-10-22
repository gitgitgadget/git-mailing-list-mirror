From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 0/3] completion: refactor and zsh wrapper
Date: Mon, 22 Oct 2012 03:45:39 +0200
Message-ID: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 03:46:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ75h-0002lO-DQ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 03:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778Ab2JVBpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 21:45:54 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58869 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688Ab2JVBpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 21:45:53 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1181979wey.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 18:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=nKhagon1v47t0Z76AQEeNnKmfNY69jnN2rVwIJmg+Is=;
        b=V5w0lRgGnSH/OJsxXsFAtq4+003H+FlFYHYgF01Eoya25aYzQVZSjeau+wnouMlq9D
         MqQfOYkm5xO1AAoh40zu86qH2An0dAK897OK8cF3a0UdregKxi+N8oX8AJUsaaTduBjh
         WJK0bI4YJ63msc5TDakK5Yo1a4z4Mwuc436eZSVRr9TGRKoyyi4AJpmQZsCWPTescB4f
         qcE+LyIru81q86ewWTjSRswDbrx/1CKP1bhqNwLlzi+l2e5cpMJsPLMMOp6KarWtRiBv
         5advFDcrrpOdb8PURSXF2Qdl5xU64QagY1OxQSjLoNcGkWQjxqvF9zs+PdNB8hS33FUq
         +ZjA==
Received: by 10.180.103.38 with SMTP id ft6mr17549879wib.9.1350870351918;
        Sun, 21 Oct 2012 18:45:51 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id dq6sm14646669wib.5.2012.10.21.18.45.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 18:45:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208170>

Hi,

Here's a bit of reorganition. I'm introducing a new __gitcompadd helper that is
useful to wrapp all changes to COMPREPLY, but first, lets get rid of
unnecessary assignments as SZEDER suggested.

The zsh wrapper is now very very simple.

Since v5:
 
 * Get rid of unnecessary COMPREPLY assignments

Felipe Contreras (3):
  completion: get rid of empty COMPREPLY assignments
  completion: add new __gitcompadd helper
  completion: add new zsh completion

 contrib/completion/git-completion.bash | 41 ++++++-----------------------
 contrib/completion/git-completion.zsh  | 48 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 33 deletions(-)
 create mode 100644 contrib/completion/git-completion.zsh

-- 
1.8.0
