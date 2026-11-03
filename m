Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793742716;
	b=BnkYrK3ASR24UmK5RfTbU6xzW9CZ9O5VoaYj9GWI1TPENA5xsTXuiu1d9oUmK4rjvXZh
	 zj9RRYwQ/zWhOL3IbJDvG7qj3o96gE55g/x6qCLfUCUbYP3fTC6QjBX0ja1CmTxfl4tIW
	 lbZEJei2YmXcyieXbtHXTsPJfeBgHFTkLNWEdcvia8HyJLAP8M8gCAwtZ4HCPbQvioQ87
	 l+xu95KtZqcS7K75SB9mYNqv9XIQP1iq70zTKZsFZEbBSqRXaZA+LMMWYWERgWbnsF3+d
	 c87JOV6YZyEKmfmmHFC5Dxaot+F2zXNsofvGU2sSwh+rkyzYYjXHbxxTltf3W08nTQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/AqHVt76rIOWS2Gv3NyTS7S/Nv5ZtIEJDewJimsmf0I=;
	b=zF9QO9qNPe/1O0vP8gJcZwk3dDVCA0JWhjdJgtk77px7ER1UjLqU3EXqVR/gvUG0TMMe
	 ATg9MCoyUTs7W/7+5szUwuzrWhAm70LRs5M0eDToF0NHgorIz94IOWvFtLeO0kELBJ+G0
	 oM39l5Rh+0objMG5hY59xaXd6z4VHpqRolA2syBQmMGyv+mFRY8nTvmoEe5K/0Ml7bxFd
	 EpPxqPEf9SugIApjzerOa3/CJiOp9fC/llTKU2j77JSY+LYaSXaUNkoRnN80l0tpWBpNd
	 o9Gq8HtZWYbqJqhw+ys7qEJ5ly4C+yFpzOidIPInfFxmIrEenrgnXJ+YQwcq3HO2swA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oV4D+j1/";
	arc=fail smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2380606A335
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 21:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2380606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oV4D+j1/
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ec3561b07dso840430e0c.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 13:51:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793742715; cv=none;
        d=google.com; s=arc-20260327;
        b=Ao3Bv/+7qpdKVd7YEAxbqSH6N2ZGU8YARz1eblRYpsdVwpCiRfBsgmdh6a/jiQFwUa
         D+MGJyYAUHCS3sJrHuGuyCuisVtYeNKS/mstEv130nxJezXYP5z/ro1MotBPrFrHiRkO
         hoMoB0DJPgyfWEER9yf2K1z5HdCkyb3RLAQn7gGiDnmA0X13flEzFaXFqzfYlRq0QxP4
         e4X/+FbHxVp/Q4g7aONfNh4mVl8tPFWtEauyVTcO+q+gL16tiFwQFwM7D7bBfihyRGEN
         bk/IF9VwcV3gm4OgwkJWJqVINzXJfLTVJb2KD+kJOw4Y+rU19+deOEGbTTtICcQSpFdw
         V/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/AqHVt76rIOWS2Gv3NyTS7S/Nv5ZtIEJDewJimsmf0I=;
        fh=dEYIOgtSXezrcUvsChM7xNX0rW1hwLsTYJPbXEW39DM=;
        b=MCLt5FRRpBbDc3kzSLXfFSEVDuZycyI5FqQUvWiL0W3vNv4OfSJgQ9osj4lqiCu4SR
         F5qQKercSYpg8Klv9GVFabDpT/wqrEIsjZGHroVvKk4igyG5si3dKk+3ewfRR/Lk5PPX
         RfGhofBa+CQFDOSoDXS80I52zntStmN+rAwW6XyLCeuFn5L9Nc12k26k8h++hNLoMClz
         BKnV2nSiSnUNiIt8cn92Iq9uDcA6fC0O5tneWB84c8+tTqxUU1aeuJyskR+1KcET5Rp/
         J9prbW2sXCx0mwI/MbtPp1dPLBTysuzWXl0qyieYSSga5QnRVErZUgl9jSNrz0ffCNVj
         FsCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742715; x=1794347515; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/AqHVt76rIOWS2Gv3NyTS7S/Nv5ZtIEJDewJimsmf0I=;
        b=oV4D+j1/0sYy0N1WX0ko9d973JnwS0f5GCRNj7lPl1Tokk7UgC8h12uF9/jeJ6ppKg
         93ZyFhi8ZZwtwSJy/nKZKBbnsD6NoWq0VRZ+K4kZnljA3JAjuiHdQQV6Z3KSnqcie2sn
         0vGGGat0s2LVGPmPdTxkTBH20bLZfdp9XKLO3u1VnlxtEv2MNBJ13QnlkBSNi2BJ1XPh
         fhTPUAYDdbEdBWJSCXxfaADeMX051Otww+wiK8U7DX+gqPCKA3RZNrBogKYLMooTyAiJ
         qWH81oEDAEkECcoiyNGHEJ73RWBSYE6QfdlciHKkPYI1KBKX8eo/djcmTiJh6NKzUKNY
         ubfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742715; x=1794347515;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/AqHVt76rIOWS2Gv3NyTS7S/Nv5ZtIEJDewJimsmf0I=;
        b=oLYo6Bo6fBiFxbc11r0CMTBWT4OU2yVHB3ifmUYYu13Jz3U0s2GZfMP7pGO5Ia7Ub8
         QSr6+dEwlJe8DeB03mUGrpE9X4kvFr9ui68nOw2PHGafkkSx8WEYgNHik59lb6trOqwd
         5yL2Gdj9acSxXtITZn7tjv86gNrGZ3od0GTvWUI/2KMALD6lj/RTPB0Z8/rMcd6dRPms
         AK1kl14lM3QlR+mq8MFa+b9JnLr3Ldabr+nWwBCA3S4iZNjTDVg33cRsb7ai0ApKJuux
         DOHt25QaNaDVk1m9gyYdOsVRqHy9NdNB2k2vC2pwqJdY2d/wVbafPrLAXnY8yi1esRIe
         KULA==
