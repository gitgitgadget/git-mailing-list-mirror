Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96BAB20C13
	for <e@80x24.org>; Fri,  1 Dec 2017 04:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbdLAELi (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 23:11:38 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:45510 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdLAELh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 23:11:37 -0500
Received: by mail-qt0-f182.google.com with SMTP id g10so11547720qtj.12
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 20:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i2/qXp8tLuaKDeGjNLUWpi/Flx85lBlZvz5a/LnPOKY=;
        b=jr8RqyifMS2UVFQSKbqyZSur4bPjYk2iulDidzLGQQwp7xUF/uJH+KNTMSEyv9ROjz
         jwnZgOEHjxa2hHQ4ZGzcAoPGK28dcnx6XTiV8sF3XLfLKmnCQmuCVZxNwpF1aVvYyM4v
         FqpOTuKZT2ct7MwZObBa6PrloaZXOm5OKR8JMpOUZjAWh1JB70NViOpD5X3VsKp4gpO+
         lQ70hUkMW2BrRS4pnMVGNge/xlMGlh1HGzoxkSOCh+DWneKPt51DCfMvQAkZzpmqyUFT
         rCJRxtG5zAjK+yMtxKYwIBiTrq5fiPTNUiTBb8e4ITLofsgro8Dd4TLAOanuicgIkaER
         5RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i2/qXp8tLuaKDeGjNLUWpi/Flx85lBlZvz5a/LnPOKY=;
        b=JIs7o7nc2Wlu4zZqHEQoivs1ZtSJz3Jo6DrK5SC4DcsQVEqxx5+xecngiV4GU7Dvvo
         LNr9dQ6YJM8anPtXH3Le8ddygKh5tUzdehDJKwzWCFNb79BoFUSF4NQ8awg+8tubIg6e
         9QOE/08JaLc883JMbvC1XdHDFOnG3MIAxgq2EcIyRWYzMhZJ3vJvCntApuba49jguqJN
         yBnQchotMYYeU3pnlmoMIBT+/4Zw1OLcR6wnJ8LuZbDhycgoeR0qQt0oCuSviFUOfN7T
         IHIUpbD5DqW5NPEtCJZ2NMljVveYznZ1Y4zAtNybbfr/xqbYxTeZKbZGHkOB9zUYQ7gs
         +pWg==
X-Gm-Message-State: AKGB3mLa1i3H9/Z634nWuAeixQNdzAJxqx8AAOerHmJgOBs9IrosAIri
        QpkmVkzMjCZjScML/l44I1/3T10A
X-Google-Smtp-Source: AGs4zMb/YfjS+FLntOWgwA/Vdw41Rc73XWPS15I05RR4o3bPbEgZGoNwvGOGTp5FbMVzBc2loo0qiA==
X-Received: by 10.200.41.120 with SMTP id z53mr7077585qtz.305.1512101496670;
        Thu, 30 Nov 2017 20:11:36 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id a17sm3980024qth.17.2017.11.30.20.11.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 30 Nov 2017 20:11:36 -0800 (PST)
Date:   Thu, 30 Nov 2017 23:11:34 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171201041133.GF3693@zaya.teonanacatl.net>
References: <20171201023239.26153-1-tmz@pobox.com>
 <20171201023239.26153-3-tmz@pobox.com>
 <20171201030234.GF20640@aiede.mtv.corp.google.com>
 <20171201034519.GE3693@zaya.teonanacatl.net>
 <20171201035340.GJ20640@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171201035340.GJ20640@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Yep, with this description it is 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for putting up with my nits. :)

Thank you for taking the time and looking at the details. :)

I'll send a v2 with the changes in the morning, in case there are any 
other comments (but mostly because it's late and time for a swim).

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It is impossible to enjoy idling thoroughly unless one has plenty of
work to do.
    -- Jerome K. Jerome

