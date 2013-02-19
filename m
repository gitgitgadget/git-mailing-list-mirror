From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 3/3] contrib/subtree: update documentation
Date: Tue, 19 Feb 2013 12:32:04 +0000
Message-ID: <CALeLG_k2M=BJouYWyk_JB0HX6N++pERJ39tGZ8=oOSDkspASUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 13:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7mN6-0003sx-Nz
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 13:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757Ab3BSMcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 07:32:07 -0500
Received: from mail-ea0-f172.google.com ([209.85.215.172]:53980 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711Ab3BSMcG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 07:32:06 -0500
Received: by mail-ea0-f172.google.com with SMTP id f13so2911250eaa.31
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 04:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=cJxAQlhb6IfMwkQ97Q25f8a2+ySXl+DQrzB+Os4wHWU=;
        b=S4Kmd2CFKI9RkNKbvKBx4AQ6hNeJhYnPpwrwSgeMC8uAL0ryHJOAu7eR7inO+btATp
         fAu+aZIzS79Qqg+uZQORBECuC4FP1Apn4u4VhTne0QSQU5Kuk8nfFFu29olg6K0nXYjF
         vE9ZRPYixVUn2t23w8PHIwYe+HroB0CRKYS3x1R144bULsKCiZLequEZya7KZd+/7C4C
         cjl7b9LlkbX7DXSZJpgcvCepM7mh2Td1BjBXB5MXuLA0myfLN7Ax57PB9JxM07yO/UgY
         HAxN/badcePac7S9mj/j0/rX7Mp121HklCiFpfdpm24kmZyJ34LToLMYXccJbjZ9JR7O
         S1Ww==
X-Received: by 10.14.204.195 with SMTP id h43mr56801072eeo.14.1361277124293;
 Tue, 19 Feb 2013 04:32:04 -0800 (PST)
Received: by 10.14.45.4 with HTTP; Tue, 19 Feb 2013 04:32:04 -0800 (PST)
X-Originating-IP: [212.219.195.16]
X-Gm-Message-State: ALoCoQnRhQEUqTxOUuVdKh0q8POyqLz363CgOMjMuHQq6oppcZoB82Nd9/X2W81tEgW2v62lRuw+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216612>

Indicate that repository and refspec are now optional on push and pull.

Add notes to add, push and pull about storing values in .gitsubtree
and their use as default values.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 7ba853e..2ad9278 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 [verse]
 'git subtree' add   -P <prefix> <refspec>
 'git subtree' add   -P <prefix> <repository> <refspec>
-'git subtree' pull  -P <prefix> <repository> <refspec...>
-'git subtree' push  -P <prefix> <repository> <refspec...>
+'git subtree' pull  -P [<prefix> <repository> <refspec...>]
+'git subtree' push  -P [<prefix> <repository> <refspec...>]
 'git subtree' merge -P <prefix> <commit>
 'git subtree' split -P <prefix> [OPTIONS] [<commit>]

@@ -72,7 +72,9 @@ add::
 	A new commit is created	automatically, joining the imported
 	project's history with your own.  With '--squash', imports
 	only a single commit from the subproject, rather than its
-	entire history.
+	entire history. Details of the <prefix> are added to the
+	.gitsubtree file, where they will be used as defaults for
+	'push' and 'pull'.

 merge::
 	Merge recent changes up to <commit> into the <prefix>
@@ -91,13 +93,16 @@ merge::
 pull::
 	Exactly like 'merge', but parallels 'git pull' in that
 	it fetches the given commit from the specified remote
-	repository.
+	repository. Default values for <repository> and <refspec>
+	are taken from the .gitsubtree file.
 	
 push::
 	Does a 'split' (see below) using the <prefix> supplied
 	and then does a 'git push' to push the result to the
 	repository and refspec. This can be used to push your
 	subtree to different branches of the remote repository.
+	Default values for <repository> and <refspec> are taken
+	from the .gitsubtree file.

 split::
 	Extract a new, synthetic project history from the
-- 
1.8.2.rc0.16.g20a599e
