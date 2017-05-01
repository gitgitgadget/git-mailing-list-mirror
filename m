Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB67F1F78F
	for <e@80x24.org>; Mon,  1 May 2017 16:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbdEAQfk (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 12:35:40 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33758 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbdEAQfj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 12:35:39 -0400
Received: by mail-pg0-f45.google.com with SMTP id y4so41837150pge.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=einxX/7CHopYlOnc5agRGaCkPgBYkRPWrZ984yaAAcY=;
        b=KVBw4vIBe5e6c/i6Z6q2AQwUi/vabwu+3fCLwVUgSUC6U5Yxd0bubx186uIoW4FLXO
         Tdk8iOHKT9Oh5PMqwOKT3PkvkqiAiAeZK6NFmanhs7rVubDlj452aQ37zR94wXcLoJ8O
         DlDTKssqekejdkR01LUwLNqMw0ZYwnqM+hqJ6ECeWP3QnD2Ej0AiP0JTnz834ZKvAaV6
         9Da7jGkewbFYBNIXi/zGiwiY8TfmgfhJZGFtHO2mSaCrWXCzm6aV/vAqZlWJ6qbmjpIS
         Jh0YKG1DMGz0S5rGy0Bt6hOfUrfToTAZz/r6g1GMuDUYNh2V+dsXyO1W+7XAn+QDfiDY
         aDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=einxX/7CHopYlOnc5agRGaCkPgBYkRPWrZ984yaAAcY=;
        b=OeW+hT7a1XGBI/dLHc/h7McbB3Sxtiy22YwCt/I7Yd7Pn+goFXPv194+MFyabTD6kA
         Onp739r5i1BK9SD8WqTenN6lkMPNMsC9+kZiHxCwA8XiVz73vS9nUi9Ca9wLJyyT6Yau
         +kMB6LnF4gKz9SCICDVVz0y3w2CCsumPvopfbQauxbgNA0z8lxoIf7JsltsSRB22h2tx
         qFzP/LCmgiX3xjFj8SIk14mapebrtHwuyCtjknBHN6PWjoMcvURW6wlP9PAZKyDvQOks
         Oa4IXgPADaq3pLzlwFmqp5wn7TfJreJDa/OshKyPFQxqpsVS1j0eMoQJaMowPpq5gSnm
         wJ8g==
X-Gm-Message-State: AN3rC/7pylcKXuW974KCZ8ijmGOXhQjhihzbjsBZmwLP8rLB+q/kEdM3
        vpu8w2FdRW3jBXQw
X-Received: by 10.98.61.91 with SMTP id k88mr27102143pfa.62.1493656538727;
        Mon, 01 May 2017 09:35:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6d87:7989:6a8d:cab9])
        by smtp.gmail.com with ESMTPSA id w5sm24378677pfd.23.2017.05.01.09.35.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 09:35:37 -0700 (PDT)
Date:   Mon, 1 May 2017 09:35:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] submodule: change string_list changed_submodule_paths
Message-ID: <20170501163536.GB39135@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170428235402.162251-5-bmwill@google.com>
 <xmqqr309gss1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr309gss1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/30, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Eliminate a call to 'xstrdup()' by changing the string_list
> > 'changed_submodule_paths' to duplicated strings added to it.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  submodule.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/submodule.c b/submodule.c
> > index 7baa28ae0..3bcf44521 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -20,7 +20,7 @@
> >  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
> >  static int config_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> >  static int parallel_jobs = 1;
> > -static struct string_list changed_submodule_paths = STRING_LIST_INIT_NODUP;
> > +static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
> >  static int initialized_fetch_ref_tips;
> >  static struct oid_array ref_tips_before_fetch;
> >  static struct oid_array ref_tips_after_fetch;
> > @@ -939,7 +939,7 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
> >  			struct string_list_item *path;
> >  			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
> >  			if (!path && !is_submodule_commit_present(p->two->path, p->two->oid.hash))
> > -				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
> > +				string_list_append(&changed_submodule_paths, p->two->path);
> 
> I notice that "path" is not used at all, and other users of this
> string list do not even bother using a variable, i.e.
> 
> 	if (!unsorted_string_list_lookup(&changed_submodule_paths, ...))
> 
> In fact, it might be even better to use a hashmap for this instead?
> 
> The call to string_list_clear() onthis list tells it to free the
> util field, and I went to see what we are storing in the util field,
> but it seems that it is freeing NULLs, which is somewhat misleading
> and time-wasting on the code readers.  Using hashmap may also clear
> this up.
> 
> But all of the above are not within the scope of this topic ;-)

All good good points which hopefully are resolved in a later patch.  This
patch exists mainly to factor out the change to make the string_list
duplicate the strings added to it as opposed to have that change seem
random and out of place in a later patch.

Most of this logic itself is removed entirely later once it is unified
with the other code path which checked for changed submodules.  This may
be out of context on this particular patch, but eventually an oid_array
is stored in the 'util' field of the string list items.  This oid_array
holds all of the changes to the submodule pointers.  This allows us to
then batch check for the existence of all the submodule commits instead
of checking each change individually (which is what this code path
currently does).

-- 
Brandon Williams
