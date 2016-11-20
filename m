Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A452022D
	for <e@80x24.org>; Sun, 20 Nov 2016 18:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbcKTSnP (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 13:43:15 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36129 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbcKTSnO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 13:43:14 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so20970785wma.3
        for <git@vger.kernel.org>; Sun, 20 Nov 2016 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4aQNBCK7ofHRMeq+9WW3Rxy6DmhkT0Owcxr65C5I7e8=;
        b=jHFMMfS740MTe60djjhE7LOVpRZx8lnczcWSxXa4KdpNJSUa5p8Z11IWguMQcuD9Pv
         V0f2lwZWC6zTxWbOUjVlGpbC/l3jZlrUcMNX49Lr+htviARh+/GXtuxlDs3/N8foi8i7
         +x039lH5CXbO5HoxvhKiRebPJXyb3ExiAMDcGk+prT+i06PpYm/QcBJdezZqBIf+zJ9C
         PM3WekGdFDGTv56iEy2F2O8wH70cvRm8I9RWF+cnSKas01fftBF5jlWZXf88GIgnKFja
         sj/XrP/CDxVCHLnBsyVK4l8HkLWpiTgsDNgBxQh0AN0IfhpJ9esW39Sqq5Qk44V7R29P
         DI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4aQNBCK7ofHRMeq+9WW3Rxy6DmhkT0Owcxr65C5I7e8=;
        b=XuztG/c1iw0HphTt9ysW10PSKMqc0ArL3uJkku7eky4lRP4zBDQTOXA7ov9YM2D0Jh
         Sz2vstaXQa5Htu3mSdNqFoEbj9OhFBz0V6zFR1+UBLpmOjFVwgfYo1THUdUTypT3HThN
         x0H1MKhF85pm9NaxmHjqKxNiXe21Jh80TAMcsGTrE4PHA2MmlKeZ/qhzwXebYKClKOmS
         lrpc6XUrbMcTwG6q+UKtKqB5rCd5f40ZSJToOIzAlRiuBT9af2skRU7TEBuVFntFzH55
         5h5NxRxnuXFvMD394qeXVjJSCD4br/ksmj9XbFJLjVxYsqJMuZbahFBhuc+W5iDT5CFx
         q7zw==
X-Gm-Message-State: AKaTC02Y2FK14GAbogopzKOwxI+jprt8/R/dOFTs8If5auE2ZBiudCZzSs2eAMWjIbKH9Q==
X-Received: by 10.28.232.85 with SMTP id f82mr8879142wmh.127.1479667392576;
        Sun, 20 Nov 2016 10:43:12 -0800 (PST)
Received: from [192.168.1.26] (enp240.neoplus.adsl.tpnet.pl. [83.20.5.240])
        by smtp.googlemail.com with ESMTPSA id t84sm15159099wmt.7.2016.11.20.10.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Nov 2016 10:43:11 -0800 (PST)
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
 <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
 <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
 <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
 <20d067ef-9e2c-0d1f-f81a-06c154e95e4f@gmail.com>
 <CAOLa=ZRf+vPOPK=ovP7JmJ52qdgwuqkpGH4UfP=+caQeyu9Ucw@mail.gmail.com>
 <xmqq4m32kqet.fsf@gitster.mtv.corp.google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <51aea3cf-eaba-f909-faa0-00d3998c0d6c@gmail.com>
Date:   Sun, 20 Nov 2016 19:43:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq4m32kqet.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.11.2016 o 18:32, Junio C Hamano pisze:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
>> We could have lstrip and rstrip as you suggested and perhaps make
>> it work together too. But I see this going off the scope of this
>> series. Maybe I'll follow up with another series introducing these
>> features. Since we can currently make do with 'strip=2' I'll drop
>> this patch from v8 of this series and pursue this idea after this.
> 
> My primary point was that if we know we want to add "rstrip" later
> and still decide not to add it right now, it is OK, but we will
> regret it if we named the one we are going to add right now "strip".
> That will mean that future users, when "rstrip" is introduced, will
> end up having to choose between "strip" and "rstrip" (as opposed to
> "lstrip" and "rstrip"), wondering why left-variant is more important
> and named without left/right prefix.

Another solution would be to implement 'splice=<offset>[,<length>]',
where if length is omitted it means to the end; perhaps with special
casing (as in Perl) of negative <offset> and/or negative <length>.

Or implement POSIX shell expansion:

  %(parameter%word)  - Remove Smallest Suffix Glob Pattern.
  %(parameter%%word) - Remove Largest Suffix Glob Pattern.
  %(parameter#word)  - Remove Smallest Prefix Pattern.
  %(parameter##word) - Remove Largest Prefix Pattern.

Though this one looks like serious overkill...

-- 
Jakub Narębski

