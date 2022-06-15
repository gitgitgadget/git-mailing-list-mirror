Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9959AC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbiFOKKu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 15 Jun 2022 06:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiFOKKs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:10:48 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C46F39816
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:10:47 -0700 (PDT)
Received: from Mazikeen ([91.110.128.244])
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 25FAAgD3006441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Jun 2022 06:10:43 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Test Failure t5516.113 RE: [ANNOUNCE] Git v2.37.0-rc0
Date:   Wed, 15 Jun 2022 06:10:36 -0400
Organization: Nexbridge Inc.
Message-ID: <01e801d880a0$2c5e4d50$851ae7f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdiAn9uDBZBC+JdZSy6xI1CoQt0FNw==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 13, 2022 9:46 PM, Junio C Hamano wrote:
>An early preview release Git v2.37.0-rc0 is now available for testing at the usual
>places.  It is comprised of 339 non-merge commits since v2.36.0, contributed by 59
>people, 18 of which are new faces [*].  There are a few topics that we may want to
>merge before the final release, which will be in -rc1 that is planned to be tagged at
>around the end of the week.

This one keeps showing up occasionally. I am not sure why, but I am not certain bash likes ! grep. This only happens on our NonStop x86 build, which is a more recent platform than the ia64, where the construct succeeds. Have we not moved away from that?

not ok 113 - fetch warns or fails when using username:password
#	
#		message="URL 'https://username:<redacted>@localhost/' uses plaintext credentials" &&
#		test_must_fail git -c fetch.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
#		! grep "$message" err &&
#	
#		test_must_fail git -c fetch.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
#		grep "warning: $message" err >warnings &&
#		test_line_count = 3 warnings &&
#	
#		test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
#		grep "fatal: $message" err >warnings &&
#		test_line_count = 1 warnings &&
#	
#		test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:@localhost 2>err &&
#		grep "fatal: $message" err >warnings &&
#		test_line_count = 1 warnings
#	

Thanks,
Randall

