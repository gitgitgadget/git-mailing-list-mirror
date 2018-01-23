Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2E11F404
	for <e@80x24.org>; Tue, 23 Jan 2018 01:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeAWB3p (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 20:29:45 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41110 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeAWB3o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 20:29:44 -0500
Received: by mail-pg0-f68.google.com with SMTP id 136so8513356pgd.8
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 17:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r9cT/fdX4sePwVPK63UCVKXDhiuSmoV5Darn81LD2Qc=;
        b=sPRQVNLiOedktU+0GPerqUeyGn0j3HlsyzxzNw2tZOhMWnWUngxW04Q2Ij9uOhrg9x
         lhVMidjkbuIy+P0zI3N/otwobiO3XDdKFLdGt4j31ZupCDJI1T/ldrlAVkQM9EZJKkUZ
         sLalWgx1d7WsmPC1Z8Q3OeL3ZwYPbpxle0MuHYqzfRwwA6/hwcJpoITajhBoUFvZ+wkn
         flR71c6qOIGz0TbSeS24KrOucX+sWGZlTk4XkKeOdTz+AfmNFRNsodzWW1OmLTfLZu+W
         UZZ9mVwhU8JEHZBx+tPjzx9rb0OphsNgJPOIPI6WumYruZ3Zm4awHLHRLH1GAPFs/UXN
         pMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r9cT/fdX4sePwVPK63UCVKXDhiuSmoV5Darn81LD2Qc=;
        b=VQea2jpifn32Z78pa8tjNIGQszEEw8q9+SCehbr1uN1tQ1Kb5HEefLKyx8QeRLK3N8
         JeEZWLaVCLbONd3UQJ00i0MsBGr/4cNjssVExILCfpxNVfzib06NRwr8Vojuspy8sp4W
         hOCvbSAEhPg1mfI294wfZA3guiQWHcyuFaBBFx7W3MoLYe85u6KfhuxbxFdeQ0weKxBk
         PEHZ4Y71n2Xb38xJlMI7KFY0NZghZwZD+Rtggf21DwGYuZBgtHlvFCr/c7UZOI795ZfR
         QgWFGMlxcQSRbHDN1Lsx18v8L0kcv76vLsmRvndGnFuOt/3eQ3FQ2ElQxuHFz+H26man
         Womw==
X-Gm-Message-State: AKwxytcY3gybh9X+ZhOOWKB5rEjQI0zyAT+JviYYL5w2MJtRoLfuAZXC
        eB3RRQeB9VBYB3kcGaLioWw=
X-Google-Smtp-Source: AH8x226Fti6ubNc5gU/dNNoaMnsPvWFCsFH7nwM6IDGblWD+GOWpo2nSp8IyUsRxnw3JoUvU6vPpXg==
X-Received: by 10.99.168.76 with SMTP id i12mr8024497pgp.119.1516670984125;
        Mon, 22 Jan 2018 17:29:44 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id c25sm1728671pfi.183.2018.01.22.17.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 17:29:43 -0800 (PST)
Date:   Tue, 23 Jan 2018 08:29:33 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 07/14] match-trees: convert splice_tree to object_id
Message-ID: <20180123012933.GA15378@duynguyen.dek-tpc.internal>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <b5782b135fb68b645ffea711028bd6024176005a.1516617960.git.patryk.obara@gmail.com>
 <20180122115642.GB5980@ash>
 <CAJfL8+TrFV=DkJPZAYYYc69recsYiOGdeV8Ev0r5xfcmmqP-Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfL8+TrFV=DkJPZAYYYc69recsYiOGdeV8Ev0r5xfcmmqP-Hw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 02:12:56PM +0100, Patryk Obara wrote:
