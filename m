Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38BC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 07:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiLLHuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 02:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiLLHuM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 02:50:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B8EB86B
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 23:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670831404; bh=RKJYqowt742P6zUXI2tq19ivQR+zpp7ymAxXCuzfOuw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h3Rw0NiRPMwpbNvWLTUlPtv3opzR0mGo4jHA6jKJDnpiu3Kd6d2jPcaediAjptKfX
         FoGFeBJsQfS4y98JJtfMqnR4797bO4CfvcrP3bF5Uh8a4XkqNQLoau8RSdaqBDrqx/
         5yxM7Sl6jnDlZB3v9FdKi9utq8iGzW1kIqzA45Ywb5XyLTaDj7eADLU9Rs7jqzZw62
         nRHsFgr+9Ndx7oDlVN2bDB1sNGh9nIWAg7Jk9ri66Zq7iivzNeBpfzLXoBBhznJE68
         9Dm0Ct00kou46Vsye0KNV3J4EGtXNyo4cVIiQjpl4ziJQ+uSOaEg7cyti9OJK4RgiL
         1OMrh/ya4ZLYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.107.233] ([89.1.215.49]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma24y-1pPTq41qi4-00VuOW; Mon, 12
 Dec 2022 08:50:04 +0100
Date:   Mon, 12 Dec 2022 08:50:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec 2022,
 #03; Sun, 11)
In-Reply-To: <xmqqpmcqv7qh.fsf@gitster.g>
Message-ID: <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr>
References: <xmqqpmcqv7qh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MlLTBvbf8tRabH0v4JMDuHHZAlScSlfSabgLqOuRYVBxezNBi0R
 y1LY8xRrqDfqSumCyHJAEACsqLEDFwVEErvzIkl/oC+qQ2J9Uf/vllQDS6U66R6AMVFnseI
 jq9Rdb5dwbYAeWWE14vg9CwQ4j7esaZTl62JDQeLESmlFKIqmPtjRgkJEh/J6hHDjg0R5qx
 lY1dwa61AbTb6NK9epjPg==
UI-OutboundReport: notjunk:1;M01:P0:DucLYkKzdys=;W2udbcpoFcoxcoSfsRXpyytQuv4
 JiUE0jeEOz1Duiw+G6jDMlqK/quLhfz7vffYoSCRr6+pV+wxDGWT9n+8AbbPCdkXQURrQPnGC
 tpU1Cslhsoub+ojbglgROLr7m0ELtPtP900qWS+gW+3nrNx/qUaouJRBwc7k2kxO6ulkI3N7P
 pDQ//apl2yoi8QZAE0VT3W8ymQedZXA+43Bf55tD+rGbuPiJtFwt/5MOAcxz5YFt7IG7cyc+t
 xWEYNYDeGwLFm+zFzUUsZAacDR/sOfYFmkXKYDOLSbRFMWYzy3vsITKNKzonLHau4sdem6HoN
 gVHhfQWM341RayESHYzlzAxo/Ij+1bIfVTzeWQFXxWlRGmtnSUkLwGiRHNmZQ9U9JTTllk6YD
 4EsH+hfhA2nIx59hSAChIaBRn8zerJUXH02wDfeLWvhWbekvnFeT72BQF0sd4uiAvtEcaUvhY
 gGfGyR8YNwcAhD7ie07vYU1mnGuw1kuT/idoS71zKW/7K5ezfG1hrPpsxmP+iP+MrBkYLZm7G
 afykmUmuCjL7btzGpL+gD/ZScSZjaro+hprrvzzQPH0VHSeyTdubn5GnA8218NHT9/OR6uBcj
 kbd6A2OYFqukgADbTZ+nZgxWOZ6BmWrxER8B4M1/Cs9bxwEtq5aIQZHmdz42XLAu+kjbuBw8d
 8y8CbArZc0dRw5a27/ZlAee0zJdBw/hy6VkIyj/1tpKtbiEZz5vqllOO/EGGRntEeo7/VLxEF
 lUKsE5PyeCmXtp9YyjeOUkf8pKAY1G5BpU6C4yaDsvW6ivYT3Fes/hOfy900P4yeS4RF7HqkU
 vyZ13QY8Uy4B+pexdyC9wtCLMTrGl6xFmx1GSH8QxtuR1+uXwcnYSEFJtfVtJVrZLCRESHurL
 lMQmKQ0cu56UxFAiS6qGY7zDs7KSmmWOeB/DAMMJkGRqhTFq810NzjOkh/wxhdzWUOMHSywXX
 87jZNQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 11 Dec 2022, Junio C Hamano wrote:

> * js/drop-mingw-test-cmp (2022-11-14) 2 commits
>  - tests(mingw): avoid very slow `mingw_test_cmp`
>  - t0021: use Windows-friendly `pwd`
>
>  Use `git diff --no-index` as a test_cmp on Windows.
>
>  Waiting for review response.
>  source: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>

There is a new iteration available here:
https://lore.kernel.org/git/pull.1309.v5.git.1670339267.gitgitgadget@gmail=
.com/

Ciao,
Johannes
