Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A52F4A
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752975591; cv=none; b=nuQvPb7w3j1qUVKAgsbTT71pZZU+lsIYCm/FFoLRvuq9E46qA05xAjvJN5SPb/alcUL+vdo0Dq+VDj6TgAbuCQdrgMSaRvBICS5b03nsZPTVTsxBmLI91zK0mtWaG/tJ26y/kL4kBoyFymoQGqZGtZO16U7P3ZCOpnpHQQxSRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752975591; c=relaxed/simple;
	bh=yL6y4dVE+Z09trnwJ0BbKqZEHw2WtCUdDcH2t167dYo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LmE1hCNWNu9K/wYbDdpYN91dSRi9G4qKWIBLgv3PWVVbbYqoxa3cxnh1I5iTL54H8vl50ZgR0QtoGSt8FePVTHT1hkoVuIl5oNSR0K4qRNG1KbjEyoWr4pBdDcGVV3w7o35Q0r/u1SKmjwrOvJHtazJ0lzrOEElww1LXgLGzW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=XIBwppMA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="XIBwppMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752975586; x=1753580386;
	i=johannes.schindelin@gmx.de;
	bh=Gr/wI1PyQ3l/xb/U4CZu0gwS3tdEso8VqWsSnyEaO4c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XIBwppMAtH+DUbyCJtqDxVfnRvC/ZtmuTplx14dH6OrwH8pmId3L3vE2W+5Fq6mN
	 0zKeO+tn/4VWHPK/rzPssWu/a5Z2i+3pVD7D0w+RdmEuAtlnXflizj8cCOzZ3elB7
	 2fjxgJ1Y3LqqCQRpitZ44YANVJfYwKLexYLlKuLuluMHtsJJSfZNkUDgvOuoc5iE0
	 tF0T03UNPHypD8QgX5WneS7Mx09bQVKZ+EhpqG1msJKxxGK7I2LttTk45oGXlLdER
	 y1TuDaB3QollxVL4tHkm/K7bxZVYt+7NxXlGnKWzqyiQdSdBbD+4zH0Sxt3jIjZNs
	 Kvr69TJ3TTxyQ1+Gvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIx3I-1uJyvY0Fru-00VVvV; Sun, 20
 Jul 2025 03:39:46 +0200
