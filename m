From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 0/4]
Date: Thu, 02 Jan 2014 17:12:07 +0100
Message-ID: <52C58FD7.6010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 02 17:12:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vyksg-0007mc-Ct
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 17:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbaABQMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 11:12:18 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:45495 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaABQMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 11:12:16 -0500
Received: by mail-bk0-f43.google.com with SMTP id mz12so4590374bkb.16
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 08:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=w3mywBceptEzV8hduHs2JYN0ZHk010xWUQphqjdhjD8=;
        b=CHBdJo9OKZUA8yO99yvb8GLgz7TsSpLUyedYHyAF/exwFRgSqg/279T3ng5zjx3Qiq
         A1+I91SuxgDhtEnZfks4Jv256ltBmX8L9XyDGzRufzi4llxb0/I0x5Zhtg+68O3zBxdV
         635zgSW78WoqRQZIJaOxQDC5hZGt3wTDz4ySadorqX0AiReRSKXASHUKHbIDQULSyUHP
         e8ZNyi19INlNu9/PH5Rso5EoirtXuFNQUg3OYm2iODw3A9c/4oKGGDONii6UASZznLS2
         HnEx1PyP5if/pVGRL3l9OPAZYP8z0Qq8GMZSQ584UAx+YAN0XhrXh99/OKQX7S2aJyLP
         L9ig==
X-Received: by 10.205.47.202 with SMTP id ut10mr49093bkb.133.1388679134896;
        Thu, 02 Jan 2014 08:12:14 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id ch4sm15354320bkc.8.2014.01.02.08.12.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 08:12:14 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239853>

This is the second iteration of the patches in

http://www.spinics.net/lists/git/msg222428.html
http://www.spinics.net/lists/git/msg222429.html

which

* adds a commit to use the term "builtin" instead of "internal command",
* also modifies the docs accordingly,
* moves the is_builtin() declaration to the existing builtin.h,
* finally moves all builtin-related definitions to a new builtin.c file.

Sebastian Schuberth (4):
  Consistently use the term "builtin" instead of "internal command"
  Call load_command_list() only when it is needed
  Speed up is_git_command() by checking early for internal commands
  Move builtin-related implementations to a new builtin.c file

 Documentation/technical/api-builtin.txt |   4 +-
 Makefile                                |   1 +
 builtin.c                               | 225 ++++++++++++++++++++++++++++++
 builtin.h                               |  23 +++
 builtin/help.c                          |   6 +-
 git.c                                   | 238 +-------------------------------
 6 files changed, 262 insertions(+), 235 deletions(-)
 create mode 100644 builtin.c

-- 
1.8.3-mingw-1
