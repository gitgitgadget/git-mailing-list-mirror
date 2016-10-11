Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C4F207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 10:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbcJKKWf (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 06:22:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:51219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752636AbcJKKWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 06:22:34 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lu3J4-1atee63sLG-011RJZ; Tue, 11 Oct 2016 12:22:17
 +0200
Date:   Tue, 11 Oct 2016 12:22:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <alpine.DEB.2.20.1610111212090.35196@virtualbox>
Message-ID: <alpine.DEB.2.20.1610111221530.35196@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de> <xmqqlgxvdf90.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610111212090.35196@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PsamTy3czFQWuDNjyvGfo9XTR7ZXH+6ycmMl7Xs9o8/pKqwD2ZB
 txZ4Ja6v+Hrp3ojZE8URciAVqUGJ6Y8mE4i1sMlGjMRd3uWJ7wiGCOU4Gb+RkoEyS7FF6+6
 Ki+TESixsOrUOh3U3okfDZkXMW0i1yewO+xaOERyq45zHBOpS22o+cCZyYUaiVej6b0zj29
 O/hijSPBoHGcXBiotDSnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2ovRkcBA2aA=:R8HXlJvjyU7qdDr3MpetD1
 jEoHG2X4RlFLYXi615UL7UtCBdWxpF/VcmufCwhOsSdFxRj2Yf4tEKp1YlCZbQhD5r+cMhPuR
 lM4hzhOC2CSleDZoma7G/60cmwf01ITa/Dhk2nXbKhokdmhMqu4TqRo+sab3mR/XsMA1wSgf6
 S+pSD46Rkv0/v5CQDSTkGvIiyMs16Xcw0wsgWIhEIFmQ5UQJo+7pCO58xK2DEfw0pUpQ+VkeF
 qE9YNAsTUt8ca6nNIg7glsjALTfNZU/RL33GqC5oDbgEVEt08+WgUTs0W6Z5AD9EpZ0YbOM3Q
 XTWKkuNXLBMplYFd2pwQ173IkXXNfF/vtVXRj0w9iCZxl8ecezNMR9YBlHhPHzQRcCBV7uuG9
 btUYEj3Kh/vJBAbVN1GRa8GGioN1mvXGSFE2WByVOqNOqs5bUSz1LEgFWMYW3qbe0epsiBRlt
 uikK23uY2fRrHq1is6fG/tXJcemHwI4sf74YncINafj5MKnByEahEEynS2uZ6sca8uOgMptnj
 QZCXFRZiXmoIUBaynmtfMqq4LUDDHeefOsuW8l6q1Vx7etu7NJjvQv0CWfvgV6HWoADks7bWS
 iLNlDqghXNYXMQ7vCdtmvRUoC46DHU2f6rUdw5lCucOG8PBAy4tRNtaiYefkp1YQPOYfaMMtN
 JPgPjO9pJ2MjrgCUVQ/LpEFMm8rFdWw3+NsGVNhiuH8BGcMw6xxCNbLyur80yo2QUlduLwB8D
 qVz9KDQfIp/uIzmbOGv+XjS8Gf50k+T1Sd5TVxVzTWE+Kt8x+kuoWpGsvuvrfnsTt+VrxMzOu
 C0KrKgm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Oct 2016, Johannes Schindelin wrote:

> -- snipsnap --
> @@ -906,11 +904,13 @@ static int walk_revs_populate_todo(struct todo_list
> *todo_list,
>                 item->command = command;
>                 item->commit = commit;
>                 item->offset_in_buf = todo_list->buf.len;
> +               strbuf_addstr(&todo_list->buf, command);

This would be command_string instead of command, of course.

> +               strbuf_addch(&todo_list->buf, ' ');
> +               strbuf_add_unique_abbrev(&todo_list->buf,
> +                                        commit->object.oid.hash,
> +                                        DEFAULT_ABBREV);
>                 subject_len = find_commit_subject(commit_buffer, &subject);
> -               strbuf_addf(&todo_list->buf, "%s %s %.*s\n",
>                 command_string,
> -                       find_unique_abbrev(commit->object.oid.hash,
> -                               DEFAULT_ABBREV),
> -                       subject_len, subject);
> +               strbuf_add(&todo_list->buf, subject, subject_len);
>                 unuse_commit_buffer(commit, commit_buffer);
>         }
>         return 0;

Ciao,
Dscho
