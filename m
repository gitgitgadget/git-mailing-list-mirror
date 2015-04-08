From: "=?UTF-8?q?M=C3=A1rcio=20Almada?=" <marcio.web2@gmail.com>
Subject: [PATCH] fix global bash variable on __gitcompappend
Date: Wed,  8 Apr 2015 02:45:57 -0300
Message-ID: <1428471958-12339-1-git-send-email-marcio3w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 07:46:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfioW-0004PL-59
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 07:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbbDHFqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2015 01:46:07 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36493 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbDHFqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 01:46:05 -0400
Received: by qku63 with SMTP id 63so73243201qku.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=CApUZLxwlg5NIflS7HFDpiT+EzXlBzIOHTvYdl6zpqs=;
        b=NV+F2RdkCIOHVcg51/Jb/iKAT6tB1qVJFMGz42T93xAPWr/49FUFINVIM4Ecq6FPJM
         AA0qcf8DZBalwaCHTqmtb/CYEoiw4B5a9kZPJIcCmdQHbNXiBTLPqdBSN9F92vH6okU4
         N72IWlBpfS0RHtgt9DICFAdGOkLmXOZp9O3GosVh7iWlarqWRzXfySs/WxFpVqPmIrpg
         2P+o3z4JEC6sYJ6cSthXyGJAO1NFF5pVWny9O2wSrjrCjnLjfZGK5vbbmgUGQIEChgQJ
         M4RNSAiCpCX5aVK+xPEG10n7AEj3Q3JqDw0BjWP9kXQq9KraPbiS1TYvCCqT3CNbTRw4
         YKmQ==
X-Received: by 10.140.129.65 with SMTP id 62mr29007424qhb.11.1428471964555;
        Tue, 07 Apr 2015 22:46:04 -0700 (PDT)
Received: from localhost.localdomain ([191.6.114.155])
        by mx.google.com with ESMTPSA id b141sm2717093qka.11.2015.04.07.22.46.02
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Apr 2015 22:46:04 -0700 (PDT)
X-Google-Original-From: =?UTF-8?q?M=C3=A1rcio=20Almada?= <marcio3w@gmail.com>
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266949>

Hi,

This is how to reproduce the bug:

```
git checkout [tab-tab]
echo $x # outputs the name of the last branch on completion list
```

Or more directly:

```
__gitcompappend "something"
echo $x # outputs 'something'
```

Might not be a big deal, but it's annoying to know that `$x` is lurking=
=2E

M=C3=A1rcio Almada (1):
  fix global bash variable leak on __gitcompappend

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
1.9.3
