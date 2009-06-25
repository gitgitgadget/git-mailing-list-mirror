From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 0/8] gitweb: gravatar support
Date: Thu, 25 Jun 2009 12:42:59 +0200
Message-ID: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 12:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJmQs-0008IK-FV
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756386AbZFYKnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 06:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756430AbZFYKnH
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:43:07 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47512 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756925AbZFYKnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 06:43:06 -0400
Received: by bwz9 with SMTP id 9so1301579bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/r+PJtPw2gDAgRckOcaiGVGDR+F+7fNbjghY5Mdhwjs=;
        b=pFiACQ2m2mAgjwpmOsNcrMg8BkzP9dsbN6S6BoKE8oxnIzh4qtZ236OHDfsWBCqY5g
         tiIposMa4Eb4xvfN6IjlhHc3d6X0GLIvTq278+gX/RbR4aqW7z62hjMdQJ7nIHXpI59S
         +Xk/N8TEHR0h8AUuxnEWHrotmMQuTqmFrCYfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PkaqNF0a6DVNTh0C17GaViW8qKvmyVh3q/2rkPmuKXK2HLPtWzHIHAwLV6Zj2NuxnT
         xb6/YYkLxByV3OkH+/V7c1qEgLRwTvAVabSXf69b1c+eGIhBI3VaW7hO0iXOhfaa58hg
         0VD8j6Yop2+Nug3PHha402VnsZ7RJ69X7m2Y4=
Received: by 10.204.112.1 with SMTP id u1mr2261151bkp.208.1245926588026;
        Thu, 25 Jun 2009 03:43:08 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id h2sm3242301fkh.16.2009.06.25.03.43.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:43:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122194>

A new iteration for my gitweb gravatar patch series. This one includes a
bunch of new patches, some of which make sense regardless of the
gravatar support (particularly patches #3 and #7).

Significant changes from the previous iteration are:

* the feature has been renamed to 'avatar', and 'gravatar' is a possible
  value for it (currently the only sensible value, other than '');
* an 'alt' attribute is added to img tags, to be more friendly towards
  text-only browser; no special text is put there, only the avatar
  provider name (i.e. 'gravatar', currently);
* the last patch adds avatars to signoff lines.

I also trimmed the Cc: list for the series, because it was getting very
long and I started feeling like I was spamming around by including
everybody ever commented on the series. Please don't feel left out ;-)

Giuseppe Bilotta (8):
  gitweb: refactor author name insertion
  gitweb: uniform author info for commit and commitdiff
  gitweb: right-align date cell in shortlog
  gitweb: (gr)avatar support
  gitweb: gravatar url cache
  gitweb: add 'alt' to avatar images
  gitweb: recognize 'trivial' acks
  gitweb: add avatar in signoff lines

 gitweb/gitweb.css  |   13 ++++-
 gitweb/gitweb.perl |  170 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 148 insertions(+), 35 deletions(-)
