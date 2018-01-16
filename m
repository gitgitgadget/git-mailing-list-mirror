Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEEEC1F406
	for <e@80x24.org>; Tue, 16 Jan 2018 07:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbeAPHXh (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 02:23:37 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:40901 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeAPHXh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 02:23:37 -0500
Received: by mail-io0-f195.google.com with SMTP id t22so3545711ioa.7
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 23:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vn5b8zJKtspco+7K1/aTY6jEl/MG5n2geohfAiCgZbM=;
        b=VZThNP16IKP1+rA4gm1tdAeFvjxOJj+7c1B+YE0wxuCgSkqzKQZvjcVtaQ01A0vp5f
         d66+6kteDqxtkxP+1QyGXKqNd7FnalNBnS0BwTGWuXOl52WHaogqegatcMcVuGeH06be
         TKZEPvoKHAOtJIGkp7UEzbKpMOWblkSYmRjJ0o9cZrZPa4xVtbs8Fw1HH1dguyGQ7Zqr
         6fUzApHfiqYYMyHqFjWIFCA5pBeOPmZIoPIDdSR3Lo9U2ok1sAWhApNfjH1p3kAuT+CD
         zIeJKCfB/ymYrXUM6Hqe1/+Of0DkRxqvPZ/yVGqu6wMb45ZTsM4vjhL/BQzqG1q15hZf
         ezqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vn5b8zJKtspco+7K1/aTY6jEl/MG5n2geohfAiCgZbM=;
        b=r6BuTmL70RzX98uhIcqtOfzjJmMDc0bfvvc7QwqfzIsh/S2ib5mrkmWB8ghwb37P+j
         BbiC5I4LDlqytZTGndPGunMZTvauygBnktYCfgfme9uaz3SFZZkOeI/sduJT9u1QFiLA
         9f90pYT8z364Q1QReGU7s5WnBbjRJNFYs9o8HTcwQuGSYjRFIQCQpP1r7tsashWf5NwG
         g1OiK8QvSKxKX3lnHV0so1DEp9bB4qFRBDQqvghmrCYR16rjgi73Ibm992gA66AlroJB
         ZMBPiAH+dShn9HckNeP1reLuu/jHNZhqDui54NrPwsp7eP6F6m4ONnfwVsnnA10HFPO1
         3Plg==
X-Gm-Message-State: AKwxytdWM426F896+eqOlIJKRnRXZ1wd+l2XLRongiEveaaIUXqDs/1Z
        SicreVyl75PVebQNoUU0OT/CISi6MjVbvtSI2JU=
X-Google-Smtp-Source: ACJfBousIQOeLnMor5O9WDnPtjrRXIkh9fIuYTcuYRqxJZZxYURG5kADSZ5jbIUYTOt9lPRPqmQfDpKUEL67OThMkZU=
X-Received: by 10.107.3.209 with SMTP id e78mr18548716ioi.96.1516087416418;
 Mon, 15 Jan 2018 23:23:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Mon, 15 Jan 2018 23:23:35 -0800 (PST)
In-Reply-To: <33af3206-b15d-3b01-e121-796cd31eb743@jeffhostetler.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-15-chriscool@tuxfamily.org> <33af3206-b15d-3b01-e121-796cd31eb743@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 16 Jan 2018 08:23:35 +0100
Message-ID: <CAP8UFD0wOo56dtqzhY8CHw=0+miQ1fPaJZJiTtLatgf_gmrQUw@mail.gmail.com>
Subject: Re: [PATCH 14/40] sha1_file: prepare for external odbs
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 4, 2018 at 7:00 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 1/3/2018 11:33 AM, Christian Couder wrote:

>> diff --git a/sha1_file.c b/sha1_file.c
>> index 261baf800f..785e8dda03 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -322,17 +322,22 @@ static void fill_sha1_path(struct strbuf *buf, const
>> unsigned char *sha1)
>>         }
>>   }
>>   -const char *sha1_file_name(const unsigned char *sha1)
>> +const char *sha1_file_name_alt(const char *objdir, const unsigned char
>> *sha1)
>>   {
>>         static struct strbuf buf = STRBUF_INIT;
>
> While we are refactoring sha1_file_name() and adding
> sha1_file_name_alt(), could we also change the API and
> pass in the strbuf so we can get rid of the static buffer?
> Granted, it is a little off topic, but it will help out
> in the long run.

Ok, but I prefer to do that in a separate patch series, so I just sent:

https://public-inbox.org/git/20180116071814.19884-1-chriscool@tuxfamily.org

>> @@ -1551,7 +1562,7 @@ static inline int directory_size(const char
>> *filename)
>>    * We want to avoid cross-directory filename renames, because those
>>    * can have problems on various filesystems (FAT, NFS, Coda).
>>    */
>> -static int create_tmpfile(struct strbuf *tmp, const char *filename)
>> +int create_object_tmpfile(struct strbuf *tmp, const char *filename)
>>   {
>>         int fd, dirlen = directory_size(filename);
>>   @@ -1591,7 +1602,7 @@ static int write_loose_object(const unsigned char
>> *sha1, char *hdr, int hdrlen,
>>         static struct strbuf tmp_file = STRBUF_INIT;
>
> Same thing here, since we are renaming the function anyway, could we
> add a strbuf arg and get rid of the static one?

I will see how it goes with the above patch to remove the static
buffer in sha1_file_name() before preparing a patch to remove the
static buffer in create_tmpfile().

Thanks,
Christian.
