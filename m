Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7BC31F453
	for <e@80x24.org>; Wed, 24 Oct 2018 05:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJXOK5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 10:10:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33081 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeJXOK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 10:10:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id z2-v6so1807559pgp.0
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 22:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ch7RYHrTNOpwAKdJhBKyT+VLTLtera6RVusFXqr3hoI=;
        b=dpQaAS9qIPGIRUs0NW3XC6YPIOi1iBE/T/ZA7whoZNf8gYFwY0d/vfkZv+p+gJWoeC
         MuWucNmIbajIlJRZJB9OEA8wcE0CmjISpY49A6f1oeVI7IKrsjSUL9K5q3KVrrLgVCD6
         eK5Wt8MB0HHr7MMzjB5HNYy6yDkRLHYh1WAAcpn+444biIPGw+a0GekfBs20xteU+wrx
         /DxzkjPYiRsxCpX2AMqCefqcNXcqNL9XOFf85opgRdpWxgkl3gRuLH4smRR/8bz86Vo8
         1IYk70ExxKQ4frRlUpOq1ondh1+b/hm65XZXnRTF/dr9S/7xP3OiQUI/8IenatxNFqza
         8aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ch7RYHrTNOpwAKdJhBKyT+VLTLtera6RVusFXqr3hoI=;
        b=FpJiDl75cn7Or2Kac5Ue5rPOakENNjiTtrn3jUIx4YZiTtBjWkB01Kw2Kgaf98uAfC
         e+Q82YwH6soiYOAyAsZza4WOVPXIp1m+9NOZQEyawD+kT6NYHCTkptfLUR1Y56gQeXnz
         jmixjim8Cf618ft/B00OxiDfyx5+C4ZRZilGNpYoV/vN/NgZtLPWbAUZv5xhfUx9WFN2
         IsnLpI8RRDOIaNSULlHs58b5Jdnd5Ccl03Qi0wN9UIO+rjcoNM7GrZi4JxcQDRpCrg5u
         M28Va7gHWUZYLBpH0H7W7x5nBBlW0NQYrFWRhwYfXEWAbE2dJaazf93RUfPUcYe+0Wbs
         2sZw==
X-Gm-Message-State: AGRZ1gIUC0Ea5I393b9TKMat6kbn0rZHo1JBO89v0TOeqG+DPWGgG57n
        0O7Fl4VYgrIDDpUwcUq3h04=
X-Google-Smtp-Source: AJdET5c0zOIFdFVbRTrC0E4bDZP7VsLgUxuUkX9wOb7QEYhSMU5BUcOY/esKN9Yc5/h8YfCyL+oaxg==
X-Received: by 2002:a62:250:: with SMTP id 77-v6mr1350020pfc.16.1540359862448;
        Tue, 23 Oct 2018 22:44:22 -0700 (PDT)
Received: from gmail.com ([2605:e000:90ab:1300:acd3:6fc6:a240:6a91])
        by smtp.gmail.com with ESMTPSA id v84-v6sm7364091pfk.12.2018.10.23.22.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 22:44:21 -0700 (PDT)
Date:   Tue, 23 Oct 2018 22:44:16 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org,
        anmolmago@gmail.com, briankyho@gmail.com, david.lu97@outlook.com,
        shirui.wang@hotmail.com
Subject: Re: [PATCH 1/2] mergetool: Accept -g/--[no-]gui as arguments
Message-ID: <20181024053656.GA2985@gmail.com>
References: <20181024022500.GA29011@archbookpro.localdomain>
 <xmqqy3aond55.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3aond55.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 02:10:14PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Subject: Re: [PATCH 1/2] mergetool: Accept -g/--[no-]gui as arguments
> 
> Other people may point it out, but s/Accept/accept/.
> 
> > In line with how difftool accepts a -g/--[no-]gui option, make mergetool
> > accept the same option in order to use the `merge.guitool` variable to
> > find the default mergetool instead of `merge.tool`.
> > ...
> > diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> > index 9a8b97a2a..e317ae003 100644
> > --- a/git-mergetool--lib.sh
> > +++ b/git-mergetool--lib.sh
> > @@ -350,17 +350,23 @@ guess_merge_tool () {
> >  }
> >  
> >  get_configured_merge_tool () {
> > -	# Diff mode first tries diff.tool and falls back to merge.tool.
> > -	# Merge mode only checks merge.tool
> > +	# If first argument is true, find the guitool instead
> > +	if [ "$1" = true ]
> 
> Don't use [] in our shell script (see Documentation/CodingGuidelines);
> say
> 
> 	if "$1" = true
> 
> instead.

Perhaps a small typo dropped "test" -- I think it should be

	if test "$1" = true


> > +	# Diff mode first tries diff.(gui)tool and falls back to merge.(gui)tool.
> > +	# Merge mode only checks merge.(gui)tool
> >  	if diff_mode
> >  	then
> > -		merge_tool=$(git config diff.tool || git config merge.tool)
> > +		merge_tool=$(git config diff.${gui_prefix}tool || git config merge.${gui_prefix}tool)
> >  	else
> > -		merge_tool=$(git config merge.tool)
> > +		merge_tool=$(git config merge.${gui_prefix}tool)
> >  	fi
> 
> In mode_ok shell function, we seem to be prepared to deal with a
> case where neither diff_mode nor merge_mode is true.  Should this
> codepath also be prepared to?  
> 
> This is not a comment to point out an issue with this patch.  It is
> a genuine question on the code after (or before for that matter)
> this patch is applied.
> 
> Thanks.


I think the code is okay.  mode_ok is setup that way to allow filtering
for the other mode's tools, but this code path is only concerned with
getting the default merge tool, which should only ever happen in one of
the two modes.

The bit about difftool falling back to mergetool's config is a
convenience so it does make sense to keep that for guitool as well.

The code after this part should handle merge_tool being empty just fine,
so once the `[ ... ]` vs `test` bit is updated, please feel free to add:

Acked-by: David Aguilar <davvid@gmail.com>


cheers,
-- 
David
