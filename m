Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF1620282
	for <e@80x24.org>; Mon, 19 Jun 2017 09:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbdFSJuA (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 05:50:00 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:43158 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbdFSJt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 05:49:59 -0400
Received: from [192.168.2.201] ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id MtJkdJXoJHGLwMtJldUx40; Mon, 19 Jun 2017 10:49:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497865798; bh=mqQrrOHCdULsXpzt1TmSzJdxQo4Dgi4wH2NAGjKb6oY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h7KBS8ST/z1u1nupB9rn1vAGMUAETDi79qQXxbubGkRm40xghghi9JgP8xNr3acyT
         ayuuOTXGB/PgJXFQAhC3ryo3qcfbTL2C6eO8HpdhMZVAy6333yyNYjGbDuh6s5M4Sk
         IVVyoOqN2beRXPjHklgBAfJIvVjSaS3A8gqcacYE=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=N659UExz7-8A:10 a=FQEkU6l08S6ofmmcvIEA:9
 a=pILNOxqGKmIA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i fixes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170614102427.5220-1-phillip.wood@talktalk.net>
 <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com>
 <xmqqk24cygvm.fsf@gitster.mtv.corp.google.com>
 <xmqqfuf0ygmu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706161527140.4200@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <969f3069-d386-a2ec-736d-e67d6f17a590@talktalk.net>
Date:   Mon, 19 Jun 2017 10:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1706161527140.4200@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGyq41999+NzX/W+kqvgEJ+rqAwSchmTArlIjTio1KgNcOqwNiT369eaS5lHobiyh/N1VyxBwpvjANMh09kMvXsQrVJLg58D+AON1oR09361Q+0GJgze
 u/av6iXvcrQpC4NMGzZ3FKjDzufiDlTTxqEsNtQDVSDhfD5dsCI1DdEIDzF+MMyVl2BdAWpxg1oJWmXPMX4jojq8RG4MBbZf1QyfODhQftUKJERsAPJYcOGo
 PXwXUfsqWCnNQRdidY4N5lwPLAxqHSmJL9YdsS18bur2w7verhN0gnhyWYyjstUNtxaNKWijDbOMQVQ45lQ8Og==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/06/17 14:49, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Thu, 15 Jun 2017, Junio C Hamano wrote:
> 
>> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
>> index 325ec75353..801bce25da 100755
>> --- a/t/t3420-rebase-autostash.sh
>> +++ b/t/t3420-rebase-autostash.sh
>> @@ -45,7 +45,7 @@ create_expected_success_am() {
>>  }
>>  
>>  create_expected_success_interactive() {
>> -	cr=$'\r' &&
>> +	cr=$(echo . | tr '.' '\015') &&
>>  	cat >expected <<-EOF
>>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>>  	HEAD is now at $(git rev-parse --short feature-branch) third commit
> 
> This is still incorrect, as the \r\n (which $(echo . | tr \.\ '\015')
> would emit) is interpreted correctly as a line break on Windows, meaning
> that cr is now *empty*. Not what we want.
> 
> What I did is to replace the `cat` by `q_to_cr` (we have that lovely
> function, might just as well use it), replace `${cr}` by `Q` and skip the
> cr variable altogether.
> 
> Additionally, there is another huge problem: the "Applied autostash." is
> printed to stdout, not stderr, in line with how things were done in the
> shell version of rebase -i.
> 
> While this was just a minor bug previously, now we exercise that bug, by
> redirecting stderr to stdout and redirecting stdout to the file `actual`.
> Nothing says that stderr should be printed to that file before stdout, but
> that is exactly what the test case tries to verify.
> 
> There is only one slight problem: in my Git for Windows SDK, stdout is
> printed first.
> 
> The quick fix would be to redirect stderr and stdout independently.
> 
> However, I think it is time for that bug to be fixed: autostash messages
> should really go to stderr, just like the rest of them rebase messages.
> 
> I attached the patch, together with the two fixups to Phillip's patches,
> and a fixup for the autostash-messages-to-stderr patch that I think should
> be squashed in but I really ran out of time testing this.
> 
> Phillip, would you mind picking those changes up as you deem appropriate?

Will do, thanks for the patches

