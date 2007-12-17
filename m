From: "Gerald Gutierrez" <ggmlfs@gmail.com>
Subject: git with custom diff for commits
Date: Mon, 17 Dec 2007 14:56:28 -0800
Message-ID: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 23:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Otq-00028G-Cq
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759947AbXLQW4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759777AbXLQW4c
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:56:32 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:55589 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759378AbXLQW4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:56:30 -0500
Received: by py-out-1112.google.com with SMTP id u77so3923984pyb.16
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=XimWkiewE+Bvj11DSfxkqPNSOJQ16U26S8HsFwUl8eo=;
        b=HgEOZHZ62Tx2EkxLvpR5jtje6gglgdIoSB77KwHdz9E1LrT/O94S9rV/UlbqtZ6lAbQ+zdq1FK1bvY6yliIXVb/NC5gegi11DT+ykVYHCVHWcf6XghUdO/Shrl8DilNpWaKAbN9dx0KrSPPDcVaUoEjccglRiRSYOkkGgHj5hu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L8+9V9pU1zosB32csHneeXmskIX8yL7jFOW13l7RHaX9NtTX/Nh+TgHrdJBe0RkIeZELNPNyZJufjdoHVUfbW/v5XscJNRo9dmmeD6BqNchEDfHwwJvWE7B4yGQEMnyZcXnTPoWUF8D18o7fA31E333Pf8da2C3KS9PzZXJ6YBA=
Received: by 10.65.135.19 with SMTP id m19mr16054099qbn.63.1197932188392;
        Mon, 17 Dec 2007 14:56:28 -0800 (PST)
Received: by 10.65.160.3 with HTTP; Mon, 17 Dec 2007 14:56:28 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68647>

Hello folks,

I do a nightly mysqldump of a database and check it into a git
repository. mysqldump generates a timestamp as part of that output
which is causing git to think that the file changes every night when
it really doesn't. The timestamp is simply in an SQL comment.

So what I'd like to do is teach git to ignore that particular SQL
timestamp comment. I've tried to set up an external diff script that
runs diff -I "<<sql timestamp comment>>" that effectively ignores the
timestamp. While this works with "git diff", it seems when git
commits, it still sees the differences.

How do I properly teach git to ignore these types of differences?

Gerald.
