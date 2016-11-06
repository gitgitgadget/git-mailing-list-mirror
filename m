Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9E92022C
	for <e@80x24.org>; Sun,  6 Nov 2016 04:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbcKFEu3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 00:50:29 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34552 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbcKFEu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 00:50:28 -0400
Received: by mail-yb0-f175.google.com with SMTP id d59so7611684ybi.1
        for <git@vger.kernel.org>; Sat, 05 Nov 2016 21:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pn7LqZW0huaT5IAOOrsLZswFmbvQ5wRen79bCaVlKoQ=;
        b=dNn4ga2fNkQCi2JX6uPt0xMKOB7sKDBFQIwma98BjfE7r580l/E6PU52bV7n3XgmCQ
         NuZsDwVOPUJVXCVM9zYW0JFB2enEVwdizFj0Z2eBDlDmfmsyINFfwY9HTi8MchB/ZJPf
         nG79/WD+6SfzvqTQMv3kqg8i22JI3T8aHscr5eIAgXrBZjgVfHOnMGRQ2Qpfr+7y7Q1z
         BT7fC22LoYQxdLzY7VbTlqsjN0B6KSFjNonhYLK11EyfJCRh5u6aQy9g5fW8WDqqk2Wr
         AZBnJf8eEjplrGdKUD5lSPBTTNFnrgFvBlByOXGmpgIXbcowbsimPKbGwtc3e2Y0XRvU
         20ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pn7LqZW0huaT5IAOOrsLZswFmbvQ5wRen79bCaVlKoQ=;
        b=KfSSlQ7vjy9y4ay/M2uOrXXUCJMbH8R+a7A6eas7WhfKJ07qdHuWzCAPLy4I08X5Ja
         A/NPpPyNzZnpkx5NzaZBjroi8dgnVNkYlccQf0K4onHigpON4edBk30Rc3FISB6w8mFg
         P4rr5ZGiFg7vCWJsf/kOFHnF1bS0LfSuASz/nTCmQPNgQGp7SjGZs2Dj2cENU7X5veDO
         desLjOC7O6eVp/JUEgbIqps3JMXVfhhfKDTLME+UJQYXMJ/FIDrU7o6VMc1YL65xMbTd
         wTtJjH7kSHHVb+Eh5hFKolzv42fSKSFA/wfbt1mXAiWVU6lhGt80Bqigfjj2MmhLs0l5
         0peg==
X-Gm-Message-State: ABUngvfBFvpJ6IX+vkpCWit7qUKcO9+OfZngXuGqtiUdeTh9JLy2CQ8Q0e/dWnkOzi2Vj+pkSVjlUaMb0M7rzQ==
X-Received: by 10.37.161.198 with SMTP id a64mr681714ybi.72.1478407827466;
 Sat, 05 Nov 2016 21:50:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Sat, 5 Nov 2016 21:50:07 -0700 (PDT)
In-Reply-To: <20161105202553.migx75gfuujakqyk@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com> <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com> <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
 <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
 <20161105151836.wztypzrdywyltvrc@x> <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
 <20161105202553.migx75gfuujakqyk@x>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 5 Nov 2016 21:50:07 -0700
Message-ID: <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 5, 2016 at 1:25 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Sat, Nov 05, 2016 at 09:21:58PM +0100, Christian Couder wrote:
>> On Sat, Nov 5, 2016 at 4:18 PM, Josh Triplett <josh@joshtriplett.org> wrote:
>> > On Sat, Nov 05, 2016 at 01:45:27PM +0100, Christian Couder wrote:
>> >> And with what Peff says above it looks like we will need ways
>> >> configure and tweak commit reachability with gitlink/gitref anyway. So
>> >> the point of gitref compared to gitlink would be that they just have a
>> >> different reachability by default. But couldn't that be replaced by a
>> >> default rule saying that when a gitlink is reached "this way or that
>> >> way" then the commit reachability should be enforced, and otherwise it
>> >> should not be?
>> >
>> > Any version of git unaware of that rule, though, would consider objects
>> > only reachable by gitlink as unreachable and delete them, causing data
>> > loss.  Likewise for a server not aware of that rule.  And a server
>> > unaware of that rule would not supply those objects to a client pulling
>> > such a branch.
>>
>> Yeah, so you would really need an up-to-date server and client to
>> store the git-series data.
>> But anyway if we create a gitref object, you would also need
>> up-to-date servers and clients to make it work.
>
> Agreed, but gitrefs have the advantage of failing safe, rather than
> failing with dataloss.
>
> - Josh Triplett

Isn't the "failing safe" only true if the client disconnects when a
server doesn't advertise "i understand gitrefs"? So couldn't we, as
part of the rules for reachability advertise a capability that does a
similar thing and fails safe as well?

Thanks.
Jake
