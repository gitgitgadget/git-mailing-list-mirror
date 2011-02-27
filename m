From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 0/2 v2] Adding Beyond Compare as a merge tool
Date: Sun, 27 Feb 2011 12:28:28 +0100
Message-ID: <4D6A355C.3000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>, charles@hashpling.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 12:28:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pteo2-0006FT-JM
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 12:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034Ab1B0L2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 06:28:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48726 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab1B0L2j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 06:28:39 -0500
Received: by fxm17 with SMTP id 17so2955804fxm.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 03:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:content-type:content-transfer-encoding;
        bh=FUUdxm6nM5Kt++i40mzrMV63bu5ATTEv8qQYnIoNd+I=;
        b=ZKmuPjecWN0uNWzQx7aZ63r6xHAA9J47fPPikZpCX40d53phyihhrmNhMUSYclvZgp
         ghi6bmoIA53tlnE0ZNuNAUp7jzIl80avdZz0XA6d5+2uKP5ilYSCGwzvybKJGOEQttF5
         ynjI2FCX/uiG/uWVeWPxeqExO1FjqeoONKFEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=EE96SmiSH4DjdnRTpud/xPZOVq8qifKxfbvSb7lUpseZOvsRIzkgoMXvQKxKHnpnlh
         BW85wauBHbIwXvTOM+p3LdlRkjUSLuNojJ9EHJ18cOGgG9NsxcW3OzRT45yKEnf4WJWw
         o2HS51pDEKRqfcUseWZD9VgiBgvo4EVoXdpQM=
Received: by 10.223.86.199 with SMTP id t7mr4935567fal.29.1298806117942;
        Sun, 27 Feb 2011 03:28:37 -0800 (PST)
Received: from [192.168.178.23] (p5DDB0164.dip0.t-ipconnect.de [93.219.1.100])
        by mx.google.com with ESMTPS id 11sm1055688faw.20.2011.02.27.03.28.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 03:28:37 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168026>

This is the second iteration of the series to add Beyond Compare as a merge tool as an alternative to

cp/mergetool-beyondcompare 

It replaces calling "BCompare" with "bcompare". While the first is the correct binary name, the latter is the name of the wrapper script to start Beyond Compare on Linux. On Windows, this change does not matter, as Windows is case-insensitive.

Moreover, the third patch in the series has been dropped for similar reasons. While the binary for ECMerge is called "guimerge", the link in /usr/local/bin is called "ecmerge". There is no "ecmerge" executable on Windows, but Windows users need to set mergetool.ecmerge.path anyway, and just specify the path to "guimerge" here.

Sebastian Schuberth (2):
  mergetool--lib: Sort tools alphabetically for easier lookup
  mergetool--lib: Add Beyond Compare 3 as a tool

 Documentation/git-difftool.txt         |    4 +-
 Documentation/git-mergetool.txt        |    4 +-
 Documentation/merge-config.txt         |    8 +-
 contrib/completion/git-completion.bash |    2 +-
 git-gui/lib/mergetool.tcl              |  101 +++++++------
 git-mergetool--lib.sh                  |  247 +++++++++++++++++---------------
 6 files changed, 195 insertions(+), 171 deletions(-)

-- 
1.7.3.2.msysgit.6.dirty
