From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v9 0/5] group common commands by theme
Date: Wed, 20 May 2015 21:22:56 +0200
Message-ID: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 21:23:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9aN-0002Tg-UL
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbbETTXT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:23:19 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34438 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbbETTXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:23:19 -0400
Received: by wghq2 with SMTP id q2so63267825wgh.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=LadkGEvZwzxpztFa+MVjTbg+9y+FFJZqd6koCNM2sQQ=;
        b=fx6NuunqqhdGBsQAwjzx9F1/zla9S0ZrN6b+Q7ijXpi93QjikxTuoZdkzIOR6lL+1A
         p1Fl9xnsZjlKT9g+PeWHq0S0ENVTg5cKr8BdEDu2tRDpxGthAvY9S7cZSBYk9tOOUebx
         yaS5HmGPIHTArUsaireCssMauhsuiz/6pcowtmr1DIq23QApXE0MRJUJ/DHdqy69Uzs+
         At94duqOoc71Q7rb4cPUWwYPKJIa20/8XIwzfwi+caBkEavobd8lskqXnYoy3FFUpTrI
         KOoeKK9Xy/WMYRlcAnkVCBd0Qe2+GkPdRlRBQmJAM6CjxPbdzpSG2IYZcql16WVLvweW
         0CIA==
X-Received: by 10.194.121.38 with SMTP id lh6mr66753508wjb.2.1432149797670;
        Wed, 20 May 2015 12:23:17 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id bm9sm28320276wjc.21.2015.05.20.12.23.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 12:23:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269496>

The major modification of this reroll [1] is the use of the perl versio=
n
of generate-cmdlist instead of the awk one.

help.c:
1. change the introductory message from:
	"The typical Git workflow includes:"
to:
    "These are common Git commands used in various situations:"

2. include Ramsay's patch [2]

[1]: v8: http://thread.gmane.org/gmane.comp.version-control.git/269305
[2]: http://thread.gmane.org/gmane.comp.version-control.git/269387

Eric Sunshine (2):
  command-list: prepare machinery for upcoming "common groups" section
  generate-cmdlist: parse common group commands

S=C3=A9bastien Guimmara (3):
  command-list.txt: add the common groups block
  command-list.txt: drop the "common" tag
  help: respect new common command grouping

 Documentation/cmd-list.perl |  4 ++++
 Makefile                    |  9 ++++----
 command-list.txt            | 53 +++++++++++++++++++++++++++----------=
--------
 generate-cmdlist.perl       | 50 +++++++++++++++++++++++++++++++++++++=
+++++
 generate-cmdlist.sh         | 23 --------------------
 help.c                      | 24 +++++++++++++++++++-
 6 files changed, 114 insertions(+), 49 deletions(-)
 create mode 100755 generate-cmdlist.perl
 delete mode 100755 generate-cmdlist.sh

--=20
2.4.0.GIT
