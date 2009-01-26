From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 0/6] gitweb: feed metadata enhancements
Date: Mon, 26 Jan 2009 12:50:10 +0100
Message-ID: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 12:51:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQ06-0003vA-M5
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbZAZLuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbZAZLuE
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:50:04 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:62961 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZAZLuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:50:00 -0500
Received: by ewy14 with SMTP id 14so329602ewy.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=p5Nc2NDEFtw/+BaJ1P53Jq6wrJEcjmfWtLQZSQz3N08=;
        b=cUCzNL9xGx3uGRI1rRAbew6IhgWDfqEdwlCRVuWDXzIJQC2FC4v+yh+LiSHBfZ5WNX
         W5JdzLmm9MdWxvGTk5xGsp+5mUtvD1VULyS++EywgirvA20L/MysqVzlkTO+Veff+17E
         gwanXCsCOXt+zGSQoqmvUZBGtwLEtlyu8noIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wVqobK+caxrJeuWPTtALlw5L4f5NamGJwQ51UIrnY2RQ+4cUfnsIixy+mt5etO8LY+
         2fFVlDckmPMkR494vt9tCWd+9KuGRo9I7pLnbt5tYV2SJQy3KoIrZoy8HcYA6raTMcPg
         mr9uPUXTFYwFqcEtYX/lB2XJ6MTxPFf5z6rGM=
Received: by 10.103.24.17 with SMTP id b17mr633770muj.21.1232970598731;
        Mon, 26 Jan 2009 03:49:58 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id e10sm23506423muf.48.2009.01.26.03.49.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 03:49:58 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107197>

This second revision adds two patches to improve client-side rss
caching: the last-modified header we output is based on commit rather
than creation time, and we now act on if-modified-since request headers.

The last patch requires either HTTP::Date (from libwww-perl) or
Time::ParseDate

Giuseppe Bilotta (6):
  gitweb: channel image in rss feed
  gitweb: feed generator metadata
  gitweb: rss feed managingEditor
  gitweb: rss channel date
  gitweb: last-modified time should be commiter, not author
  gitweb: check if-modified-since for feeds

 gitweb/gitweb.perl |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)
