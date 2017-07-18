Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF512029F
	for <e@80x24.org>; Tue, 18 Jul 2017 16:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbdGRQ7W (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 12:59:22 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36079 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdGRQ7V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 12:59:21 -0400
Received: by mail-pg0-f47.google.com with SMTP id u5so15794081pgq.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Fwx5EJlY0NdzMIl+9KAOzhaaU5rZkfR/de1FRWt7OwQ=;
        b=Gzv7qTUSqoLHq6vuAUx/62sFR8VJyKuV0BFWpdC1CJe2l2E97gV++oseL8P5OX6e2T
         UI0ias4Z1K2oPKGVof1RR/ApPCmp6YC5A9s5T5KcV8bth7b7JYEUQmfBWrmUHku5sK0O
         8kb53XHij5A0DAIC8gUnLINTExHP+QUJrA5+RGHSCxxDE0uxGktzN3rMWt8HDHJDhAIa
         9a2CM4yKxG9RK9mcaKsnRsA+m+Ksk7LkoyHO9xL7kaRtvC7JBhJFpA2AChT9Nr82PRda
         uUEdjn8NgnKcfeYwJeMz2CB5j8cnMC/IhQEab+JUa05L3RKy9muXHnr7Cg5Bn6kuVACM
         ZxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Fwx5EJlY0NdzMIl+9KAOzhaaU5rZkfR/de1FRWt7OwQ=;
        b=oD6G+QK5yqVY2zUDwnUPua+rMvsVtmAXQzWE9k7dmnb6UanJI4ny421plsJ3a4kWxB
         ec6nZE4LCmJIkLPA+bIXEJRFA6ekqT7yuXVqsJuFDzT6GvBJNbUGkiwk7o36AiMRtxK0
         Nh9ZpezD7hlngwPSRkIO99quxI4iuR4GRABdJDDMmK6U8TDAk1ScbGX26Yy8mSpM/0yP
         P94z5ShlWrJHfEasW3TgmX1H9vPJUi0+OWj7fjBzObROkpYKCdCizy3rxmNcvejAl3Zs
         3izlxhKCFTbxJpkr20btgxM0kpkHCrpLxmfo80DOBjdarG7MzHl/E92joEcClDKxKbcQ
         ZptQ==
X-Gm-Message-State: AIVw1128hrot7WFK8oiTmSFQauHtr3/Pm5oA8tJ8A2svNGnbpPrqHdZl
        0wEMsI5YokF1iUE9uF6r+r371+TbM6j9ieFmxw==
X-Received: by 10.84.194.228 with SMTP id h91mr2868617pld.46.1500397161041;
 Tue, 18 Jul 2017 09:59:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 18 Jul 2017 09:59:20 -0700 (PDT)
In-Reply-To: <596ddaa620821_77f83e7330107c4@ss1435.mail>
References: <596ddaa620821_77f83e7330107c4@ss1435.mail>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Jul 2017 09:59:20 -0700
Message-ID: <CAGZ79kaPFDMn2K0f529-Crzv+vhU3XUMsSM6w3QV4RXKBv5s_g@mail.gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for git
To:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I looked at this report for a while. My current understanding:
* its detection was triggered by including rs/move-array,
  f331ab9d4c (use MOVE_ARRAY, 2017-07-15)
* But it is harmless, because the scan logic does not understand
  how ALLOC_GROW works. It assumes that
  done_pbase_paths_alloc can be larger
  than done_pbase_paths_num + 1, while done_pbase_paths
  is NULL, such that the memory allocation is not triggered.
  If that were the case, then we have 2 subsequent dereferences
  of a NULL pointer right after that. But by inspecting the use
  of _alloc and _num the initial assumption does not seem possible.

Stefan

---------- Forwarded message ----------
From:  <scan-admin@coverity.com>
Date: Tue, Jul 18, 2017 at 2:53 AM
Subject: New Defects reported by Coverity Scan for git
To: sbeller@google.com



Hi,

Please find the latest report on new defect(s) introduced to git found
with Coverity Scan.

2 new defect(s) introduced to git found with Coverity Scan.
1 defect(s), reported by Coverity Scan earlier, were marked fixed in
the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 1415508:  Null pointer dereferences  (FORWARD_NULL)
/builtin/pack-objects.c: 1292 in check_pbase_path()


___________________________________________________________________________=
_____________________________
*** CID 1415508:  Null pointer dereferences  (FORWARD_NULL)
/builtin/pack-objects.c: 1292 in check_pbase_path()
1286            }
1287            return -lo-1;
1288     }
1289
1290     static int check_pbase_path(unsigned hash)
1291     {
>>>     CID 1415508:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "done_pbase_paths" to null implies that "done_pbase_paths=
" might be null.
1292            int pos =3D (!done_pbase_paths) ? -1 : done_pbase_path_pos(=
hash);
1293            if (0 <=3D pos)
1294                    return 1;
1295            pos =3D -pos - 1;
1296            ALLOC_GROW(done_pbase_paths,
1297                       done_pbase_paths_num + 1,

** CID 1415507:  Null pointer dereferences  (FORWARD_NULL)
/builtin/pack-objects.c: 1303 in check_pbase_path()


___________________________________________________________________________=
_____________________________
*** CID 1415507:  Null pointer dereferences  (FORWARD_NULL)
/builtin/pack-objects.c: 1303 in check_pbase_path()
1297                       done_pbase_paths_num + 1,
1298                       done_pbase_paths_alloc);
1299            done_pbase_paths_num++;
1300            if (pos < done_pbase_paths_num)
1301                    MOVE_ARRAY(done_pbase_paths + pos + 1,
done_pbase_paths + pos,
1302                               done_pbase_paths_num - pos - 1);
>>>     CID 1415507:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "done_pbase_paths".
1303            done_pbase_paths[pos] =3D hash;
1304            return 0;
1305     }
1306
1307     static void add_preferred_base_object(const char *name)
1308     {


___________________________________________________________________________=
_____________________________
To view the defects in Coverity Scan visit,
https://u2389337.ct.sendgrid.net/wf/click?upn=3D08onrYu34A-2BWcWUl-2F-2BfV0=
V05UPxvVjWch-2Bd2MGckcRb8HAP5hlBzHe8sORKm64S-2F81GsNbRdSrOteP-2FXoviMkw-3D-=
3D_PwiGIFugGOKqSZ6DZhASdI2SvWKInry4kHBXrJUc9pnRRRwN8fPiR-2BR4LTK2qB-2F8Dwbe=
ZJjY7Zg2FBdb8jgiAk7m6rh1YdNCvPYCPUewgRcPRcmkOFDltPB2GLYjg5Pl86kCKSRkx6inI-2=
BuknVr53Cjba4HgtlWmCuW5A0WMiIFvSKDW3-2BKYfPjiZDMCOFSGSLivQrUyaTeOHAHjl-2FNv=
bw-3D-3D

To manage Coverity Scan email notifications for "sbeller@google.com",
click https://u2389337.ct.sendgrid.net/wf/click?upn=3D08onrYu34A-2BWcWUl-2F=
-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4rtNFBzV5kav4CghkcEfRxS=
YnY6rsKHvgCYp1ThXvyV0VWbGuKIDENjx2sj6ivdYZu-2BNbJM6lgB1oY5D28iuW580xRVIt7xU=
Sma4mf0o8-2BwE-3D_PwiGIFugGOKqSZ6DZhASdI2SvWKInry4kHBXrJUc9pnRRRwN8fPiR-2BR=
4LTK2qB-2F8ec7P8LTccgviKTLC0eUY7vUYOHaxCJX7GTQpS8ooD-2BtrxVu-2BilxPyHEoqsJL=
DaUcr6ObouH5nHR8K0ccYTKk6yC1yT-2BgMwWml4OIILno46DqjVrTy1kpeg4B-2BRv4QBTs54v=
6KZ4s-2FPtTLU3-2BsF7qgg-3D-3D
