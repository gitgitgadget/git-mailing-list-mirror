Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2D991F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeJGUym (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 16:54:42 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33222 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeJGUym (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 16:54:42 -0400
Received: by mail-wm1-f53.google.com with SMTP id y140-v6so6912912wmd.0
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=pMzZtgaoIVDioNtxlcLQ6eovggSxaAxCUOgEBl4URno=;
        b=Vi+CoEBQQrYkkjXhmil0qIoDnZ4HVbWx7KsoIbejn55pt+1oKj8FSlRqOIbg9eCT/o
         0JGRP1mZyZO9PVDeCX5CN6XUNORVJTfxU/89dB3kRitvp5stizt6p/s6yDgOyt5E95KI
         UKwDzqq9kJS1k4+rVZuPC+ZeiUYVfdqwlpYWtLp7qKh+ND2wnGKc2Rjx9wHfC/ikVWdz
         tdCQOTg8tIaKxzAFK5Uiw4sQ1/0qffyyF7q0FHWEM9VnWINKIweL6RYQiY3LIuZFkmCg
         CpfJwSogqBrafx0hL73Vg9e352zH/JsoUxmG/kfQliS/roFEs0e41QPr6tLaSbZ44lq9
         o3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=pMzZtgaoIVDioNtxlcLQ6eovggSxaAxCUOgEBl4URno=;
        b=MAFozA/dOILdNEKBRC+iyP7vwP1EWIzFV8WtHyIzLNCD+VODNTVgYiAKD6Bq8r5XLO
         AH6oT9k6vZeRFp5/gAfUXSC7xucJzqMq+bY5Dvm0Sn7oqhbCMxm5ZjMGNC78I2ydXciV
         JV7wROv0XLxhCVVSVTojRNXDcOxeOMdGH489DeMLLpsvE3Q5nW+DQ9uSqtp0TEM7eNBs
         eSIhy0F/zJHWzxREze9cWpwFVX9TOAzz9x+Hvr5aeMKl+z3OXPlahOUU7AEe2toV3zED
         lJNpioQvQukZ5Uty8lLnTmY59oIJSBaZIXV9kD1rMOww3eDLbrdkqt3iKV6Kz0zXBZTI
         6H0w==
X-Gm-Message-State: ABuFfoiZDRzAvnWLCmqbGlaY9IVQBCNm9rcUeqffb7YvwTkPdRHwUEtO
        vFGg9Pn1zcyCVnM1cELamwAbEB+wDiE=
X-Google-Smtp-Source: ACcGV60wUTWLyz7EiimwqxJvCaeP3/5z02W685qbL8VK/eL6wZWHs6+488QzHu0JHqs9W5Qxkf0xpw==
X-Received: by 2002:a1c:9cc9:: with SMTP id f192-v6mr13354174wme.135.1538920044093;
        Sun, 07 Oct 2018 06:47:24 -0700 (PDT)
Received: from imac.localdomain ([85.193.139.174])
        by smtp.gmail.com with ESMTPSA id 62-v6sm16078597wra.48.2018.10.07.06.47.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 06:47:23 -0700 (PDT)
From:   Era <aigner.erik@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Diff Range Underflow
Message-Id: <ED62D6B5-9227-4FC9-AB77-7DB4D3835501@gmail.com>
Date:   Sun, 7 Oct 2018 15:47:22 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.100.39)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I discovered an apparent underflow when using the =E2=80=94unified=3D0 / =
-U0 flag with git-show on a merge commit.
Leaving the flag on its default value or 1 shows the ranges correctly.

	$git --no-pager show -z --no-color --pretty=3D%x00%s%x00%b%x00 =
-U1 3ac9cfed9ce01836dea1fee96c4eceb2df4b6878

produces a diff with the following ranges

	@@@ -582,2 -599,19 +582,1 @@@ extension =
TranslationContentViewControl

changing the flag to -U0 like so

	git --no-pager show -z --no-color --pretty=3D%x00%s%x00%b%x00 =
-U0 3ac9cfed9ce01836dea1fee96c4eceb2df4b6878

results in the following ranges begin output

	@@@ -583,0 -600,17 +583,18446744073709551615 @@@ extension =
TranslationContentViewControl


Obviously this is some sort of underflow bug.
Unfortunately I cant share the original repo or diff.


Best regards,
Erik






