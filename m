Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885791F453
	for <e@80x24.org>; Mon, 29 Oct 2018 07:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbeJ2Qnk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 12:43:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36357 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ2Qnj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 12:43:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so6907224wmf.1
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BUOpLIzkbNFNUEiPg0pEvygQtYPy/0ByJAQbz5yu5ZA=;
        b=DSko2qrEyxrhKr/gt2HBSz2mwdHH5lqRKngtE7UKXQyrjlGfeu4P8hVPG1NNmMhfRC
         tiwUiZAUog+xoiwaNbLxTsiZfwGMRaXfBsf6t0OJZtSZMNYmsVAAVVZrI2Q393u2gVmT
         CfNaxW6Xu5QR/IDIrDwFzdAWGB9Ddz4fcg6QEx5ekuqvN2DcnEcu6ioxFiFChjg5qKEo
         EYJG18egpn5TU1eFqAafojvCWDd4sIeyTAjTDqLWFvAd8YUET3kzUyMUx2ZO4MhCFZvO
         mIRmFFUBPS7WYHQfLoeXUhqD7/riI3JIe84/75NYW/V69r9TbPdE8YOKVv2q4wAT9ztl
         c6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=BUOpLIzkbNFNUEiPg0pEvygQtYPy/0ByJAQbz5yu5ZA=;
        b=jD2+fk2HPyIKYlR47UwuGxQrmQubnHTJ2hJQGiWEI2h5Y4DgUzD66+CDwXyrI73NMh
         weSa5xXNEiodvPuwdT1cc3udzxUg3QzjwcArajHl/uxA1cUFqGR/pTUUKRCusBoCZVLX
         eUE3nBYuQFnzNx/lsnY+az0+BTHSk5jgstabI8YwXP/UtMsgpU/tl4reAMRH7zcZkzeL
         DDN2HzYT/67txJzYQLsTsom/Uv0p7EkVjILlSqvE/8pC3mtCe9i7QDBATL4/N03nfF+i
         KWPZj+wzypLJD5hzdnb3vIulspIjYNVwwG6fCeDpCbiBM27Fv8SZDi26iu0wHSJMNYqa
         Yv0g==
X-Gm-Message-State: AGRZ1gKAPx9LS1PhLuhq4MGrkPf/1EPq0SdX2/D0wKhSl6EucVJ2Ah3B
        lORpnnBFk4x0jyoWsYzdsTQ=
X-Google-Smtp-Source: AJdET5cv10QtSQBzZYlQnO79bP/87zkkTDXJkznhlrMJuNJesZaA84Z6EWL+w8CbtQIHbyWtdG6FKQ==
X-Received: by 2002:a1c:410b:: with SMTP id o11-v6mr8335451wma.49.1540799766493;
        Mon, 29 Oct 2018 00:56:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b143-v6sm19547740wma.28.2018.10.29.00.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 00:56:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/12] remote.c: mark messages for translation
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181028065157.26727-9-pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 16:56:02 +0900
In-Reply-To: <20181028065157.26727-9-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 28 Oct 2018 07:51:53 +0100")
Message-ID: <xmqq36sp425p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> @@ -995,12 +995,12 @@ static int match_explicit_lhs(struct ref *src,
>  		 * way to delete 'other' ref at the remote end.
>  		 */
>  		if (try_explicit_object_name(rs->src, match) < 0)
> -			return error("src refspec %s does not match any.", rs->src);
> +			return error(_("src refspec %s does not match any"), rs->src);
>  		if (allocated_match)
>  			*allocated_match = 1;
>  		return 0;
>  	default:
> -		return error("src refspec %s matches more than one.", rs->src);
> +		return error(_("src refspec %s matches more than one"), rs->src);
>  	}
>  }

These minor changes that are not accompanied by their own
justification mean that the patches in this series cannot blindly be
trusted, which in turn means that I won't have bandwidth to process
this series properly for now.

I also saw die() -> BUG() that was not highlighted in the proposed
log message; the single instance I happened to notice looked
sensible, but I am not sure about the others.

There are other series in flight that touch the same area of code
and in different ways, causing unnecessary conflicts, which does not
help us either X-<.


