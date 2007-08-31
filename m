From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] fix parallel make problem
Date: Fri, 31 Aug 2007 11:15:17 +0300
Message-ID: <20070831081517.GB17637@mellanox.co.il>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:15:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR1fV-0000Jo-SZ
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbXHaIPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758349AbXHaIP3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:15:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:17238 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757591AbXHaIP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:15:27 -0400
Received: by fk-out-0910.google.com with SMTP id z23so560072fkz
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 01:15:26 -0700 (PDT)
Received: by 10.82.106.14 with SMTP id e14mr3140429buc.1188548124321;
        Fri, 31 Aug 2007 01:15:24 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.35.163])
        by mx.google.com with ESMTPS id k28sm1128161ugd.2007.08.31.01.15.22
        (version=SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 01:15:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vabs82kcq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57130>

> Quoting Junio C Hamano <gitster@pobox.com>:
> Subject: Re: [PATCH] fix parallel make problem
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> >> +.PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
> >> +
> >>  test-%$X: test-%.o $(GITLIBS)
> >>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
> >
> > Add a comment here?
> 
> I did not see a particular need for that.  What would you say
> there?

That it's a work-around for make bug.

> >> Warning: 1 path touched but unmodified. Consider running git-status.
> >
> > BTW, shouldn't the warning go to standard error?
> 
> No, usually you are under PAGER, so we need to send this to
> stdout.  We do this only when we are generating textual diff
> which will be consumed by patch or git-apply.  They both know
> how to ignore such a non patch material.

So how did this end up in your mail?

-- 
MST
