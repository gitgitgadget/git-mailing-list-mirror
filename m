From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Makefile: transport-helper uses thread-utils.h
Date: Fri, 10 Dec 2010 13:48:25 -0600
Message-ID: <20101210194825.GC6801@burratino>
References: <20101210114839.GA5771@burratino>
 <7vhbeleber.fsf@alter.siamese.dyndns.org>
 <20101210194637.GA6801@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 20:48:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR8xX-0005Nr-Mu
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 20:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875Ab0LJTsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 14:48:46 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56110 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab0LJTsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 14:48:45 -0500
Received: by wwa36 with SMTP id 36so4105384wwa.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 11:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=421q8PgGdt4LZgRveCfKpN/cGXMimXNxm6wQQ9/rurg=;
        b=W8GIit6fVhnl9BGU3Hx7zq1aQShAGLDlOnClIw6+TzuQi+IO2BP1LYOwpABFJhIGJ+
         D3I8hxFJoYTadB/CHM0hBt/pTaJjUy4uoTwDU2sHBOkPFc447HE6uH0sL106hjO0QqrW
         3RNgtK9uQTrNKDG65szFW5DUixpyBiw5PXnUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xWiX1V4rbvuLDXqnazwMZO91Oxr3LZ0hlvQ7pJx6nsJkDXPPnInCBQt2NxBTBsI1ap
         lYgWLG/OOm+M5yEXPdu0OX6t5pDoJzdngF7KaPumAKSPqKMBBcwy913SscD9Qer0b940
         wRNqDg+d531VidO3ImHjc9mBh/t+3TwSViF/0=
Received: by 10.216.17.202 with SMTP id j52mr35982wej.36.1292010523848;
        Fri, 10 Dec 2010 11:48:43 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id a2sm1678662wer.41.2010.12.10.11.48.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 11:48:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210194637.GA6801@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163435>

transport-helper.o gained a dependency on thread-utils.h in
7851b1e (remote-fd/ext: finishing touches after code review,
2010-11-17).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1fe1a3b..41ab490 100644
--- a/Makefile
+++ b/Makefile
@@ -1937,13 +1937,12 @@ builtin/branch.o builtin/checkout.o builtin/clone.o builtin/reset.o branch.o tra
 builtin/bundle.o bundle.o transport.o: bundle.h
 builtin/bisect--helper.o builtin/rev-list.o bisect.o: bisect.h
 builtin/clone.o builtin/fetch-pack.o transport.o: fetch-pack.h
-builtin/grep.o: thread-utils.h
+builtin/grep.o builtin/pack-objects.o transport-helper.o: thread-utils.h
 builtin/send-pack.o transport.o: send-pack.h
 builtin/log.o builtin/shortlog.o: shortlog.h
 builtin/prune.o builtin/reflog.o reachable.o: reachable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
-builtin/pack-objects.o: thread-utils.h
 connect.o transport.o http-backend.o: url.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h
-- 
1.7.2.4
