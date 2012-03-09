From: David Barr <davidbarr@google.com>
Subject: Re: [PATCH 2/2] fast-import: teach ls command to accept empty path
Date: Fri, 9 Mar 2012 15:28:02 +1100
Message-ID: <CAFfmPPNnQ21qwKb_w1FCRL7Vx7CSQKYurM2zqziTw01kkRoMog@mail.gmail.com>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
	<1331184656-98629-1-git-send-email-davidbarr@google.com>
	<20120308202721.GA8992@burratino>
	<20120308203330.GC8992@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 05:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5rR7-0001yK-TB
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 05:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193Ab2CIE2E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 23:28:04 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51479 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758175Ab2CIE2D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 23:28:03 -0500
Received: by gghe5 with SMTP id e5so685775ggh.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 20:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=OsU70Sp3qiNx9T4qWaoK2YXrKgt4bze4DqPEkqnwVGU=;
        b=FxMLC8llRf4drRbDsWQgMTp2qWMnSv59mNgOFsWiqu+M4CaSU0XiGQ7oT1QMXtdfAn
         5MeBxaRlsIbsEk79bPG5Y8SaTJMJN88+Oi38AQ8MN6m3hUUbkt0zw4EPrDZEalAvnKSB
         yMQu1SuzmckeP/yiTCPaJyzmlvQFtWUVYMbaW02xSbFehzB0cmfmbPOZdMs3HnxFnQf3
         yutcKx02IbP8vjAiCPB57M98DXhPD/ThHh3fYLIuycGN/IWa88ny7c3Qm7ZtNgLOFNlS
         puubeY+8DPYwD5MzV2AeHhKukyBUfxYT9TsixIH+nmoPFzSKvXDeXredViKrjhiPLUoY
         Kxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=OsU70Sp3qiNx9T4qWaoK2YXrKgt4bze4DqPEkqnwVGU=;
        b=fpGHRRn0XAOUcUKw4oXmWH9DPu09udlM+lMZ2KBhPqmyTFmmtOjx0bRNdU8svN+4lr
         7zpFSO/9p5eUXu+4QKYiT/pdhI2acEZ6Dw0mP++1ZiFfU5vCFNhUa80KDpIcXCgNfh6i
         422GM5Ge33mDVkmaJ5aJOuYtRaQJSqa4RFp1WvIaw0wFpkIvHPUtZKJ4LJFC2nmZBsv9
         bK+lKDOMgcEgTCZBKJUiXgplCKAlgaPvRI/jP+HQwQ4fWA38Dx7Q8/uq3bQVm7p7cVHw
         pW7ARPTWIwKxU0Jqi/VceeVYIToDj+vhRhxBgAqlvh/PJrb9UBn0QL62PTjWBrvChf1H
         3WGw==
Received: by 10.236.173.195 with SMTP id v43mr794977yhl.40.1331267282356;
        Thu, 08 Mar 2012 20:28:02 -0800 (PST)
Received: by 10.236.173.195 with SMTP id v43mr794960yhl.40.1331267282240; Thu,
 08 Mar 2012 20:28:02 -0800 (PST)
Received: by 10.101.154.34 with HTTP; Thu, 8 Mar 2012 20:28:02 -0800 (PST)
In-Reply-To: <20120308203330.GC8992@burratino>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnpobRQVC8cwOOAj05W6L4Cyv6+RX7BXxrEzBJrWv0nJIOSjrrwwt2DIABaqZMtDpd02JwwncEfLNFxoJnU4u5BS+kY9/npa2KTCfzq9glzfKondhAbUJrOS/My5AAgGlgMVRCxd18e/IZuVCk7OS43F0JBDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192674>

On Fri, Mar 9, 2012 at 7:33 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> From: David Barr <davidbarr@google.com>
>
> There is a pathological Subversion operation that svn-fe handles
> incorrectly due to an unexpected response from fast-import:
>
> =A0svn cp $SVN_ROOT $SVN_ROOT/subdirectory
>
> When the following command is sent to fast-import:
>
> =A0'ls' SP ':1' SP LF
>
> The expected output is:
>
> =A0'040000' SP 'tree' SP <dataref> HT LF
>
> The actual output is:
>
> =A0'missing' SP LF
>
> This is because tree_content_get() is called but expects a non-empty
> path. Instead, copy the root entry.
>
> [jn: using a deep copy; w/ more tests]
> [jn: with a fix from Dmitry to fully initialize root->versions[0]
> =A0and versions[1] now that root can be passed to store_tree]
>
> Reported-by: Andrew Sayers <andrew-git@pileofstuff.org>
> Signed-off-by: David Barr <davidbarr@google.com>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* store_tree scribbles over version[=
0] in leaf.tree's
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* entries, so we need a deep copy.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (root->tree && is_null_sha1(root->ve=
rsions[1].sha1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 leaf.tree =3D dup_tree_=
content(root->tree);

Is it ok to call store_tree(root)? If so, could we not introduce a
pointer rather than a deep copy?

diff --git a/fast-import.c b/fast-import.c
index 94d7037..eab24f3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2993,7 +2993,8 @@ static void parse_ls(struct branch *b)
 {
 	const char *p;
 	struct tree_entry *root =3D NULL;
-	struct tree_entry leaf =3D {NULL};
+	struct tree_entry tmp_tree =3D {NULL};
+	struct tree_entry *leaf =3D &tmp_tree;

 	/* ls SP (<treeish> SP)? <path> */
 	p =3D command_buf.buf + strlen("ls ");
@@ -3022,27 +3023,18 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p =3D uq.buf;
 	}
-	if (*p) {
-		tree_content_get(root, p, &leaf);
-	} else {
-		memcpy(&leaf, root, sizeof(leaf));
-		/*
-		 * store_tree scribbles over version[0] in leaf.tree's
-		 * entries, so we need a deep copy.
-		 */
-		if (root->tree && is_null_sha1(root->versions[1].sha1))
-			leaf.tree =3D dup_tree_content(root->tree);
-		else
-			leaf.tree =3D NULL;
-	}
+	if (*p)
+		tree_content_get(root, p, leaf);
+	else
+		leaf =3D root;
 	/*
 	 * A directory in preparation would have a sha1 of zero
 	 * until it is saved.  Save, for simplicity.
 	 */
-	if (S_ISDIR(leaf.versions[1].mode))
-		store_tree(&leaf);
+	if (S_ISDIR(leaf->versions[1].mode))
+		store_tree(leaf);

-	print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, p);
+	print_ls(leaf->versions[1].mode, leaf->versions[1].sha1, p);
 	if (!b || root !=3D &b->branch_tree)
 		release_tree_entry(root);
 }

--
David Barr
