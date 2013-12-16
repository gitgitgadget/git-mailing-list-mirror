From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v4 0/3] diff: Add diff.orderfile configuration variable
Date: Mon, 16 Dec 2013 15:09:43 -0500
Message-ID: <1387224586-10169-1-git-send-email-naesten@gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 16 21:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VseUb-0005cW-HY
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 21:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab3LPUKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 15:10:12 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:51717 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3LPUKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 15:10:11 -0500
Received: by mail-qc0-f170.google.com with SMTP id x13so4170575qcv.29
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/yaZf2q1qgFKXjeX1KfEHeCBXO+RtgcmQMN80apN/oA=;
        b=LT90CxLT5Qw3QE3QhrZt/aQkkYkf8fcYv9iJeDPKxrSiT9PKQa8MkWOPlSWe1k3m/r
         SMgU8SS791vHP0SkIwBxhtEHBm/Ztrn5PClYCDAdIOZoLyqFTajjarqpak+wQLcYSsLK
         UD7rnna9vDPFkxjaTA3V01DCAUW8AoUrfNKkq3hkpzXM8Nd20RcTBGF44Rs+WSNYNdvM
         okgUUhUS9XEt6B95ViVJ/TVbQzn7zYTNdKhQjMfQokaLnYxo5e7snXVyacCYJ/ZtM6Ds
         edaoiGSRmU8S7i7OfgUr4qlWvjEuCU+K9OETO8IO/UKEYvtj/asCkeBQjyp6D0uli0tq
         vVHg==
X-Received: by 10.229.105.9 with SMTP id r9mr35630830qco.12.1387224610203;
        Mon, 16 Dec 2013 12:10:10 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id 4sm48389961qak.11.2013.12.16.12.10.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Dec 2013 12:10:09 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VseUQ-0002ek-9v; Mon, 16 Dec 2013 15:10:06 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239359>

The original purpose of this patch [series] was to allow specifying
the "-O" option for "git diff" in the config.

In this version, I've revised the commit message for patch 2, changed
patch 3 to use git_config_pathname() instead of git_config_string(),
and removed the FIXME from patch 3's commit message.

Samuel Bronson (3):
  diff: Tests for "git diff -O"
  diff: Let "git diff -O" read orderfile from any file, fail properly
  diff: Add diff.orderfile configuration variable

 Documentation/diff-config.txt  |   5 ++
 Documentation/diff-options.txt |   3 ++
 diff.c                         |   5 ++
 diffcore-order.c               |  23 ++++-----
 t/t4056-diff-order.sh          | 105 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 15 deletions(-)
 create mode 100755 t/t4056-diff-order.sh

-- 
1.8.4.3
