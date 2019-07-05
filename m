Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439DE1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 00:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfGEApM (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 20:45:12 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:46292 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfGEApM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 20:45:12 -0400
Received: by mail-pl1-f169.google.com with SMTP id c2so2175105plz.13
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 17:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6Ezpenm74wX2oAiZ83o98rTT6EpZo5Im+wHiHFpPg7o=;
        b=zouj1Hlm331hi3xquZ/umlT/Bn1rWlhIgG77SVSBnWnOIse5W67PQfioceRMn3Khu3
         ql5DI+rT1nyrmPmbx5a2us4DMAYLoMJkkWBF36M9ewtxMTFrkDM7mpYzlr81UH98Ob8a
         NpCiIsXEPjp1NX1wtpm0muJPommjHhsmVi3nyqli9rFqd4qmzCvOcoXrUpc6bGw8OSiF
         xQQU9vnx7MCUC7i5S3ip4cXyrcTm1ixWBD2CewDPTG88eXBzcGHthiB85Bg3rc7sKb09
         zsHaGaRlZbmnJo431207Glw0oGoWKiTHEfPpBrX7hM+kKJNinjAszCqcSclk4QhmXvGp
         wEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6Ezpenm74wX2oAiZ83o98rTT6EpZo5Im+wHiHFpPg7o=;
        b=J7g2bliQOyxjNEUGBaAkrxTLFv8ULUl3ZiToYv+vxEglpmX8racqQqjxfFBOg7Vgzy
         yYHAu6XXCSXsmOftlOSlBGU/iDBpJmcNedOBa+dCFrxaNLPc8jCUUcyRaeFf/Jj+Vdb8
         1/vWuFCprMqlgs/907MaOYxuZxFCglvGxVftEka4aYNqsEh9xCF6mIi1nJAYzh6umbay
         DfNprPxKLSewpRXi6IAVzXZvHycJliH0eLjYsTTAUpiaJ4qV7p4tmwCV8k5oGyZZa28p
         ocSIqsDKg0OvnFcSLJJ81vLVtar4LWmRDLBEg5NokfKIeQGp/nBe0b8a9UpvIO1jdwM+
         FB0Q==
X-Gm-Message-State: APjAAAXTEr6EOJRtsnELq3ggTMaHkI9/RI6bIA5HHa2utRPy5+9Au9Rn
        KfjBojXeU900PKMvSmfpLNqc8w==
X-Google-Smtp-Source: APXvYqzfVQfAohkCftiCYmNN1eMbXLSQYb6X8GTNqfj9sS7wxXKBErfj3B5I0UcFu8F+sbUq07+b5w==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr1138628plb.30.1562287511295;
        Thu, 04 Jul 2019 17:45:11 -0700 (PDT)
Received: from aermolenko.office.atlassian.com ([103.233.242.9])
        by smtp.gmail.com with ESMTPSA id c98sm7493882pje.1.2019.07.04.17.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 17:45:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [QUESTION] Git fails to detect merge conflict?
From:   Anton Ermolenko <aermolenko@atlassian.com>
In-Reply-To: <20190702001528.GA94153@google.com>
Date:   Fri, 5 Jul 2019 10:45:07 +1000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <70A38295-66D4-43B0-87EF-EA3EB5C0CEAE@atlassian.com>
References: <E42B8D46-0CA0-44E0-946F-8ADA96993629@atlassian.com>
 <20190702001528.GA94153@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

Thanks for you answer.


The original content of the file:


--- START ---
  LINE 1
  LINE 2
  LINE 3
---  END  =E2=80=94



Branch =E2=80=9Cchange-a=E2=80=9D modifies it to become:


--- START ---
  LINE 1
  LINE 2
  LINE 3
  LINE 4
  LINE 5
  LINE 6
  LINE 7
  LINE 8
  LINE 9
---  END  =E2=80=94

While branch =E2=80=9Cchange-b=E2=80=9D modifies it to become:


--- START ---
  LINE 1
  LINE B
  LINE 3
  LINE D
  LINE E
  LINE 3
---  END  =E2=80=94

Now, on master I=E2=80=99m able to perform =E2=80=9C=E2=80=94no-ff=E2=80=9D=
 merge with and git does not detect any conflict.
The result is this:


--- START ---
  LINE 1
  LINE B
  LINE 3
  LINE D
  LINE E
  LINE 3
  LINE 4
  LINE 5
  LINE 6
  LINE 7
  LINE 8
  LINE 9
---  END  =E2=80=94

Which is both changes applied sequentially - first, the change from =
=E2=80=9Cchange-b=E2=80=9D as it happens to be earlier in the file, then =
change from =E2=80=9Cchange-a=E2=80=9D.


Thank you,
Anton.





> On 2 Jul 2019, at 10:15 am, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>=20
> Anton Ermolenko wrote:
>=20
>> My understanding is that recursive merge here won't consider that =
situation to
>> be a merge conflict as the changes have been introduced in different =
spots in
>> the file.
>=20
> Yes, that seems right to me.
>=20
> Do you have more details about the context?  What do these files look
> like?  Are there other cues that we could use to discover that the
> customer intended the changes to conflict?
>=20
> Thanks,
> Jonathan

