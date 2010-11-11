From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 00/11] gitweb: remote_heads feature
Date: Thu, 11 Nov 2010 13:26:07 +0100
Message-ID: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:26:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWEQ-00006L-P1
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400Ab0KKM0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:17 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43993 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab0KKM0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:17 -0500
Received: by wyb28 with SMTP id 28so630026wyb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2tKnvfDA9vXOkTrAloMJOHp5R0eiDRTb2UQLaFz//uM=;
        b=NVR6uOipgrLIiD3B3icIWdijYFbbYcgqyzN1lpBjHpLIJIl7dLdexaRN0P+Py6zdLb
         Jh1rKwtl4jvAHHpB3+J/mENQcBmYw/wKeX1s8QiBW2UgbihNVBn9GE2K08lO2goy6Xd8
         XCTyJKVtxM0D0vquRB+DR4xm3LsomTXP19DCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nL1RoP95AaVnS37DpJ7EZuVMhb5fvNWSlpgy7b5QQfrCfQJqUOEK5p0ROqBE1jQb2G
         p6YzOPO/S0lbfF8KLEXLz9SEc6y+mUmwCZdPETMUfGvyDpD2q7sgSywptvedhOYXuOiv
         xlWN4WziZN3IkQMqcTs9kIdNp5I4C+VkEv/Cc=
Received: by 10.227.68.206 with SMTP id w14mr738984wbi.144.1289478375737;
        Thu, 11 Nov 2010 04:26:15 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id f14sm1650720wbe.14.2010.11.11.04.26.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:14 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161231>

This 7th version of the remote heads feature for gitweb differs from the
previous mostly my small tune-ups, renames of internal functions, some
patch reordering and a final addition.

The first patch is a bugfix that is only exposed by some subsequent
code. It's independent from the rest of the patchset, and can just go
in.

The next 4 patches are rather straightforward too, and they introduce
the remote heads feature in a rather primitive way. They are ready for
inclusion.

Patch 6 and 7 introduce the 'single remote' view with an improved page
header visualization.

Patches 8 and 9 provide the infrastructure for the grouped remote heads
view introduced by the next patch.

Finally, an 11th patch was added to the series to enable remote heads
view from git instaweb.

Giuseppe Bilotta (11):
  gitweb: use fullname as hash_base in heads link
  gitweb: introduce remote_heads feature
  gitweb: git_get_heads_list accepts an optional list of refs
  gitweb: separate heads and remotes lists
  gitweb: nagivation menu for tags, heads and remotes
  gitweb: allow action specialization in page header
  gitweb: remotes view for a single remote
  gitweb: refactor repository URL printing
  gitweb: provide a routine to display (sub)sections
  gitweb: group remote heads by remote
  git instaweb: enable remote_heads

 git-instaweb.sh          |    2 +
 gitweb/gitweb.perl       |  275 ++++++++++++++++++++++++++++++++++++++++++++--
 gitweb/static/gitweb.css |    6 +
 3 files changed, 275 insertions(+), 8 deletions(-)

-- 
1.7.3.68.g6ec8
