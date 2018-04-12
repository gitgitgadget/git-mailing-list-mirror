Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9C81F424
	for <e@80x24.org>; Thu, 12 Apr 2018 08:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeDLIeX (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 04:34:23 -0400
Received: from mail.javad.com ([54.86.164.124]:52204 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbeDLIeW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 04:34:22 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 4FAF23FEBC;
        Thu, 12 Apr 2018 08:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523522061;
        bh=Am9H7KKzOh5+3yIr2u0WESdrlZhpddYLw3qmo0WkdHA=; l=800;
        h=Received:From:To:Subject;
        b=UmtY8CAFgawk9c87BdW9vYlRx0VvNfl+DNsa8wCq7v6UUFLLP1Mm5/UI6JkROi+/a
         AO6AFzmC7y+9Jczuan/a51T4Wt/HbJTRjq7oJ90hwJzt8PQm6i5glSb7dgI1ZR/4eQ
         M11hmyQu3223jkpgKnADGvR+JrtuPVbfBvwVgvy8=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f6XgQ-0001O1-V4; Thu, 12 Apr 2018 11:34:19 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <87tvsj6rn2.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <871sfm737e.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87h8oh51jm.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804112233470.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 12 Apr 2018 11:34:18 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1804112233470.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 11 Apr 2018 22:40:51 +0200
        (DST)")
Message-ID: <87in8w2585.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Sergey,
>
> On Wed, 11 Apr 2018, Sergey Organov wrote:
>
>> The RFC v2 and Phillip's strategy are essentially the same, as has been
>> already shown multiple times, both theoretically and by testing.
>
> No, they are not.

It's off-topic here. If you _really_ want to discuss it further, you are
still welcome to come back to where you ran away from and continue:

https://public-inbox.org/git/87po3oddl1.fsf@javad.com/

Abrupt change of the topic of discussion indicates your intention to
take attention off the apparent ugliness of 

git rebase --rebase-merges

I also get it as an indication that there are no more arguments in favor
of --rebase-merges on your side, at least for now.

-- Sergey
