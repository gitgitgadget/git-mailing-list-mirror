From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 2/2] send-email: add test for duplicate utf8 name
Date: Thu, 20 Jun 2013 14:48:15 +0200
Message-ID: <87vc597xtc.fsf@linux-k42r.v.cablecom.net>
References: <1371731166-24015-1-git-send-email-mst@redhat.com>
	<1371731166-24015-2-git-send-email-mst@redhat.com>
	<87a9ml9cou.fsf@linux-k42r.v.cablecom.net>
	<20130620124502.GA24172@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 14:48:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpeHr-0005Y9-KV
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 14:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965484Ab3FTMsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 08:48:19 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:30528 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965102Ab3FTMsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 08:48:18 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 20 Jun
 2013 14:48:12 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 20 Jun 2013 14:48:15 +0200
In-Reply-To: <20130620124502.GA24172@redhat.com> (Michael S. Tsirkin's message
	of "Thu, 20 Jun 2013 15:45:02 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228491>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jun 20, 2013 at 02:41:37PM +0200, Thomas Rast wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > Verify that author name is not duplicated if it matches
>> > sender, even if it is in utf8.
>> 
>> Small nit: if you make two patches out of it, add the tests first with
>> test_expect_failure.  Then flip it to test_expect_success in the actual
>> code change.  That makes it easy to verify that the test actually checks
>> the right thing, and that it was your code change that fixed it.
>
> I did this by reverting 1/2 and rerunning.
>
> But applying in reverse order means bisect can give us
> a setup where some tests fail, I thought it's a
> good idea to avoid that.

That's why you need to test_expect_*failure* in the commit that adds the
tests -- essentially saying "I know this is broken!".

Yes, it's a roundabout way.  But splitting code and tests in the way you
just posted is equally roundabout, while not having the benefit that one
can check out the commit at patch 1 and verify that it is indeed broken
(showing up as "still have known breakage").

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
