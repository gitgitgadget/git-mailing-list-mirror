From: Carlos Pita <carlosjosepita@gmail.com>
Subject: Add submodule specifying depth and branch at the same time won't work
Date: Mon, 12 Oct 2015 16:48:09 -0300
Message-ID: <CAELgYhcmzDEVRH9neGwZeqVBduL-nb=d+XoSMwRGKpmLUeX83g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 21:48:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlj5M-000732-52
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbbJLTsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:48:30 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33774 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbbJLTs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 15:48:29 -0400
Received: by oiar126 with SMTP id r126so41070474oia.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=XI4/5Xd1Gyp1wRuPJYGV1YGSNUyIYFItV6SDeWa8OUI=;
        b=GlsTpjpn5a4Cfe1jRbMGiVxYpNaVL2ggyghQvmWtvBb6Gc8fPSz9MnxZux27sMiMHn
         aFzwPZTSexFsKr5qfiT8V5Gq5MKu7v0LBJy8y0BUBVafvsnPig9g9CsnUfGieE+NfvSa
         j3Q3YyoXLNSq4cpd083dyRX5iOvPEgGb0DuJdNqbkOKOxvatSyU4onio12PhKKYm4M7+
         iyHAjG74BK0lZVv2SV58BZLw21yOLJ4Zn4HHQJUtntnU1dYSl3xEZP5b1BhkDy8EFvYQ
         RHDsg4FNA6KnB5WiJTsTTI6/yVoG6aIW3LxwRHkgyje9Vb6BcCiIPbxqxHn7Qi2E02pj
         wnrQ==
X-Received: by 10.202.83.19 with SMTP id h19mr16261499oib.119.1444679309128;
 Mon, 12 Oct 2015 12:48:29 -0700 (PDT)
Received: by 10.182.28.37 with HTTP; Mon, 12 Oct 2015 12:48:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279410>

For example, I can do:

git clone --depth 1 --branch devel git@gitlab.com:memeplex/bash.git

But if I try:

git submodule add --depth 1 -b devel git@gitlab.com:memeplex/bash.git

I get:

fatal: Cannot update paths and switch to branch 'devel' at the same time.
Did you intend to checkout 'origin/devel' which can not be resolved as commit?
Unable to checkout submodule 'src/aur/bash'


I think the devel branch is left outside the update because depth is
just 1, but then the same could be said for the clone, which just
works. The request should be interpreted as depth 1 inside devel
branch.
