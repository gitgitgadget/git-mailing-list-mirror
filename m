Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAAC12022A
	for <e@80x24.org>; Mon,  7 Nov 2016 22:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbcKGWej (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 17:34:39 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34560 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbcKGWei (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 17:34:38 -0500
Received: by mail-wm0-f67.google.com with SMTP id p190so19020867wmp.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Zqcw8HYWX2uQcNKWm23pjO53yI7T7Hro5fWduQwS7MQ=;
        b=bpkaIddgbkz0R96ONUaeRBGb6d3XdhA8rD6XTdKAjwnGwv/h9S5lE6qR9Ra+U2Ch3h
         5FKFRkXsyXcCXvxHqvQFKKJza17R+FzvfsxUtgdxZiWIAl5hQZFf30XgpVzClIqrwY1T
         x5G88YJCqkLktsKbnKeyi7T8sK+74GorCMLyM5syqQ1oE3HSMre9XWWqgpattLAkYXTS
         gFLnhjZazYzf3a++MV55vLjjxjq+kMosYVRfY5+SwZBNvsZCQAdtTnG4jwsUhQSjRWto
         zBza3oWFHMvgDhbmrwr8lVUMl+KxcS0O5/ib0OAspov2a3YAlzJDxV4Ug2NF7iSfsUFO
         ycGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Zqcw8HYWX2uQcNKWm23pjO53yI7T7Hro5fWduQwS7MQ=;
        b=F1+f0F84t/CgNJGYz2yp4NKhd+5cXCKjjLuc/wQwlxShce9joiHw4GIxO4Pmq0Jfj0
         I1uI7/9+b9CCCFgu/IIXxdqCgwcSsx/nhGLC7+7Rp45/ErulJ07RspEmEIfOYdC2Vl/u
         BmDYzgSuOcDem+5PQC++zMgnhrZ6V5I8Az+sOkwiY1Nm3iZkJ4jYrfStKwj5d2RNj8nZ
         KooednLHdaxlJDE82vcvRMiq7KH849l+a/VqiByg44Ucvkg3+bjo7IkFydDV/9DblrGs
         aYEm1zkBLicYzwKHQhtIAj6y8bmXnx6QAc4fY0+3R7E35M6UEXHO9w2DXmrx+J8eSgyy
         ayDA==
X-Gm-Message-State: ABUngve68Y2eIoRVi6Ef5EzHj/OyY5abLq3Ap6J9WLMhsaefrLoXIjuSjX/2MVP2h4pgdQ==
X-Received: by 10.28.158.209 with SMTP id h200mr12125676wme.54.1478558076860;
        Mon, 07 Nov 2016 14:34:36 -0800 (PST)
Received: from [192.168.1.26] (afv251.neoplus.adsl.tpnet.pl. [83.25.151.251])
        by smtp.googlemail.com with ESMTPSA id a1sm33559997wjl.28.2016.11.07.14.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2016 14:34:36 -0800 (PST)
Subject: Re: Git issue - ignoring changes to tracked file with
 assume-unchanged
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <BY2PR0601MB16400EAC3E9683841907F4B2A2A10@BY2PR0601MB1640.namprd06.prod.outlook.com>
 <20161101174526.e2tilsriz2fqaru3@sigill.intra.peff.net>
 <xmqqy413oysp.fsf@gitster.mtv.corp.google.com>
Cc:     "Halde, Faiz" <fhalde@paypal.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <9784a23f-2f44-33c7-5055-c6d66e779471@gmail.com>
Date:   Mon, 7 Nov 2016 23:34:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqy413oysp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 01.11.2016 o 19:11, Junio C Hamano pisze:
> Jeff King <peff@peff.net> writes:
>> On Tue, Nov 01, 2016 at 10:28:57AM +0000, Halde, Faiz wrote:
>>
>>> I frequently use the following command to ignore changes done in a file
>>>
>>> git update-index --assume-unchanged somefile
>>>
>>> Now when I do a pull from my remote branch and say the file 'somefile'
>>> was changed locally and in remote, git will abort the merge saying I
>>> need to commit my changes of 'somefile'.
>>>
>>> But isn't the whole point of the above command to ignore the changes
>>> within the file?
>>
>> No. The purpose of --assume-unchanged is to promise git that you will
>> not change the file, so that it may skip checking the file contents in
>> some cases as an optimization.
> 
> That's correct.  
> 
> The next anticipated question is "then how would I tell Git to
> ignore changes done to a file locally by me?", whose short answer is
> "You don't", of course.

Well, you can always use --skip-worktree.  It is a better fit than using
--assume-unchanged, because at least you wouldn't loose your precious
local changes (which happened to me).

OTOH it doesn't solve your issue of --skip-worktree / --assume-unchanged
blocking operation (pull in your case, stash is what I noticed problem
with when using --skip-worktree).

But --skip-worktree is still workaround...

-- 
Jakub Narębski