X-Gm-Message-State: APuU4Z9ISbWSgrqri9FBIK+N64tGmV5NulpeJUhwDU95DYGv7kuewcLJ
	XKPQLwaS6lGMjujd1BrPmwF4v8SVhaxIqrauRJK+mAdCEWNRnjNWl/r4iebFyHE/72ji20pUXSF
	zKIeWvY8QBaANJXHvjTCOufzjdtIuUyI=
X-Gm-Gg: AYBFou3vZC94wZgduERkdzmijxG20KmqokmeodYUchNauYU0Y8D7diGD2saFvfRfHZ2
	ZADRIr0G9d6mp0a53Ep5Hi+W2JVN6lgQ97Xtm2cD4I9fg3J3MtKRJuTRbUFQb+nHC69xDlJjjDt
	XZOQTeY7bUCEBeGpcPrt3GkSCt42E3jF4phpz2MeGMMXfFPSjoSeyN4lwq6XvWE6DpTsLveV7Kr
	KPqyNEYknwlNankJVbiqjsCWHU0MJq46fQq+TGtGn9wdRAGJ5LNuEGZk6bPapSUh1EfwDBEfd+C
	l/MxnxF1eICda+9/wIspBrT814S4yZEHlPWX28Zl7mBSE48CIJqGVynJ9M43+FXe+HVQlNiOZe3
	jBM4/uYE26R3NRY9RxG2k0CFJ2YnNUfiCUv06XoVui7ih1466LIeshzCGlu5dq/1P3K87IKL8Mt
	dm/MayKm26MQCNNvw06qLaXPc=
X-Received: by 2002:a05:6122:8487:b0:5ea:b8ce:7701 with SMTP id
 71dfb90a1353d-5ec5876d7cbmr3875287e0c.10.1793742714629; Tue, 03 Nov 2026
 13:51:54 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com>
 <CAFzd1+5s6V+YC3onNjYQmxRPVnsMROpsVi=qy1mg2=LOAnU+gg@mail.gmail.com>
 <DMLW72EXMN1K.3IXVPHWNYQ3EH@gmail.com> <DMLW93TBSOXK.2OLM5O3HGK1ZY@gmail.com>
In-Reply-To: <DMLW93TBSOXK.2OLM5O3HGK1ZY@gmail.com>
From: "herr.kaste" <herr.kaste@gmail.com>
Date: Tue, 3 Nov 2026 22:51:25 +0100
X-Gm-Features: AclHuK9_Oalemm9ubyNrwndLDuXltlP75_Un54dm1mD3TBHYvCjhlXNvFHwuR8Q
Message-ID: <CAFzd1+6fiuT1R3B7aK6mN842g5+EiQ4Qt2_GCS1YFMVs+mXFaQ@mail.gmail.com>
Subject: Re: log --graph draws an orphaned branch with parents
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From 48bbcf965dc630251cc32f38d7efca5e6fb77c5e Mon Sep 17 00:00:00 2001
From: Caspar Duregger <caspar.duregger@gmail.com>
Date: Tue, 3 Nov 2026 22:38:22 +0100
Subject: [PATCH] graph: do not indent visual roots with columns to their right