> >> @@ -197,26 +195,26 @@ static int splice_tree(const unsigned char *hash1,
> >>               if (strlen(name) == toplen &&
> >>                   !memcmp(name, prefix, toplen)) {
> >>                       if (!S_ISDIR(mode))
> >> -                             die("entry %s in tree %s is not a tree",
> >> -                                 name, sha1_to_hex(hash1));
> >> -                     rewrite_here = (unsigned char *) oid->hash;
> >> +                             die("entry %s in tree %s is not a tree", name,
> >> +                                 oid_to_hex(hash1));
> >> +                     rewrite_here = (struct object_id *)oid;
> >
> > You don't need the typecast here anymore, do you?
> 
> Unfortunately, I do :(
> 
> Few lines above:
> 192: const struct object_id *oid;
> 194: oid = tree_entry_extract(&desc, &name, &mode);
> 
> Function tree_entry_extract returns const pointer, which leads to
> compiler warning:
> "assigning to 'struct object_id *' from 'const struct object_id *'
> discards qualifiers".
> 
> On the other hand, if I change const qualifier for 'rewrite_here'
> variable - warning will
> appear in line 216:
> 
> 216: oidcpy(rewrite_here, rewrite_with);
> 
> So the question here is rather: is it ok to overwrite buffer returned
> by tree_entry_extract?
> 
> When writing this I opted to preserve cv-qualifiers despite changing
> pointer type (which implied preservation of typecast) - partly
> because parameter 'desc' of tree_entry_extract is NOT const (which
> suggests to me, that it's ok).
> 
> But this cast might be indication of unintended modification inside
> tree description structure and might lead to an error is some other
> place, if there's an assumption, that this buffer is not
> overwritable.
> 
> Maybe const should be removed from return type of tree_entry_extract
> (and maybe from oid field of struct name_entry)?
>
> I will give it some more thought - maybe oidcpy from line 216 could
> be replaced.

I've read this code a bit more (sorry I didn't see the "const struct
object_id *oid" line when I read this patch). I think the typecast is
very much on purpose. Junio wanted to make a new tree with one
different hash in 68faf68938 (A new merge stragety 'subtree'. -
2007-02-15) but I think he kinda abused the tree walker for this
task.

A cleaner way is create a new tree by copying unmodified entries and
replacing just one entry. I think the old way was ok when we dealt
with SHA-1 directly, but with the object_id abstraction in place, this
kind of update looks iffy.

Alternatively, perhaps we can do something like this to keep tree
manipulation in tree-walk.c, one of the two places that know about
tree object on-disk format (the other one is cache-tree.c)

-- 8< --
diff --git a/match-trees.c b/match-trees.c
index 396b7338df..a8dc8a53d9 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -171,7 +171,7 @@ static int splice_tree(const unsigned char *hash1,
 	char *buf;
 	unsigned long sz;
 	struct tree_desc desc;
-	unsigned char *rewrite_here;
+	const object_id *rewrite_here;
 	const unsigned char *rewrite_with;
 	unsigned char subtree[20];
 	enum object_type type;
@@ -199,7 +199,7 @@ static int splice_tree(const unsigned char *hash1,
 			if (!S_ISDIR(mode))
 				die("entry %s in tree %s is not a tree",
 				    name, sha1_to_hex(hash1));
-			rewrite_here = (unsigned char *) oid->hash;
+			rewrite_here = oid->hash;
 			break;
 		}
 		update_tree_entry(&desc);
@@ -215,7 +215,7 @@ static int splice_tree(const unsigned char *hash1,
 	}
 	else
 		rewrite_with = hash2;
-	hashcpy(rewrite_here, rewrite_with);
+	replace_tree_entry_hash(&desc, rewrite_with, buf, sz);
 	status = write_sha1_file(buf, sz, tree_type, result);
 	free(buf);
 	return status;
diff --git a/tree-walk.c b/tree-walk.c
index 63a87ed666..f31a03569f 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -164,6 +164,17 @@ int tree_entry_gently(struct tree_desc *desc, struct name_entry *entry)
 	return 1;
 }
 
+void replace_tree_entry_hash(struct tree_desc *desc,
+			     const unsigned char *sha1,
+			     char *buf, unsigned long size)
+{
+	unsigned long offset = (const char *)desc->buffer - buf;
+	unsigned char *to_update;
+
+	to_update = (unsigned char *)buf + offset + tree_entry_len(&desc->entry);
+	hashcpy(to_update, sha1);
+}
+
 void setup_traverse_info(struct traverse_info *info, const char *base)
 {
 	int pathlen = strlen(base);
diff --git a/tree-walk.h b/tree-walk.h
index b6bd1b4ccf..9a7d133d68 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -35,6 +35,9 @@ int update_tree_entry_gently(struct tree_desc *);
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
 int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsigned long size);
 
+void replace_tree_entry_hash(struct tree_desc *desc,
+			     const unsigned char *sha1,
+			     char *buf, unsigned long size);
 /*
  * Helper function that does both tree_entry_extract() and update_tree_entry()
  * and returns true for success
-- 8< --
