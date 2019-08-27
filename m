Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD381F461
	for <e@80x24.org>; Tue, 27 Aug 2019 19:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfH0Tfp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 15:35:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61129 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0Tfp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 15:35:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AED0E16C9CC;
        Tue, 27 Aug 2019 15:35:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZJk6KfBoTtjJvb5I8+TvzE673sQ=; b=vjs2Bi
        rHQtVDfEXDitaje2wXhxxf8gZpkocQDl734LEmada/JBPBJlVYy12DVdXLKtn5Jc
        f2+C4fu1bFNNLa4G/ZdqiQojQ0sDkcWpWGgZoegi7ztGLBdsDYvZD48rdbJfXHcL
        aNcKdRKuZGu7yvfdpOtKO4fbX+kVWczcfvIRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O9ZFtspLUC8BLu3steirhfuZHhK2BGK8
        1l4x4lc+lhkZyhzs2fscp45ggECRlHlSCsRb0ycLnM5YD2OJhkFix6cFHXjDph2+
        yLAQkF4/XBr/9sjEPp7DL8takU7M8pBGAdqd6WHuD5pmFFIO0EfpLtYkYTaXCZ5J
        CbN/aLQnyDU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4DD516C9CB;
        Tue, 27 Aug 2019 15:35:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F42516C9CA;
        Tue, 27 Aug 2019 15:35:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Albert Vaca Cintora <albertvaka@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
        <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
        <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
        <34935414-4e69-114b-7a32-f94514e3679d@iee.email>
        <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
        <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com>
Date:   Tue, 27 Aug 2019 12:35:42 -0700
In-Reply-To: <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com>
        (Albert Vaca Cintora's message of "Mon, 26 Aug 2019 20:42:56 +0200")
Message-ID: <xmqq4l224d0x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC5D6DFC-C901-11E9-ACD2-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Albert Vaca Cintora <albertvaka@gmail.com> writes:

> It "works" for some definition of work, but it asks for confirmation
> for every file, which is a pain. I'm on Linux.

Ah, your "rm" command needs to learn "-f" option, too, then?
