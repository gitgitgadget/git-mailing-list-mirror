From: "Eduardo R. D'Avila" <erdavila@gmail.com>
Subject: [PATCH/RFC 0/3] enable color prompt in non-pcmode
Date: Sun, 16 Jun 2013 14:32:09 -0300
Message-ID: <cover.1371402672.git.erdavila@gmail.com>
Cc: felipe.contreras@gmail.com, t.gummerer@gmail.com,
	artagnon@gmail.com, zoltan.klinger@gmail.com, hegge@resisty.net,
	martinerikwerner@gmail.com, s.oosthoek@xs4all.nl,
	gitster@pobox.com, jonathan@leto.net, szeder@ira.uka.de,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 19:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoGoi-0008Pa-8z
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 19:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab3FPRcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 13:32:24 -0400
Received: from mail-ye0-f174.google.com ([209.85.213.174]:42198 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347Ab3FPRcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 13:32:23 -0400
Received: by mail-ye0-f174.google.com with SMTP id m9so707369yen.5
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6U6YKcG6B6w0AYYJGxpu0TRJj9Kl+RJ10jnSoImVOE4=;
        b=Vj4s6sBsTGSt510xp7QxLk7rJ4tJ6/CHDt1qwlz6CadljhJe0tA6iOvsvzaQuXUo9p
         Es0VFLP9C21qPHZOnxj5ZX97Oe4/M6qvu30bHavUR8UJByapcyZds9Dc35BGBJyaqdhc
         AvUfdpE/85+w/yHYfMfSr9Gk/y15raLjD76srdpGj0JrmkYQS1H0W+vJqD++4SZ43Ivp
         WWcH+me1ts849TtD6LXLC58D5Rrezv5ArPbknt3OSHJm3Hi+WkcLfT85yWO9Ha5fSLRL
         4w8sD4eikVlByOg8grvN34uK2jXPIpwsaASXLsPjTwChvrzjD4LdqrG0msdCmARrdd6c
         QFjA==
X-Received: by 10.236.222.193 with SMTP id t61mr5090674yhp.117.1371403942336;
        Sun, 16 Jun 2013 10:32:22 -0700 (PDT)
Received: from localhost.localdomain ([177.18.63.49])
        by mx.google.com with ESMTPSA id s29sm18661561yhf.6.2013.06.16.10.32.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 10:32:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.440.g82707f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228017>

The use of colors in a prompt is only possible in
pcmode (using the variable PROMPT_COMMAND).

Make color prompt work in non-pcmode (using the
variable PS1) for both Bash and ZSH.

This requires editing __git_ps1() and __git_ps1_colorize_gitstring(),
which have duplicate code to handle the prompt
gitstring and color codes.

Prior to enable colors in non-pcmode, refactor
__git_ps1() and __git_ps1_colorize_gitstring().

Eduardo R. D'Avila (3):
  t9903: add tests for git-prompt pcmode
  git-prompt.sh: refactor colored prompt code
  git-prompt.sh: enable color prompt in non-pcmode

 contrib/completion/git-prompt.sh |  91 +++++--------
 t/t9903-bash-prompt.sh           | 269 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 301 insertions(+), 59 deletions(-)

-- 
1.8.3.1.440.g82707f8
