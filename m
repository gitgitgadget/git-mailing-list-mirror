Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34035201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 20:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdBUUio (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 15:38:44 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33982 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbdBUUih (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 15:38:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so21757134wmi.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 12:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ke4/0tvIRphKfLFxkzQZ5/wbPlLf8HNFU/Vy2OKZzoo=;
        b=BymU6yNMoAqzsFEi/gPAoMXnoS2Dg+AxH+/86efSmyp2ZrF4++hXGb5yBvsqqcTXGL
         m4LrlRB+LpbWLDEPrvTL4h2aATn9F4YJ53RT02ILrq+Um8Va+83DxsUvWJxz0A04GFn2
         teVn6Zzab9jEY8/rCuQBwEaPWpIbPljsY7cRpoSktAOdDOlBlHFLiavfGT57FdbdNU2B
         C7Th8KEUo64zOGPjqvbHe4+09y6sVgX930p/xKZ9VCFO0EUFe4ljzesmN1JZyPYxPMmu
         6XlDc3pcqWQ/x3v0Snob3diEb60P7snFk0crB7Upa71+px0mrn0Oyuh8wSdKKBgJd9/G
         yJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ke4/0tvIRphKfLFxkzQZ5/wbPlLf8HNFU/Vy2OKZzoo=;
        b=ILtFUyIApub3imiaC8VoiNRpReWqCCXc7rIsw36myqJHymGqDO1GWupFYSEneDyzUo
         uN63TFwYUbpRyoanGMr2U7+TI/Njcr6aq1e7oBEtpVjL+nkR+B35+l1Af9dbNray5X4W
         Zy5IEOQCDBgqbDy/34KSZDK20Z3G2Mlh/24ERaxHCGiXrHuaof8lgmidNv79nkwSPOEw
         jOEYROKDZngAQ5YDz/h6A0jQjqC21aqAloEZBk9hq8jLqpxTScKU/a7YOZqdR6m7mmBn
         I4Hdr1qTqeAClXENAUR0EJNySVVmNrFYDnVqZAG9Ew/WqtuJrLfC0ST8tTLZf/X/zA1r
         tRTw==
X-Gm-Message-State: AMke39lWuEfwFgRsj9P+h5/ST1JnQc4kilP7lyQbqheh8n06wEbi7eDaDj1YdAIcnQ0OXA==
X-Received: by 10.28.67.134 with SMTP id q128mr26421581wma.34.1487709504947;
        Tue, 21 Feb 2017 12:38:24 -0800 (PST)
Received: from hobo (139.14.90.146.dyn.plus.net. [146.90.14.139])
        by smtp.gmail.com with ESMTPSA id s17sm30284762wrc.6.2017.02.21.12.38.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 12:38:24 -0800 (PST)
Date:   Tue, 21 Feb 2017 20:38:36 +0000
From:   Ross Lagerwall <rosslagerwall@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote: Ignore failure to remove missing
 branch.<name>.merge
Message-ID: <20170221203836.GA11736@hobo.lan>
References: <20170218002341.23099-1-rosslagerwall@gmail.com>
 <xmqqtw7nfift.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw7nfift.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 11:32:54AM -0800, Junio C Hamano wrote:
> Ross Lagerwall <rosslagerwall@gmail.com> writes:
> 
> > If a branch is configured with a default remote but no
> > branch.<name>.merge and then the remote is removed, git fails to remove
> > the remote with:
> > "fatal: could not unset 'branch.<name>.merge'"
> >
> > Instead, ignore this since it is not an error and shouldn't prevent the
> > remote from being removed.
> >
> > Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
> > ---
> 
> I was waiting for others to comment on this patch but nobody seems
> to be interested.  Which is a bit sad, because except for minor
> nits, this patch is very well done.
> 
> The explanation of the motivation and solution in the proposed log
> message is excellent.  It would have been perfect if you described
> HOW you get into a state where branch.<name>.remote is pointing at
> the remote being removed, without having branch.<name>.merge in the
> first place, but even if such a state is invalid or unplausible,
> removing the remote should be a usable way to recover from such a
> situation.

I got into this situation by setting branch.<name>.remote directly.  I
was using push.default=current, and wanted a bare "git push" on the
branch to push to a different remote from origin (which it defaults to).
Configuring branch.<name>.remote made git do the right thing.

Perhaps what I did was invalid, I'm not sure, but it achieved what I
wanted.

> 
> And the proposed solution in the diff seems to correctly implement
> what the description of the solution in the log message (modulo a
> minor nit).
> 
> >  builtin/remote.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index e52cf3925..5dd22c2eb 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -769,7 +769,9 @@ static int rm(int argc, const char **argv)
> >  				strbuf_reset(&buf);
> >  				strbuf_addf(&buf, "branch.%s.%s",
> >  						item->string, *k);
> > -				git_config_set(buf.buf, NULL);
> > +				result = git_config_set_gently(buf.buf, NULL);
> > +				if (result && result != CONFIG_NOTHING_SET)
> > +					die(_("COULd not unset '%s'"), buf.buf);
> 
> With s/COUL/coul/, the result would be more in line with our
> existing practice.

Oops. That's what I get for coding when I should have been sleeping.

> 
> >  			}
> >  		}
> >  	}
> 
> We do want an additional test so that this fix will not be broken
> again in the future by mistake, perhaps in t5505.
> 
> As it is unclear to me how you got into a state where branch.*.remote
> exists without branch.*.merge, the attached patch to the test manually
> removes it, which probably falls into a "deliberate sabotage" category.
> If there are a valid sequence of operations that leads to such a state
> without being a deliberate sabotage, we should use it instead in the
> real test.
> 

See my explanation above. I wouldn't call it "deliberate sabotage", but
rather using config knobs in unexpected ways.

The test case looks reasonable. Do you want me to resend a patch with
the test case included (and nit fixed), or will you fix it up?

Thanks,
-- 
Ross Lagerwall
