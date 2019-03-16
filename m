Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9FAC20248
	for <e@80x24.org>; Sat, 16 Mar 2019 22:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCPWJS (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 18:09:18 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:55980 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCPWJR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 18:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GcI3FtkEHPPAzm+WIuuSmQiSf7GFB76iqwsvRoG6Vm0=; b=OEQ05us6Wtl9j8nm3Fu8YtMp2
        5OaKhcj/ZddQ22ZSWbe6JXgXxymfPNwxp/c47vOL9nuh4LaDUS7OayDNEBElW5Yfr9q9jZTPVAMJv
        u2MmpkuZ4P7tF+txFYdqE+6Ssd924CX6zlP9xOUCpBazPyR/+vtjkYJckQjr7U3/WSzm8wlCp1THa
        pZegk64www8tejqrJfvWhvhwaxRFdsCwlQfNXf6H3ave2/mbaAeBsSFhopGDblk76i4679UQtFhRB
        Fnz0Y8E/2PR6Zi1dZmDfHmR5U+LXhcfVPAMcWbqu5Jx0bcL95XmWlOXA0+K23KKv8RUPNY6wmD8bQ
        2URJjCDMw==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:59850 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h5HUQ-00CgAd-R0; Sat, 16 Mar 2019 18:09:15 -0400
Date:   Sat, 16 Mar 2019 18:09:13 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "man gitattributes" doesn't explain comma-separated attribute
 values
In-Reply-To: <408d82f6-e935-487a-6d0c-9ec4be5e8b6e@kdbg.org>
Message-ID: <alpine.LFD.2.21.1903161807480.19900@localhost.localdomain>
References: <alpine.LFD.2.21.1903160816410.10724@localhost.localdomain> <408d82f6-e935-487a-6d0c-9ec4be5e8b6e@kdbg.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Mar 2019, Johannes Sixt wrote:

> Am 16.03.19 um 13:22 schrieb Robert P. J. Day:
> >   as a working example, i looked at the top-level .gitattributes file
> > in the git source code itself, which opens with:
> >
> >   * whitespace=!indent,trail,space
> >   *.[ch] whitespace=indent,trail,space diff=cpp
> >   *.sh whitespace=indent,trail,space eol=lf
> >   ... snip ...
> >
> > first observation is that i see nothing in the man page that explains
> > the notion of a comma-separated list of attribute values.
>
> This comma-separated list is not a property of attributes in
> general, but a property of the whitespace attribute in particular.
> See core.whitespace in git-config(1) and "Checking whitespace
> errors" in gitattributes(5).

  ah, i was digging through the code trying to figure out where the
whole CSV thing was explained -- it's massively helpful to understand
that that property is specific to whitespace. that does not appear to
be clarified anywhere.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
