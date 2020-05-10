Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F1EC54E49
	for <git@archiver.kernel.org>; Sun, 10 May 2020 09:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870D3208DB
	for <git@archiver.kernel.org>; Sun, 10 May 2020 09:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nK3ceTep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgEJJHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 05:07:46 -0400
Received: from mout.web.de ([212.227.15.4]:41645 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgEJJHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 05:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589101651;
        bh=r0RedhlcqdB67XcI1NpQA/3caKMz4bsuHabibFtKlmc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nK3ceTep3KNL4DaA8HOm1WovRqo6gIRkhHXdsVO6SsOujujFgywLUm5xDO4PFyFJk
         Qm7KtXXZlRbbdnEKpczkQW8SnoS74W0nEjW1NVyx73/FxOxG+9o4cdoSxOiEJ4jvPY
         nNi7IaRpeDSH+BHNe0xNvDkm0RFcl6uw1i+N2tsU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kAH-1jT3EA1xTd-004oJS; Sun, 10
 May 2020 11:07:31 +0200
Subject: Re: invalid tree and commit object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
Date:   Sun, 10 May 2020 11:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7wovoop.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1wKyzklJkxKey1MCzET2cx/aaRMWOC9K6sFEiO9Gx7GsZS6DdB9
 hiENnw0DWfOmf/TyTeKuBlASl/kR7s/d/G+b1/iqinrhk+uvuL6TExoI6Jrhh+c7m97Cku6
 rlj769J/te5l7+R3bfhRxJ7MBBWsbFdFfN+9J+4WpN9hRYN5MQwYxBt7VT5AO8zGdt2OEqP
 hzw9sgmynpYoiA57gKtpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w64cYzv2ltM=:2gxS+tDj6NMHt/Kls0DcR/
 GTwIEdH7MEA35uDfkzda7h9m1vNERnpB3n49LON72XqJWoz5ZoSK0NgxE1OIPXELBbJCBa8sl
 +pFoyV87pCSkJyJhsibx4bTu2v585JibDnvRjTSd1byZaDHuMzphJP4IVFcQnoNtMitHQjA9e
 YoiBycWLEW8x1qLyTebF6WBZLPIETepacOQuYm8ZszmTzccjxCEtChNjxJWtPSMArReSPWjDl
 jG8LW5r/SYc3BifyQPLoxuo1lrLVCJS+LzILQd5Gsk/pX7/gSDNamFGoNHCL5kLYywELaIDC5
 nilLdr4xEEdWfPKfzaZ/j1uAnRLXOzMRvIrEjNhz7jjVDqaYCgjI0Iu4/3O8KrQnkRsUf3L3+
 4IKuoXorEYxUCltO6ngM/PLpo8GCJGBiw5TWoipADDCnEX5lRyJShqe3tOV7J1wKZy+S04LvP
 WX56+++6Ik4t+relXtrQG6deXwVTEYU1II0Bzk1ubPv0Yqc00w07qGfi4by2dz9m8m13pP46C
 amAIty2mqWPqicTJ5f3zHkFCmouDitPNUELSmeaHh4LXBIRrdLrOKqJS21AQkF3xuWXEGWKny
 kJa5zFNyKQp1/epuWfftJJtRWpL8JdWlEDLs5ZISLq9s5hUn8+cejCBK2Potu1PnpOAQHex+g
 F0zZLb90GBHf97xYZ9cl2veTJpeCDb3ky2pIIpbjX+3e1irBCeBrFoDOaPmkRgtzSCBv4hzvT
 w5j7aZ+CFQdTdkIH1QLc4JvZ3i1YhppjrcIWrMRdeeOZ0tG1SixwXp3qB8Fem03OV9P2PBiHe
 mIBE11rVBEU/84xL3Kd10t7FDpwfg7ct4CXuE5VGt9UPldCO4f11MAH24ycxvzYccju++B98h
 6zGQlS+NkpPu3CRuHkQhqOJRP2a5QrRB4HG/94yI+/DT4iKmaGTLM70vxZieY2juozgLEjPPA
 RQnMrYVFHb/UBVoOyn3wBuetKsAluCW/YUAR8v2taHu6RL4FbVfGyNI+w5f+dU/e/JRH5CzjH
 dJVKQGEbAuEq90jdYNnRdOh1pIJpwIRKapFHdjrViXFVBFIb+64J0M3mJ1oJeiW905UtCiWmv
 lj8588Io3nNxr9nrGQuYy9Jni/Oo3N3phsOA5tnKe7ony5Fwyyl72yqhskXZQLS3Ck1joxa+G
 KWAzUrXdCdV8Xx+HxKKH+IQ5nMyItg/JT89ZsHiZHvmxj2jWnU4cARA/es2wXJm2BPo2xmG9i
 gS+J/Jtdjt022LvNb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.05.20 um 22:27 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Hmm, this could lead to quadratic behavior in the worst case, can't it?
>
> Oh, absolutely.  But as you have shown, you'd need a specially
> crafted tree with early entries that are prefixes of later ones,
> which would rather be rare, and most of the time the bottom pointer
> would advance by one every time we consume one path.
>
> So it is trading (hopefully rare) worst-case runtime with reduced
> storage cost.
>
>> We could, however, reduce the names we add to the string_list to
>> those that are possible candidates for conflict -- blobs followed by an
>> entry whose name starts with the blob name followed by a dot and trees
>> that follow an entry whose name matches in the same way.
>
> Yes, that is a valid solution that strikes a different balance
> between allocation and runtime.

fsck should ideally handle the worst cases gracefully -- I assume it has
to deal with the weirdest "natural" corruptions and the "best" that
pranksters and DoSers can come up with.

> We may want to survey how commonly "bad" trees appear in real
> projects.  Depending on the result, we might want to update the
> "limit re-scanning using the bottom pointer" hack we have been using
> in the unpack-trees code.

They are surprisingly common in Git's own repo.  Ca. 74% of the trees
in my clone had at least one candidate and the average number of
candidates per tree in those was ca. 8.9.  We have e.g. the t/ tree
with its several tnnnn/ vs. tnnnn-foo.sh entries, or builtin/ vs.
builtin.h.

In the Linux repo ca. 20% of the checked trees have at least a
candidate and the average number of candidates in those is ca. 2.4.

So the patch for only adding possible candidates to the string_list
is below (on top of my earlier one), but I wonder if we can do
better.

When we look for a d/f name clash we don't necessarily have to look
back upon finding a candidate directory -- we can also scan ahead
upon finding a candidate non-directory.  That could be done using
repeated update_tree_entry_gently() calls on a private copy.  It
wouldn't require any string_list allocations, but its worst case
complexity would still be quadratic, of course.

Would a stack work?  When we see a candidate non-directory, we put
it on the stack.  When we see a candidate directory, we compare it
to the entry at the top of the stack using strcmp().  Equality
indicates a duplicate and we are done.  If the directory name is
less then we can pop the entry from the stack and check again, as
we're past the point where a duplicate would be.  Makes sense?

The candidate stack solution would have linear complexity and
require less memory than a full list of candidates.

It would rely on the entries to be in the correct order (same as
the patch below, come to think of it), but that's probably OK.
We may miss DUPLICATE_ENTRIES (just like today :), but
TREE_NOT_SORTED would still be reported.

=2D--
 fsck.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index f47b35fee8..7d5bfef804 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -569,6 +569,25 @@ static int verify_ordered(unsigned mode1, const char =
*name1, unsigned mode2, con
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }

+/*
+ * Consecutive entries are checked for duplicates in verify_ordered().
+ * However, there can be non-consecutive duplicates because a slash
+ * ('/') is appended implicitly to directory names during sorting, so
+ * there can be other names between a non-directory entry and a
+ * directory entry with the same name.  E.g.:
+ *
+ *    foo
+ *    foo.bar
+ *    foo/
+ *
+ */
+static int may_be_df_dup(const char *candidate, const char *interloper)
+{
+	const char *p;
+
+	return skip_prefix(interloper, candidate, &p) && '\0' < *p && *p < '/';
+}
+
 static int fsck_tree(const struct object_id *oid,
 		     const char *buffer, unsigned long size,
 		     struct fsck_options *options)
@@ -678,11 +697,14 @@ static int fsck_tree(const struct object_id *oid,
 			default:
 				break;
 			}
+			if (!S_ISDIR(o_mode) && may_be_df_dup(o_name, name))
+				string_list_append(&names, o_name);
+			if (S_ISDIR(mode) && may_be_df_dup(name, o_name))
+				string_list_append(&names, name);
 		}

 		o_mode =3D mode;
 		o_name =3D name;
-		string_list_append(&names, name);
 	}

 	nr =3D names.nr;
@@ -1221,7 +1243,6 @@ int fsck_finish(struct fsck_options *options)
 		free(buf);
 	}

-
 	oidset_clear(&gitmodules_found);
 	oidset_clear(&gitmodules_done);
 	return ret;
=2D-
2.26.2

