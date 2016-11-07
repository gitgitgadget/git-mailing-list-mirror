Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E252022C
	for <e@80x24.org>; Mon,  7 Nov 2016 09:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbcKGJmm (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 04:42:42 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:35624 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbcKGJmk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 04:42:40 -0500
Received: by mail-it0-f43.google.com with SMTP id e187so88110527itc.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 01:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9ZEVVhwpU81LcbLwnBU5Xt9JpdtPgJwFc16kPTtlhmY=;
        b=GpdvV265H0G9iEbcZKiB1XIaVqstG4ZTqJ+NVEMvW5QQpbjW4nGRexe8o6dnVi/Qe2
         1ZfXHV2q5cmwgRNujdMzP4fVdW85qlyNe6ZJItK4CncM8iL85YnL+YGZ93AI5zL5R4pq
         miYzcdjVQk0QcptN/+RPjnloGwPETjeDo1qyvGDWtAntuKsPEULr8GCUXpV2TMLR0aG3
         HU6+FWFg9x+iWMfSCD5WdP2pD901Nc8kx2FUByiC6eJJUmbJaGoVKjN1qLXRy4fBbv9O
         fLqsHN2C4u7VQevXOzDK4qobpZsBzLoyA67d8ZAMl8WqwHhSYPwXw62qhsduPpbqpUwm
         OTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9ZEVVhwpU81LcbLwnBU5Xt9JpdtPgJwFc16kPTtlhmY=;
        b=foLn6ASoFaydSuCS1RYRRcd1DHVI8Qhi23iLcQTsh6zYPhEYsTTmL0HvUf3eLGOihv
         Et3e2tDmX2kD43FjuaAphyT2cj90gBTMNJ8S6fDHId5npZcrGXitLn5gBNKlCdUlEZva
         7feES9gMym5niXd4I9QYW3s8sjNFjdWzUu06TTblB/NNp2MS3KAVVac7OEMDKoIhZybo
         SfwI5dR53Vboqhzh3ntBBbXm83A6t40pNiinIMR5v0bK8/ok90H/E2jlw/YzC2EIa4v8
         RjZKfi9Dc7bocA/qIVP/8Ij4MRB/9viy1D5V4B1AhvbvKzAye1ewuobA3mMYrlXif0uR
         UA/w==
X-Gm-Message-State: ABUngvcmxeBYbmX/ZNNPbg2driglvKxHAx7jZsyTylV+ImXEVSklv1V9tK7MinJFqnTVsKPWSnyHm5SyO4KplA==
X-Received: by 10.36.67.8 with SMTP id s8mr6147715itb.50.1478511754805; Mon,
 07 Nov 2016 01:42:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Mon, 7 Nov 2016 01:42:04 -0800 (PST)
In-Reply-To: <20161107011841.vy2qfnbefidd2sjf@x>
References: <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
 <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
 <20161105151836.wztypzrdywyltvrc@x> <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
 <20161105202553.migx75gfuujakqyk@x> <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
 <20161106163410.ilysej5r6qd3744e@x> <xmqqshr4cyy7.fsf@gitster.mtv.corp.google.com>
 <20161106173311.lqoxxgcklx4jlrg7@x> <CA+P7+xoxjwvjXrW0Pwh7ZK-OYBiYamPAxvf_=zqJOsQ8xWDPWw@mail.gmail.com>
 <20161107011841.vy2qfnbefidd2sjf@x>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 7 Nov 2016 16:42:04 +0700
Message-ID: <CACsJy8BDySBWyp3iiLinRkBCew5FNXoQo7z9dMb6w6m9a5X=NA@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2016 at 8:18 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> Once we have gitrefs, you have both alternatives: reachable (gitref) or
> not reachable (gitlink).
>
> However, if you want some way to mark reachable objects as not
> reachable, such as for a sparse checkout, external large-object storage,
> or similar, then you can use a single unified mechanism for that whether
> working with gitrefs, trees, or blobs.

How? Whether an object reachable or not is baked in the definition (of
either gitlink or gitref). I don't think you can have a "maybe
reachable" type then rely on an external source to determine
reachability,
-- 
Duy
