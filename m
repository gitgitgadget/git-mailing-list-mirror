Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6CAE95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 17:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjJHRez (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 13:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjJHRey (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 13:34:54 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BDFB6
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696786486; x=1697391286; i=l.s.r@web.de;
 bh=bzSIYOJq/9cMedFvOtaBdVPh3HvD2MAiNUM3wlo+WZk=;
 h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
 b=nuWHYbGLi8j+KbXdUxFswbhxnwA7JK7apOx1BLfT2QgHbOAoTKIsyYfKMXKBN5GHddkFRK6wlEF
 +7fcQIOO23M1pLBc0kF5/PMbHm3Q9OUmTwJ70bCkYejktnuWAx8O7HY81bhOkYrn2+N9/FFnKhgvC
 Y/MKYoQQs17k7GmX7q/un7E0PtwbepxaH6KzPsaSzbce4m4O2UB/JjuyOY2uWUamG/OP0xdVlF3nO
 4uWUyGD40dYOhmOi16F3wK4JmhGLWXFglkwoxOYWf8uPskhrmp6UAgmoUXX2Ev5qfNTjFgaifdBzX
 hepyilOF21Ro4/sOZBbieHmou1domr2/aoJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXN7-1r5gAk3gSd-00YiXL; Sun, 08
 Oct 2023 19:34:45 +0200
Message-ID: <4014e490-c6c1-453d-b0ed-645220e3e614@web.de>
Date:   Sun, 8 Oct 2023 19:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Oct 2023, #03; Fri, 6)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh6n24zf1.fsf@gitster.g>
X-Mozilla-News-Host: news://lore.kernel.org
Content-Language: en-US
In-Reply-To: <xmqqh6n24zf1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hd0uUCJGlMDOe05sqTJFjgm+2qRTLNJtJUnvqirwgcLdvgX6tjW
 hUwgAkTqjAJcOp7I176J0vfB+RkltpMrb61Y20WQV92JQycR0ELzKBBwyAdKwBJPwpsHu/c
 +STaJsxJn9cFTxyOHjFBZnFrrtM/D8D9D+XPp7+fiz+vFZEuZNB3NzqaptJ16qyU1o6Li8P
 cdmv2F4dTqYCs7guLlOVg==
UI-OutboundReport: notjunk:1;M01:P0:TDdUo/gZ/YQ=;P2P9pNYZYafua49RsjQATq8/Bgs
 bsmQsnkZvld5ld/DXSEfkqwAnRtwP9BmTvr873EhNdhG/vHaLFQWGcr8sjqg2JDM/djiuX2wG
 HoqGFEtNMLYx+D8cFN5bEydA8b0yHTSh9PSgMDfvIQZeUjBuXsZUiphyHcshOdbDgnA+z0BdU
 sBLrBqaro1dMY8NmDjc/jAVYlutTt6I7IQTYYI2M521Nb6/h8lvtKDPDKGxwzJzKLrWHvMXmm
 UJtlTHXpIQAWWxIuAzX7hbahrNMzUDK1l1kXYTNamQWoA0r9KjQozdGhLaLy/ttMNCt08N1LL
 o+Iucu5Xud2hZiUvZPEiaIRXdhc7pDO+PhzQhhAqQSgTR/kRgKLc+0m3PyRJ0fH3vVXsaxrYY
 ck9y7lElQ2LlTPftVF7qp7wRISGfD6zo/SS6K2J0JrrF4F6PiBozYUKIT5GBad7VxRGs3BnXi
 Q7YNEHN33zhkFOjoJeNK+ZjFGuFZi5bjlLG9QJNyAwMx92c4XK8s2VXDiMI+DkXe0+iGAsrCu
 rwvrEP1Qh8Lb6rHy0zFPafXFq1y2gEFyf/4QiOIVlk5C+IEulykEKN4aIlc4gZWYK8Sxt7Qbn
 rtKGBhyApIuf0jR+Yx7S70pHBfVtTr2ky+FBTufEmODlop1MD9xo72+ymWtMoT43hlfsGm3rM
 QJkkevMUNn3MMZ2SFdl6bpauIDbZ80USB+QkRY5Sp+gvKOwuTn7ejmWxRyG9Bi6zQBFwUR9W8
 k4n0RWsibcRBxYv442oDvors5LMP+ttbetbRtMWMEBkf3xGhjr6DhL4h09LAn4d/XSjiHPzL8
 0NmM9wvOGMQEx0WnM6vLZRt++ZniYvIh6Dk57Tamv3pLx6lq/NZBEaa2NSuZzQ2uqOkVYAgJ8
 lCO43s6/BGqODnUb6ZV5aXWiZwGSkd0Q4SIVzKzOA75utxp7HtZPeRK3VASpN3qtFBkur/wUV
 v1M1cg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.23 um 10:20 schrieb Junio C Hamano:
> * rs/parse-options-value-int (2023-09-18) 2 commits
>  - parse-options: use and require int pointer for OPT_CMDMODE
>  - parse-options: add int value pointer to struct option
>
>  A bit of type safety for the "value" pointer used in the
>  parse-options API.
>
>  What's the status of this thing?
>  source: <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>

tl;dr: Feel free to drop this topic if it's in the way.

I think the added _int variables are defensible, but the mode_int member
added to struct resume_mode in builtin/am.c is too ugly.  Extending
OPT_CMDMODE to support arguments would allow getting rid of the struct
altogether and is probably a good idea anyway.  It's surprisingly hard
to get right, though -- just discovered that the interference detection
is only working half of the time in the current code, and we can't have
that, can we?

   # a OPT_CMDMODE option
   $ t/helper/test-tool parse-options --mode1 | grep integer
   integer: 1

   # something else setting the same variable
   $ % t/helper/test-tool parse-options --set23 | grep integer
   integer: 23

   # combined use is flagged if the OPT_CMDMODE option comes last
   $ t/helper/test-tool parse-options --set23 --mode1
   error: option `mode1' : incompatible with something else

   # ... but not the other way around
   $ t/helper/test-tool parse-options --mode1 --set23 | grep integer
   integer: 23

Anyway, I'll get there eventually and present a nicely shaven yak -- or
give up and focus on the original topic.

https://lore.kernel.org/git/6cb09270-04b9-456e-8d7e-97137e56e9e2@web.de/
detects and handles the same type mismatch by adding a level of
abstraction (getters and setters).  That way is more general and adds
more overhead compared to the _int variant.  A fair comparison requires
argument support in OPT_CMDMODE, though, I think.

I don't mind removing this topic from seen for now; it's not ready, yet.

Ren=C3=A9
