Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60A61FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 17:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbcLERed (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 12:34:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:64536 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbcLERed (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 12:34:33 -0500
Received: from [192.168.178.50] ([188.98.240.120]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOw4N-1cHXf72QBL-006NpP for
 <git@vger.kernel.org>; Mon, 05 Dec 2016 18:34:30 +0100
To:     git@vger.kernel.org
From:   Juergen Kosel <juergen.kosel@gmx.de>
X-Enigmail-Draft-Status: N1110
Subject: Feature request: Set git svn options in .git/config file
Message-ID: <1936940c-c4c8-540c-eb99-b434e8d32d6c@gmx.de>
Date:   Mon, 5 Dec 2016 18:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:RUBG1aXAugqms1/AWIHnacaQXvVVc5OJ8ql9osTmhybPr5BIPZT
 Vu1hsoTTbalZ9XkZQ8CUJkwk34MYlOtpmKWtdL0E3QpdbhHk6tMwD/N9zgu6QTafEfV6ZQM
 AbtpndPb8jF1GMEmoLONRPWbe23xaUH6av8GS4WKYJaPeCNXd013392hiYkHsXvMOkrzRp1
 Ti+FNmK0nXf0IY7VXmLoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VFSoTToUf5U=:8AYOG3FMuDXZCYHakEp/ex
 4OSTBc9d0xlIgdcDuPQ9rroeLxbPoPETn67sZTyEJj+TQlRECJM8NouIiYWqtxWaIQPeh8eK2
 3P5yPklaEGO89Isdz9dX33vgRg5XtvArW7S6+YZZUn8WG7wXDym2FK2D6Edxoab+kFrZpdmNr
 06H6sOKwLgeuAuHshB45IUZdovJnx6x+66AGzWdYvoFdj2snHl8OQ5XVRIJkrYpmlR9SKd0DX
 qXDPawBlcyvTSjMjEHvQfMsl6TdcNcmAErwOLZVPiY83O2zePzW3Ao3wXzy2R1MC7BXOgJ0oq
 uCkpu6XnobLQ2qvZl9kIYphI7u5tKeJCCukDRWSMnTAR6F+wPi7Mkj9F7Z06dmDpOhw/q4yZ7
 1+S9xDGLHlCjsTN4zBsl358yRgSa0etTr/+QDfvs6zvbdztJbMK23Dn+n2gc67dBpzWIBy+WV
 KCZA89OgkOxxvSp2nk+lQ2Hb2LXVY/vC06w8GyeXEgy8bR+ZzVg2HY8g0zU+QdYIAFfzhUcTL
 tkq85HsHCbeyNDtFL5ZZi5N7JVjjkQ9uWWTfRNVusEnNe+wagnr9AypMTUKiGPaN0MCPefPw7
 tVM3RTyIpqPYRvQv/sNGu61zgrdBOqxHCB93kuKCewCFoitRa66R/vWMUW1RuVtYLsgHlJJSh
 iY+M++4hNYX0Bz1vTPRR44KusiTPlZkUiasWTjXmM7ZaLNbgdd8pFOn6eWCpGw0orpyjMl8Ej
 bV7pyj0PLSxK1jTZOTGVU1/XpPeOsg3c9Wq3TihRxH4MXb5YJWwH6xM96tTrCA8i1x89NfcZ8
 tfo9iSI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

while working with a git-svn repository, I like to use the command
line options --use-log-author and --add-author-from for all calls of
git svn fetch,
git svn rebase,
git svn dcommit, ...

Doing so consequently, the commit-ids of each git repository, which
has been cloned from the same svn-repository match.

Unfortunately, it is possible to forget these options on the command
line. (And 2nd, tortoise-git does not surport it, see
https://gitlab.com/tortoisegit/tortoisegit/issues/2824 ).

Therefore I believe, that it would be the best solution to store the
settings of --add-author-from, --use-log-author and maybe
--authors-prog in the .git/config file.


Greetings
	Juergen
