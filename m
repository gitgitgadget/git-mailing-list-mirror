From: Leonid Volnitsky <leonid@volnitsky.com>
Subject: bug report: git status --porcelain inconsistent quoting
Date: Sat, 7 Jul 2012 23:25:20 +0300
Message-ID: <CAMECdFuJMya-4sknmaT0iAXcs997zXTo1Ewt_H3pF-uUwjVncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 22:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnbaO-0002JC-6r
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 22:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab2GGUZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 16:25:51 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62749 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab2GGUZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2012 16:25:51 -0400
Received: by obbuo13 with SMTP id uo13so17417719obb.19
        for <git@vger.kernel.org>; Sat, 07 Jul 2012 13:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :x-gm-message-state;
        bh=mGPli8M8CoQmU5tBzH135ChIaUHjY5zkCWmto895kLo=;
        b=JTaku9z6X5L8OjTiE4nVzjQINFJtOqG6QarWy4DXx1bjGqLE7CO7Msbc04Acp15Ogc
         XUPGfkUp/ICtD69UMYG/0PXQ+K/oM7kfcoZUd2DiFawRRzrurQy0oCGNi2zqK0iJCKWf
         qiWPPLwRZXdVwjK+6ko5E88/tPav5CfpjkA2JcG2fgGObb3QgSTDAGVrKOW9dsLg308m
         N5YVoZM+yW4nMDAqjbmLHtU8Xghu8Ao3p+K4Wnnq9LhBg6AiVXuxbQCzelgQdAKm6d0d
         UMca6oDBLkD31Qot7/leflxjCMRAtV2HNvtyauDPMeRJwDFdkvyK/z4rt6wFBRw5Vdm7
         Oxvg==
Received: by 10.182.174.68 with SMTP id bq4mr30596988obc.53.1341692750650;
 Sat, 07 Jul 2012 13:25:50 -0700 (PDT)
Received: by 10.76.139.103 with HTTP; Sat, 7 Jul 2012 13:25:20 -0700 (PDT)
X-Gm-Message-State: ALoCoQkSIp/ZbG+KwQLJCkfDmsZb69UcUK0qSU4bDEgDjFRFcQtaMLPVibXTHVwip567/yzQ8hHU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201164>

mkdir D
cd D
git init
Initialized empty Git repository in /tmp/D/.git/
echo 1 > "with space"
git status --porcelain
?? with space                   <------------ NO QOUTES
git add with\ space
git status --porcelain
A  "with space"                 <------------- WITH QOUTES

git --version
git version 1.7.9.7

git config -l |grep quote
core.quotepath=on
