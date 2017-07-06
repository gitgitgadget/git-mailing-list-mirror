Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E244202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 18:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbdGFS0b (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 14:26:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58933 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751813AbdGFS0a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 14:26:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86CAC967D6;
        Thu,  6 Jul 2017 14:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=j3574wyLwzEnrl3jalhMHD+2m1E=; b=G2H9LK
        8lVtIyCcBv+0T36jaWkf0ZgI2gWRZwFOW/zc79ju++GrCc2x3SCHcUMcLTDTkzOa
        f+GB8h75EmJ8ZgBOUOy0viD/r9kElPK+SFg5O05nSGllfn1NmN8wE7/AYb4m5XK5
        MU7fP3tYske9QQA/+eB3s4T4RBNEzZsuD6pDA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E799967D5;
        Thu,  6 Jul 2017 14:26:22 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC00C967D4;
        Thu,  6 Jul 2017 14:26:21 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
Subject: Re: name-rev: anchor pattern without --exclude?
In-Reply-To: <CAGyf7-HiwR+CDtDCvQ7q9Dd_TYfvN0133UOYTO65F=4qOHqy9w@mail.gmail.com>
References: <87k23ltsl6.fsf@kyleam.com> <xmqqfue9fqfe.fsf@gitster.mtv.corp.google.com> <87h8yptr7t.fsf@kyleam.com> <CAGyf7-HiwR+CDtDCvQ7q9Dd_TYfvN0133UOYTO65F=4qOHqy9w@mail.gmail.com>
Date:   Thu, 06 Jul 2017 14:26:21 -0400
Message-ID: <87eftttoaa.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C86B4FA-6278-11E7-B332-61520C78B957-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=j3574wyLwzEnrl3jalhMHD+2m1E=; b=W8peNW84YTv8D9AaRvG3gqOmACOIb+1ZGGA895mF/UTYWK8/SF+PAc/I1RmNRodUu3tpkvIT4z7MRI5ICOmOAvWyXxPt3nyZs56+6fzUMXyNdrxKB6BhrJSjftqTC3TB1mTFc+dRgkbeiVLqjtCc216Km8otTiWFiA6hTGfG/sI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

[...]

> If you don't need the ancestor traversals "git name-rev" provides,
> "git for-each-ref --count 1 --format "%(refname:short)" --points-at
> <hash> refs/heads/" might work. That only goes back to Git 2.7.0,
> though; still quite a ways off your 1.9 target. ("git branch
> --points-at" does the same thing, I should add, and only for branches,
> but you can't directly limit its output like you can with
> "for-each-ref".. Perhaps that doesn't matter for your use case.) If
> you want names like "master~2", from your example, though,
> "--points-at" won't do what you need.

Thanks for the suggestion.  Unfortunately, I do want to consider names
like "master~2".  I was just hoping that I had overlooked another way to
achieve the

    git name-rev --refs="refs/heads/*" --exclude="*/refs/heads/*" <commit>

example I gave in my initial post.

-- 
Kyle
