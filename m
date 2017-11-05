Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9019920450
	for <e@80x24.org>; Sun,  5 Nov 2017 11:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdKEL6f (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 06:58:35 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:55286 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdKEL6e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 06:58:34 -0500
Received: by mail-wr0-f193.google.com with SMTP id o44so6083183wrf.11
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 03:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fkqZq0Qf6i45WwZ+a8cj6BZXLWcdsCQv0QsT/PVFQU=;
        b=dLGnT9Hf94EoICwaeTGa4h4Badm2u0kAgvvPY3FqNtmpn0o280Xca/NMEhBTigxYi5
         Aw3TVh16GhYbzWwA+uh+pNxiPh3nb73OyF23sekUCJenS3Gn0xQXIFh4mURNJVSUMbgR
         2w+vXqbri8EAynUzQP+UFP2Tq4gXiBUc3fgZ7CCvf3KySbw8Qbu1IHWhk/dcs8zWbTgg
         UuIGM2VIOOe3BzlpKzX8eM+H5wUNafRwuTDw5sdglCZ5fW9ikwtDYFTyEOAMfkTQ23Ck
         kde8u7Doyc3ImJAa/b6UOkSOq63971F/KGHR3h6quB2l1VK7lk1Tz8NoKtItBmD8cBoA
         hvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fkqZq0Qf6i45WwZ+a8cj6BZXLWcdsCQv0QsT/PVFQU=;
        b=K/gRYrf2iN4jjWT7rU3HgVU9GfEbHXFFa390Y6fhg6tlAN56ZH6rvGvSMxygg1teON
         YLMnNOh+yn0cvwVzGWoO2+lgjIMB3wPt/QzjzGPRW2NMzzCO3EmMvzVZGm4gEPHmWMp8
         sFScBuA2cNiP1wwb0s0Md9LfUz0qxUdP4hq8cGJj7Bj40uquVmRvtigeC6HXftaLmlu/
         /CArlo9x3B8Jic9N3ngymwJaY6ODGcQ2+XjpAOw/Ete9xau/4xKzRi10lqXZ5UkgamkZ
         zLvo4UFG6tCDiyKNvSU7xcoGZdqddRWK8P1Xi7pNgePqxIFsR+KKJKQziMqx9Mi5j9jU
         RXEg==
X-Gm-Message-State: AMCzsaUeitCKaaFux7liSHTjt1fIINA6WBAhR+lus/4vQbLQ1cBEkddF
        zymtt6P/qN3vGrVYEWC2AFw=
X-Google-Smtp-Source: ABhQp+Sxe5/CDjMRkn2hGIJnl4o2dU20oNdtfmSd7eJUqdIgF/KLM8NrZBWOX5ivyFmKXQkYy2WVYw==
X-Received: by 10.223.129.228 with SMTP id 91mr10660447wra.233.1509883113015;
        Sun, 05 Nov 2017 03:58:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u18sm14391450wrg.94.2017.11.05.03.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 03:58:31 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, hkleynhans@bloomberg.net,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/DONOTAPPLY 0/4] first steps towards pager.foo.{command,enable}
Date:   Sun,  5 Nov 2017 12:58:18 +0100
Message-Id: <cover.1509879269.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net>
References: <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not posting this for inclusion (yet), but because I read this:

On 4 November 2017 at 10:28, Jeff King <peff@peff.net> wrote:
>  - the pager.<cmd> config is mis-designed, because our config keys
>    cannot represent all possible command names (e.g., case folding and
>    illegal characters). This should be pager.<cmd>.enable or similar.
>    Some discussion in (this message and the surrounding thread):
>
>      https://public-inbox.org/git/20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net/
>
>    But I think you could find more by searching the archive.

I'm posting four patches I have on this to save others from redoing my
work and findings. These patches feel a bit incomplete, which is why I
put them to the side some time ago (and eventually forgot about them).

In particular, they do not teach `--paginate` to use the pager
configured by `pager.foo.command`. It is already now possible to use
`pager.foo` to say "I don't want you to page, but if I later give you
`pager.foo=true`, this is the pager I want you to use". That does not
work with `--paginate`, but this can all be explained -- indeed, we
document that `--paginate` overrules `pager.foo`.

If we teach `--paginate` to respect `pager.foo.command`, it seems that
we would either 1) introduce a small (and possibly hard to understand
and explain) difference between the old-style and the new-style
pager-configuration or 2) knowingly change the behavior of `--paginate`
with `pager.foo` or 3) knowingly change the behavior of
`pager.foo=false` as documented in the first patch.

I think there's great value to being able to say "this is the same as
this, and that is the same as that", but that might get muddied by "oh,
except if you use `--paginate`".

If someone wants to pick these up and bring them to completion, great!
If not and if I or someone else feels confident about which way to go,
then I can revisit these.

Martin

Martin Ågren (4):
  t7006: document that `pager.foo` can be partially preserved
  pager: refactor `pager_command_config()`
  pager: introduce `pager.*.command` and `.enable`
  pager: make `pager.foo.command` imply `.enable=true`

 Documentation/config.txt  | 19 +++++++++
 Documentation/git-tag.txt |  3 +-
 Documentation/git.txt     |  2 +-
 t/t7006-pager.sh          | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 pager.c                   | 16 +++++++-
 5 files changed, 134 insertions(+), 4 deletions(-)

-- 
2.15.0.415.gac1375d7e

