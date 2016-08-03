Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7C11F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbcHCVsX (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:48:23 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36620 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758401AbcHCVsE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 17:48:04 -0400
Received: by mail-wm0-f43.google.com with SMTP id q128so464256505wma.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 14:48:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MRBMlbytUXtGrGUM9ELtZTn6nyVveF96Aew9S5iDrQg=;
        b=R+ETW4zuZX269PLKRMfzxG+Zduya+8A328DQbPMyjIDGe/IAEvW66vNE0UrwofRHME
         K/ihFJ8M8L3Lbvk81wWML5olgcI6T5lYOcItJIljq6GEnF3FCdOhyzWU3qVBIpFux75P
         +3Hk0NgqnsBo8y+tJ+PjB0QL5smngxGcYeqHkyEhURqCybG3dOPstRJunRUfHSi0GGGm
         w+/JdAdDoy824W8VT626lvRkdpCNXCwDQt9xu1uvV3j8wVZPNmsLYxI+Py8xoU1X9MPy
         gaC7G0YFHxCfpscb9Pmq4xFSeC7HOEr8lrwg5M79lbeO76EAd7UecKI320Q2EryCy5BV
         evUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MRBMlbytUXtGrGUM9ELtZTn6nyVveF96Aew9S5iDrQg=;
        b=Uk/QFI1MOg8p5iPQaYzAxRN9uLd1kd+g/gGNwYS1eVpewLJIiE438Bfz+HUiTLpqkB
         BfDKCiljTdl76RUVeiuHABwpDYzgk9FVKPwNTrNdxULwvthLtSp7wtvX2h1NBjTRtq+2
         BKd6MKzkFmtUwOkBovwdF0dgN1jyQ6YQvgJc7luZmG6TIpEZjzYtvauuK5rDTgu4SG5j
         68SnaoI/7X80VHbnxK9thtvvxSyrbxqENS0kIfTGv5vngGLR6rvHCIcRBeGFpznjpJfz
         yc7A1UDf+2VKcjNZQ/qXookEX+5NlFWxYMn0KlL3inaN8l/s+BHtdtx8Zx/4xNfMfLu4
         0VCw==
X-Gm-Message-State: AEkoousuyjFV2D4zkrE6VbyLazInXg1W4cX8+mOZq9Oc8R371Ph52IOtpI8kqjhDZ0+kJA==
X-Received: by 10.28.35.86 with SMTP id j83mr65727307wmj.18.1470260882695;
        Wed, 03 Aug 2016 14:48:02 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB674A.dip0.t-ipconnect.de. [93.219.103.74])
        by smtp.gmail.com with ESMTPSA id v189sm386198wmv.12.2016.08.03.14.48.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 14:48:02 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqtwf19263.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 3 Aug 2016 23:48:00 +0200
Cc:	git@vger.kernel.org, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <0E3FC781-1B2C-4341-9B7B-D9D836596A35@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-12-larsxschneider@gmail.com> <xmqqtwf19263.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 19:45, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> packet:          git< git-filter-protocol\n
>> packet:          git< version=2\n
>> packet:          git< capabilities=clean smudge\n
> 
> During the discussion on the future of pack-protocol, it was pointed
> out that having to shove all capabilities on a single line/packet
> was one of the things we would want to fix in the current protocol
> when we revamp to v2.  As this exhange between the convert machinery
> and an external process is a brand new one, I do not think you want
> to mimic the limitation in the current pack protocol like this; the
> limitation mostly came from the constraint that we cannot break
> existing pack protocol clients and servers before we extended the
> protocol to add capabilities.
> 
> You may not foresee that the caps won't grow very long beyond
> clean/smudge right now, just like we did not foresee that we would
> wish to be able to convey a lot longer capability values to the
> other side when we added the capability exchange to the pack
> protocol, so "but but but we will never have that many" is not a
> good counter-argument.

OK. Is this the v2 discussion you are referring to?
http://public-inbox.org/git/1461972887-22100-1-git-send-email-sbeller%40google.com/

What format do you suggest?

packet:          git< git-filter-protocol\n
packet:          git< version=2\n
packet:          git< capability=clean\n
packet:          git< capability=smudge\n
packet:          git< 0000

or

packet:          git< git-filter-protocol\n
packet:          git< version=2\n
packet:          git< capability\n
packet:          git< clean\n
packet:          git< smudge\n
packet:          git< 0000

or  ... ?

I would prefer the first one, I think.

- Lars