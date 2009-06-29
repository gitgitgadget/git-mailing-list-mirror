From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv8 0/7] gitweb: avatar support
Date: Tue, 30 Jun 2009 00:00:47 +0200
Message-ID: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 00:01:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOux-0005Hd-Oq
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 00:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZF2WAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 18:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbZF2WAm
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 18:00:42 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63590 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbZF2WAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 18:00:41 -0400
Received: by bwz9 with SMTP id 9so3551293bwz.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=P28ZHON1dqosWjVD+jQW7nHWakhl9cQWsZqU/j2tD/s=;
        b=VuG2PM2aeyy5zgJY93MuF+RUUbaCm2i6QdrwgujNUpqO4B9h0I6hxJg7BmvitNROwa
         foTfqbPp5IWwfh3qM3jeErtF5EOKLFUPjvTUEnrQT3d1Xna4rDCtyxhQqt84v43XKTLZ
         QhGLuSPgGftjE+cbxPD2PwVTqjqvV47mkuYE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nLgMLuq8g4dbuD3d7n+BH9S+JDGL0LzS2fmDTsdwE3Q+XhoMCZ8GY+63tBzTgX85vr
         2W3vxOCRhMLFfRtichBRPFN4R3rtGa2Tv0+18lNa4HRUVLN/+qhTIM4vPFntxPRmxc1L
         t/Y9uFy3vSyeuf1kwogAWk05BDhZwfA5TNt+Q=
Received: by 10.204.103.197 with SMTP id l5mr3778409bko.165.1246312843614;
        Mon, 29 Jun 2009 15:00:43 -0700 (PDT)
Received: from localhost (host-78-13-59-48.cust-adsl.tiscali.it [78.13.59.48])
        by mx.google.com with ESMTPS id 18sm13177294fkq.59.2009.06.29.15.00.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 15:00:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122468>

8th iteration of my attempt to implement avatar support for gitweb. Only
minor changes from the previous version: the removal of a couple of
patches that need to be discussed some more, and some tune-up suggested
by Jakub.

Giuseppe Bilotta (7):
  gitweb: refactor author name insertion
  gitweb: uniform author info for commit and commitdiff
  gitweb: use git_print_authorship_rows in 'tag' view too
  gitweb: (gr)avatar support
  gitweb: gravatar url cache
  gitweb: picon avatar provider
  gitweb: add empty alt text to avatar img

 gitweb/gitweb.css                      |    9 +-
 gitweb/gitweb.perl                     |  231 +++++++++++++++++++++++++------
 t/t9500-gitweb-standalone-no-errors.sh |    2 +
 3 files changed, 196 insertions(+), 46 deletions(-)
