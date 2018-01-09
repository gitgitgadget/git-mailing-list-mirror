Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2931D1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935454AbeAITZU (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:25:20 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:40394 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935447AbeAITZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:25:19 -0500
Received: by mail-qk0-f181.google.com with SMTP id d18so9568256qke.7
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9wJi/FrHA2eFpXDOqzieoDy+jXj9z74hEGR2yEpFSes=;
        b=htFTADbQbV/j3MVydVwyHLsMbXQChZ8FLXZbdTyYWTzID3TRRVwvwGQcnOJiU+QSOf
         lX+jTRlAesQzu26vySEo41KBOBbPXCGAb+PN49nigIH2SidouCI7oYchFkwaRoS1be5Q
         7qVO05DugjbHXHn1VHqRAqpdH9rtfYbTvYfhvjxdpG/cyR+fFBtl48CU21PN/ncsS0yk
         iJbEnSocqeYMuIWSPcK8XVJGrophs8npsu0qlf8ffuEu5xo4HGDPCzDIM+3nSpvXvo+f
         TlufxH6ZjZOy7LczwXTVfbeaJ4y186BobNi+FAPPTdcvWGuaBOtXerYrumGEuUXon7RC
         MbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9wJi/FrHA2eFpXDOqzieoDy+jXj9z74hEGR2yEpFSes=;
        b=gHArtamPp/9PC0x1z5Vp9Ecz+ODjNI1AAt/vu6rZZJqFMjpB1pJVYuve7VNKGz13AM
         X6mDPCuPXplsAo2gUxBab7p9yk4N2kJ4OAP3S6zFrAwdl+tbfX+1E7cma9fiZ9zNtmSk
         qQ2jCXVzxhzjweJlAXViZuSg6BgcCdfLGcxRaTSjSyctcGuq2/CJXdlLwUUJkHUgDBlD
         ImwH2cZASBsi7OSx25V9ctCbGjSJsDSOUDkDRKlPJUbqEauNxuYgCI2/koZNKoyVgJxn
         44TyutfoaEgo7Gr84L5oVZ6cecud3Lk/8gTjqMJ2lKAPR+KYrTaIPwRUeeTL2wKb+Vkq
         u0Qw==
X-Gm-Message-State: AKwxytdccEvB6AbRuXhyy2cSvnJuhnXIC2MtL8yn/Kyw2I0FGPdrkhBI
        W7Hhm4ObSosBULIiMVyCAeIZ18Xj+dte6cuR5kwNkA==
X-Google-Smtp-Source: ACJfBou2K+95KPxsox0/zU2Ba5y+7sd0+tsIjUkzlS0bo9giWiwuuGydX7DQfah5Z4C5yuoNFIjuoyb9ZMiXnrST8xQ=
X-Received: by 10.55.41.40 with SMTP id p40mr19309459qkh.133.1515525918217;
 Tue, 09 Jan 2018 11:25:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 9 Jan 2018 11:25:17 -0800 (PST)
In-Reply-To: <20180109175703.4793-1-pc44800@gmail.com>
References: <20180109175703.4793-1-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Jan 2018 11:25:17 -0800
Message-ID: <CAGZ79kZs9fNOZ0wCahRrwRn8k3rHOAXCchyLmb0AaC_qCNFx4A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Incremental rewrite of git-submodules
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 9:57 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> The patches [1] and [2] concerning the porting of submodule
> subcommands: sync and deinit were updated in accoudance with
> the changes made in one of such similar portings made earlier
> for submodule subcommand status[3]. Following are the changes
> made:
>
> * It was observed that the number of params increased a lot due to flags
>   like quiet, recursive, cached, etc, and keeping in mind the future
>   subcommand's ported functions as well, a single unsigned int called
>   flags was introduced to store all of these flags, instead of having
>   parameter for each one.
>
> * To accomodate the possiblity of a direct call to the functions
>   deinit_submodule() and sync_submodule(), callback functions were
>   introduced.
>
> As before you can find this series at:
> https://github.com/pratham-pc/git/commits/patch-series-2
>
> And its build report is available at:
> https://travis-ci.org/pratham-pc/git/builds/
> Branch: patch-series-2
> Build #195

Cool!

I have reviewed both patches and found them good to apply;

Thanks,
Stefan
