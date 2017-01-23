Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962A920A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdAWSWu (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:22:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55134 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751206AbdAWSWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:22:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BF4961D60;
        Mon, 23 Jan 2017 13:22:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sUtioBGS+HBXyy7hWwPA3Sfo/VU=; b=OiyHbC
        6TcunXqBZN0lUxqHlYlqWZ3ckn4/rqzrAkyVh2ekpB6q6yiMJsa1iBxf+vtBItTK
        fYIdIlEJO9alUp8RabxeeLcr2EwgM+lKwDD5/nQ6KSsvftMdrDSCWMdwsz/LI+F5
        IYnuVrszqoVgkjJmb+dQTrW16tIdIY24ZILrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XirldgIRrALTN6VWU8JT64NL/HXlhOOT
        1t3FuRNW6UUGmLnArDNoj1RR6X1VtXj8BJjQ/LlbmWKe3cgaIU6j/WSZrGkQrXzY
        Dbg+6CRjx3y4QrbM4NQpOGgEMfeZTABb4Jy4xdW7z5jePT7SoatVdAZpGfYvOJ+S
        sJnUSGqZf8w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 903EE61D5D;
        Mon, 23 Jan 2017 13:22:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB03D61D5C;
        Mon, 23 Jan 2017 13:22:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: fix Perforce install on macOS
References: <20170121144245.31702-1-larsxschneider@gmail.com>
Date:   Mon, 23 Jan 2017 10:22:46 -0800
In-Reply-To: <20170121144245.31702-1-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Sat, 21 Jan 2017 15:42:45
        +0100")
Message-ID: <xmqq8tq1tz49.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F139D45C-E198-11E6-9632-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> Could you fast track the patch to `maint` if it works without trouble on
> `next` (as it should!)?
>
> Notes:
>     Base Commit: 787f75f056 (master)

I do not think there is any difference between 'maint' and 'master'
for this file right now, but I still would have appreciated if this
line also said 'maint', not 'master', if you want it to go to
'maint' eventually ;-) As https://travis-ci.org/git/git/builds seems
to be doing 'pu', too, hopefully we'll catch any issues there first.

Thanks.

>     Diff on Web: https://github.com/larsxschneider/git/commit/ec7106339d
>     Checkout:    git fetch https://github.com/larsxschneider/git travisci/brew-perforce-fix-v1 && git checkout ec7106339d
>
>  .travis.yml | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 3843967a69..c6ba8c8ec5 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -75,20 +75,13 @@ before_install:
>        popd
>        ;;
>      osx)
> -      brew_force_set_latest_binary_hash () {
> -        FORMULA=$1
> -        SHA=$(brew fetch --force $FORMULA 2>&1 | grep ^SHA256: | cut -d ' ' -f 2)
> -        sed -E -i.bak "s/sha256 \"[0-9a-f]{64}\"/sha256 \"$SHA\"/g" \
> -          "$(brew --repository homebrew/homebrew-binary)/$FORMULA.rb"
> -      }
>        brew update --quiet
>        brew tap homebrew/binary --quiet
> -      brew_force_set_latest_binary_hash perforce
> -      brew_force_set_latest_binary_hash perforce-server
>        # Uncomment this if you want to run perf tests:
>        # brew install gnu-time
> -      brew install git-lfs perforce-server perforce gettext
> +      brew install git-lfs gettext
>        brew link --force gettext
> +      brew install Caskroom/cask/perforce
>        ;;
>      esac;
>      echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)";
> --
> 2.11.0
