Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63A220248
	for <e@80x24.org>; Fri,  8 Mar 2019 17:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfCHRnx (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 12:43:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54184 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfCHRnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 12:43:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27CBF61F70;
        Fri,  8 Mar 2019 12:43:49 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=CURT4m94V98BQOK8dbj0K2nrhJc=; b=bvrZHdV
        YmijtkRRht95u+cyClnGR7Ivq0V5XqEPbEsdd/4+wh2RSsQ03Z31O6lVgA3sqSw1
        qH0KnP/X5gVQXyQfzgt+jswACLjKNv1QReiotErdmgD/pJscDh9y9ySjg75WZTN0
        4lPlqq9sg0uutmqRsOuDlXw4DhrIitY0Y62M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=nhc1jGGsYVNNpRb75drk5MkmEAu9KfHpH
        ftizVV4H0Qg9AqaKQNkxrOcYHqmUf46cSHiuHss6f8KMRu0Q93HO0P5mRcfCDVm7
        2YtqjvMwWSmdor9xtVytBxgRolhGEoQ8RYypKVAAheFTGH0OOF69Lnya/pwvhxy9
        h3tIMs0auM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FC9061F6F;
        Fri,  8 Mar 2019 12:43:49 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 03A0761F6E;
        Fri,  8 Mar 2019 12:43:45 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Fri, 8 Mar 2019 12:43:43 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: One failed self test on Fedora 29
Message-ID: <20190308174343.GX31362@zaya.teonanacatl.net>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: B921F174-41C9-11E9-863C-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeffrey Walton wrote:
> Fedora 29, x86_64. One failed self test:
> 
> *** t0021-conversion.sh ***
[...]
> not ok 13 - disable filter with empty override
> #
> #               test_config_global filter.disable.smudge false &&
> #               test_config_global filter.disable.clean false &&
> #               test_config filter.disable.smudge false &&
> #               test_config filter.disable.clean false &&
> #
> #               echo "*.disable filter=disable" >.gitattributes &&
> #
> #               echo test >test.disable &&
> #               git -c filter.disable.clean= add test.disable 2>err &&
> #               test_must_be_empty err &&
> #               rm -f test.disable &&
> #               git -c filter.disable.smudge= checkout -- test.disable 2>err &&
> #               test_must_be_empty err
> #
[...]
> # failed 1 among 26 test(s)
> 1..26
> gmake[2]: *** [Makefile:56: t0021-conversion.sh] Error 1
> 
> Does anyone need a config.log or other test data?

It would probably help to know what commit you're building.
The verbose test output would also be useful, e.g.:

    cd t && ./t0021-conversion.sh -v -i

If it's not reliably reproducible, the --stress* options
might help catch a failing run.

FWIW, I just built and ran the tests on a Fedora 29
container for master, next, and pu a few times (some with
various --stress options) without any test failures.

I did this with and without a config.mak from the fedora git
packages.  I've never used the configure script, it seems
like unnecessary overhead.

    $ git branch -v
      master 6e0cc67761 Start 2.22 cycle
      next   541d9dca55 Merge branch 'yb/utf-16le-bom-spellfix' into next
    * pu     7eadd8ba98 Merge branch 'js/remote-curl-i18n' into pu

-- 
Todd
