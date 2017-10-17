Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366281FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 17:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759312AbdJQRKu (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 13:10:50 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:47301 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759282AbdJQRKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 13:10:49 -0400
Received: by mail-it0-f48.google.com with SMTP id p138so3398498itp.2
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 10:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jVnaRcIdCwaBJKTn9u5k2E+oAeOa0ryOx8IAmKQrzKA=;
        b=JUUaLAIpf2UedvbN/NfEwf5gwZh2RwhIN1WV8J4X91HNdG085tZy/KmvpR8CqAIFCm
         XVDIolQf+oZptMoqMo9HEc9MDyAxj8mflj5fJ/qgAXJZLcUxE2KzppoQaI6U6oDFdb5p
         F7GFqJh9S+lqP1BfeONBafh6V/Y99NfQBNk+bvzVDncseM8fJ5YzQGlkuuEDFHdJudta
         ur11g1YVs/Mwl++XLiGddKJ3eCYqIwJ91Y4SDSHtx0HZsZ2sv0q138LKJMj4CovTiXB4
         uZ+qOpjhxr8WjfqgSMndoJvLLC2+/RFLjvy/1lg3608VHql0nWEgX0eLhTUQ4uuOTUJI
         npOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jVnaRcIdCwaBJKTn9u5k2E+oAeOa0ryOx8IAmKQrzKA=;
        b=fpNgBHk5K0iWFv9KleNtLZtk5qdS2SXGp+P2qnwwnvxVrdSnX7aYbm5fRNEUfl17dF
         tA89YsJslST0WZTiNGytYA3WdBNsdk6PtLbgtQpnz/sGIA5rmBBaSxrsmNfeTVHmQsW8
         bY/NOzx6FQ5/myvTdfkk9JmuRVK3GBPAT9YlHCg+Qk/0n+xDP/qkVAdTTYXOr3pm5H/o
         qi7UwVSf8jWQVQGTQKZn+L5Pj7+zR1+MrXlfcrxin9YE9dEK/HjTMscBPY8FYN4B/m5J
         wKpyA8PN6kHOYPyAcimlCTDx6brmePxcLWYo2k/GUHfKAFQY/jifMK0v/+F1eNHkZc7M
         L3yA==
X-Gm-Message-State: AMCzsaUPLOvhHcTVDov2ht2nwCfjFY0mK82YIReImlaTcTSXflCWSkq9
        6wo8HCUaB+ME1c++tWJDuwVfOg==
X-Google-Smtp-Source: ABhQp+QUE1CPLoW4KszttV63HdE0ZDP3d7/CX0ev2U8cWrIkLjVOGON/lZv6JA86F1iw16XevWibXQ==
X-Received: by 10.36.34.11 with SMTP id o11mr6786568ito.70.1508260249124;
        Tue, 17 Oct 2017 10:10:49 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3037:268d:49a2:8de3])
        by smtp.gmail.com with ESMTPSA id m141sm3008098itm.12.2017.10.17.10.10.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Oct 2017 10:10:48 -0700 (PDT)
Date:   Tue, 17 Oct 2017 10:10:46 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Is t5601 flaky for anybody else?
Message-ID: <20171017171046.GA48544@google.com>
References: <xmqq376ipdpx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq376ipdpx.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17, Junio C Hamano wrote:
> I seem to be seeing sporadic errors with this test, and today I got
> annoyed enough to do
> 
> 	cd t && while sh t5601-clone.sh -i -v; do :; done
> 
> I saw an error from "cp" saying "plink.exe - text file busy" or
> something like that at around test #45; here is an workaround that
> seems to work (the above loop is spinning without problem for
> several minutes now).

I haven't noticed any issues myself but maybe this has something to do
with my changes to this test in the 'bw/protocol-v1' topic?

> 
>  t/t5601-clone.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 9c56f771b6..50e40abb11 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -308,6 +308,7 @@ test_expect_success 'clone checking out a tag' '
>  
>  setup_ssh_wrapper () {
>  	test_expect_success 'setup ssh wrapper' '
> +		rm -f "$TRASH_DIRECTORY/ssh-wrapper$X" &&
>  		cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
>  			"$TRASH_DIRECTORY/ssh-wrapper$X" &&
>  		GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper$X" &&
> @@ -318,6 +319,7 @@ setup_ssh_wrapper () {
>  }
>  
>  copy_ssh_wrapper_as () {
> +	rm -f "${1%$X}$X" &&
>  	cp "$TRASH_DIRECTORY/ssh-wrapper$X" "${1%$X}$X" &&
>  	GIT_SSH="${1%$X}$X" &&
>  	export GIT_SSH

-- 
Brandon Williams
