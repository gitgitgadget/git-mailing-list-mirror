Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADCC20A17
	for <e@80x24.org>; Fri, 20 Jan 2017 00:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbdATAgS (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 19:36:18 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33131 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbdATAgR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 19:36:17 -0500
Received: by mail-ot0-f196.google.com with SMTP id f9so6048533otd.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 16:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RYXd3Nls5A3/v+bC6GwUN/+V7e5sjMMb4CRFsp3DEGg=;
        b=q2+eVyrJQqRUybvn6oT7njGBtEENryFQ2G0MBmtGmsbaS/IARoU5xuDn3vIqaJzefg
         +XTtaBDoKGN2mgS7wUsk00IC8IgndazaX4va2Ubi7Ax6M6ztDQXDZNwgGhcydP1tRe4Q
         E3Rjw25gKE21vOvWFORx04ahNKtUTiZVUTe4Va7Knq3mfGrn5gKVTe7AOLBeBGkzxn6C
         D8LtlwqL5BWbsdqDJPXqDNYKZ1FJD0evV4O/l4ZfoNYoxFIZAkb/BgL9X2xm+5au0AdB
         uTL3QDJSqeiN9NZgdVPKt2F3NBcPSY/sSZOm7yQJjINlSWcXAPMcQ4vqVQ/RAwj8dVd2
         1xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RYXd3Nls5A3/v+bC6GwUN/+V7e5sjMMb4CRFsp3DEGg=;
        b=GzV0jhqY99Zepk/8rXOYhsM0umSwYj5iZRvIq1OTDF6rYmqv1csW+DB2fLTld9Rac8
         0nY7lobd9Q6iY+7hoX+VXXsPReRVydan0KYnsCv3OQswc0d/gp/8JZNKR7AcEfO5IVlB
         HGHf26yJyFYy858msgAjyCnsIMiPJE12VdgYAUM9NpVXifeTpnNdIjmP/dx7JBXhECLF
         Ny1bkwCXxELurhOWfkaTFUnvp55XDURYMveZeHf4BNY38qqRExUlBArOIwvqS27UQnLq
         ZjSmFVIMIlZofengZVsGDLmnLvNSKKU8QG3NtNyHBTH8ka59wDDCGPr6xnhEKgDp62uL
         hGxA==
X-Gm-Message-State: AIkVDXJsSbxjPQkjPfZ8SU68Z67JFNV35XG8xF7WmyOfHN2BChriMCCFYBVu2DYJKae03AVpXUSLxnxO77Gq4A==
X-Received: by 10.157.46.24 with SMTP id q24mr6486491otb.269.1484872002441;
 Thu, 19 Jan 2017 16:26:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Thu, 19 Jan 2017 16:26:41 -0800 (PST)
In-Reply-To: <b96b71b9-f8a2-d039-6e8a-c64e7aac02a0@gmail.com>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
 <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com> <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
 <b96b71b9-f8a2-d039-6e8a-c64e7aac02a0@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Jan 2017 16:26:41 -0800
X-Google-Sender-Auth: XSfzEvkVK1MTLHXtL2hrW31ruYE
Message-ID: <CA+55aFz5Rnt8U3bpvgoHQSfjPrnxnMfWUGBbHW2XKiagKXga5w@mail.gmail.com>
Subject: Re: Git: new feature suggestion
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Git Mailing List <git@vger.kernel.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 1:48 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 19.01.2017 o 19:39, Linus Torvalds pisze:
>>
>> You can do it in tig, but I suspect a more graphical tool might be bette=
r.
>
> Well, we do have "git gui blame".

Does that actually work for people? Because it really doesn't for me.

And I'm not just talking about the aesthetics of the thing, but the
whole experience, and the whole "dig into parent" which just gives me
an error message.

            Linus
