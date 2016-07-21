Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6249820195
	for <e@80x24.org>; Thu, 21 Jul 2016 11:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbcGULWJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 07:22:09 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33728 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbcGULWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 07:22:07 -0400
Received: by mail-lf0-f45.google.com with SMTP id b199so59062236lfe.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2016 04:22:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ECQHUKp/nSAL8dLoCvdb1TuhFV2njokpCzEZV3t9gNI=;
        b=ItBxZ9qxwD8cu4xGroALZhEEMDfFpwnJmgcZm6wr4OWb0QirvS1fex8qdkOeaxmDe7
         WW7kUnutDejUjfhfrrzXpgVBxIyogngU7/LXFoxkmcNHcWucz4tQg9c09pjr0l46HXLH
         YlDNysmYZiLszhDLpWBsfoc9ORYq3ZxBwj4bTSn1LewJxRP/EBp4zkC66JVHZlHpRpa/
         NEeunONqh5sLe1T8tlICdwBpQmoHcJRh3g2TiSUpNCFbW2Dc2W5s3Nkgn3JBbwAJztIc
         XWylfMj5R36mCpCEyd9aNILt+drWsCn75WMx5p023Xuno29jqTjz3V+rsDTbh07TRIdH
         1YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=ECQHUKp/nSAL8dLoCvdb1TuhFV2njokpCzEZV3t9gNI=;
        b=fq8ayvvQqdRlyDM5ABz7Fvn5FrOQhTUNhWj8x9jq8P6b2p5EE4h8EDduxn/klL1dtS
         xiZ6qKa87+it/dZKal1Y+mvw6bO889IXCHcRQJE/5jl3u9Bptoj5OEW56DvDId23JNnR
         S1RitRQIjJKL8Mo+MzzQ0bS3s9YMvh11164UK+bNTWn3b608CvevVv+nB71YHhfekr46
         qtJ5Rwx3bu6NWNCsslfp/Tzj2Y2FDFaujIHMWiA9cFkkTC7OhETTzgFLOyGtNZyNcxUE
         KbH9ukX2HgsngeviDPa6lZ5NWJctam5EBV0ciM8MOrAXI3IN0Y3ZXg6xBtqdHvAss41E
         l/cw==
X-Gm-Message-State: ALyK8tIAS3yL73ZxxIAyTaggVvDKT9b9OCi3D+kSK/oXB3vzVBUSLlACRPgnEdkfwhswHQ==
X-Received: by 10.25.90.203 with SMTP id o194mr4449850lfb.67.1469100125365;
        Thu, 21 Jul 2016 04:22:05 -0700 (PDT)
Received: from [192.168.1.26] (elu20.neoplus.adsl.tpnet.pl. [83.21.214.20])
        by smtp.googlemail.com with ESMTPSA id u14sm1581208lja.11.2016.07.21.04.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2016 04:22:04 -0700 (PDT)
Subject: Re: Server-side preventing some files from being overwritten
To:	Stefan Beller <sbeller@google.com>,
	Thorsten Glaser <t.glaser@tarent.de>
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de>
 <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5790B055.4060603@gmail.com>
Date:	Thu, 21 Jul 2016 13:21:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-14 o 18:57, Stefan Beller pisze:
> On Thu, Jul 14, 2016 at 8:31 AM, Thorsten Glaser <t.glaser@tarent.de> wrote:
>> Hi *,
>>
>> is there a way, for example with some sort of pre-receive hook,
>> to prevent some files from being overwritten by a push?
> 
> pre-receive hooks are a thing!

Or you can use third-party tools with support for such cases, such
as Gitolite.  VREFs allow to restrict pushes by the filename, see
http://gitolite.com/gitolite/vref.html#NAME (though I am not sure
if it checks only the end state, or if it checks every commit
that was pushed).

Best,
-- 
Jakub Narębski
