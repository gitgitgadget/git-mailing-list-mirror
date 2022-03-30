Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AC9C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiC3WxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351736AbiC3Ww4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:52:56 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4159E68F9E
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:51:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=cG86M2NDH2B+8dovCVifO/NxJQQXQJtV/fo85S+tokn/JA11tRd4/myYTSmnFs1QGSWxsiS3pV/i5tavAYEZHsrTaorZ0bqh5TmTWpkYfrbIWptYHoZLWfAklbzq/7kc5M05fwYNf+1bGSqOb6Q1FkPup5ofRyelutSk3uwTwoeH3qR5HnaRzyowy0Zl8pMkJl49vf5iVFF2h169jWW76r5h0kh3Hvz7wV5GvAr4mW9e2El9fxxIk6mnuwojkzUMvps1zRXdDC5RaISmztfNL39nSfBbmrQ4mTSw4+xtFYBCnOjP8pD8u51M+nGKDp3oe7SGNHiUMzko2zrfHpwE0w==; s=purelymail1; d=slashdev.space; v=1; bh=PMWs8PtibeoUosHx5zFKqsaNjDnxeVUeRV1uhLViAow=; h=Received:To:From;
DKIM-Signature: a=rsa-sha256; b=UeazeXwG1imE1EkfqNeGNlI1PfxeHTQbL6gKD7wUwcpU/UN7I0CqZWKuQhwQBIntc5jQK3jK3CR6qjgM+XuG4OshDZd92P2BxxTMt4COLM4cAruwwmRP06Ytmr1/SDPjUvT85lgbK92/JHngtEziHKKy6XCXdOSpOK2Pe5lylRF6kJx/KRY7d9Y/Gio13QUsGd7ZYwGA75i/XC5rgv6IrHp2nu1SaypR85F3/pR+o4KhRP1V24CX+bU6obwNxIXZcRhJTfynaSo9WVrdAT0WMuAzG69rPs3AFzJPxx+hQzIhrfEK+5yHUdhC9Ef30J89BtpeadScskhLuLcaXpQPDg==; s=purelymail1; d=purelymail.com; v=1; bh=PMWs8PtibeoUosHx5zFKqsaNjDnxeVUeRV1uhLViAow=; h=Feedback-ID:Received:To:From;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -228430439;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 30 Mar 2022 22:50:58 +0000 (UTC)
Message-ID: <fb915b91-ead2-ac35-4431-ad35674da463@slashdev.space>
Date:   Thu, 31 Mar 2022 00:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2] cli: add -v and -h shorthands
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20220330190956.21447-1-garrit@slashdev.space>
 <xmqq5ynv6rb4.fsf@gitster.g>
From:   Garrit Franke <garrit@slashdev.space>
In-Reply-To: <xmqq5ynv6rb4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30 2022, Junio C Hamano wrote:

> Sorry, but it is unclear why it is a good thing.

My main motivation behind this change was a standardized user experience 
across tools. Many users use these shorthands out of habit to get an 
overview of a program. Seeing the command fail and having to retype it 
in a longer form creates unnecessary friction between the user and the 
program.

 > Again, it might be safe right now, but it also closes the door for
 > introducing global "verbose" option.  What in exchange are we
 > gaining?  Are these short options worth it?

I definitely see your concerns. Ultimately it's a question of which of 
the two flags would be more convinient to have as a shorthand. As stated 
above, users unfamiliar to the software arguably expect to see the 
version number printed when using this flag. A user who seeks more 
verbose output is probably more familiar with the options, so they are 
more likely to know they have to use the longer "--verbose" form.

Thanks
Garrit
