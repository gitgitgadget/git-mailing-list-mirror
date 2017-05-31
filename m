Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B46C1FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdEaWxx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:53:53 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36514 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdEaWxw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:53:52 -0400
Received: by mail-pf0-f178.google.com with SMTP id m17so19813351pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 15:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=en9VioxOWHMBhmqX9wCWoZbZyE4xWjflRzI/mD8TBhM=;
        b=U5E37Ap20s6wM8j98WLcjd7CvBsYRqkADxQT84CpS98qRfXG+5GQOVrDrg/snHQNAN
         B4BGoNAnLKa+MEVUTMEz7x2W+uieJJjh9A1a7BiUY9KHDBtEBbeJDAm/a8YCy33TaoQd
         H5pUOTnxWcA2ZH2SGJSW22/S+Jta48/OXjlxiJZS+0y1lcHZ1J9AaRkaXCgA6ZkX+u2B
         GX2lEKI3q1xyCXNM6MxaIfNXvrKbyjf/cVF4UwH5zzTtIeSa16T9RQDfABVY0ENuuhqJ
         TU9fQ7cO8FfeQTV4it4WstXk6sVexjrUGkSj0+DjOf2y+Xv/vqB2UwP4LNNLlxQfulyZ
         sTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=en9VioxOWHMBhmqX9wCWoZbZyE4xWjflRzI/mD8TBhM=;
        b=bcJqAuV4UxFIyYGMZavHVD9ChSIK2JjxSOsvm5Fd6A4u6bx84XwqAGPW8iPHiKBrde
         Dum1LrDSsslmdn7hiTewoN/xDM20p4tRmEY6UBFWRhRDY/Lb6R+7RGl7v1IUCJAzL3w5
         PtOCRAg2/F6BQlOuzy5RvBlrQiRxeVQn2+RY2KwySbOeUEizWCYtefkbP2dyy3sdh0ad
         va0HzoLQ/hdr2Id3n2AmG8VY+8E8lBnf8ofTMaMt65ym4MOvNvJqdi2TWzMfP36LY/Ba
         sFPQj3zDEtsiA77cqWzjuaJrN3qFCPanPNUQ9cGhk3huTa+wACpf0hX9l31uAYcq40uf
         Ybwg==
X-Gm-Message-State: AODbwcCZneGZMdfcjy/9wBBKck8znFgtk2VcYNsWYbCM2QZz4gAfAZRD
        RknZHfxaiLsDwg==
X-Received: by 10.98.80.152 with SMTP id g24mr32226754pfj.222.1496271231735;
        Wed, 31 May 2017 15:53:51 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:6469:e172:b5f4:6d97])
        by smtp.gmail.com with ESMTPSA id v9sm29969566pfa.43.2017.05.31.15.53.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 15:53:50 -0700 (PDT)
Date:   Wed, 31 May 2017 15:53:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] send-email: Net::SMTP::SSL is obsolete, use only when
 necessary
Message-ID: <20170531225348.GD81679@aiede.mtv.corp.google.com>
References: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
 <20170324213732.29932-1-dennis@kaarsemaker.net>
 <20170531214634.GB81679@aiede.mtv.corp.google.com>
 <xmqq7f0wabxn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7f0wabxn.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jun 01, 2017 at 07:39:16AM +0900, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> This broke git send-email for me.  The error message is
>>
>>   Can't locate object method "starttls" via package "Net::SMTP" at /usr/lib/git-core/git-send-email line 1410.
>>
>> Is 1.28 the right minimum version?
>>
>>   $ perl -e 'require Net::SMTP; print version->parse($Net::SMTP::VERSION); print "\n"'
[...]
>>   $ grep starttls /usr/share/perl/5.18.2/Net/SMTP.pm
>>   $ dpkg-query -W perl
>>   perl    5.18.2-2ubuntu1.1
>
> Thanks.
>
> Let's revert the merge for now until we know (this time for certain)
> what the minimum version is.

Thanks.  I just sent
http://public-inbox.org/git/20170531224415.GC81679@aiede.mtv.corp.google.com
in response to another thread.  That uses 3.01 as minimum version,
since it is the minimum version imported to core perl with starttls
support.

I haven't tried testing with historical Net::SMTP versions, though.
Is there a git repository available with all Net::SMTP versions from
CPAN, or is https://perl5.git.perl.org/perl.git as good as it gets?

Regards,
Jonathan
