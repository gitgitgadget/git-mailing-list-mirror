Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481651F516
	for <e@80x24.org>; Mon,  2 Jul 2018 20:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeGBUI7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 16:08:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46322 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeGBUI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 16:08:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so18710170oie.13
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 13:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=INp9QjMEYOHZSIfdVSxzMTas1+kDxWY+stRtXmBo3/U=;
        b=ze/5ZydG8QkiDyzFiZNAXKF9vcQpboby8061YTCptrz1T1fsnpHqGkwP1ZNzHOct97
         ggINRr45rmmhGfeXKsJBXkLBvs4eUHX/sB6S3Zh6vzootRU54B5m2kywyRXsXbQXjWeK
         W55BIY7GqQ1eYUUdJ6lgE9/FrDYfFPaJ+6rsNiwR/3i/JFV4MgPXxd4fg0BSYZrHjbbd
         si959NSYtYQh3WOC9rvB1R1i9hAuvxTWmLThcwlKjuoeWp7ZgTb1jzI9KFo5uIlhmyjL
         DTNx9CaBWMQ4yS/3Tpdpj5GMvelc8zwkRRRRV+vFDN38nStLeu1QLbjTL8AMxvlqUYyz
         R84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=INp9QjMEYOHZSIfdVSxzMTas1+kDxWY+stRtXmBo3/U=;
        b=m96/mzC1DBWk8FyBvX6Ij02CzcmE5i1EGeNkiuAnJ1jJE9vKrdHoliPe9NbC9+RBKy
         Lo1D6UxN8fAZ9GwIH9dauJhmSdCezAxjuSInxefCvX9EUxZcPFpDhxHAUxPAS9nk5KsY
         nhvRflgSWzn2MVU51AErq5tzl+AmxRDm19Giuy5yrmX+F3XZstkMUE+yi+f3TWmM6vlM
         yoCyYc9Lji03f/j74mLstPtrw/N/h+XEM+pwe5CmQ2Q+QuI9NB51u9zghTvYEIkQ+dgf
         kQiqjOMHUbTvUzaLQcRmtC6S4ChCjF4kBIRM32ScN0LcQoJ4L/uYbBwvAOlZvA0Rp6D2
         5aNw==
X-Gm-Message-State: APt69E2dunJ/bKc8MCxiPWt+TWEoUJb4NzauLWWP4pyl/WZ/uaPEtyPJ
        ArM+ifNGuiX6xq6hzTuN+HEtM3BIa/o=
X-Google-Smtp-Source: AAOMgpdg/A+kQWGIXcAvFqUOaE/8yh5lNMPb0mQs+9MS3XSzA3uq1LL1wkrT9kksnFsAujMJqOhhiQ==
X-Received: by 2002:aca:3907:: with SMTP id g7-v6mr18728716oia.145.1530562137347;
        Mon, 02 Jul 2018 13:08:57 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id o16-v6sm3757175otc.3.2018.07.02.13.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 13:08:56 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:08:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 0/2] teach --only-matching to 'git-grep(1)'
Message-ID: <cover.1530562110.git.me@ttaylorr.com>
References: <cover.1529961706.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529961706.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the second re-roll of my series to teach 'git grep
--only-matching'. Since last time, not much has changed. The change I
did include is summarized below, and an inter-diff is attached as
always.

  - Initialize both match_color and line_color to NULL, thereby
    silencing a compiler warning where match_color was given to
    opt->output_color uninitialized [1].

Thanks in advance for your review :-).


Thanks,
Taylor

[1]: https://public-inbox.org/git/xmqqsh58gp3p.fsf@gitster-ct.c.googlers.com/

Taylor Blau (2):
  grep.c: extract show_line_header()
  grep.c: teach 'git grep --only-matching'

 builtin/grep.c  |  6 ++++
 grep.c          | 91 +++++++++++++++++++++++++++++++------------------
 grep.h          |  1 +
 t/t7810-grep.sh | 15 ++++++++
 4 files changed, 80 insertions(+), 33 deletions(-)

Inter-diff (since v1):

diff --git a/grep.c b/grep.c
index 48cca6723e..49a744f96b 100644
--- a/grep.c
+++ b/grep.c
@@ -1448,7 +1448,8 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
                      const char *name, unsigned lno, ssize_t cno, char sign)
 {
        int rest = eol - bol;
-       const char *match_color, *line_color = NULL;
+       const char *match_color = NULL;
+       const char *line_color = NULL;

        if (opt->file_break && opt->last_shown == 0) {
                if (opt->show_hunk_mark)

--
2.18.0
