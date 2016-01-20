From: dis trans <humanoidanalog@gmail.com>
Subject: Bug(ish) - Documentation of .gitattributes Globbing Syntax Whitespace Escapes
Date: Wed, 20 Jan 2016 12:35:37 -0800
Message-ID: <CAN1fZZGqERtA1FqSH1sxi4T74TB4sex7kBPBM8J4fVimQO1eSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 21:35:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLzTi-00023K-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 21:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbcATUfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 15:35:39 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33185 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbcATUfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 15:35:38 -0500
Received: by mail-ob0-f175.google.com with SMTP id is5so17342480obc.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 12:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CMxlnc89+vYfvkYIs+KQ2e0gD76Qj7Qt47Mr3ouV/ZY=;
        b=KqG5Im412+Q2PgLaEYW/zIoqaTjUXzIbt9ZTMd97uajzZZJpb+Sj91tzfkROIMAUVQ
         WHF/CYmcsZwRPix7HLag6MbwJmfRrZhPN4oyKUhZWAp2A80AHmH/74MLHdsaDhRL+CIF
         e9fd+/ccGB+GU6U6B/qcv8Tr0KjYY/VYMPCnopbv/cmXzGwqHwX/cTQponA4Ox/pvZb/
         wIA/BA3U5LpLULyFxyqpqkIlq1wlqz0AKdSYkHWy4Ku3gh3qXIOsAl/XQOmTBjPSAx+h
         mk0PzxwWVCT7VtGbVM7TIpMTnQhS64WEy5rXVXrFjCU3Uc7DvY0WMvZ+wss8WGEX5H4Z
         Ml8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=CMxlnc89+vYfvkYIs+KQ2e0gD76Qj7Qt47Mr3ouV/ZY=;
        b=Z8OfXm4ZW7SNBK8Tk/mRLIxrFe2lDGjbBR7Sg6nOqJbP2Yo8dqaj053r+78tDKI03K
         YMfyO73uhhbeb/5Mzc1/BlQhi6Jj18gbec7q+cRMsY9wnsXFzCvKDXw1PQHC02FPUtN2
         fI9kAf1lV1s7as4mbi+CDqh83ahwgo3GMQIWhNJ8CBTe+pCaeKZXt0QbvvvYAsQwxO5s
         xvFLZ/QJc8GvhqUGFxwgUyN0ieO4g63SIh52fkOmb6/XGhyduXK8rJlccvhpIDR3IbkH
         O5cKIi0+YNtvJLfUU5HcVkh8i627IpBDvIBTRkKP+zphN9gWSK0vl7VXxnP7YzgWVj7O
         MsHw==
X-Gm-Message-State: AG10YOS7OjDB+zrnl0YtYndQN/LBGmBm2oJCdz6IIpfY+u5AZLb/9X4aPTpyQJvUpSY1v2+/mv5ajnL5GvAaww==
X-Received: by 10.182.33.101 with SMTP id q5mr27414563obi.28.1453322137345;
 Wed, 20 Jan 2016 12:35:37 -0800 (PST)
Received: by 10.202.173.145 with HTTP; Wed, 20 Jan 2016 12:35:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284464>

In the documentation for .gitattributes, "[[:space:]]" is mentioned in
a code snippet but is
not documented, and neither is the glob syntax escape from the
documentation page for
.gitignore ("\ ") not working with .gitattributes.

For example, in a .gitattributes file the first glob will work, but
the second will not.

my[[:space:]]directory/**/*
my\ directory/**/*

The opposite is true with .gitignore.

I got caught up for a number of minutes trying to figure out why my
escapes weren't
working in the fancy-pants .gitattributes I whipped up, and I'd
figured it'd be worth saving
someone else the trouble. It could very well be documented somewhere
I'm not aware of
beside the code snippet, but I wasn't able to find it seldom a github
issues search, so I
think it'd be worth putting on the .gitattributes page.

PS -- Apologies for not having a diff to send to fix this, but I don't
currently have the tools
available to me.
