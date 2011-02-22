From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/2] Add missing const to char* declarations
Date: Tue, 22 Feb 2011 22:43:21 +0000
Message-ID: <1298414603-22338-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 23:44:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps0xv-000460-NZ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 23:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab1BVWoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 17:44:14 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:56536 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab1BVWoN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 17:44:13 -0500
Received: by bwz10 with SMTP id 10so3819163bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 14:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=866vXkkXZKPMf34Mz7nS2k0q2fC+BZkr5HmC4ZTyqJg=;
        b=PRZJmuEuPO8DwD/kvAAbmPTnVNkpojU77vCREj2Vm/dFERRRRCZDc5b0VF+dfUuYjV
         1KiGdSQpmg2SOpnNQouyJ/AL8cdfgypja4YaW3sJvkgwuxHaQ8d5RaabOms8fNQy8dp/
         1AwcvJ34/1mzUheoHJm5XQytectgA0xiHQmgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jNl7Zjbk2FcGlVZJ9J+DLYIHZhEtLcZ4O8TwnDxXvMiwaS+kSHqzQxN9jxWFuSmowm
         ZT7YDwFBPAuC9gsl4VkArgZDs5AtN9qDBVh/YG+BdLmxtrb6ixxngthwbOt7Mdb3tPCu
         6dDG0SsYnMZybZ8apSe+ixk7jNbLDhFFrrAmk=
Received: by 10.205.24.76 with SMTP id rd12mr1566065bkb.166.1298414652018;
        Tue, 22 Feb 2011 14:44:12 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id a17sm4883767bku.11.2011.02.22.14.44.11
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 14:44:11 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167587>

These two patches by Jonathan Nieder have been extracted from my
soon-to-be-sent updated gettext series, which he's graciously helped
with.

Without these changes this code using the new _() function will warn
because it's expecting char* but it's returning const char*. Since
there's no reason for these not to be const just add a const to the
declaration.

Jonathan Nieder (2):
  checkout: add missing const to describe_detached_head
  update-index --refresh --porcelain: add missing const

 builtin/checkout.c |    2 +-
 cache.h            |    2 +-
 read-cache.c       |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.2.3
