Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F5720A21
	for <e@80x24.org>; Sat, 16 Sep 2017 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbdIPKmB (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 06:42:01 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:45347 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdIPKmA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 06:42:00 -0400
Received: by mail-wm0-f48.google.com with SMTP id g206so13160511wme.0
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cl6YqFZ2CWtw2LJ0raesWCfWjuRl9CRNvFA93p5Zzgs=;
        b=Nn1tx8pg4+nxM0ceAVYp+yJLrvHABndgCVvaBmBnkhAvZ5a4dcS1aYtbyDkZGu7RRY
         tmKMdbSxeygQTdZqtLdSBt2EzMp3NdKQRS8YtuUTSY/azoLUtOPEI5G7Kk6DDd+Bbbbm
         vzfRcgBBbcAJRI61AMS552vj9r/upie9x5PL7+cKF86S298SAYJIu2BQ5jLyFJFhNFtc
         jZhKQNk7K2Ekjesckdfbgzt+uT3So02bwP9lA1znBVTL3ZJzQKbL9PI492l+mnctojRT
         r7y+8pNKZtv7MiNCY62zF/LUktHSWDICJKnQrQFf5Pd38o4h834vDPFLbbsdpePc/RKz
         gAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cl6YqFZ2CWtw2LJ0raesWCfWjuRl9CRNvFA93p5Zzgs=;
        b=V5A5DVFUsf/+jfdyCNCfCnF7VrDedmtifm1MqtB6bDhnKfhrP/7XjZMK+Z/tl4Mvxc
         Zm40Hwk43Updvtdp82rDD7nfWdo3eXUnn/PR6qhvwg9xannwWifTXuOIP3VzdR+I5OAa
         9fJ3w5DN0cg/iVmzqM8pSIM3B+dbmvmJrp/H2cooZTJ9e5kToqZBDoJ+NAFp3NbNNt6r
         dU4bzb/HsHvgUSKwT/4QGUeV/ohCOeuMaLv0fPFXkBTDmxRhk2a5YQDqjUlNawXKr5lv
         LDK05vQPEUOB0yVFxv9/UNBEHOhEvVUVizyoXc57XpPZq+MIQnYBUmSpR95LpHLldT/O
         bvDQ==
X-Gm-Message-State: AHPjjUj3NnfPJPfAQYWsD08U+sRvIuN5sxGaqfWko74g0gX3yF++Q06S
        S8mBW78mLpDq8YEwxiKWeEKvTQ==
X-Google-Smtp-Source: AOwi7QBOluwJuZ/axhqECW/wW41ZwSv/+YerlP9XYe0LLvkYA52pFqvQtl6MiI9HVvLKAo49GIbItA==
X-Received: by 10.28.212.140 with SMTP id l134mr4694255wmg.1.1505558518367;
        Sat, 16 Sep 2017 03:41:58 -0700 (PDT)
Received: from ?IPv6:2001:a61:3402:1b00:2003:73d8:ae4c:c1fd? ([2001:a61:3402:1b00:2003:73d8:ae4c:c1fd])
        by smtp.googlemail.com with ESMTPSA id k9sm3468240wrk.27.2017.09.16.03.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Sep 2017 03:41:56 -0700 (PDT)
Subject: Re: Commit dropped when swapping commits with rebase -i -p
To:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <oo62vr$pvq$1@blaine.gmane.org>
 <CAN0heSqGfxrFTwuaxgppZTx+3U=g_Qs4PyaCBF6ddV_PbvdpTQ@mail.gmail.com>
 <CAHGBnuMC_10krsdZe2KiQ4jjiL43kogn--dWjPgca_p2xgmQMA@mail.gmail.com>
 <20170902000417.GE143138@aiede.mtv.corp.google.com>
 <a47058cc-8ffc-4484-c247-3c8d4f827c07@gmail.com>
 <xmqqbmmbwuq0.fsf@gitster.mtv.corp.google.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <9e004c75-bc35-06ae-8479-9440059c4d0f@gmail.com>
Date:   Sat, 16 Sep 2017 12:41:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmmbwuq0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.09.2017 um 22:52 schrieb Junio C Hamano:
> Sebastian Schuberth <sschuberth@gmail.com> writes:
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 6805a74aec..ccd0a04d54 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -782,10 +782,11 @@ case" recovery too!
>>  
>>  BUGS
>>  ----
>> -The todo list presented by `--preserve-merges --interactive` does not
>> -represent the topology of the revision graph.  Editing commits and
>> -rewording their commit messages should work fine, but attempts to
>> -reorder commits tend to produce counterintuitive results.
>> +Be careful when combining the `-i` / `--interactive` and `-p` /

"Be careful" is not necessary because the text is already in the "BUGS"
section.

>> +`--preserve-merges` options.  Reordering commits will drop commits from the
>> +main line. This is because the todo list does not represent the topology of the
>> +revision graph in this case.  However, editing commits and rewording their
>> +commit messages 'should' work fine.
>>  
>>  For example, an attempt to rearrange
>>  ------------
> 
> 
> Anybody?  I personally feel that the updated text is not all that
> stronger but it is clearer by clarifying what "counterintuitive
> results" actually mean, but I am not the target audience this
> paragraph is trying to help, nor I am the one who is making excuse
> for a known bug, so...
> 

For me the proposed wording implies that the only bad effect are dropped
commits on the mainline. But I experienced something like this:


O--O--O--O---M--O        ==>   O--O--O--O---M--O
 \          /                   \          /
  O--X--O--O                     O--X     O


Where X was a commit without a ref and hence lost. Also the merge commit
seemed to combine two unrelated histories.

Therefore I would avoid "definitive wording" like "will drop" and use
vague wording along "there are various dragons out there" like this:

    The todo list presented by `--preserve-merges --interactive` does
    not represent the topology of the revision graph.  Editing
    commits and rewording their commit messages should work fine.
    But reordering, combining or dropping commits of a complex topology
    can produce unexpected and useless results like missing commits,
    wrong merges, merges combining two unrelated histories and
    similar things.

