From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/8] docs: use <sha1> to mean unabbreviated ID
Date: Sat, 18 Dec 2010 01:47:18 -0600
Message-ID: <20101218074718.GA6187@burratino>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
 <1292650725-21149-4-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 08:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTrff-0006EO-NW
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 08:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab0LRHz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 02:55:26 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37091 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab0LRHzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 02:55:25 -0500
Received: by ywl5 with SMTP id 5so679070ywl.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 23:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uVAljIcjifIEDkzhM7Wp/B6HTr7mTvl9t/CNA6AetCM=;
        b=oLLoODDv69wCKbpPEnc7Nn5B/KrkspUmPsQDAnDEUm2meV5JQJF8dbNzu2+RSg4PRj
         WLkRr/46PTzeSzj04p0ZE2lYVBh/VxnSzcu27KeSJprIH0iCtszL+a0Rvam64nCGp269
         HNwXD5LijLKldt9ZbqanembOWj3dbGLkoBbKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ntsOAWOcWBf8ZHejWj94svj3N8mrX/vtl6F25cr6Y95dXFRUonha3Xk7PfwMD7KEnV
         3glUpdRmVf08Lu1099rEWllaPU0zWXGIwHnb9YJG54QynxEK2QzE74sfm2CM2ZBVAxk8
         VDS/47Vg0apr0ghq7gUqqqVYSzopU39LJuq7Q=
Received: by 10.90.36.3 with SMTP id j3mr3199262agj.2.1292658447336;
        Fri, 17 Dec 2010 23:47:27 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id f10sm5313597anh.25.2010.12.17.23.47.24
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 23:47:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292650725-21149-4-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163908>

Mark Lodato wrote:

> There are some places that literally require a full, 40-character SHA-1
> ID, rather than a generic revision specifier.

One name I have seen for these is "object IDs", as in git get-tar-commit-id
(to avoid putting too much emphasis on precisely how the identifiers are
chosen).

>                                   Use <sha1> in git-diff-tree(1) to note
> that --stdin only takes <sha1>s, not generic <tree>s or <commit>s.

In this example, maybe it would be cleanest to spell out "40-digit
object identifier".

Perhaps something like this?  (The text is more verbose than I'd
like and it would be nicer to include an example, though.)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index a7e37b8..85ce185 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -49,9 +49,11 @@ include::diff-options.txt[]
 --stdin::
 	When '--stdin' is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
-	reads lines containing either two <tree>, one <commit>, or a
-	list of <commit> from its standard input.  (Use a single space
-	as separator.)
+	reads lines, each naming two trees, one commit, or multiple
+	commits, from its standard input.  Each line consists of a
+	list of full 40-digit object identifiers with a single space
+	as separator.  Objects must be named directly; for example,
+	a tag ID cannot be used to represent a commit.
 +
 When two trees are given, it compares the first tree with the second.
 When a single commit is given, it compares the commit with its
