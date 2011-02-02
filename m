From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Documentation/fast-import: explain how to remove a note
Date: Tue, 1 Feb 2011 23:00:22 -0600
Message-ID: <20110202050022.GD15285@elie>
References: <20110202045826.GC15285@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 02 06:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkUpW-0006lb-Lm
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 06:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760Ab1BBFA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 00:00:28 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35540 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab1BBFA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 00:00:27 -0500
Received: by gyb11 with SMTP id 11so2808442gyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 21:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6BCxWlLUN15CL8fX6Zv+7eLGCpTpcoI8I+BYr7P2TEk=;
        b=hgqxfdbQLCVRU65E4E+Mq6HHGCBaHotAcyK44Oab0eZ7Yy+ERS76xJGn8J1yIcij+8
         nH01vuJ6KAGumGAcMMgCNV9GaibxrE65V0vpkIjy5QYB0hvfOqDABx4Elb5pleuI3jOf
         WlnB/jwamNyvkxcn9V+owN6QdLXR9SRUeIlaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FwlqvJcYUG/NFISzE1zHWH4eulnOF+vnE8ZagwU2H6oHXp7ntobT6JMUPTqk1NcNzo
         LpIVxXTj975dkPrZQuJwH2nep13bUbdTTExUbD7S0C0BfT2Es+TsHzw4Qkxd/MkCtrzh
         y7DK4PTkSqQIFAmGIHnzMSO3r3jKdIXGFF+JA=
Received: by 10.236.95.173 with SMTP id p33mr17840374yhf.44.1296622826564;
        Tue, 01 Feb 2011 21:00:26 -0800 (PST)
Received: from elie (adsl-69-209-75-28.dsl.chcgil.sbcglobal.net [69.209.75.28])
        by mx.google.com with ESMTPS id x62sm5766321yhc.30.2011.02.01.21.00.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 21:00:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110202045826.GC15285@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165896>

A notemodify (N) command with blob id consisting of 40 zeroes (so
is_null_sha1 is true) means to not add a note to replace the existing,
removed one.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-import.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 4415e63..086b14f 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -651,9 +651,9 @@ External data format::
 	'N' SP <dataref> SP <committish> LF
 ....
 +
-Here `<dataref>` can be either a mark reference (`:<idnum>`)
-set by a prior `blob` command, or a full 40-byte SHA-1 of an
-existing Git blob object.
+Here `<dataref>` can be a mark reference (`:<idnum>`)
+set by a prior `blob` command, a full 40-byte SHA-1 of an
+existing Git blob object, or 40 zeroes, to remove a note.
 
 Inline data format::
 	The data content for the note has not been supplied yet.
-- 
1.7.2.3
