Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3E42036B
	for <e@80x24.org>; Fri,  6 Oct 2017 09:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbdJFJJK (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 05:09:10 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:38539 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbdJFJJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 05:09:09 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Fri, 06 Oct 2017 11:09:08 +0200
  id 00000000000000CB.0000000059D74834.000018CD
Date:   Fri, 6 Oct 2017 11:09:07 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention
 mechanisms
Message-ID: <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20171003201507.3589-4-bmwill@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 01:15:00PM -0700, Brandon Williams wrote:
> [snip]
>
> +protocol.version::
> +	Experimental. If set, clients will attempt to communicate with a
> +	server using the specified protocol version.  If unset, no
> +	attempt will be made by the client to communicate using a
> +	particular protocol version, this results in protocol version 0
> +	being used.
> +	Supported versions:

Did you consider Stefan Beller's suggestion regarding a
(white)list of allowed versions?

On Mon, Sep 18, 2017 at 01:06:59PM -0700, Stefan Beller wrote:
> Thinking about this, how about:
>
>   If not configured, we do as we want. (i.e. Git has full control over
>   it's decision making process, which for now is "favor v0 over v1 as
>   we are experimenting with v1". This strategy may change in the future
>   to "prefer highest version number that both client and server can speak".)
>
>   If it is configured, "use highest configured number from the given set".
>
> ?

It would also allow the server operator to configure only a
specific set of versions (to handle the "version x is
insecure/slow"-issue raised by Stefan Beller). The current code
always uses the latest protocol supported by the git binary.

Minor nit, s/extention/extension/ in the patch name?

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