Date: Sun, 20 Jul 2025 03:39:44 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
In-Reply-To: <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
Message-ID: <295a911b-b461-e66d-5f9a-501b522f0e12@gmx.de>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L8Wlj0wnRqWLOXGuPW1IyJFKVXyZkJPRfN1ETmK9Mq0w8DMRX9m
 Q/6Sf63K1e3unGQeYvcotcWce5LS1Di6g02FIWjVdSC/9lCyZ0QDdTq/50Y5v9bpW5/TrST
 Y5Wgm7oqyORctGNCrVMy25kH2DOLjhGn4kUAreOapeCL56CQfKUt9ZiUu+4qUhfx5Xq2RNe
 kZ13LLgihrIiwX7RYOI2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+mtDorMXYSg=;AYVAlbfG3DE6E4x2CEpD6vF5NRf
 n8ySD87xHL89QE5b8XJ1fdH6/XAUw+1Px781lF9QuE2vqh/Lk/1QMVXxMgeqsgBjaGK7afEwM
 Rg43aTDSnJYGYfBPRP8D42ek8ms7bf0NEZb3hoYqFGgUA/CuSQivuPR4kpjmBt7JopJvKJyo9
 wIPRSfZFMIuzaLnSXvMam7fhHWN7bW+zJuzuGfwaid06m66c+wC2gHnA22NRSLiO98uh2XmhB
 3Rpw0stwQsEoAvWNPcGUc4e/3HQBiUouHyYVQSPwR4Ms2gMUi7LnMUYx9gAx9+siHNI54zbCX
 jf4sBT5gc0i3Yi3RZSgHpz628XSjv6ikWcjfNIvW+S/MjJfFMTf1RQ+uEgGTS8391yaZh5HgP
 rz8v8W28k9ktrKh62RSxyxHhOCmdwIRu2uEhfNf1kUiTKENFeeaDEzl8uydfzEirIe4aUxs0T
 FHuH9QahpiGikszii3cdIaow1mWj4tnlrFy1iEht2wFx20bIiyptTaUS/zw0zZ0Ns6hHSg0X2
 YQdH3tNpSnHbI9FCwN+y1VtBq/Qs2Z/id/qmUJ1hpK//izy0gaJeBTJaHGyyYp1+br1sZLaLO
 Ss7Agjy8S1KA7YtV4lKAIVel2ASWuuRgECH7iVUvCxiZ5htyuYovbC6AY6iJZUZZhYr2Vy/xv
 wZayWdilLS3RP9JwUh9GiSrQ6HxbZDEyQOVmwiIfYKPZrjI9I9Ogvy1/pl6mopSfVSO9CQ1yk
 U5f1/WgHntGYBhS3DD0r2+0AYPJ+k+SxWXIh0pg9FE51WGI7RF6tX6wA2evevzjMFfrLgGl0T
 RqGJ0IOULOjgyEnopXlSKHZZ3oit29mJ3YXW1s4wq2zVhqEIEePDk2Zrfi36W6guZqtKX9aLm
 FIsxVX2RXGgFKppXBDBAtMylg2fV9fp+di9v/cx+XB4wYu0rYzkjz+2SSpyLo00YvGg4VOBBX
 EgSBENbjpyGSZISeSA6EpKQVxJI6D6jJ9TLcchXssSEBhMPWDJjA6pV2vuj/3BKSqTmOH/RvJ
 P7FWb9/JYsiQZfTPgwPuu/Cm7H8g+eQnTyajfNo0Sv0jKw+OumqX4jFkDlz1LxV6/1DTbil7Q
 W+0EZa1r6C2HdXwdTttX375QdnDK+1HU+IHAiebqPOIZFy5llKhZnbBUbNE7q5sbtDEyN884n
 KAN8zyPz5F9B1uX1TTe+064MWSBYtp9rMzWsJa41AgmbGkXtFb7Ssd+ayNl8vab+U6Mtm3nDo
 hzgQx1SPsy63+e0Fa+56OvBCokP50CrUeMmxvxEG3WhlCpMsXKHMSqRE2vxXFkUtyhzjN075a
 oYtERmT2pTNNQcfHywlJz4aTAgYqM9uAv7Z5/wRxptItfM9IgE9REEet1ViU4YxG7G2E+9gwT
 Xh515hMBUd2mfygsZVtpK6m7t7ykCHb4w5KD41U5CsMRKwi/oGP3GPzz/m517xbhXB+dunq9z
 Mtoshc/9+3md1R+kuKmBag8uvhVbV07TdHAU4rA7FV8Yy1Ust+eoJhgypWh6r9Dd9b0fEBDCp
 4/QtsSs9uvyibnDN6TtRsD3VRZL65ROtylMlujGLlREblVv7tekR8btaBIY4htstO6Fc0AXkN
 aR5okvh5ZqSJEZGLazClfHbZufjv3KPDozOxb6BZJ7Zop4eZ20oXm+t7Pn36R2RxVau/Zf9Vq
 qN8hMpBtT5r9ojkaant52lbnuV4et3luMLkOpl28ar56fzeUnurDSZnQOrcBFStjv7ojsNRmr
 mACzI+9aVVXv9h8d87W/jzfYEBTFz6PoOZLIcOGbpQ3QcSr5VBt7SGTsxZ63QGdsy5w39t3ov
 s/xNhzMQ8sLS7iLlxnZK+lx88zLIMBkMbKOgHPL75DHO0zy8UQC9quK+KfaqesDIkY8ZIvCsH
 X7iU+Wr21RfXZ+ggw8M37RYnSjeLjhsP32CGjqONFllhEdxcDT1kc0L4O7BoGqISo2YlEzNHR
 Qg3G1IMjqLhYN9VPex9P+TQtrYWwgq5GIKDdvF/oQJB+NzEkVUSLBeS3+FTUqnBHmnyo/Ti3n
 0Oc5C95GQ8RGd0r2GX2tHY4WmhMPAo/PnU5anD/JXuOBVpUUggQ0RsdnfpRQxe0RwpLABRX2K
 QxUwPIJN4hBklP186z2b9nLIFMr/gwO9/GXr5FZ+H1JF3Zeu25Q7fPnltiatLQloKFX7YBO9a
 DFUNppPrucCjrZHaJMUGaDMsb8qmY5TwBw1COULbewsZpZuk6O2T07NlnP0XmyDxoeeLwk/aY
 THJYcOBhaJuA/CSDwjYzQL1FbFUNIBW6fRoiSYtjClTvElJKohVLJtX43lqXbRKmgqFU2k7jV
 P0HlTV9GVphMSzpYSigzc5cJtL8CAQ8nVgmtiCemjPjUWbP4VbWFcglWWPNlXJWPEoGVywYiP
 ZJgQ/mErQpOXbE9AncpCzNhnW7ZnvPozTV85YFigw1OsbJfsCTEXWnW6OSuBDyuGu45AkJ7NX
 nRGOGKBHW1EUr8o4gvNa5wt5D4FOktGOY5os4HFvDxj3n2O9dyzriYd3eaqum57ueqTSri176
 MW1rD9Bb6pUXnrKe9Lmisrb/1sfV11FKzS7hNdOEX60iDNObohVVHjWL23/3/ZuYgOdy3RYmX
 bpP96MujsLuR5yoIh+AadrhtSBp1bCV5dsDOTeYYL33H4OL2EPBAK6GeJ/WE8iub4J6MgOttr
 LLPwT3fhcjcoCE2SHrj9D/Ma6zG665eFRalnEWt0WTF7o1CEKsI8drGawaCsPJLY85NGmqxcq
 QXYCGAqRO32shC5EFknVrZVFtlnLC+aLnUvG4oYNS5MubulR2fBzzXK20AUMba43hhe5hj4SZ
 VeaZSi0p/Cne5vkquiYOgFC0ngjInCqtbzkF3JTkj05tN50G+wCqgCcw0OYz2l1rEvJ180usv
 id0mYuxI89Vc+BzEEGkh7UhgavFA4W5s05AJp/2XdRn4mNg5pnTZFFqmWWh7uApIe0LuLFhv1
 ZI4DjKQl02asso6oKbrWfEBrcsUKBqT95mnVB+m0nOPAYR5ka4FRdDWBACoL9LEILdjoubeXn
 NqSWmE6YkxlzA+TJ8ZOQ6qDTQqJIrFlHSlq11l4SgbutdMkSyPFulnh8eRww56Zu/lvxfSxcd
 5qGdbpUZm/mzUT6L8aM89O4+CPDiH2zCEfO6Q6CSUnSjBP8cXDFcsxq6kT2u4YavZW3mg/wvw
 FI/Aip0ZXMs7ypuDcP10x31+GY1bY2KphjnsgayyUC0KFFSPhRrzxb3TA1BpFO4MfJagXao0O
 gNUX7IUeInvyvyxaYR2iSK/w5CyvQRSo9AW6hyVLm7y/WbdoEaL+wett7iif0+Q4BH85Fyg7H
 NMLiOwLSVCQndR1YAKo5RwQ6r5F47t6hWRR1S1D9PriVHS+qFBWuYhjOP+jifxbeOkwjCKSZD
 MVkBzZlWKxV500cHm3Lyt3ukfgTivJi8qTgxBcs71iRKLdBTTJUuAcA6Xm4pDZZqC5SH8uWlz
 m8j59gCwwIpGK9JiKTV/1VF/9YWWobo25eBoSTXTsSvfjlcNxB5ew9UjhJP5PT0R0jlGqdfAV
 dS7iFOT7iXRQflVb4EwmXDPubXCsskB1Ymb4T2Ss0PWj1nVBcAiNxvqRBFWwzVW+l6Y/SOZtw
 EmWGPzcUjytU0nAIXhAwkqyunAxVqpQiIjn9yMhINIQ64aJtWZI3IrmkkCS5rhSA0Gr4B/6dN
 Y5h1s=
