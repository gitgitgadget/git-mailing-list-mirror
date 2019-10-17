Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DC31F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 20:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfJQUpg (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:45:36 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:38986 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfJQUpg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 16:45:36 -0400
Received: by mail-qk1-f179.google.com with SMTP id 4so3212232qki.6
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nm0y8itQwNxycU+KkCNl4rRv/KEizP64S0h3JjcmM1I=;
        b=CSQkOFqGa4+s7tlWZ+YT+n2bPhZ97z4bHV0wAW/4JArlvdW9LCrTnANTSBE9hoh+r3
         aLCCN31qCG5v4O5opbrSGTmYoK8vjfAnzSNQSkTHVmK2TqvWiRqCAptFypjby7HlsV/1
         JV9EAp/r3IE3NFEsoDFZLsoUvjPn3Kq0IrbSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Nm0y8itQwNxycU+KkCNl4rRv/KEizP64S0h3JjcmM1I=;
        b=qf6j3imZZ/2oY3jrH7pIq/Ov63jR2YRVj6s6Cq2i3U5ofFq4NyhewtzAKPA6SG+Yw6
         1N4KtC6609Phj9+SMU0IRMytyFdMAuKrD+GKOjIZs4vJrS6emg4Tkkf31lThP3YbcbEM
         +njQY883aYNNqnPAlKq5YLq0etYk2vlgvcFyX0nTA6sPGUrzUvS0XPjBvzTIBwpHHx2M
         cWHCCIxpMfZTbxGAdlskjmjr7Oiv+fsxjQlijIHJDUcW10ckQCXj7xBkKilkKAJgTGT7
         qyeYms7eiWDYYRQBnE4Uqxd7nf5kATsjAvjOnD3YXCXr9U1u1zW2yT6KNWX9+uVDjvjm
         jD9A==
X-Gm-Message-State: APjAAAX1MAG/QgTTY3XD90Db07oLWRGeL0yFr1dLX7rwpX3w85VsX0E9
        5+WW2qRe24Apdn1vR5go/Uzrp6rMxHc=
X-Google-Smtp-Source: APXvYqx67ShxHPsHmU4ie8AOdmAv0dC9DADOXV5AgHyiljWTFyBCcpGVIsssPGNMCbxjXk9vRGW2Aw==
X-Received: by 2002:a37:507:: with SMTP id 7mr5422980qkf.107.1571345135302;
        Thu, 17 Oct 2019 13:45:35 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id j137sm1974051qke.64.2019.10.17.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 13:45:34 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:45:32 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Greg KH <greg@kroah.com>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191017204532.GA6446@chatter.i7.local>
Mail-Followup-To: Greg KH <greg@kroah.com>,
        Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>, workflows@vger.kernel.org,
        Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <20191017204343.GA1132188@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191017204343.GA1132188@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 01:43:43PM -0700, Greg KH wrote:
>> I wonder if it'd be also possible to then embed gpg signatures over
>> send-mail payloads so as they can be transparently transferred to the
>> commit.
>
>That's a crazy idea.  It would be nice if we could do that, I like it 
>:)

It could only possibly work if nobody ever adds their own 
"Signed-Off-By" or any other bylines. I expect this is a deal-breaker 
for most maintainers.

-K
