Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6EE20986
	for <e@80x24.org>; Tue, 27 Sep 2016 17:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934520AbcI0RFn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 13:05:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58039 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934282AbcI0RFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 13:05:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A96A3F68D;
        Tue, 27 Sep 2016 13:05:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=p
        5yjfEhiVpGGgMtvlFCSa7f7X5E=; b=kXqGw85YsTT1b5icrF1vQa0jAf6QYCs4i
        q8kVBLxcUNiTDN2iOdFHSEILVsQTkzSnA8/pe+J7zEoSfySauwiwVZ7sYjk83gel
        YCjsYjGw+zMqPmbZkrKnpsWjQqJy9Opah9ohSy0RXjcZNlLBfp1prydrCrx5kWfC
        7qnjYIIjKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=gJu
        4ZiRIxsx6EdegDg9a2ohYOd+5bN+VAeLCC0/V07ZUON455aUmWASVuG4Qp27i3cN
        59nwKJmNqjK/RCbhmFKG3mM0f5Ge7axnlF8MmcuEz/gn+x3h7zlsYozovdMHPBli
        SDkK8jzkZjvRcffS6wCDg9PCXRkDJBDDFvX67tTU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43B5E3F68C;
        Tue, 27 Sep 2016 13:05:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B60573F68B;
        Tue, 27 Sep 2016 13:05:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [Q] would it be bad to make /etc/gitconfig runtime configurable?
Date:   Tue, 27 Sep 2016 10:05:37 -0700
Message-ID: <xmqqoa39p926.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DD95D62-84D4-11E6-96C2-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subject says it all.  Would it be bad if we introduce an
environment variable, GIT_SYSTEM_CONFIG=/etc/gitconfig, that names
an alternative location of the system-wide configuration file?

That would supersede/deprecate GIT_CONFIG_NOSYSTEM that we
introduced primarily so that we can run our tests without getting
affected by the configuration that happens to be effective on the
host that the test is being run.

