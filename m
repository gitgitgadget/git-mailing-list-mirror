Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3890F20969
	for <e@80x24.org>; Thu, 30 Mar 2017 20:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934773AbdC3USw (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:18:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934658AbdC3USv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:18:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD32E6EB06;
        Thu, 30 Mar 2017 16:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wofxPyuzmx1D1y7hnO8XZ9wmQ3M=; b=DX5bWt
        4IoM2j2j/WIE1TqVqZPgPLgAaoNiJYl7D0cFUE8YLhpUe7O5fnUu3sQsjjOeevFb
        FOQmbQZO0TGrK9gOi1+QkfagihZ35UMsUyKsKxc9vbb+kGuRoZIY0PevmXR8rkqk
        uHcPTsCJKJaOGyF+Ol0m6jmOMfgrsp0TBZ0qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Op7IqzTWT9VDtxQ9H2w+NHoUK+LF02KO
        59kXK1m3IjtDrIfi2grZPJcYujVAgE2zurn9JxLzAdSKGLConhhhNZqKgHlcMibY
        KIlujZPJ1xZ4VxTVyKmbJ1nj+1dTY83DntIGyyZR/ERKGHO1lT5Qmij0zLvp91ZQ
        yC8coFlVw9o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D41816EB05;
        Thu, 30 Mar 2017 16:18:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32EE16EB03;
        Thu, 30 Mar 2017 16:18:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Docs: Add some missing options to git-diff.txt
References: <1490903375-2115-1-git-send-email-asheiduk@gmail.com>
Date:   Thu, 30 Mar 2017 13:18:48 -0700
In-Reply-To: <1490903375-2115-1-git-send-email-asheiduk@gmail.com> (Andreas
        Heiduk's message of "Thu, 30 Mar 2017 21:49:35 +0200")
Message-ID: <xmqqinmq34d3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15B6E75E-1586-11E7-A5CF-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> git-diff understands "--ours", "--theirs" and "--base" for files with
> conflicts. But so far they were not documented for the central diff
> command but only for diff-files.

This is probably a shared issue with the original text for
"diff-files", but I think we must stress that these options make
sense only when you are in the middle of conflict resolution.  

In addition, unlike "diff-files", if these were to appear in the
general "git diff" documentation, it also must stress that these
options are only about comparing the index and the working tree
files, e.g. "git diff --ours HEAD^ HEAD" does not make sense.

