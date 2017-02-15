Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E8082013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdBOVrc (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:47:32 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33566 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBOVra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:47:30 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so9540615pfg.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 13:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8y47M7rJ+BSkLDAXrWIiPRyFPFG2DnKFxNfY1z3Jy8c=;
        b=MXw+5RR6SUqRLhDqKhXtuz49L/GYHpr4O37dQI8aqyox8n/PzIu+rzasJlKe0dQ11T
         Yt8JSb6mM3EqANC8OGz4O+UHagDV2t8/jgZFvoAPfGJlKao2TtgYiCl+tbwk+6d8m3iw
         v+rYSpwyYotk9zM1ak2q5RV6950Ffr+4SWJ+R5K3vRku1OVLWWoVlW0nwa2Q7gdYWxFH
         x1/AVIApuLTWeWotxfTtU0QrGB9oGEQCsNAeq2OInDMuymWhYIvbKnybBMDKp5QXRtZ9
         ivlD9gNnREwSkOybzvHqVdvnA1gvyh/0GU82f9tpaNnGIm7fcc3Wmq++Kb1c3tbtKOhC
         zMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8y47M7rJ+BSkLDAXrWIiPRyFPFG2DnKFxNfY1z3Jy8c=;
        b=g9oyZ6LxAHTDvvwzHEgcTYBLq0DmfiPl7kDBBAzkxqSR1XSpD6h3HeEfQ7wZbZQtRD
         2kbqgAsSxmVyzszhH7ll3FOQ8n4Yn3QeyPkBu9o7pZxvUt7QE11cpWr6TG4UXSMOCkxx
         n8OxIW7T22acjR+jSHNy00ix9WJZmKQgjor/hQ17eP3vEbZXfOsl5gtToijOBZXLA2cx
         tX/oBN6gV2z7wCzD2O5RwzhvDT+7FeqkICMJ6anaQ3vlYvntI4vSuAzYg7NMu3fFwuRN
         0HN+iFtYYVyHU5YyOzNRNgRsTWo/Ps2xDp6rhLB4sVkK3RVBYwRIem07aARpdKke27Wv
         loOw==
X-Gm-Message-State: AMke39kYOHJpFBfZWgdHNLgFyv+pBosd6VXedcJ3X/TtBAst+PBML1tZR4HAi4mVkZwxsA==
X-Received: by 10.84.132.33 with SMTP id 30mr3919156ple.44.1487195245034;
        Wed, 15 Feb 2017 13:47:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id g28sm9382804pgn.3.2017.02.15.13.47.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 13:47:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?J=C3=A1chym_Barv=C3=ADnek?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: Confusing git messages when disk is full.
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
        <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
Date:   Wed, 15 Feb 2017 13:47:23 -0800
In-Reply-To: <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Feb 2017 16:32:22 -0500")
Message-ID: <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Feb 12, 2017 at 05:37:30PM +0100, Jáchym Barvínek wrote:
> If FETCH_HEAD failed to write because of a full disk (or any other
> reason), then the right thing is for "git fetch" to write an error to
> stderr, and git-pull should not continue the operation at all.
>
> If we're not doing that, then that is certainly a bug.

One suspect would be store_updated_refs().  We do catch failure from
fopen("a") of FETCH_HEAD (it is truncated earlier in the code when
the --append option is not given), but all the writes go through
stdio without error checking.

I wonder if this lazy patch is sufficient.  I want to avoid having
to sprinkle

	if (fputs("\\n", fp))
		error(...);

all over the code.

 builtin/fetch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b5ad09d046..72347f0054 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -868,7 +868,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
  abort:
 	strbuf_release(&note);
 	free(url);
-	fclose(fp);
+	if (ferror(fp))
+		rc = -1;
+	if (fclose(fp))
+		rc = -1;
 	return rc;
 }
 
