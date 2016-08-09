Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F8C1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 23:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbcHIXLz (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 19:11:55 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38654 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932521AbcHIXLx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 19:11:53 -0400
Received: by mail-it0-f46.google.com with SMTP id x130so29041896ite.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 16:10:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UyI3ifRrz6SjNrtmU8VUVKZfddPr6l4RDagJh1fT5Vk=;
        b=P7L37FOLnL5bKRpd0nwvFhFRmI+ZABXShe82AwS74tPsg1W3CERsMXVACLHfok/duJ
         koCZp2x6HUYNCad5CE9KQIWPHaCcxCNuIv05LrNsPFWb9T7zhYwLxoza4mKUUYrLUrr+
         0/VDFWcnZJi++ZGqPyNtQ8VJNFMWI/wPQR5PdKL86smoGovWGqyvDgDSVheZvm/Z/aLF
         IslyGOaFUcf/7r3S9oFxUZFs5qgjoLg8it7xxTu+7g6tYhVH2FIavOYSdjQvbS9p03oU
         cnRZMxNR5AIejGH8GpeDAqQGZpYx9CqkgC+IUwfksBYfOPDE5HGA6SjY+Q7CPpYmeyCW
         BMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UyI3ifRrz6SjNrtmU8VUVKZfddPr6l4RDagJh1fT5Vk=;
        b=UO+roztuLHH616eiMZwjLhkO3AY/zVKFf/VYrPIRf3//3Is5Jf5vvcD0oayTevuT16
         0qoIPdLCCM30CdutZ746aGvm661oEPzSv8YQXo9qqIoJ5qkrLZdDndHM/uOZFsuOgmJB
         AsLvd0LFQqWAhMAFuR4WhP6bns8whpXygcBvny47JqcgEBVjKGrZjQ/242DC3j9UGWfM
         bbFJ4t0ZnrQB5UbFVfhiBYDC/k4pbjxyoZJJsStBXg77ikysZXFVHxQ0QEj7IqQCakMq
         X5WMr94OI82kujFRscb/dXh2ASnEuvoCNFUBOyrC5rmyrdud2WByAuA4nZOrlAS1+Kmv
         m35A==
X-Gm-Message-State: AEkooutvhH5rGtw7eajlUXV7+MGMtTL+pyLbaCwE3plsm7aa14s8e6synD4NNCDFIS5DSshSBgDhtOgtCzrGjBt9
X-Received: by 10.36.228.138 with SMTP id o132mr26931841ith.49.1470784254331;
 Tue, 09 Aug 2016 16:10:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 16:10:53 -0700 (PDT)
In-Reply-To: <CA+P7+xqnALzwkgLXrP57BUtFGaxGudAEG7cmGTakP47ofFEjHQ@mail.gmail.com>
References: <20160809223219.17982-1-jacob.e.keller@intel.com>
 <CAGZ79kbzDhpsfpY8s=7O86_dNLA=VRkyC=8eiCqMambKvUnXmw@mail.gmail.com> <CA+P7+xqnALzwkgLXrP57BUtFGaxGudAEG7cmGTakP47ofFEjHQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 16:10:53 -0700
Message-ID: <CAGZ79kZbHAsxf9G-8=nz3o_zOMNFPa=kSphdo=4zLq97jycbYg@mail.gmail.com>
Subject: Re: [PATCH RFC] diff: add SUBMODULE_DIFF format to display submodule diff
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 3:56 PM, Jacob Keller <jacob.keller@gmail.com> wrote:

>>> +
>>> +       if (strbuf_read(buf, cp.out, 0) < 0)
>>
>> So we keep the whole diff in memory
>> I don't know much about the diff machinery, but I thought
>> the rest of the diff machinery just streams it out?
>
> Yea, but I can't figure out how to do that. Is there an easy way to
> stream chunks from the pipe straight into the file?

Maybe, roughly:

    cp.stdout = -1;
    start_command(&cp);
    do {
        int r = xread(cp.stdout, buf, MAX_IO_SIZE);
    } while (r >=0);
    finish_command(&cp);

xread does use a poll() for you so it is not active polling,
but only reading when data is available.


>>
>> When not checked out, we can invoke the diff command
>> in .git/modules/<name> as that is the git dir of the submodule,
>> i.e. operating diff with a bare repo?
>
> We can actually do this every time. How would you pass that in a
> child_process? I don't think it's "dir" but instead passing
> "--git-dir" somehow?

git -C $GIT_DIR diff --relative ${superprojects ce->name}

with $GIT_DIR = ${SUPERPROJECTS GITDIR + modules/<name>/ with name to be looked
as submodule_from_path(ce->name) and then taking `name` from the
submodule struct)


Thanks,
Stefan
