From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/10] svn-fe manual: Clarify warning about deltas in dump
 files
Date: Mon, 9 Aug 2010 17:58:36 -0500
Message-ID: <20100809225836.GF4429@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 01:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OibKH-0005Hc-9d
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 01:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009Ab0HIXAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 19:00:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37393 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756766Ab0HIXAD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 19:00:03 -0400
Received: by vws3 with SMTP id 3so7136970vws.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 16:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=T13QGWD6cZEbCGLAKoRxv5wyuNZ+Xe9g0Zql9uT+poQ=;
        b=fHk3o9uZIVeKJ2JV929dGVM+85wrUpmAGIhwQcMHTACjjIv+lzzQtGzwVrxh92sN0n
         cMGxf9TWXNqwW2lah9USjW4zWCjSP5mnmsh/u/yF0xWttW/RGkG3o9uTWVO7DdihHQ+Y
         WRJRj8CuiKKemLZl0N7A2PsIuhWvWAVqrOMFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=G8u8uuN38clr0bfvESofp6E7aVEQuUdfeLbAF/B2ODo8bK5OEAx4X8sIDA1sF25Phv
         ZzeIDTXYL/yOWneqD2F0uiahwLSZjRNwnHxJB5T8dC4MtaIbyXnwcCPmKYcUL37CpIDd
         isBhuI8VHn33xeIj1Q6lagtdGLT7KApNl9/V0=
Received: by 10.220.100.67 with SMTP id x3mr9708857vcn.262.1281394802952;
        Mon, 09 Aug 2010 16:00:02 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id i40sm1164119vcr.32.2010.08.09.16.00.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 16:00:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153047>

Those in the know would notice that dump file format version 2
means "svnadmin dump --no-deltas", but for the rest of us, an
explicit reminder is useful.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That=E2=80=99s the end of the series.  Thanks for reading.

On the horizon, as you may have guessed, are changes to use
dumpfile format v3.  Doing so sanely requires two-way communication
with fast-import, I think (as discussed).  Ram has already put
together a prototype delta applier, so it seems to be mostly a matter
of plumbing now.

 contrib/svn-fe/svn-fe.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index fb0ee56..35f84bd 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -12,7 +12,7 @@ svnadmin dump --incremental REPO | svn-fe [url] | git=
 fast-import
 DESCRIPTION
 -----------
=20
-Converts a Subversion dumpfile (version: 2) into input suitable for
+Converts a Subversion dumpfile into input suitable for
 git-fast-import(1) and similar importers. REPO is a path to a
 Subversion repository mirrored on the local disk. Remote Subversion
 repositories can be mirrored on local disk using the `svnsync`
@@ -25,6 +25,9 @@ Subversion's repository dump format is documented in =
full in
 Files in this format can be generated using the 'svnadmin dump' or
 'svk admin dump' command.
=20
+Dumps produced with 'svnadmin dump --deltas' (dumpfile format v3)
+are not supported.
+
 OUTPUT FORMAT
 -------------
 The fast-import format is documented by the git-fast-import(1)
--=20
1.7.2.1.544.ga752d.dirty
