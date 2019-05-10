Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCCF51F45F
	for <e@80x24.org>; Fri, 10 May 2019 16:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfEJQ5i (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 12:57:38 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:40629 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfEJQ5i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 12:57:38 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id P8pzhG4Pwp7QXP8pzhVY2M; Fri, 10 May 2019 17:57:36 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=LCD9t0dvo01R78KsqUQA:9 a=QEXdDO2ut3YA:10
Subject: Re: Request to add option to interactive rebase to preserve latest
 commit date
To:     Junio C Hamano <gitster@pobox.com>,
        Peter Krefting <peter@softwolves.pp.se>
Cc:     Jeff Schwartz <jefftschwartz@gmail.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.org>
References: <CAL3M-FZ7b3H7Z+Vr9Wbey5iYVoWiUBnDKVEenyAMrUXeNfL56w@mail.gmail.com>
 <xmqq4l6kvnuu.fsf@gitster-ct.c.googlers.com>
 <alpine.DEB.2.20.1905010900260.23829@perkele.intern.softwolves.pp.se>
 <xmqqtve6nbfv.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <412f07c2-3ab2-0902-89bd-21e8fe8dc190@iee.org>
Date:   Fri, 10 May 2019 17:57:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqtve6nbfv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfLtO+Fi7yl2b3QsfVLYbucT5W0FOoofpE6VG+I2u11B8jeBjLpkZvSjShpbL6aRmG/CQbt+QtZEGLPdYhK0LluqXOxk2Yjoy22nJTFR7UvWWbI0D3Txk
 eVsD7ly/q/6rCg3wuLGCIo1h1EJvdrIkuAkXe8uIxYIoAw/OJs+pgFy/NMpVJ+Ag5iphw11ILbL85oVDPkKtSNGdcm+pYnSGs2ZlOtgGIJazvhiIS41EZ+b5
 VnIQ1q+CYLGpW2oFXI/oGutgQn26C8NVjd5ntE7k5izRjJKPcxQtRZ+Bu/RFrSV7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05/2019 05:19, Junio C Hamano wrote:
> The principle is "the bulk of the work was done in A, no matter what
> is done incrementally by squashing in or amending small refinements;
> the primary authorship date and time stays the same as the original".
>
> When the person who is correcting other's change with --amend makes
> a contribution that is substantial enough such that the amended HEAD
> no longer resembles the original HEAD, there is a mechanism to let
> the amender take authorship,
IIUC the effective change in authorship was noted in another thread 
about a perceived problem in rebase, and it just bit me as well recently 
(and the Github PR bot rejected my series for a mismatched 
author/sign-off :-(.

If a commit is edited in a `rebase -i` then I think the same can happen, 
resulting in the same user surprise at the change. Possibly a simple 
documentation note may help reduce user surprise.
> i.e. do this at the last step instead
>
> 	$ git commit --reset-author --amend -a
>
> in the second sequence.  I do not think there currently is an
> equivalent in "rebase -i" language to do so.
--
Philip
