Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5053201CF
	for <e@80x24.org>; Wed, 17 May 2017 07:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbdEQHCv (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 03:02:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36682 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753528AbdEQHCs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 03:02:48 -0400
Received: by mail-io0-f196.google.com with SMTP id f102so642358ioi.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n5VWUMKcTC3/FxeDxBZoUhup82wyEl+uaYCdOfpMRqg=;
        b=HHwp5+CjCsbllcUHNv5YdM2tsmZTwvnEofpvKg8r4DiemFiHdjM0DTY3xpe4rXVgl3
         JHPvdyEurHFconSBFcZ35z2VUQtAoT1GDjBy47vDi20sGJ+0hJunScN3CyDLy4gL1h4B
         M7vo9HyYqii3LAe5mgE+2eaXan0Hkum48wKCvCtbol/6Li7iYBuk2vaL1JKDEbrMwuZJ
         OVJK0G8SH/YfO95ivSy+NQMUGbRRZCfYfJ7iLN3BeH4BnxLQt1GZR3jmIXJ67lRg+VKu
         9iP682XpcEBn0I4H5cCKb6O80AiM58UUeBzTQ0TbjB8v5f/BKLGW5TTWEkAJKaqIHUnP
         Ayrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n5VWUMKcTC3/FxeDxBZoUhup82wyEl+uaYCdOfpMRqg=;
        b=tfMnbpQAIY1g4RBrriJ4xGqsSY2/8Jq8tMqUvdetDYBioNTNne9fo3oyCQ4QkBBfYc
         Yita0amegRbPiNHF5JYvo9qPOSN+ZEi8JiKPWcBkQQpTmwQMBobKq+qvRmrAvloOS0n6
         OjLoycxLhgWmLNjzew12hXkb8SH6+ynH+AFD15b/GEgvJG8kYb7fJInkUNM3O2MU+gAz
         ajDu03wXvLwPAxnfE4XxwoVTIqP3lxsPUoBC2NGXoz/1e3GJ1+mEC+2UKdrKEmfXeiZp
         KSKe1+KET47Ep9J8ifJd0pUotRgnfjCxBuERjiAwZ0xSDAk00AkOsXAkfO0K+MSefAOv
         9hIw==
X-Gm-Message-State: AODbwcCglvWOQp/uxPr0LPO6Kyl9UhB0BnhDwwK4vgi4K6VsjJCQ7wOR
        CWo3amRxjJaJ3R3wOyxbdcXcApQLRg==
X-Received: by 10.107.195.70 with SMTP id t67mr1998459iof.17.1495004568015;
 Wed, 17 May 2017 00:02:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 17 May 2017 00:02:07 -0700 (PDT)
In-Reply-To: <xmqqy3twvw66.fsf@gitster.mtv.corp.google.com>
References: <20170516073423.25762-1-sxlijin@gmail.com> <20170505104611.17845-1-sxlijin@gmail.com>
 <20170516073423.25762-4-sxlijin@gmail.com> <xmqqy3twvw66.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 17 May 2017 03:02:07 -0400
Message-ID: <CAJZjrdXTWsOX6-=4XJwa0EwOUieWw7xpK6i9hfOaxpAAjqqz-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] dir: recurse into untracked dirs for ignored files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 2:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Lijin <sxlijin@gmail.com> writes:
>
>> We consider directories containing only untracked and ignored files to
>> be themselves untracked, which in the usual case means we don't have to
>> search these directories. This is problematic when we want to collect
>> ignored files with DIR_SHOW_IGNORED_TOO, though, so we teach
>> read_directory_recursive() to recurse into untracked directories to find
>> the ignored files they contain when DIR_SHOW_IGNORED_TOO is set. This
>> has the side effect of also collecting all untracked files in untracked
>> directories as well.
>>
>> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
>> ---
>>  dir.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/dir.c b/dir.c
>> index f451bfa48..6bd0350e9 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1784,7 +1784,12 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>>                       dir_state = state;
>>
>>               /* recurse into subdir if instructed by treat_path */
>> -             if (state == path_recurse) {
>> +             if ((state == path_recurse) ||
>> +                             ((get_dtype(cdir.de, path.buf, path.len) == DT_DIR) &&
>
> I see a conditional in treat_path() that is prepared to deal with a
> NULL in cdir.de; do we know cdir.de is always non-NULL at this point
> in the code, or is get_dtype() prepared to see NULL as its first
> parameter?
>
>         ... goes and looks ...
>
> Yes, it falls back to the usual lstat() dance in such a case, so
> we'd be OK here.
>
>> +                              (state == path_untracked) &&
>> +                              (dir->flags & DIR_SHOW_IGNORED_TOO))
>
> If we are told to SHOW_IGNORED_TOO, we'd recurse into an untracked
> thing if it is a directory.  No other behaviour change.
>
> Isn't get_dtype() potentially slower than other two checks if it
> triggers?  I am wondering if these three conditions in &&-chain
> should be reordered to call get_dtype() the last, i.e.
>
>                 if ((state == path_recurse) ||
>                     ((dir->flags & DIR_SHOW_IGNORED_TOO)) &&
>                      (state == path_untracked) &&
>                      (get_dtype(cdir.de, path.buf, path.len) == DT_DIR)) {

Ah, I didn't realize that. I figured that get_dtype() was just a
helper to invoke the appropriate macros, but if it's actually mildly
expensive I'll take your reorder.

>> +                             )
>> +             {
>
> It may be just a style, but these new lines are indented overly too
> deep.  We don't use a lone "{" on a line to open a block, either.
>
>>                       struct untracked_cache_dir *ud;
>>                       ud = lookup_untracked(dir->untracked, untracked,
>>                                             path.buf + baselen,
