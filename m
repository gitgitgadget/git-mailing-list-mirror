Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44A51F404
	for <e@80x24.org>; Wed, 18 Apr 2018 17:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDRRZL (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 13:25:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:45950 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752093AbeDRRZK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 13:25:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7FB15133631;
        Wed, 18 Apr 2018 13:25:09 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cEwsQufYkpyg; Wed, 18 Apr 2018 13:25:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C365D13362E;
        Wed, 18 Apr 2018 13:25:08 -0400 (EDT)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oKcha1kQ_hEK; Wed, 18 Apr 2018 13:25:08 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B1CC2133623;
        Wed, 18 Apr 2018 13:25:08 -0400 (EDT)
Date:   Wed, 18 Apr 2018 13:25:08 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Matthew Wilcox <willy@infradead.org>, git@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Message-ID: <1481207245.12764.1524072308610.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180418103339.30bae9bc@gandalf.local.home>
References: <20180418140503.GD27475@bombadil.infradead.org> <20180418103339.30bae9bc@gandalf.local.home>
Subject: Re: [PATCH] git-send-email: Cc more people
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: git-send-email: Cc more people
Thread-Index: Rc48m5J3qAbE+dTyghyoVmlC0FG5cw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

----- On Apr 18, 2018, at 10:33 AM, rostedt rostedt@goodmis.org wrote:

> On Wed, 18 Apr 2018 07:05:03 -0700
> Matthew Wilcox <willy@infradead.org> wrote:
> 
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>> 
>> Several of my colleagues (and myself) have expressed surprise and
>> annoyance that git-send-email doesn't automatically pick up people who
>> are listed in patches as Reported-by: or Reviewed-by: or ... many other
>> tags that would seem (to us) to indicate that person might be interested.
>> This patch to git-send-email tries to pick up all Foo-by: tags.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Note, this is one of the reasons I still use quilt to send my email.
> I've modified my quilt scripts to do what Matthew does here below.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

I find it really surprising and unexpected that people listed as
"Reviewed-by" don't end up being CC'd.

Thanks,

Mathieu

> 
> -- Steve
> 
> 
>> 
>> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
>> 
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 2fa7818ca..926815329 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1665,7 +1665,7 @@ foreach my $t (@files) {
>>  	# Now parse the message body
>>  	while(<$fh>) {
>>  		$message .=  $_;
>> -		if (/^(Signed-off-by|Cc): (.*)/i) {
>> +		if (/^([A-Z-a-z]*-by|Cc): (.*)/i) {
>>  			chomp;
>>  			my ($what, $c) = ($1, $2);
> >  			# strip garbage for the address we'll use:

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
