Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9B720209
	for <e@80x24.org>; Thu, 25 May 2017 03:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941559AbdEYDmR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 23:42:17 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36274 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941556AbdEYDmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 23:42:16 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so154236365pfg.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 20:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bl4MdJVewi+4Z0oLWuuMojuOdtgqNw4AIg58K8TctrY=;
        b=pw7i/b1tRsc4bStgpq2Af5T570xKYJjEgt3E0zmtuJdtmDXZaEf1xTP5gEh80eNenX
         R6Zzxo2zJgQK9eKffggdWvWZ1TftPFdNSvYLp7Ec4l4KXlKG7+jI+TLvqMqwELas704x
         joIFlBswU512YSibsLMrdCU8SfCnMhosslGgxlu2oKprAJevR6vdpMY9hCFZ/1xLgBxQ
         0V3mpokmVPrv8TolGy4a/iJBEbrQiGGU4nU2Xgo0qSnpGF3IkHJzmPgk6mH3KJjuS9JV
         HJA95oyCHFavy4k4mkLN9eewPAkwbJNrBEUPL8Zg1VL3ZDWI0IcmuliAVOzo/qo8cwFl
         7Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bl4MdJVewi+4Z0oLWuuMojuOdtgqNw4AIg58K8TctrY=;
        b=oP46iSApnbSgkKhRhrKHOX7u2BLEy8Crd1YpPWC44104mIRFXbEM59HdY9C8D001jy
         wqZdolHdmVhJsAN3oOta7zOQhoKAmYyI+JCsOek1WcGoccRK1uvifK/L5PS4msZ8Yq+3
         ZFosGjXcSw4Mq/03LSwbBC7xqi2N5VttqlI/Ad44NVnMSpAvQfxROBP8IencGD4KVqw+
         nzwEd4e7dAGUoQWbhxCVFARUJ3NB9kJrSXBbvUj98MSeuOiiG9cgOUmZhHPTBp898xTR
         5BuOuf70CO8Rh6QF50wEBGvGwc2rP3ctvxeLFwSO122wbqhKAwHgeLTh3XHa7Hd48MYa
         I+NQ==
X-Gm-Message-State: AODbwcBKacCHXBVoEM9K7CgyhHoP9ZJFtwxLyDAizHqG97oKxPpEzVwL
        GfMxdBW4ADGvGA==
X-Received: by 10.84.238.200 with SMTP id l8mr46712477pln.85.1495683735930;
        Wed, 24 May 2017 20:42:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id 3sm8162389pgb.22.2017.05.24.20.42.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 20:42:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2017, #07; Tue, 23)
References: <xmqqwp98j8q2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZMJP7K5MU0UujuEatZ2MOrSnFpfD707aSGa64mKyCZbw@mail.gmail.com>
        <CAGZ79kYoHYz6hi5kDjQBcN-35c0kXE6mf6NNV_Z_F6-UqZ=3cw@mail.gmail.com>
        <CACBZZX4adLy6Xumicu3Qke=g39EEe3iBa5ShsGvTBAYFqXENPg@mail.gmail.com>
Date:   Thu, 25 May 2017 12:42:12 +0900
In-Reply-To: <CACBZZX4adLy6Xumicu3Qke=g39EEe3iBa5ShsGvTBAYFqXENPg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 23 May
 2017 21:50:37
        +0200")
Message-ID: <xmqq60gpfvqj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> The tests added by grep rely on the old content of
>> test 2 'grep correctly finds patterns in a submodule'.
>
> Sorry about the fallout.
>
>> The (whitespace broken) diff below fixes it.

Ah, then, this was an example of maintainer not doing a good job.
When I see a topic that pass its own test that fails when merged to
'pu', I usually try to see where it goes wrong myself and come up
with a fix in an evil merge, but this time I didn't have enough time
to do so before sending out the "What's cooking" report.

Here is what I taught my merge-fix machinery to apply after
mechanical merge of the two topics.

 t/t7814-grep-recurse-submodules.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 14eeb54b4b..7184113b9b 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -36,18 +36,18 @@ test_expect_success 'grep correctly finds patterns in a submodule' '
 test_expect_success 'grep finds patterns in a submodule via config' '
 	test_config submodule.recurse true &&
 	# expect from previous test
-	git grep -e "bar" >actual &&
+	git grep -e "(3|4)" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep --no-recurse-submodules overrides config' '
 	test_config submodule.recurse true &&
 	cat >expect <<-\EOF &&
-	a:foobar
-	b/b:bar
+	a:(1|2)d(3|4)
+	b/b:(3|4)
 	EOF
 
-	git grep -e "bar" --no-recurse-submodules >actual &&
+	git grep -e "(3|4)" --no-recurse-submodules >actual &&
 	test_cmp expect actual
 '
 
-- 
2.13.0-491-g71cfeddc25

