From: Victor Engmark <victor.engmark@gmail.com>
Subject: textconv not used for diff
Date: Wed, 6 Oct 2010 22:36:16 +0200
Message-ID: <AANLkTi=Y2U1DqnW4oA7_MD3gZMXYzFCFYHwKuuonsmA0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 22:36:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3aiv-0000p6-A4
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 22:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0JFUgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 16:36:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33698 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab0JFUgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 16:36:18 -0400
Received: by bwz11 with SMTP id 11so5643654bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=oPLpBBGWeM0zRCpitZEAB8p2GxwrxsX20Bl+5yjOPlM=;
        b=fq0j2wkbvN/STryLdwGt/U6TUp3YE+MaDW07lssxa1Q8LsK8VPb46wuGxQ/+W+1BJC
         HZVtQ7AQXwh/+dlAHLWjiih0snJWMS9n9eyRea1yd0/Zx469A8iEbw0n0nF+FN5HotHs
         lncYUoLCthBIUJYKXyQL2g6ATlTmSoYhIB7GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=IDWB3Dz8zGAr5ifvuuW7T0SyG1Ew9zhB4HjXBljgQWRMtgDAf8X/SX04ADK/QVR8Vb
         pLrbO5S+5AXRj3Oci4gJwth1KKA3wFgj8UqcE9taWVIWcQd6GVXbU3YWJyGc7ELvWAe2
         vsQSza21p3JInhbHm3unhF5BoKP+IXZcL6ZZ4=
Received: by 10.204.68.136 with SMTP id v8mr10118663bki.88.1286397376803; Wed,
 06 Oct 2010 13:36:16 -0700 (PDT)
Received: by 10.204.46.211 with HTTP; Wed, 6 Oct 2010 13:36:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158306>

Hello,

After trying for a couple hours to get textconv to work according to
<https://git.wiki.kernel.org/index.php/Textconv> and other pages, I've
given up. I've tried changing .odt, .ott and .ods files, but git-diff
never outputs the text diff:

$ git --version
git version 1.7.0.4
$ cat ~/.gitattributes
*.odp diff=odf
*.ods diff=odf
*.odt diff=odf
*.ott diff=odf
$ cat ~/.gitconfig
...
[diff "odf"]
	textconv = odt2txt
$ odt2txt budget.ods
[produces useful output]
$ git diff
diff --git a/budget.ods b/budget.ods
index 64374b9..c4a1949 100644
Binary files a/budget.ods and b/budget.ods differ
$ git diff --textconv
diff --git a/budget.ods b/budget.ods
index 64374b9..e680dee 100644
Binary files a/budget.ods and b/budget.ods differ

Any ideas?

-- 
Victor Engmark
