Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573DB1FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 06:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753601AbdBHGrn (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 01:47:43 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:36607 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbdBHGrm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 01:47:42 -0500
Received: by mail-ot0-f170.google.com with SMTP id 32so106044231oth.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 22:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vtr8keC/+9lRLiuXE1wGU4hcD7i4e02GvKHUqGYZ3TI=;
        b=NR37ABxU4wa6T9k5fJCdmtZaT1pYt0VyXU0zXcAskvjfApZtNDWiI9y3A6M7nnf/qA
         5g1Kg4RZjs+VUgbxFE9lWsrGT49Hmra6awrkPnZNfdFvnbqTW8TLHPCMQlQ4P64Fe33C
         yq+mcYh/ZWNb1Si8OE6nOSetbiRSaOis8YuKrKegPCfIuBSgr7XbXiD5NvXon3Cq7uEE
         SH61EiYX1F6C7phWUKOJW9ksuQ7JZIDjA6fHWMrHivlZawldqrzAyBJQE2OuXZ2oJa/k
         tHkteIaZvbeyjOtovDEZHeNElegZnwR57NIJ+MjpZzUpyNL1ywR4WPl6wPuKJGKdGrLW
         atfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vtr8keC/+9lRLiuXE1wGU4hcD7i4e02GvKHUqGYZ3TI=;
        b=SF6Jv5oLJLVi8y1m/ZKXGvrBaFhda6eglAqIUqENQfANveIfLZBIr46V+TN0w9cbB8
         QQvRSNHyY3ET0C3nG3JA2vbGPawp3Lww+/g3NaSgMYFvf23qcLQCIZF6fXOAQvMBeWJy
         ql68linvJuZVnEa1qt18N3X9R1FmyacrmT2CTnVAYUkl86AxqZv9eVWeCQEKBF+8J/El
         FEa52BsX9N/ZCGKF4Hut5ECB8+e7q+5X7ybi6hDET8V19SFZ/uyQcK+ABZ2wPhpHA5ke
         pnKm+e6LuyZen+ZbH81sw2WVPqqQp5bijzLXTxLbpgUuqn7DpEUfdlJGOEESx1EV5anT
         U5nA==
X-Gm-Message-State: AMke39lXWFqDPd/D3ieegMcHlgEuGvZ6R4tjyJRnghw/wsZ3VuC+m0oyBFH6jMhdjSu5OdnDKnDUm3+ACcOu2A==
X-Received: by 10.157.39.35 with SMTP id r32mr9259624ota.199.1486536373504;
 Tue, 07 Feb 2017 22:46:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Tue, 7 Feb 2017 22:45:42 -0800 (PST)
In-Reply-To: <1486515795.1938.45.camel@novalis.org>
References: <1481922331.28176.11.camel@frank> <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
 <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com> <1486515795.1938.45.camel@novalis.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 Feb 2017 13:45:42 +0700
Message-ID: <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
To:     David Turner <novalis@novalis.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 8:03 AM, David Turner <novalis@novalis.org> wrote:
> On Sat, 2016-12-17 at 14:50 +0700, Duy Nguyen wrote:
>> And we can't grep for fatal errors anyway. The problem that led to
>> 329e6e8794 was this line
>>
>>     warning: There are too many unreachable loose objects; run 'git
>> prune' to remove them.
>>
>> which is not fatal.
>
> So, speaking of that message, I noticed that our git servers were
> getting slow again and found that message in gc.log.
>
> I propose to make auto gc not write that message either. Any objections?

Does that really help? auto gc would run more often, but unreachable
loose objects are still present and potentially make your servers
slow? Should these servers run periodic and explicit gc/prune?
-- 
Duy