Since a34c00d96 (graph: indent visual root in graph, 2026-07-14), a
visual root that has a child is drawn indented, connected to its child
by an extra GRAPH_PRE_ROOT line.  When there are columns to the right
of the root, this breaks the graph:

*   M
|\
\ |
 * | R
/
| * T
|/
* B

graph_output_pre_root_line() writes the extra " " for the root column
without shifting the columns to its right, so they are drawn between
two columns.  graph_output_commit_line() then pushes them one column
to the right, but the following GRAPH_COLLAPSING line is computed from
the mapping, which knows nothing about that offset.  The column next
to R does not continue into the next line, and with more columns to
the right of R one of them goes nowhere.

But in this situation the indentation is not needed in the first
place.  The columns to the right of the root collapse into its column
once it is rendered, so the collapsing line always leaves a blank
right below the root, and the next commit cannot end up vertically
adjacent to it.

Do not consider a commit a visual root when there are columns to its
right, which gives:

*   M
|\
* | R
/
| * T
|/
* B

Signed-off-by: Caspar Duregger <caspar.duregger@gmail.com>
---
 graph.c                          | 12 ++++++++++++
 t/t4218-log-graph-indentation.sh | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/graph.c b/graph.c
index 28bef1b88..95eef3a95 100644
--- a/graph.c
+++ b/graph.c
@@ -969,10 +969,22 @@ static int graph_is_visual_root(struct git_graph *graph,
  * already a column, so it will not be rendered below, the
  * current commit has to act as the last commit and omit
  * indentation.
+ *
+ * If there are columns to the right of the commit, they collapse
+ * into its column once it is rendered, so nothing can be rendered
+ * right below it and there is no need to indent it.
+ *
+ *   * | <- visual root with a column to its right
+ *    /
+ *   | *
+ *
+ * Indenting it would also push these columns to the right, but
+ * the collapsing code does not know about that offset.
  */
  return graph_is_visual_root_candidate(graph->commit, graph) &&
        !(graph->commit_in_columns &&
  graph->columns[graph->commit_index].is_merge_parent) &&
+       graph->commit_index + 1 >= graph->num_columns &&
        flags->is_next_visible &&
        (!flags->next_has_column || graph->visual_root_depth > 0);
 }
diff --git a/t/t4218-log-graph-indentation.sh b/t/t4218-log-graph-indentation.sh
index 24dc9b497..b3b9f7c14 100755
--- a/t/t4218-log-graph-indentation.sh
+++ b/t/t4218-log-graph-indentation.sh
@@ -449,6 +449,24 @@ test_expect_success 'two unrelated merges' '
  EOF
 '

+test_expect_success 'visual root with columns to its right is not indented' '
+ create_orphan _70 && test_commit 70_A &&
+ git checkout -b _71 && test_commit 71_A &&
+ create_orphan _72 && test_commit 72_A &&
+ TREE=$(git write-tree) &&
+ MERGE=$(git commit-tree $TREE -p _72 -p _70 -m 72_merge) &&
+ git reset --hard $MERGE &&
+ lib_test_check_graph _72 _71 <<-\EOF
+ *   72_merge
+ |\
+ * | 72_A
+ /
+ | * 71_A
+ |/
+ * 70_A
+ EOF
+'
+
 test_expect_success '--max-count treats the last visible commit as
the last commit' '
  lib_test_check_graph --max-count=2 _8 _9 _10 <<-\EOF
   * 10_A
-- 
2.56.0.350.g48bbcf965


Am Di., 3. Nov. 2026 um 22:29 Uhr schrieb Pablo Sabater
<pabloosabaterr@gmail.com>:
>
> On Tue Nov 3, 2026 at 9:27 PM WET, Pablo Sabater wrote:
> >
> > I think I may be able to see how to fix it tomorrow, but I'm quite busy
> > until next week.
>
> I forgot to ask if you want to try to fix it yourself, I'm happy to
> review it :).
>
> Pablo.
>
