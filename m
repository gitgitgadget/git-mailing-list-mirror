Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B932F208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbdHUWqG (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 18:46:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59646 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751575AbdHUWqF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 18:46:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F0ED92E7A;
        Mon, 21 Aug 2017 18:45:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nn9PycDOsaKVaXmwD8D6axbMDvk=; b=dsHlUb
        206ARHxDNzshLG1FLReQqKcHHDJa1FL/cEARGiscKKeTKox3LQrZROuadGh4ZhJg
        xHDAbZs95dfCC5wWZeDXcfeEs/pWp0BGb3sWXqf22uZkBCHAbudmopHekjOOaUfa
        HATLZME115lUQR2TIOv2ApBgahOCtaHt3MU2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JtU2J5UbFwFDwhxUmIUDguocqjq9d+XV
        OpHCZBLJWy2+PdLaC9gFeRDr2VTIo1WEk7fOChiIqh+8UX3v+7seJLy8Ambj8+XA
        m9o29riyupjIdJXx90GpDKjaPs24nzi8v/Knsfsd5E9b4SCGaABzOKpOtSe424pY
        8tUC0Jyxw/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 478D692E79;
        Mon, 21 Aug 2017 18:45:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A807892E77;
        Mon, 21 Aug 2017 18:45:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
        <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
        <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
        <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
        <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
        <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
        <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYaBGDyScWihJ7gRdbiJfMPOnNo8LfkB58+WAcOtXyibQ@mail.gmail.com>
Date:   Mon, 21 Aug 2017 15:45:55 -0700
In-Reply-To: <CAGZ79kYaBGDyScWihJ7gRdbiJfMPOnNo8LfkB58+WAcOtXyibQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 21 Aug 2017 09:46:23 -0700")
Message-ID: <xmqqefs45yl8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EC9C786-86C2-11E7-A56F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Aug 18, 2017 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> As long as we are talking about idealized future world (well, at
>> least an idea of somebody's "ideal", not necessarily shared by
>> everybody), I wonder if there is even any need to have commits in
>> submodules in such a world.  To realize such a "monorepo" world, you
>> might be better off allowing a gitlink in the superproject to
>> directly point at a tree object in a submodule repository (making
>> them physically a single repository is an optional implementation
>> detail I choose to ignore in this discussion).
>
> Then the sharing between superprojects (e.g. send an Android's linux
> patch upstream or to another distro that also uses a superproject),
> becomes cumbersome as the commit messages are missing and
> potentially not specific to that subtree.

Indeed.  That is a problem "git commit --recurse-submodules" has.
Socratic method seem to have worked well to convince you that it is
not necessarily a good idea to make submodules "just like a tree".

