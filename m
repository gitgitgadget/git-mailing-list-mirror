From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH v2 0/5] git-prompt: cleaning and improvement
Date: Wed, 26 Jun 2013 00:05:12 -0300
Message-ID: <cover.1372211661.git.erdavila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	gitster@pobox.com, "Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 05:06:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urg3m-00041b-KV
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 05:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab3FZDGO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 23:06:14 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:54574 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3FZDGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 23:06:14 -0400
Received: by mail-yh0-f49.google.com with SMTP id v1so6216690yhn.36
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 20:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=f0tUXvop8/b/EPC+9fAyfevqYOqJpe9O9jLQUTfavI4=;
        b=OSmuLS9FJosm1GKbD68zmsE30TZj2T9q0LREMdaOkuzS57xlGwD2AnvIixYqeg5OGq
         g7pd+LVUZr38KQlDTqSUeZb9HdFWKMuakdFUSpiJPOA/jTWy+cMuVQGYpjHy3qTqkala
         eXT/xPx/0Lkp+GaEaU8PzQVIEa2LuN36kUttfaFrZqDFtE8iP+22ZsRkb9wKrLdsq/R+
         8H/+yFkyO5qmXo4eDLkROQYoWdM6+vwv+ALaM2V8/i9QJr5YYWxrjtk5V7615BxvUhwz
         i2yYWS7WDmTDNSmRxXdMVe1sS5TR25+HEDHtPbSta8dkq3ZaT1ynpkT/CW6pi/Yu8muz
         m8gQ==
X-Received: by 10.236.123.210 with SMTP id v58mr1075062yhh.64.1372215973350;
        Tue, 25 Jun 2013 20:06:13 -0700 (PDT)
Received: from localhost.localdomain (200.175.80.235.dynamic.adsl.gvt.net.br. [200.175.80.235])
        by mx.google.com with ESMTPSA id y70sm42415518yhe.15.2013.06.25.20.06.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 20:06:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.590.g42a98dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229021>

Changes since the first version [1]:
 - During refactorization in 2/5, mention what the lack of \[...\] can =
affect.
 - New patch 3/5 that removes redundant tests (noticed by SZEDER G=C3=A1=
bor [2])
 - Rephrasing in 5/5:
   - rephrasing suggested by SZEDER G=C3=A1bor [3]
   - rephrase some parts that mention only the "current branch name" be=
ing
     displayed in the prompt by stating that the "repository status"
     is displayed.
   - explain the color codes in the ZSH precmd example (there was an
     explanation that applied only for the Bash example, but it was not
     clear that it did not apply to ZSH).

=46ollowing G=C3=A1bor's example, I merged his patches series [4] to mi=
ne
and published at:

  https://github.com/erdavila/git.git bash-prompt-speedup-and-color-ref=
actorization

Both G=C3=A1bor's and my series were rebased/applied on top of the
current master 9832cb9d4d.

Thanks,

Eduardo

[1] http://thread.gmane.org/gmane.comp.version-control.git/228566
[2] http://article.gmane.org/gmane.comp.version-control.git/228705
[3] http://article.gmane.org/gmane.comp.version-control.git/228707
[4] http://thread.gmane.org/gmane.comp.version-control.git/228851

Eduardo R. D'Avila (5):
  t9903: add tests for git-prompt pcmode
  git-prompt.sh: refactor colored prompt code
  t9903: remove redundant tests
  git-prompt.sh: do not print duplicate clean color code
  git-prompt.sh: add missing information in comments

 contrib/completion/git-prompt.sh | 111 ++++++++++++------------------
 t/t9903-bash-prompt.sh           | 141 +++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 182 insertions(+), 70 deletions(-)

--=20
1.8.3.1.590.g42a98dd
