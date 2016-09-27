Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B8820986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbcI0Uoq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:44:46 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36448 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbcI0Uoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:44:44 -0400
Received: by mail-pf0-f181.google.com with SMTP id q2so9343048pfj.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3RP0HlImar3GCXjHdRuhF6z33j3NBYGhFKcL6gPLDgQ=;
        b=eWqTNSVuj7HIFqJi63tIdUFT6tM3z2/n8ZFB/Xsf15htloy3arqyFEYG9nPPsZa+mi
         40CNDoH1NmTCGVDDfe/uO+w1/TY/oc8rddRlvzAsjuPc0cz3tqTk5lqAbJtrFa1snq3b
         Xfm0gYdDP71Ki1xAwtnJiu6gcvk1ni6zCIbhTcGY3Cd/JBXqjP5g6GDt/b+4Lzqzaj15
         6Qs3gjp+GA5nvKKZQy7cUDgzvRMXJL4kwZvmp5IkqBc5ORvD470V3VurQKGOW+9HV71g
         mudyTsE45wDHKqwI8jz965QCB8ZQCSSPmWTgWF306kfbOsdr30BihyiFS23DwpuNjDFK
         1dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RP0HlImar3GCXjHdRuhF6z33j3NBYGhFKcL6gPLDgQ=;
        b=GH+FcfSHvIcPv3wTT1gZ38rWMgJk4WoMrKH2gaHgWyF8J/6OPqnfQZoJl3hl1kRzt0
         rKSiLyd6JgSMVUEo6SWQwXSW71bcQJGPGIjhDNfi1mC+ld2ZNT7thQVBnxoMR0aMd8YL
         vXeDV+NLoJD1rcmKQGRUJuovwZEqZmmyZqfNzkFawtr6D1f4OSD4HYL80cKetej6OVKs
         mQh7TA5KJfqlW74c68EAl6cuMj7RK11FisULej2TjGamdm2IJ46+QNR14toYjYRK19Ox
         Q1rd2I0sSGuKfALswseTnO+gEBXjrPjYJGa2F3CW2YWZ/Vhg6diN7+PMVLfc9r53q4te
         LWrA==
X-Gm-Message-State: AE9vXwN0hW7PNvVlg579qn7e7fn5IBipXPotsPuZT4ryOqc5wylz+P9uwMsgahZ+fiDfF9my
X-Received: by 10.98.113.135 with SMTP id m129mr50348313pfc.41.1475009083562;
        Tue, 27 Sep 2016 13:44:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:3959:5f82:1885:1644])
        by smtp.gmail.com with ESMTPSA id h123sm6929870pfe.87.2016.09.27.13.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 13:44:42 -0700 (PDT)
Date:   Tue, 27 Sep 2016 13:44:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for
 --recurse-submodules
Message-ID: <20160927204440.GE32565@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1474930003-83750-4-git-send-email-bmwill@google.com>
 <xmqqd1jpnpyh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1jpnpyh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >  	if (recurse_submodules &&
> > -	    (show_stage || show_deleted || show_others || show_unmerged ||
> > +	    (show_deleted || show_others || show_unmerged ||
> >  	     show_killed || show_modified || show_resolve_undo ||
> > -	     show_valid_bit || show_tag || show_eol || with_tree ||
> > -	     (line_terminator == '\0')))
> > +	     with_tree))
> >  		die("ls-files --recurse-submodules unsupported mode");
> 
> Ahh, one more thing, and this comment probably applies to 2/4 not
> this one, but if the intention is to shrink this "not supported yet"
> check as the series progresses, in the earlier step the check would
> need to make sure no pathspec is given, which is first supported in
> 4/4, I think.  It is not a big deal to require rerolling by itself,
> bit if you are rerolling 2/4 for other reasons, then...

Oh there is a separate if gaurd for pathspecs which is introduced in 2/4
and then removed once pathspec support has been added in 4/4.

-- 
Brandon Williams
