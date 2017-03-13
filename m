Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF20420311
	for <e@80x24.org>; Mon, 13 Mar 2017 17:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbdCMRY1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:24:27 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36580 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdCMRYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:24:25 -0400
Received: by mail-pg0-f43.google.com with SMTP id g2so48818028pge.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kvh91ZenIfl2pxkOTt7M46fr+q9NbJOLsahTo3tC994=;
        b=jxK6SGR/+f40sMJgyXE2Qf5ab/opVmMXPooqFiY1TVN7XO3dGoVAT5L72PC3MXrsKE
         5jZUr3jBYgB41hKHQ5Ohgx7UiCj5tGMhjjSa+4hA2Tc0bH+iXA2Yp+vukqxLBSCyjWyW
         DpEBAED/GBXPWHtsCemIz2AkZQCZhpl/cI2Ep3G3xMRpR88e44fjPc0Aq5aOzsCjY9Hu
         bVyjpiVHlQzoeupvpH7uQCQfKfj5WgTz8UNHiGS1xXmtrMbYO3ZJYB4xjH/b5+bHYIJ9
         8bvClJ8E9yx0aKZX+83wAAXwaft8nVjLe3pcmMsmb64UeKCyhS3EMlyiJIYDPmkGuBxE
         Swkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kvh91ZenIfl2pxkOTt7M46fr+q9NbJOLsahTo3tC994=;
        b=X5Y+5WEnq1R8K+48qDxy3PSlEOU3vLEfn16LnCW9h19Qys4nMdHnjJHTd/A+H5bzAI
         HZC3Y9Wl9gZCzK/QWDksrk+2ZRI+FNeu33VaAjlxiEVoTemp4QvhM68CapeF79BF+wPO
         E27ai5eRwFY0wTQToX7tz7qwrFyaaXAppKRE+wptpOnqfS2qe92QeDA3uQDKT+zALiWF
         TACF3D9icVI8QOdcGoEsbbo5Jqpt3epKqgV6AvfxamV1eEml8flMjhqFTiaWD3QXUV+l
         EMLZVafoUpw9VA+kBuTpzZGXJpFlPcVio12t1vFNB1qmppduT8hpxsHCoxjOF9mcQ62j
         1VfA==
X-Gm-Message-State: AMke39nCR5NYWxbBBRMPjqb4NbCXAf4/AiTbXeVGu58GMGKldpCgCHcUZGvZzclLrQR159yW
X-Received: by 10.99.103.133 with SMTP id b127mr38685266pgc.29.1489425864184;
        Mon, 13 Mar 2017 10:24:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:ac5e:90c6:a609:7ab8])
        by smtp.gmail.com with ESMTPSA id 10sm33805057pfs.113.2017.03.13.10.24.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 10:24:23 -0700 (PDT)
Date:   Mon, 13 Mar 2017 10:24:21 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        novalis@novalis.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 12/17] update submodules: add submodule_move_head
Message-ID: <20170313172421.GA66601@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
 <20170309221543.15897-13-sbeller@google.com>
 <20170309233709.GD52558@google.com>
 <xmqqo9x7ug2j.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9x7ug2j.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >> diff --git a/submodule.c b/submodule.c
> >> index 0b2596e88a..bc5fecf8c5 100644
> >> --- a/submodule.c
> >> +++ b/submodule.c
> >> @@ -1239,6 +1239,141 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
> >>  	return ret;
> >>  }
> >>  
> >> +static int submodule_has_dirty_index(const struct submodule *sub)
> >> +{
> >> +	struct child_process cp = CHILD_PROCESS_INIT;
> >> +
> >> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> >> +
> >> +	cp.git_cmd = 1;
> >> +	argv_array_pushl(&cp.args, "diff-index", "--quiet", \
> >> +					"--cached", "HEAD", NULL);
> >
> > The formatting of this line is a little odd.  Also you can drop the
> > backslash.
> 
> Heh.  I think I saw and pointed out the same during the review of
> the previous round X-<.  It is a bit disappointing.
> 
> >> +static void submodule_reset_index(const char *path)
> >> +{
> >> +	struct child_process cp = CHILD_PROCESS_INIT;
> >> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> >> +
> >> +	cp.git_cmd = 1;
> >> +	cp.no_stdin = 1;
> >> +	cp.dir = path;
> >> +
> >> +	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
> >> +	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
> >> +
> >> +	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
> 
> Somewhat related; will this use of --super-prefix be affected when
> we split it into two for "adjust pathspec" prefix and "adjust
> output" prefix?

Maybe? From what we discussed we can have 'super_prefix' maintain its
current meaning (Path from root of parent down to the submodule) while
adding a new env var or option to pass the 'prefix' variable to the
child process (Path from root of parent to the directory the original
cmd was executed in).

So this shouldn't be affected unless we decide to change the semantics
of 'super_prefix'.

And I'm always torn on how best to do naming for the newer
functionality.  I think the easiest thing to do would be to have a
--prefix option to pass the 'prefix' from one process to the next, but
I'm sure there are other opinions on the matter.

-- 
Brandon Williams
