From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: /* in .gitignore
Date: Tue, 25 Sep 2012 13:18:53 -0700
Message-ID: <CAE1pOi1vEGVcg5wn9VjkSVmMO_hparmYP0hn86XwpSpMmB=Peg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 22:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGbbI-0007CW-By
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 22:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab2IYUTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 16:19:15 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42877 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab2IYUTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 16:19:14 -0400
Received: by bkcjk13 with SMTP id jk13so1495072bkc.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=kvficvxC3ud+RaTxo2i3N2PQej8nB37cBjTPLa67qd0=;
        b=VCzo4VJy3h+1pijh+DBDHgJ2OTmISR+zdLr3IIjB0EeTJzpEFkg5HvW46S+68fjP0z
         oTrLsDT7DgjF+1VRulkCx1WorAwY5iK3vIXT7Kw16NJYTlRGzg3e8V+84BA9SBvkw4e5
         GEs+92A1O6PViE33Ke3AVgXNQpuTSFrwlbL9bU1QUrSZu1ORKJsAQ4SxMbFosLSzbIr0
         IwBmkGbgqII2O+s4D2bR+59CoNS+c+AzVYLtMN0J7gqV32S89E3VBz6OelES8ng6iD0A
         yT1nQBAym9ZnIFXHPCSVjQRR+nz6q8vVYN5uE8mSvOMMQwnpRHD+mWdaHAzIl5h5vjwI
         zHgw==
Received: by 10.204.151.9 with SMTP id a9mr2538304bkw.2.1348604353615; Tue, 25
 Sep 2012 13:19:13 -0700 (PDT)
Received: by 10.205.32.15 with HTTP; Tue, 25 Sep 2012 13:18:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206376>

Hi all,

If you add "/*" (or "*") to '.gitignore' Git will ignore '.gitignore'.
This means that your '.gitignore' appears to work (which in fact it
does) but really it will only work for you because your '.gitignore'
will not be added to the repository. You have to override with an
explicit "!/.gitignore" for it to work correctly. (Or use "git add -f
.gitignore".)

Naturally, this behaviour makes perfect sense: "/*" means everything.
Still, I was wondering whether it might be a good idea to make an
exception for '.gitignore' itself? Then if somebody *really* wanted to
ignore '.gitignore' they could add "/.gitignore" to '.gitignore'?

Cheers,
Hilco
