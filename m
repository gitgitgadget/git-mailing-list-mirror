From: "Sverre Johansen" <sverre.johansen@gmail.com>
Subject: git-svn fix for broken symlinks
Date: Tue, 18 Dec 2007 17:11:56 +0100
Message-ID: <a74c0d680712180811m216699a4h7123039c3158c2ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 17:12:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4f3d-0004d8-Lp
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092AbXLRQMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 11:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757361AbXLRQMB
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:12:01 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:47543 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092AbXLRQL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:11:59 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1717353wra.1
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 08:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=z/TiKXwZwogisJOjk+XCOPoEY/5Z9q84qr8pplinM6M=;
        b=TABamkqf0p+lp63kIQtqtVGzfdmGWnQmX2ADRSzWggv70yItAWBpRcMaEoLcJBiSOJJq1aJ+12tHRKierqQ6MLoT1/U28c6pZQGMkl2wluMwDrcMQQSdcLdX9A5G1lqVNgh2soPRtLS+A66qyz1OHE+kwl3N/KG0kRV8Cp1tEbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=vk8kGSwIGbLLTcDnZK7n+C1tT1CvTXaN8CQcUHELAb5jgEpFEyFh0brIxV+af30kDEgBYSpGRh2r37HEqwScJ0M5JvyFNc2cPEE0H7sArNYQfrnjbyxkxTGuxRUQJhd/QZAyKqeeWbGYJKqmh+zffHjICMbK/4tfaOfONhoCA0Y=
Received: by 10.115.79.1 with SMTP id g1mr5270220wal.43.1197994316759;
        Tue, 18 Dec 2007 08:11:56 -0800 (PST)
Received: by 10.114.77.3 with HTTP; Tue, 18 Dec 2007 08:11:56 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68772>

Hi,

There is a bug in older versions of SVN that makes it possible to create
symlinks where the target is not the path to the file, but instead the
content of the target file. The bug is described here [0].

This breaks git-svn because it expects files which is marked as symlinks
to have the content "link: <filename>".

There was a thread about this back in July, resulting in this patch [1]. Is that
patch planned to be merged anytime soon? I'm using it, and it works great
for me.

[0]: http://subversion.tigris.org/issues/show_bug.cgi?id=2692
[1]: http://kerneltrap.org/mailarchive/git/2007/7/19/252025
-- 
           Sverre Johansen
