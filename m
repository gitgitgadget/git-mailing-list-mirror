From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/6] t/t7030-verify-tag.sh: Adds validation for
 multiple tags
Date: Mon, 4 Apr 2016 23:51:38 -0400
Message-ID: <CAPig+cTkQn45ax5pEGghj6_c=FKwP=ApxRo85Jyyu1UD28FrJA@mail.gmail.com>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
	<1459808535-8895-3-git-send-email-santiago@nyu.edu>
	<CAPig+cQJ6EzJ0976NJBHXRZyuTf1dr+0ZOvzrCfiTVZOp6fXBA@mail.gmail.com>
	<20160405014609.GB12006@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Apr 05 05:51:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anI1o-0003M6-Se
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 05:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbcDEDvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 23:51:40 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33619 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbcDEDvj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 23:51:39 -0400
Received: by mail-io0-f194.google.com with SMTP id g185so549431ioa.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=KssjDxj+UMRLC6HXxVeiVNF4bExj77mDAm0AyoVpDQA=;
        b=c5m5UBVmHxFtkuNWlmREbZy5rfSZPK2j55+2/RJ2CwURii9P2tknZROnuOMxz8LiKT
         CvXr6fxLZHMQNLBmTXnLDY4YilihDmXYDm755BBDehs++WaACAdpqnc0rhs1Kj809qbc
         QpAA7ABJfZsS3OAtm2VYZAnwll9S+9IwSTtkEGVzJcNRCk1oXu0ZUNZbyVYPo5qquYQI
         RRVjPWTz6oNig97hmxyzn9HrfKTbntAYo/6ZlyawAI5h8SNMqP0xdF7qeWga1ix1umXD
         n1FrgiiHVriByNh98CxNq1LEyWePjsfpDLxOcpMflZ3Q+TDfeuJUz2PQL+ZrsFwI41FV
         LK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=KssjDxj+UMRLC6HXxVeiVNF4bExj77mDAm0AyoVpDQA=;
        b=Q8/0MQYBTK57yR+M2xB8Bn1sO3RrkV+yZhDbWd47UJ+OYGZVPbD4iqxT8v5B8WxTf9
         zj1EwSsXxrYC2iyCUly+13h2Fc1/OVJ6LGCW+yjNUaGApLgdfGHtznnGHQVSP7VxIUJh
         c1YQSUdDrzNgORRupfsUz6fJjE5SdyVOjCSfVp5T3Bm5BDJmlTSqLPiJ1FPl/EY0nXTd
         2cqMUyaTfFIKso02ihEjubkR4sDce/ianZx/8Rhil0cYopcFbERSLB+QUrXRklc5j/aX
         e8kZIJMttHxmqVoalEcKv6VRO8CgcUzGtjj7jfcyr+x1W4jd3LV3SIyVEm8WECUUIi3K
         yulQ==
X-Gm-Message-State: AD7BkJIVYuJuM/aThuKObSc77MNS3k4r+anyuCgeraRA47basoJWoDLaR7hGzNCG2e5O1I0BVjpsijLK4pS2Vw==
X-Received: by 10.107.9.28 with SMTP id j28mr10108375ioi.104.1459828298576;
 Mon, 04 Apr 2016 20:51:38 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 20:51:38 -0700 (PDT)
In-Reply-To: <20160405014609.GB12006@LykOS>
X-Google-Sender-Auth: v_8xxa8xcUgAewG64Xl9qpZU95g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290758>

On Mon, Apr 4, 2016 at 9:46 PM, Santiago Torres <santiago@nyu.edu> wrote:
> Eric Sunshine wrote:
>> > +test_expect_success GPG 'verify multiple tags' '
>> > +       tags="fourth-signed sixth-signed seventh-signed" &&
>> > +       for i in $tags; do
>> > +               git verify-tag -v --raw $i || return 1
>> > +       done >expect.stdout 2>expect.stderr.1 &&
>> > +       grep GOODSIG <expect.stderr.1 >expect.stderr &&
>> > +       git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
>> > +       grep GOODSIG <actual.stderr.1 >actual.stderr &&
>>
>> Hmm, I had expected you to adopt Peff's suggestion[1] for the greps:
>>
>>     grep '^.GNUPG:.' ...
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/290691
>
> I thought this was an stylistic thing. I can of course adopt this
> suggestion.

It's probably not a big deal, but Peff's suggestion (at least feels
like it) makes the test a bit more comprehensive.

By the way, as the test is heavily inspired by Peff's example, it
might be worth giving him a nod via a Helped-by: just above your
Signed-off-by:.
