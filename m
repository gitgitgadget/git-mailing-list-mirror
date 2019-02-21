Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CB11F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfBUU6m (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:58:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62714 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUU6m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:58:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07B1C13CBFE;
        Thu, 21 Feb 2019 15:58:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=dgIKmDrpQGTuEyX7NMnC//X/0Kw=; b=T/63bHP
        A5FBQHLncd9zTfr8VGm9q+tOJ/R+ookRQ+WLjjYco8U2apAictqRjgrMltSXcWfq
        APAGf4WzIBQ1SRGPyPWUDz4OGsY+ABaHvM2aJx3TJykGLDJNxG2r7mlF2B7mg4Sj
        NU4vC+CxKBbeReBdAhQPY8p9q0neCVeqJduI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=u2P7U5zyT7GprUA5SgURUJaHBMbrJyf1X
        dbo4FOkfvXzyGXDW7AjZdLMJXKgiBnYfqgNLE8sgbz6i6Gxqor/4/yPDAeeobath
        OslcQPvNsWJFlpYe+QLLNkxK8wKzV0TVeMUtyAbUvaXoADUbWibqplItY9UNQuDU
        t2pAUDjIo0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1E7B13CBFD;
        Thu, 21 Feb 2019 15:58:39 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BE1F13CBFC;
        Thu, 21 Feb 2019 15:58:39 -0500 (EST)
Date:   Thu, 21 Feb 2019 15:58:37 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Suggestion] Add Skip for t9020
Message-ID: <20190221205837.GX16125@zaya.teonanacatl.net>
References: <004b01d4ca23$faebcad0$f0c36070$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004b01d4ca23$faebcad0$f0c36070$@nexbridge.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 76B5FD44-361B-11E9-A6B2-F733E42159A7-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Randall S. Becker wrote:
> On February 21, 2019 15:00, I wrote:
>> t9020 subtests 1,2,5,6 failed - Not new. unsurprising as there is no SVN or
>> perl with SVN module on platform. It might be useful to have a detection to
>> skip of Perl SVN is not present.
> 
> While this is a bit of a hack, it might be useful for skipping t9020 in
> environments where the svn.remote package is not installed. I can make this
> into a patch if this style is reasonable - guessing probably not and that
> the REMOTE_SVN test should go elsewhere if it is called that.

Jeff King sent an RFC patch which would remove this test and
the rest of the vcs-svn experiment in August[1].  Jonathan
Nieder replied as one user who would rather see it moved to
contrib/, so it was held off.

Whether that has any impact on adding a way to skip all the
tests here, I don't know.  Maybe it's a gentle nudge in
favor of moving them to contrib?

[1] https://public-inbox.org/git/20180817190310.GA5360@sigill.intra.peff.net/

-- 
Todd
