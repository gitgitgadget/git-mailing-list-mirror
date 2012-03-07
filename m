From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/7] nd/stream-more updates
Date: Wed,  7 Mar 2012 17:54:14 +0700
Message-ID: <1331117661-19378-1-git-send-email-pclouds@gmail.com>
References: <7vty21twqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 11:53:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5EUP-0002aQ-9c
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 11:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab2CGKwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 05:52:54 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:64743 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2CGKwx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 05:52:53 -0500
Received: by dadp12 with SMTP id p12so7761663dad.11
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 02:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UTIBXbzr5k+AbDArpODiWD2M9+0xwBSFxsyHyPg15do=;
        b=O7hjfDLRptiN/otCWbD8n4vmoiTb4FSBvI8GvbW1us8nSi8vjtJoijX7lF9cfhG/et
         zFFs77yR/3oklcKcpFN1A1gmi+GUt/rr8YktLB/v+nkhMyTqC+wFyh+QZowzPU72KQ7U
         +uW+pjOmZ7GkTZLPLhgErZaeg5Pb8mdrHYChs7zXvmFkUN9MIMGXbckVGaCB2PTKDfuj
         kRWl+o8WSFX58hwZvmbiUj61zWpPZT9LncgxDp0EDlrL/nl6Ay1jnrDXwYfqJMWi6u7o
         KSke8WjOkdGmzN7bgTNLEehlrQ0uN5bY0Ruxvs+viJ7imoVZTwxxo8qH7ep1Z2boFH3X
         5LNQ==
Received: by 10.68.225.104 with SMTP id rj8mr2936206pbc.135.1331117572747;
        Wed, 07 Mar 2012 02:52:52 -0800 (PST)
Received: from tre ([115.74.59.10])
        by mx.google.com with ESMTPS id k3sm568170pbn.71.2012.03.07.02.52.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 02:52:51 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 07 Mar 2012 17:54:22 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <7vty21twqc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192436>

As discussed, this series removes test_expect_failure that are still
not fixed in the end. It also adds update-server-info patch. I'll hold
off the rest of the previous series until 1.7.10 comes out.

Junio C Hamano (1):
  streaming: make streaming-write-entry to be more reusable

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  Add more large blob test cases
  cat-file: use streaming API to print blobs
  parse_object: avoid putting whole blob in core
  show: use streaming API for showing blobs
  fsck: use streaming API for writing lost-found blobs
  update-server-info: respect core.bigfilethreshold

 builtin/cat-file.c           |   25 +++++++++++++++++++
 builtin/fsck.c               |    8 +----
 builtin/log.c                |   34 +++++++++++++++----------
 builtin/update-server-info.c |    1 +
 entry.c                      |   53 ++++------------------------------=
------
 object.c                     |   11 ++++++++
 sha1_file.c                  |   42 ++++++++++++++++++++++++++++++-
 streaming.c                  |   55 ++++++++++++++++++++++++++++++++++=
++++++++
 streaming.h                  |    2 +
 t/t1050-large.sh             |   38 +++++++++++++++++++++++++++-
 wrapper.c                    |   27 ++++++++++++++++++--
 11 files changed, 221 insertions(+), 75 deletions(-)

--=20
1.7.8.36.g69ee2
