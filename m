Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762083;
	b=zQYVnxE8mxeFKt4ZZQYSRiiDkH9Ft4Y4N9rv/iBIne12EgHQkQ/rlbv99Pa1QUDsNB+m
	 BvAvljYpi5KY0EpI2MfxmqGqBb+aXq5Ha3uiZ+NODBu3gztVHB8CLqConaQkdjnH0pjlV
	 MpNLfxQWfjAleTNcfZKkZgNi5XCzRhpv0TCfxBDl8vxblBJh0Omitp4f2DDzqqdoXiJxg
	 IhAyeQwFswa3tZ0iqdYQWUriOafr2Uac9dvmi01twubZzICbmO7kIzy5KOMaT2xax1qtC
	 zL7dqaYf7BL2K62H6rSvp0JfD/cJV5kr0PSYiwdYnzS9me3O0IYZ3iEoQ0JVE4MGI+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UrExQA1SfYdmOtck112k5ZuPqBbgzyFY8aOZt8y2df8=;
	b=DJJfu8up3r61DQa3cvBQQiQZ//8aku/BqxR+CcDsDlD8chbEahlhWG/U9oH8ffRMvX4C
	 13ARKszpf8NwLJ2N+Uj4QY/QgbnHbjSQtfsVBLLpMfGtbHRaQCWSR3WPbX3b2I/dxgerm
	 ed13rX/pE7RMdgaEWAm+JOhqqrMxhMA2Kh+CAMiyMUzTiRztPyWN840IqzrFB/+npvU/5
	 p6XpGAVDW0r9uBeVy2R0MLO7mI+vH13RYMq4y+IREzIhkVjn2rqLYreWG7vA5MH93Izbl
	 JS/iddyeT+0DlRj1F1HivbHERn3NTA0Za75lLefjFYaCS6CyrkeWEzVehKiaRtj+FKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N3XJbMHI;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11168606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11168606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N3XJbMHI
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b056d58f2aso8214107b3.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792762082; x=1793366882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrExQA1SfYdmOtck112k5ZuPqBbgzyFY8aOZt8y2df8=;
        b=N3XJbMHIE7L/flElHJ2oWIDfd24/Oql/oW/QeAT1yNqH0UsrW/bZQEn7qTlmuKPUm1
         3iQVeMlEHf7kJbU2iePuIiPyGGYh3NKLbN/yJqyABistSohsPWzDZu9bwhin7/LE83Ms
         pn8bWUmgzTbU81QQHgf0sYR0hPoLOWaIakYOSMtp6A0m7/dZlosABmSwMqbATLYaUIG1
         nx/GuSzB3Jyv1ijudv6TLtXbrfDMaW66P50hi8PoxnjKZp6lMy47WRoyp0yucVCmzh5W
         cf+CvcRRpsL2D0uqc47gAKqj+mjePnR8o8U6Ym8vjGIseRAduGt715haR1DfW6Gjsm9j
         gDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762082; x=1793366882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UrExQA1SfYdmOtck112k5ZuPqBbgzyFY8aOZt8y2df8=;
        b=CcWmChClsVpHLkx9wbttJ6MPLP1Y5Q07JSgytWDhCzKScX5aKnkQFdRBSZRuBcPFhB
         2tnfcKZbh2sTpKXC55kuSodvJsO2Z9lccygQ8qtSRgP/Dgc+G5cM72rM0TV+OMrOxr1o
         zrn+zSvzNesiUUBpcr55LzuHGyzGYAdP9vKO/7snQ5vAIvTYRrkahq7t0fdQ8q6TIMzw
         NmUSlqRBgzREyM2jL2BRpnnOBoFAbam5dzctAbdEFi18b4GJzcJZ8qYXSxSpdbuhva41
         5SRwDk0Sh5mLjqnTseIQH9Xn9Dvl9Y/ju+a4ycoPsqtzNe3paYRvi6CLuZDqCP8YBJKQ
         3VYg==
X-Gm-Message-State: AFq9FYK/a+x/cWoAd05lUuZM+3thwoLak74Q6jsOeF/12Z6RkL3hDtV0
	mcTqzFCC9KYuZpki/DwZnBLB3HiWYRB68TX/59SOzRPowPZOiQdxLQK4bWKvWJpf
X-Gm-Gg: AYBFou1k2p1FRZ5tsnrJnNmmKsoo/GW57IWVc1zCYmb3jH0JKNRKPy/5fmBTe0q61UT
	ddImo7NieE0unt/QxCjUuNT0/Gfoqz37bnXBWY+4ip/yRthSgh9UV8FdynyaYmA7Fg99gG7AlDg
	3ZUyCRkfj6s/wMloY9GmFtfsgIOvwU8nNqXlHX9ZMYyfT54/SmJ998Aw65L+u4awgDO9dd/wDmD
	mgC3lfrgEEISzZzEmEfDNURO4D4s3Lu2WpqaF1TQ3ZHCDTKIzg0P1zmS47Eqp4SckMiHOz+1+lF
	xbxbgGHRIZZN3y6f/erYEgr8VCFMmpqkBL2qiM/t9kPLBekNwkj647FJm+7ARPWNkLbsNP0TsTe
	Xd197dotuxHtDyY+LnZrsoFbNHJH7m3JxLX6JYHl3xnXPVPmCEYSzIaPTQnc/ggqJnCftri8FKr
	8TgF4rDDbe1A+2lZvKKuDoYU5zSM2xdLqgm4buXHmJKJ0FmRWyX13N+iIB9U438eBniBiggRVQi
	l2HGpFLU9FAyHida0yb5JJ3EUb7dDj4+R12G/KM9DRYOoVBs/eYVhZq73G0FTIxI+WOTubqnQFE
	BVvPjhQbTdkZ/RNMunRQ7s2hPAENRFFkWx0tI2Kw7hfQaNzTtD8A0zzVKfloh36GR7NCXZRTD7p
	dKylyjktNnGOQr2sGbuhrnAvflQ==
X-Received: by 2002:a05:690c:c512:b0:89a:63bc:8dd with SMTP id 00721157ae682-8b157eb32f1mr15005557b3.103.1792762082026;
        Fri, 23 Oct 2026 06:28:02 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9d17:3000::3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156183032sm12898647b3.34.2026.10.23.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:27:57 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] Completion: extract common stash listing code
Date: Fri, 23 Oct 2026 09:20:52 -0400
Message-ID: <abf8efb792e6cc90db2752baaef4a7bb1d00f4b1.1792761643.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.237.g5414b88716.dirty
In-Reply-To: <cover.1792761643.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com> <cover.1792761643.git.ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With no change in behavior, prepare to adjust how stashes are completed
by centralizing candidate generation.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d60e85479c..697fef5462 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3593,20 +3593,23 @@ _git_stash ()
 		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
 			__git_complete_refs
 		else
-			__gitcomp_nl "$(__git stash list \
-					| sed -n -e 's/:.*//p')"
+			__git_complete_stashes
 		fi
 		;;
 	import,*)
 		__git_complete_refs
 		;;
 	show,*|apply,*|drop,*|pop,*|export,*)
-		__gitcomp_nl "$(__git stash list \
-				| sed -n -e 's/:.*//p')"
+		__git_complete_stashes
 		;;
 	esac
 }
 
+__git_complete_stashes ()
+{
+	__gitcomp_nl "$(__git stash list | sed -n -e 's/:.*//p')"
+}
+
 _git_submodule ()
 {
 	__git_has_doubledash && return
-- 
2.56.0.237.g5414b88716.dirty

