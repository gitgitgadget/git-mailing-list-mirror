Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CC7C433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA732071B
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NUkJ7Lmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgH2SeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:34:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57631 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SeB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 14:34:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6442D6FEF8;
        Sat, 29 Aug 2020 14:33:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FWjCxgwpkrk5o2Pf3KrQlM3ABK4=; b=NUkJ7L
        mpXS5gAmowVruKHimbZp/T04QFQ6LNwg/0XEH+uE8JHhYAoAaflVPibfdopi/Taz
        6/wdOzukabepidZwmrTP6a4WY0JBXPL/NRM4ZVjrIUoiCzpXd3CiOUhk4GKAKBis
        pm8W00YyKQBoxHeQprFSbjWEjt2Z77/gwra/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vuKEKnslyMJDp/V4A2QGW53I0jN1iCLV
        XcbAf9p2ij+pCE0kF8twbGHhMMn+yHTPFPRTWeQUniEFx5oZ85Z2Z6xRItv+1Roy
        HvL0ZlZ8zVDPQEs8z8EQ/lh6geLa0G+zYLJdf6Ku+7q+fWJajKx6FJVJrGhpjPMD
        X/J0Bqlrgsc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AB5D6FEF6;
        Sat, 29 Aug 2020 14:33:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDB456FEF5;
        Sat, 29 Aug 2020 14:33:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-send-email.txt: Mention less secure app access might need to enable.
References: <CAPig+cT8Kmh6LcoKqkcJX6imXaase07o8C_-7k7RkyhEyW02rQ@mail.gmail.com>
        <20200829153920.17155-1-vvavrychuk@gmail.com>
Date:   Sat, 29 Aug 2020 11:33:56 -0700
In-Reply-To: <20200829153920.17155-1-vvavrychuk@gmail.com> (Vasyl Vavrychuk's
        message of "Sat, 29 Aug 2020 18:39:20 +0300")
Message-ID: <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32BE9EE6-EA26-11EA-AB53-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasyl Vavrychuk <vvavrychuk@gmail.com> writes:

> Looks like Google changed Gmail security and now less secure app access
> needs to be explicitly enabled if 2-factor authentication is not in
> place, otherwise send-mail fails with:

'send-email' I presume?

>   5.7.8 Username and Password not accepted. Learn more at
>   5.7.8  https://support.google.com/mail/?p=BadCredentials v5sm13756502ede.13 - gsmtp

Is the v5sm1375... part stay constant that everybody would get the
same thing?

Otherwise,

    ... otherwise send-email fails with an error message from Gmail
    server telling the user to "Learn more" at 
    https://support.google.com/mail/?p=BadCredentials

would be preferrable.

> Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
> ---
>  Documentation/git-send-email.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 0a69810147..06953fd1e0 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -494,7 +494,11 @@ edit ~/.gitconfig to specify your account settings:
>  	smtpServerPort = 587
>  ----
>  
> -If you have multifactor authentication setup on your gmail account, you will
> +If you do not have multi-factor authentication set up on your Gmail account, you
> +will need to allow less secure app access. Visit
> +https://myaccount.google.com/lesssecureapps to enable it.
> +
> +If you have multi-factor authentication set up on your Gmail account, you will
>  need to generate an app-specific password for use with 'git send-email'. Visit
>  https://security.google.com/settings/security/apppasswords to create it.

In 2020, we should probably list the instruction for those with 2
factor first and then give "less secure app access" as a fallback.
IOW, I'd suggest the order of these two paragraphs swapped.

Thanks.

