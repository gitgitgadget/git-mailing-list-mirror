From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 0/9] gitweb: avatar support
Date: Sat, 27 Jun 2009 14:04:56 +0200
Message-ID: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 14:05:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKWen-0006pk-4B
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbZF0ME7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 08:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbZF0ME6
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:04:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:40331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbZF0ME6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:04:58 -0400
Received: by fg-out-1718.google.com with SMTP id e21so627857fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rSK1aeYAenfNtH7un8RZpszhaBeNUiUrqcMjYIjCYmw=;
        b=f49W2s5+BNFrBnfUP9Ty4Hyokxc4yTJp0pZHAwi07EkuSV1dUMBoTEKKgAwpsbuy0I
         h+VMkYpelOpluTIhgtiuB/OeQWwrxB8IFPYRbla0X1qoIQEosNwuge7K5yQs6+UQBXD8
         PrhdbHCCtXC+qOBSgIOVwozdZ93KQWUlsf1Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ihspBn0SEWhrsCSzdMyX1mmEXnK2lPEQFD5IoFl2qlP6uuacOPVurzpcfRoilgjfZ0
         dSeA96rsDAnIKYXO8Yn6BkMsE9c0Qiy2xJ19kSjFIId4D7phpriHa+EWl0x5rYYfUxIr
         JG7GPHhsDB5JIJXieEaxPmJhcUkkhJBY7JspE=
Received: by 10.86.70.17 with SMTP id s17mr465756fga.31.1246104300238;
        Sat, 27 Jun 2009 05:05:00 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-10-227.clienti.tiscali.it [94.37.10.227])
        by mx.google.com with ESMTPS id 12sm2149573fgg.9.2009.06.27.05.04.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:04:59 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122353>

One more attempt at adding avatar support to gitweb.

The most significant change since the previous iteration is the addition
of a picon provider, and its use as default from gravatar.

Most other patches were changed to follow Jakub's suggestions. In
particular, the two-line author/committer information was refactored
to reduce code duplication, with the benefit that it could also be used
in 'tag' view.

Giuseppe Bilotta (9):
  gitweb: refactor author name insertion
  gitweb: uniform author info for commit and commitdiff
  gitweb: use git_print_authorship_rows in 'tag' view too
  gitweb: right-align date cell in shortlog
  gitweb: (gr)avatar support
  gitweb: gravatar url cache
  gitweb: picon avatar provider
  gitweb: use picon for gravatar fallback
  gitweb: add alt text to avatar img

 gitweb/gitweb.css                      |   13 ++-
 gitweb/gitweb.perl                     |  238 ++++++++++++++++++++++++++------
 t/t9500-gitweb-standalone-no-errors.sh |    2 +
 3 files changed, 207 insertions(+), 46 deletions(-)