Content-Transfer-Encoding: quoted-printable

Hi Ezekiel,

On Thu, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:

> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 8b8467360ecf..6e5f67ebf380 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -39,9 +39,9 @@ typedef struct s_chastore {
>  } chastore_t;
> =20
>  typedef struct s_xrecord {
> -	char const *ptr;
> -	long size;
> -	unsigned long ha;
> +	u8 const* ptr;
> +	usize size;
> +	u64 ha;
>  } xrecord_t;
> =20
>  typedef struct s_xdfile {

You cannot do this on its own, you'll also have to do the following (which
incidentally fixes the linux32 failures as well as the win test and
win+Meson test failures, see
https://github.com/dscho/git/actions/runs/16394351471):

=2D- snipsnap --
=46rom 8693c83858a7c9308e54fb470cd7e82bcf67c758 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sun, 20 Jul 2025 02:34:35 +0200
Subject: [PATCH] fixup! xdiff: make fields of xrecord_t Rust friendly

To make `xdl_classify_record()` work, the `ha` attributes of `xrecord_t`
and of `s_xdlclass` _must_ have the same range. Otherwise the function
won't be able to recognize previously-classified records correctly when
the `ha` recorded in the `xrecord_t` is so wide that it won't fit into
the `s_xdlclass`' attribute and therefore they won't match when they
need to match.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 xdiff/xprepare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 5a2e52f102cf7..c0463bacd94b0 100644
=2D-- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -32,7 +32,7 @@
=20
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
-	unsigned long ha;
+	u64 ha;
 	char const *line;
 	long size;
 	long idx;
=2D-=20
2.50.1.windows.1

