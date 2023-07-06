Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA97EB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 21:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGFVBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 17:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGFVBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 17:01:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420CE1999
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 14:01:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB4E120B5A;
        Thu,  6 Jul 2023 17:01:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/mvKXfFW4OOH9rYZyoIhPSMhOBEXq2VTIOiCuE
        nkP98=; b=W6O/n9GoHnrNrI/mG8YKgdiDCCrFjxCQBSEEiREAH5p9JvGYsKLS1t
        GTsSR7gb2bx2Fa5tqkpYSF1Xjt7XQSxvisIgwt2RumsnSO3JWT5W5vZddushxraW
        ml1c1MieZdqtrDHiycY5MEDU8skv4mXtXy0Kd+Xu/UGHoiDqxy40U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9182220B59;
        Thu,  6 Jul 2023 17:01:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1F5DB20B58;
        Thu,  6 Jul 2023 17:01:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew Hughes <mhughes@uw.co.uk>
Cc:     git@vger.kernel.org
Subject: Re: Expected behaviour for pathspecs matching attributes in
 subdirectories
References: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
        <xmqq7crddjtq.fsf@gitster.g>
        <CAEzX-aC=UDkf6nevLbN0bNyGXujZVDuqtCp3YcYhAPD6zvYZiQ@mail.gmail.com>
Date:   Thu, 06 Jul 2023 14:01:14 -0700
In-Reply-To: <CAEzX-aC=UDkf6nevLbN0bNyGXujZVDuqtCp3YcYhAPD6zvYZiQ@mail.gmail.com>
        (Matthew Hughes's message of "Thu, 6 Jul 2023 21:54:10 +0100")
Message-ID: <xmqqjzvcbvqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F5A987C-1C40-11EE-A5F2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew Hughes <mhughes@uw.co.uk> writes:

> ... (the 'rm' at the end is just to avoid polluting any
> other tests with extra attributes, not sure if there's a more standard way of
> doing this):

Study the use of test_when_finished in other tests, perhaps?

