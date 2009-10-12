From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] Documentation: describe check-ref-format --branch
Date: Mon, 12 Oct 2009 00:28:23 -0500
Message-ID: <20091012052823.GC11106@progeny.tock>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
 <20091012052536.GA11106@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 07:20:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxDKq-0006Uy-KI
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 07:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbZJLFUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 01:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZJLFUc
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 01:20:32 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:56542 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbZJLFUc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 01:20:32 -0400
Received: by ywh6 with SMTP id 6so7893437ywh.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 22:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=a6gOqLG5f/8WZKlJ4ni8Cmfba0nJ1X7FHvm82XpCQnE=;
        b=vHVsMl80C/UyuErphZBHBsB3+3ZJ51tB5v7CZGSE8PEs3dTXyVEEiwxkhg56jVZFv5
         dR90o+6/ojaMRmuuVpsSM+kcksMLV6YdMhAbiW/+WigsyQHTqW7BeKDAmLySy3eD7QEj
         0wHCJ/hVAI3UQ8BU3xOaGBK5n+IgZr5Bp0gzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZLD77j6Fqv+f/COfITQ2Kx58LUtmUQ51oSykUSd5+OnLgVvIr8TF6EBQOGDnf6GIhC
         LdXZZsqpYgLg24LU8EtIs6e1aKdEhWnMeBu3qJ006JC52DLe+HvmG64ynBKvhZWHwNMg
         6sFIYWFx3Nktys/BQjQQj6xkljoAjZnDVTSoA=
Received: by 10.150.242.2 with SMTP id p2mr9339344ybh.217.1255324795807;
        Sun, 11 Oct 2009 22:19:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm130615gxk.13.2009.10.11.22.19.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 22:19:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091012052536.GA11106@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129980>

Unless one already knew, it was not obvious what sort of shorthand
"git check-ref-format --branch" expands.  Explain it.

The --branch argument is not optional.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-check-ref-format.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 0b7982e..e9b3b40 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git check-ref-format' <refname>
-'git check-ref-format' [--branch] <branchname-shorthand>
+'git check-ref-format' --branch <branchname-shorthand>
 
 DESCRIPTION
 -----------
@@ -63,8 +63,11 @@ reference name expressions (see linkgit:git-rev-parse[1]):
 
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
-With the `--branch` option, it expands a branch name shorthand and
-prints the name of the branch the shorthand refers to.
+With the `--branch` option, it expands the ``previous branch syntax''
+`@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
+were on.  This option should be used by porcelains to accept this
+syntax anywhere a branch name is expected, so they can act as if you
+typed the branch name.
 
 EXAMPLE
 -------
-- 
1.6.5.rc1.199.g596ec
