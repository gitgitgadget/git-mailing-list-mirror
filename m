Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B4420954
	for <e@80x24.org>; Fri, 24 Nov 2017 09:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbdKXJwZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 04:52:25 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:44589 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752737AbdKXJwX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 04:52:23 -0500
Received: by mail-wm0-f47.google.com with SMTP id r68so21400112wmr.3
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 01:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=42J07qfgy8on9zdCX6IM/oduZTODly1IALS6VTBbmEg=;
        b=sNytPkemF6oLsWHyBuc9rE1pAkYIF4AC7A9pt//hPrT/FaJ9hpGoGKyA3tPT8MA/DZ
         NUQedWM6hL3nkRynXyHl3VxsPvbtw79WSSZ4aMo1xwImVhIz/OepFMMZhp171797mgLq
         /Ig2eI+YMJtDInypqrbcAJroVCJUK0yBWfTuSNvAWqDcXzl9vSxAaQ71EqIQUxfMaAu8
         PzwLaraENNu8/v8ksz7TbS6rwap8im8Uo9zBZb3Z0xiUnAbJfAMhx2H/DnDfHPVWWxDU
         +QJzz94T+C4/9jbrNFRXDd41z93cO4PPr+1K9BEy8zE31CWxZl5f1BphqfEa7Xs9DJep
         uoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=42J07qfgy8on9zdCX6IM/oduZTODly1IALS6VTBbmEg=;
        b=mzArEuuD5lNV6EhFkS24YBwCBb0Vv76VteyrQs2VWn8oQ/30tSc/g/fBi8LvarD7m5
         YAj6IiNtTHmF7b78HPfSp6JBOskE1IqaRjVSIHqkbBdopx0A2t49IN1A+1KyAdvGfNPJ
         dICLg29759niRU/V6CfBxydYXTdYt5Tk6lSBzOJ6Koa8NjcNW1rFmh2aZvqI/C0Fqe6e
         lDqJU0YUGB6ptzKV64GjBcz4kfnq2xovwiB+tFqxho9PK0rhbAcmVzL4DaONkFaSzDuf
         vqyUTj2ETWkyyGzqTm2UTGHKTRjmk0k49oIk92ior7ppE/aAuw4IUtsBHCM/nTWMmuz8
         91iA==
X-Gm-Message-State: AJaThX4716F4SfcIkr9/QN4mA24on0qs+Egv1FOXMlcX/fRM2Uj+nPZN
        c57mBY26GlH9t2GAMYXcES0O+aKhq/Nek6/UV+M=
X-Google-Smtp-Source: AGs4zMZzxXSodQCrlzBUUyot+cZMzMW5KFBjXGYXdRShPrx/lk2+vVMJD/upS5uxjv6vqJHa8opSAq0d17so01i0yjc=
X-Received: by 10.28.227.136 with SMTP id a130mr9953171wmh.104.1511517142517;
 Fri, 24 Nov 2017 01:52:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.151.195 with HTTP; Fri, 24 Nov 2017 01:52:02 -0800 (PST)
In-Reply-To: <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com>
References: <201711231458.vANEwUMK048049@elephants.elehost.com> <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Fri, 24 Nov 2017 12:52:02 +0300
Message-ID: <CAPkN8xJBWRs-2DxViBACLKzAbD1_EBA2MvmWVZmWgL+Sg72znw@mail.gmail.com>
Subject: Re: Re: Unify annotated and non-annotated tags
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 6:08 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On 2017-11-23 02:31 (GMT-05:00) anatoly techtonik wrote
>>Subject: Re: Unify annotated and non-annotated tags
>>On Sat, Nov 11, 2017 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>>> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>>>
>>>> If you would like to mimic output of "git show-ref", repeating
>>>> commits for each tag pointing to it and showing full tag name as
>>>> well, you could do something like this, for example:
>>>>
>>>>       for tag in $(git for-each-ref --format=3D"%(refname)" refs/tags)
>>>>       do
>>>>               printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
>>>>       done
>>>>
>>>>
>>>> Hope that helps a bit.
>>>
>>> If you use for-each-ref's --format option, you could do something
>>> like (pardon a long line):
>>>
>>> git for-each-ref --format=3D'%(if)%(*objectname)%(then)%(*objectname)%(=
else)%(objectname)%(end) %(refname)' refs/tags
>>>
>>> without any loop, I would think.
>>Thanks. That helps.
>>So my proposal is to get rid of non-annotated tags, so to get all
>>tags with commits that they point to, one would use:
>>git for-each-ref --format=3D'%(*objectname) %(refname)' refs/tags>
>>For so-called non-annotated tags just leave the message empty.
>>I don't see why anyone would need non-annotated tags though.
>
> I have seen non-annotated tags used in automations (not necessarily well =
written ones) that create tags as a record of automation activity. I am not=
 sure we should be writing off the concept of unannotated tags entirely. Th=
is may cause breakage based on existing expectations of how tags work at pr=
esent. My take is that tags should include whodunnit, even if it's just the=
 version of the automation being used, but I don't always get to have my wi=
shes fulfilled. In essence, whatever behaviour a non-annotated tag has now =
may need to be emulated in future even if reconciliation happens. An option=
 to preserve empty tag compatibility with pre-2.16 behaviour, perhaps? Sadl=
y, I cannot supply examples of this usage based on a human memory page-faul=
t and NDAs.

Are there any windows for backward compatibility breaks, or git is
doomed to preserve it forever?
Automation without support won't survive for long, and people who rely
on that, like Chromium team, usually hard set the version used.
--=20
anatoly t.
