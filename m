Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592162027C
	for <e@80x24.org>; Tue, 30 May 2017 23:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbdE3XOu (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 19:14:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35998 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdE3XOt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 19:14:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so83350pfb.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+Ami/y11yBqVWjjuvyU5EhMzj+gxD8dOrLzg0eMsC58=;
        b=JJM4cJJ/ZSkuvQeyXy+LK+jY6nacP+wfb/zy23ObmbW9k/dp64kqN/JWqqZS1DcL9D
         Lwmo5f/gZ9H+2Hezh6OGH/qry7gQgzaV1XSaSro+8uw4ChEwF83TytacTK0DVBCs/B0m
         rtPRVKWZBBraUZ9obJzrLbeFWezURgVSthTbilNQJKhTss20YDSKk+4FJKLPoPbbCJtI
         IYh5Rnj7aCjKzT2VSIlIBV7puiIBuzx9PXqsLaQ5cjTk9gmQ0khJWhGFLx4dizxwZ6dN
         x+a378zOk13ulEGxP8DOCilVSw5ME6FapvoAvPWoPALG4WbSkv9mBN3WIneXEbqRL8WS
         VUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+Ami/y11yBqVWjjuvyU5EhMzj+gxD8dOrLzg0eMsC58=;
        b=CDlUg0DQBMNS08y29l7AlR8Zf8nQ7Y9ALdaRFSX1UwbgeXcyhtIycj/fv9BVCofKbz
         zsQDSSg9kFT/DB7FL8Sivhtjscy5+KVwRrzl9dy58pQZfV60da2a7GDN3bC7w+fQqy8g
         8E5EmLaEm31nMigUKywzCx/JABGjoUDiYnTCYDFyabWO+nCK296FaPI+5Z/GeGliw+R/
         yRxyIhTMRARHeK3+NEelldgz7esIojzy8b5/YPuo5/KpbfGSSZlHHTmlOXJ7ON5fuSij
         3NwM2CnXxpDd27T3Rd9Gk81tLq22stM8/c3Spb5YWdd4OyaJ5HD/FWmmqaeGCNLYQ3CH
         vK1Q==
X-Gm-Message-State: AODbwcAJ0GErNCx3EQj5X5cS9vXm7oA7AiHCFJWy+2hfER9R1v+BzplL
        E/60awpgcH7zVw==
X-Received: by 10.99.175.76 with SMTP id s12mr28826407pgo.152.1496186088292;
        Tue, 30 May 2017 16:14:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d156:5238:7809:132c])
        by smtp.gmail.com with ESMTPSA id h62sm22774000pfj.0.2017.05.30.16.14.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 16:14:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 05/13] config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
        <20170526033510.1793-1-gitster@pobox.com>
        <20170526033510.1793-6-gitster@pobox.com>
        <CAGZ79kb2LJ-aqDq9o7Z015aNYo0zoK5DdwDGyABOe1V8ifF2wg@mail.gmail.com>
Date:   Wed, 31 May 2017 08:14:47 +0900
In-Reply-To: <CAGZ79kb2LJ-aqDq9o7Z015aNYo0zoK5DdwDGyABOe1V8ifF2wg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 30 May 2017 11:51:12 -0700")
Message-ID: <xmqqo9ua9btk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, May 25, 2017 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Do we have any reasons for that, or pointers on the mailing list, that this
> is a good idea or needed? Does it fix a bug or enable a new feature on Darwin?

BSD lets you open() a directory for reading and hence we require
this workaround on it; I think somebody in an earlier round
suspected that that Darwin would have inherited the same from its
BSD lineage, and I don't see a reason to contradict with that
suspicion, either.

>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  config.mak.uname | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/config.mak.uname b/config.mak.uname
>> index a25ffddb3e..1743890164 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -110,6 +110,7 @@ ifeq ($(uname_S),Darwin)
>>         BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
>>         BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
>>         HAVE_BSD_SYSCTL = YesPlease
>> +       FREAD_READS_DIRECTORIES = UnfortunatelyYes
>>  endif
>>  ifeq ($(uname_S),SunOS)
>>         NEEDS_SOCKET = YesPlease
>> --
>> 2.13.0-491-g71cfeddc25
>>
