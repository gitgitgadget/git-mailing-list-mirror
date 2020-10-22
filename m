Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9DC388F9
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 22:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32C320795
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 22:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372591AbgJVWCo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Oct 2020 18:02:44 -0400
Received: from elephants.elehost.com ([216.66.27.132]:50231 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372585AbgJVWCo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 18:02:44 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 09MM2fYH028632
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Oct 2020 18:02:41 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Adrien Berchet'" <adrien.berchet@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CAKuTeyftpz8mQiiy2S56pxmW0fzCENAQ8=gmaTE5a-Ef5g216g@mail.gmail.com> <000601d6a883$66d8e180$348aa480$@nexbridge.com> <CAKuTeyc6WhEguV2mi_eg8JYrhri0inBJE-xHL3ZbFRGuYsyaDw@mail.gmail.com>
In-Reply-To: <CAKuTeyc6WhEguV2mi_eg8JYrhri0inBJE-xHL3ZbFRGuYsyaDw@mail.gmail.com>
Subject: RE: [bug] Cloning SSH repo into /tmp
Date:   Thu, 22 Oct 2020 18:02:35 -0400
Message-ID: <007901d6a8bf$0f9d3830$2ed7a890$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMqDjtu6hmKiRxIwMY8YurVYTJEqQKwTF9XAsr2ULOm0YcvoA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 22, 2020 5:27 PM, Adrien Berchet wrote:
> 
> I encountered this behaviour on Linux Mint 20. But I just tried on
> RedHatEnterpriseServer 7.6 and I could not reproduce this behaviour.

I wonder whether there's something strange about how Mint partitions the disk, and whether /tmp is somehow configured weirdly on your machine.

> Le jeu. 22 oct. 2020 à 16:55, Randall S. Becker <rsbecker@nexbridge.com> a
> écrit :
> 
> >
> > On October 22, 2020 6:28 AM, Adrien Berchet wrote:
> > > I encountered a quite weird bug when I tried to clone a repository
> > > into the /tmp folder (I just wanted to test something, so I was working in
> /tmp).
> > >
> > > I run the following command in /tmp :
> > >     git clone ssh://[user]@[host]/project/[project_name]
> > > and I got the following error:
> > >     fatal: the protocol '/tmp/ssh' is not supported
> > >
> > > I got the same result if a run the following command from /tmp
> directory:
> > >     git clone ssh://[user]@[host]/project/[project_name]
> > > /tmp/project_name
> > >
> > > Nevertheless, the command works in other directories. Even the
> > > second command works when run from another directory (this
> command:
> > > git clone ssh://[user]@[host]/project/[project_name]
> /tmp/project_name).
> > >
> > > It is very specific and can easily be worked around so it is no big
> > > deal but I preferred reporting this in case it hides something else.
> >
> > What platform are you running on? I have experienced similar when /tmp is
> linked to a separate file system with complex ACLs.

