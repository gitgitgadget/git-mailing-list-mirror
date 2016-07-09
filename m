Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860AA1F744
	for <e@80x24.org>; Sat,  9 Jul 2016 02:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbcGICKr (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 22:10:47 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33290 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932635AbcGICKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 22:10:45 -0400
Received: by mail-yw0-f174.google.com with SMTP id j17so51721768ywg.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 19:10:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rQG/WeIYSv3SLWekBk2ro8HddNTqjqQa8aMS2iBYxk0=;
        b=uWzWcy2INZGkXlDtDtRdDBKGVHZKhql1cdD71Gax1vsZ3PDAfWb1oCCXHXGkLip68D
         xpeFT1v2eVaUzqsTDJT9eQq+58XO5/0YPMxoNGTQ2o/CK5qGo8qob1Z7Hc2YOstMOY//
         4wU35ZKrDheqTpjcyKKFaSmztPZ4OOWL5QMGikJSg5DgBI+YEODU1XPmKYlScxTWk1YO
         pN8khNJRo6OYMm6z7k2nESsNjUpDoVq5O7BME5GuVAk8KMys6zjVEwKZ9Gm4TNPCX0hK
         esL+M/NB2H37T9rlUJjSSNBs/M5TMqQMjLB+q44HaWwrchouUhe9p4LVgEbeAsYfuhNF
         2NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rQG/WeIYSv3SLWekBk2ro8HddNTqjqQa8aMS2iBYxk0=;
        b=CdYoANBccf0gA8CWjV03oXa21G8Lsy5JZLGvsSCbGBVFLtqIAbnes4bzX3MSlPeo0A
         wu9N6bvTRZF3v4dpfF/A3RbXMZDTMXwaiYr9RK05pumwAVNzbi15b7u31zCb5BK0Xa+L
         gVv/dC3Iwmmc1Lhz6A8JqyospWG34Y0NbjfUfPatG2HxWrm93NzfsA/GyUHjI0lCHVU4
         o72P62Av4p++rosqX+lhpd8Ji565XwLmJLS7m5JcR2l4m5yd08FFM84uIPSZ/flXos/C
         /w67o+6ttGV/qNYRfRdFaKUpZrVfq7m/LXECvTKRL7vxvUjUgLsEASu4HPYaLeF/ykDK
         tPoA==
X-Gm-Message-State: ALyK8tKY3aNbbRaCNx2tX3UssfTC8FmLMWEsPMlB7kO3QV/Az6ryoZNM7fsB6FpFwwCPlppDcgKC9oKBCgjbBg==
X-Received: by 10.13.245.132 with SMTP id e126mr6530000ywf.258.1468030244712;
 Fri, 08 Jul 2016 19:10:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.34.133 with HTTP; Fri, 8 Jul 2016 19:10:25 -0700 (PDT)
In-Reply-To: <xmqqbn27lqm0.fsf@gitster.mtv.corp.google.com>
References: <CAP4gbxqjHzqHhPuNK8UOwPMa46g2=vcNSk1AvGjxN8s+ou-0Dw@mail.gmail.com>
 <xmqqh9cnrvp2.fsf@gitster.mtv.corp.google.com> <xmqqr3bokeib.fsf@gitster.mtv.corp.google.com>
 <CAP4gbxp6qKntysrkyTSWxkQNpqPzf2gHLiKpJzA-TmqO71sHyg@mail.gmail.com> <xmqqbn27lqm0.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Fri, 8 Jul 2016 19:10:25 -0700
Message-ID: <CA+P7+xroUpQDX1hV=s7Qcp_yyt8A1dXuZS4+gwXgqOGy_+QC5w@mail.gmail.com>
Subject: Re: Fast-forward able commit, otherwise fail
To:	Junio C Hamano <gitster@pobox.com>
Cc:	David Lightle <dlightle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 3:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Lightle <dlightle@gmail.com> writes:
>> In fact, I just noticed that GitLab has built in the functionality I'm
>> looking for even, which is what they call "Merge commit with
>> semi-linear history" but I'm asking whether direct support for this
>> approach would be reasonable.  These approaches can all produce the
>> "untested merged product", but they support the way the users want to
>> use the system as well.  I'm not saying any approach is right or wrong
>> as I'm not qualified enough to say.
>
> We, not being a for-profit entity, do not have a strong incentive to
> add features that encourages bad workflow to the users.  Of course,
> we also do not necessarily stop them if users really want to shoot
> themselves in the foot ;-), but such a change would inevitably be of
> lower priority to us.
>

I would add that after using a linear history at $dayjob a lot, i've
found the biggest reasoning for a linear history is that non-linear
history confuses the users. I'd rather advocate for learning how to
handle the more complex history than trying to force users into
quickly rebasing code which can lead to the issues Junio mentioned
above.

Thanks,
Jake
