Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41929200B9
	for <e@80x24.org>; Fri,  4 May 2018 21:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeEDViw (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 17:38:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751687AbeEDViv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 17:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52A43857EA;
        Fri,  4 May 2018 21:38:51 +0000 (UTC)
Received: from redhat.com (ovpn-123-58.rdu2.redhat.com [10.10.123.58])
        by smtp.corp.redhat.com (Postfix) with SMTP id 955D82023227;
        Fri,  4 May 2018 21:38:46 +0000 (UTC)
Date:   Sat, 5 May 2018 00:38:46 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
        berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org,
        git@vger.kernel.org
Subject: Re: cover letter cc's [was: [PATCH 60/67] hw/s390x: add include
 directory headers]
Message-ID: <20180505003653-mutt-send-email-mst@kernel.org>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
 <1525376963-79623-61-git-send-email-mst@redhat.com>
 <20180504091007.55405a6a.cohuck@redhat.com>
 <be79d6dd-beaa-ba6f-2990-b5e91139411b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be79d6dd-beaa-ba6f-2990-b5e91139411b@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 04 May 2018 21:38:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 04 May 2018 21:38:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 04, 2018 at 08:07:53AM -0500, Eric Blake wrote:
> [adding a cross-post to the git mailing list]
> 
> On 05/04/2018 02:10 AM, Cornelia Huck wrote:
> > On Thu, 3 May 2018 22:51:40 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > This way they are easier to find using standard rules.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> ...
> 
> > [Goes to find cover letter to figure out what this is all about.
> > *Please*, cc: people on the cover letter so they can see immediately
> > what this is trying to do!]
> 
> Is there an EASY way to make 'git format-patch --cover-letter $commitid'
> (and git send-email, by extension) automatically search for all cc's any any
> of the N/M patches, and auto-cc ALL of those recipients on the 0/N cover
> letter?  And if that is not something easily built into git format-patch
> directly, is it something that can easily be added to sendemail.cccmd?  This
> is not the first time that someone has complained that automatic cc's are
> not sending the cover letter context to a particular maintainer interested
> (and auto-cc'd) in only a subset of an overall series.
> 
> On the other hand, cc'ing all recipients for a largely mechanical patch
> series that was split into 67 parts, in part because it touches so many
> different maintainers' areas, may make the cover letter have so many
> recipients that various mail gateways start rejecting it as potential spam.

I do this sometimes (pipe to this script):

grep -e ^Signed-off-by -e ^Acked -e ^Reported -e ^Tested -e ^Cc | sed 's/.*<//'| sed 's/>.*//'|sort | uniq | sed 's/^/Cc: /'


> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
