Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183DD20380
	for <e@80x24.org>; Thu, 23 May 2019 21:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbfEWVjU (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 17:39:20 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19365 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbfEWVjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 17:39:19 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x4NLdDWw026356
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 17:39:13 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <esr@thyrsus.com>, "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     "'Jakub Narebski'" <jnareb@gmail.com>, <git@vger.kernel.org>
References: <20190521013250.3506B470485F@snark.thyrsus.com> <86h89lq96v.fsf@gmail.com> <20190523205009.GA69096@thyrsus.com> <20190523205457.GC70860@google.com> <20190523211916.GA73150@thyrsus.com>
In-Reply-To: <20190523211916.GA73150@thyrsus.com>
Subject: RE: RFC: Separate commit identification from Merkle hashing
Date:   Thu, 23 May 2019 17:39:06 -0400
Message-ID: <007a01d511af$f5dc1d50$e19457f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQI6MOS103FD8bgGgJ2ASraEPp5rYQKsNOkeAmpDAlkCEXSbnAKXJJknpWEEBdA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 23, 2019 17:19, Eric S. Raymond wrote:
> Jonathan Nieder <jrnieder@gmail.com>:
> > Honestly, I do think you have missed some fundamental issues.
> > https://public-inbox.org/git/ab3222ab-9121-9534-1472-
> fac790bf08a4@gmai
> > l.com/
> > discusses this further.
> 
> Have re-read.  That was a different pair of proposals.
> 
> I have abandoned the idea of forcing timestamp uniqueness entirely - that
> was a hack to define a canonical commit order, and my new RFC describes a
> better way to get this.
> 
> I still think finer-grained timestamps would be a good idea, but that is
much
> less important than the different set of properties we can guarantee via
the
> new RFC.

I don't think finer-grained timestamps will help long-term. The faster
systems get, the more resolution we need. At this point, I can easily get
two commits within the same microsecond. The weird part is that if the
commits are done from two different CPUs on my platform, it is theoretically
possible (although highly unlikely) that the second commit could be one
microsecond earlier than the first commit, on the same file system, if a
inter-CPU clock-sync had not been done for the past few seconds. On a
broader scale, that is somewhat obvious and assumes global time
synchronisation is maintained. It also makes me wonder what happens when git
runs on a quantum computer and a commit goes to the wrong universe (joke).

Just my $0.014

Randall

