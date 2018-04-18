Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77D31F404
	for <e@80x24.org>; Wed, 18 Apr 2018 14:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeDROdm (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 10:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbeDROdm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 10:33:42 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D31F204EF;
        Wed, 18 Apr 2018 14:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D31F204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date:   Wed, 18 Apr 2018 10:33:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     git@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] git-send-email: Cc more people
Message-ID: <20180418103339.30bae9bc@gandalf.local.home>
In-Reply-To: <20180418140503.GD27475@bombadil.infradead.org>
References: <20180418140503.GD27475@bombadil.infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Apr 2018 07:05:03 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Several of my colleagues (and myself) have expressed surprise and
> annoyance that git-send-email doesn't automatically pick up people who
> are listed in patches as Reported-by: or Reviewed-by: or ... many other
> tags that would seem (to us) to indicate that person might be interested.
> This patch to git-send-email tries to pick up all Foo-by: tags.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Note, this is one of the reasons I still use quilt to send my email.
I've modified my quilt scripts to do what Matthew does here below.

-- Steve


> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2fa7818ca..926815329 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1665,7 +1665,7 @@ foreach my $t (@files) {
>  	# Now parse the message body
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^(Signed-off-by|Cc): (.*)/i) {
> +		if (/^([A-Z-a-z]*-by|Cc): (.*)/i) {
>  			chomp;
>  			my ($what, $c) = ($1, $2);
>  			# strip garbage for the address we'll use:

