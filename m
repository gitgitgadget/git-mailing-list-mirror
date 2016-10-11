Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD71D1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbcJKTZS (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:25:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58404 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751765AbcJKTZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:25:16 -0400
X-Greylist: delayed 1001 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Oct 2016 15:25:16 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B8C04240C
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 15:07:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :subject:message-id:mime-version:content-type; s=sasl; bh=nbj5tb
        I17Xf40sAqEYu/rvMPl4Y=; b=geSUwGyO+jJZ/D5lHM97fw6usqXgQzLo8IA1tp
        Mmohl9cAc8RD/z5vEwZuaN1yeS5KzM1jDpdrMKpWGsf1//iQObOMcdCdEscs1kR1
        yE6xXVAKkS84QE87MrN+QQwlS5XwzBeGh3tEUfMIlhEHD5LzvLVcFt9YdLcD3vRD
        iJ9Io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to
        :subject:message-id:mime-version:content-type; q=dns; s=sasl; b=
        sxRMrgp9Bm+zIjoAYWfRDldExOMnOolufDXU7BgWET64YrwFXTB4GvoXKi/HcIK7
        2mxtu4seNPlY3YOtW0awDn0fg5slJyaXZ/l2yPxGzu9qBHIYKCZuzMT/hcd+NiGR
        iZCCKw1c9+s5virso51Bx9i9MVAz3WOHGzTf/s88af0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8423D4240B
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 15:07:48 -0400 (EDT)
Received: from pobox.com (unknown [73.251.167.225])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB53A42406
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 15:07:46 -0400 (EDT)
Received: by pobox.com (sSMTP sendmail emulation); Tue, 11 Oct 2016 15:07:45 -0400
Date:   Tue, 11 Oct 2016 15:07:45 -0400
From:   Joshua N Pritikin <jpritikin@pobox.com>
To:     git@vger.kernel.org
Subject: interactive rebase should better highlight the not-applying commit
Message-ID: <20161011190745.w2asu6eoromkrccu@droplet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://people.virginia.edu/~jnp3bc/pubkey.asc
X-PGP-Fingerprint: 275A 6673 208B 1E36 CDEC  5188 281A 7053 6127 B3F7
X-PGP-ID: 0x6127B3F7
User-Agent: NeoMutt/ (1.7.0)
X-Pobox-Relay-ID: FF12C1B0-8FE5-11E6-B6B1-5F377B1B28F4-03616332!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of GIT 2.8.1, if you do an interactive rebase and get some conflict 
in the stack of patches then the commit with the conflict is buried in 
4-5 lines of output. It is visually difficult to immediately pick out 
which commit did not apply cleanly. I suggest highlighting the 1 line 
commit summary in red or green or some color to help it stand out from 
all the other output.

I decided to suggest this change after I realized that I probably 
skipped a commit during an interactive rebase instead of resolving the 
conflict. I knew I had to skip some commit so I assumed that I just need 
to skip without reading the commit summary carefully. Now it is 7-15 
days after I did the erroneous rebase. I had to spend a few hours today 
with GIT's archaeology tools to find the lost code.

I assume somebody familiar with GIT's code base could make this change 
in about 10 minutes.

-- 
Joshua N. Pritikin, Ph.D.
Virginia Institute for Psychiatric and Behavioral Genetics
Virginia Commonwealth University
PO Box 980126
800 E Leigh St, Biotech One, Suite 1-133
Richmond, VA 23219
http://people.virginia.edu/~jnp3bc
