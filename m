Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27641F40E
	for <e@80x24.org>; Tue, 15 Nov 2016 06:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbcKOGsr (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 01:48:47 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34158 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbcKOGsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 01:48:46 -0500
Received: by mail-yw0-f180.google.com with SMTP id t125so85422225ywc.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 22:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2G7Xv3tbNK1lwsl4TApreNx/HuOSRwWYKBy5DDD+ZdY=;
        b=U9n9H9QPBK70MAxAxVDzcuf+scTVkLlKF1penSmLnEmZJMZL0TE0+9Gi4a+1QDY1n1
         JGv+8sI7bsh1KyJbqzL7b1kpSgGaxEZdlGP/6ICpK4H/5lbJbP5heK0uwhmOpzlFlffF
         ZyWveoBc51VT5BLsnkXJS02lSwfkTA4RVh6BAT6JfGovebHzfSLjeckgYb1vM+wCyzx1
         u9SlozZT/lsmzOwsKwI+U2Zi44XGE1jlZxhTFcs8IbCdJ0Ti+elgQQ7vetUomXcx5S2y
         TOxFqEf3QMrgCJSCHCMGzC4KiMSUFl50sUnQ5QHE4FYd6UHurE5ZrR1KWtTq6tbxFkC/
         ns/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2G7Xv3tbNK1lwsl4TApreNx/HuOSRwWYKBy5DDD+ZdY=;
        b=D111rKuaVrD7/qfLhsDoy9LYoN/ineqBbprMKFEQuMIRmI8UUjUrTY94QgxznGccLa
         e8pcQpzj9gllfQ0j5lBv+APCCqwtYA89NkM/8W153V5DsCFv86MO2Cyp9ogaOluxWk1F
         Pz3ZhjP6OIhNiuzmCGI03wuhCydLrLQqowzSFSH4XyS8cw89je5Xcripnow0hx8aBx4s
         gUcYAcOEZvgEz3iLc7KdXHAMdqZ5iNvrocDf5wrz5anR8d0GaKIXYsNfN1IKLcijEEbj
         eF1jeV2RVwlaS5N0tAv3murqy2CO4ZhFOz8pJSzJKfzjzzWrgHyk3688UQ2mwl9ovCjK
         NJ9Q==
X-Gm-Message-State: ABUngvfpN44Sh9UicMHfFKsFP270U7l9UcbPTH5wf0SfCyLUFBvE6Q8JdOO5yItEgrYqiaZ4RZB8xeSwVXxFwQ==
X-Received: by 10.129.121.1 with SMTP id u1mr17835901ywc.146.1479192525498;
 Mon, 14 Nov 2016 22:48:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Mon, 14 Nov 2016 22:48:15 -0800 (PST)
In-Reply-To: <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 15 Nov 2016 12:18:15 +0530
Message-ID: <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 1:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>  - More importantly, what do these do?  I do not think of a good
>>>    description that generalizes "base of refs/foo/bar/boz is foo" to
>>>    explain your :base.
>>
>> $ ./git for-each-ref --format "%(refname)%(end) %(refname:dir)"
>> refs/heads/master                  refs/heads
>> refs/heads/ref-filter                refs/heads
>> refs/remotes/junio/va/i18n     refs/remotes/junio/va
>>
>> $ ./git for-each-ref  refs/heads --format
>> "%(align:left,30)%(refname)%(end) %(refname:base)"
>> refs/heads/master                 heads
>> refs/heads/ref-filter                heads
>> refs/remotes/junio/va/i18n     remotes
>>
>> I guess this should clear it up.
>
> Hmph.
>
> I would guess from these examples that :dir is an equivalent to
> dirname().  But it is unclear how :base is defined.  Is it the path
> component that comes immediately after "refs/" that appears at the
> beginning?

':dir' is equivalent to dirname(). Yup, base is the folder right after 'refs/'.
For local branches it is 'heads' for remotes it is 'remotes'. This is useful
when we want to make decisions based on the type of branch we're dealing
with (using along with %(if)...%(end)).

-- 
Regards,
Karthik Nayak
