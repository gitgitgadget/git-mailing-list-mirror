From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: [RFC] pre-rebase: Refuse to rewrite commits that are reachable
 from upstream
Date: Tue, 21 Feb 2012 18:59:38 -0500
Message-ID: <1AD297DA-6E85-4808-94F8-907BA890E7F6@apple.com>
References: <201202111445.33260.jnareb@gmail.com>
 <1329772071-11301-1-git-send-email-johan@herland.net>
 <7vobstjfcs.fsf@alter.siamese.dyndns.org>
 <CALKQrgcDDVH8rxn80ZTMyR3y3n3Vs1LSCtH=ZiwG7it_LE2wgQ@mail.gmail.com>
 <7vehtoiqae.fsf@alter.siamese.dyndns.org>
 <CALKQrgfLBKG5ssL8ua_EtfyQeOp0h9HPC7vdOM_Yc_AVaa39xw@mail.gmail.com>
 <7vsji3eoqs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	jnareb@gmail.com, philipoakley@iee.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 01:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzze8-0005RM-BP
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 01:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab2BVABM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 19:01:12 -0500
Received: from honeycrisp.apple.com ([17.151.62.51]:41764 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab2BVABK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 19:01:10 -0500
Received: from relay11.apple.com ([17.128.113.48])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPS id <0LZR00LJRP9W8V80@mail-out.apple.com> for git@vger.kernel.org;
 Tue, 21 Feb 2012 15:59:41 -0800 (PST)
X-AuditID: 11807130-b7bd2ae000007737-03-4f442fed2da9
Received: from jimbu (jimbu.apple.com [17.151.62.37])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay11.apple.com (Apple SCV relay)
 with SMTP id 50.FE.30519.DEF244F4; Tue, 21 Feb 2012 15:59:41 -0800 (PST)
Received: from [17.168.163.128] (unknown [17.168.163.128])
 by cardamom.apple.com
 (Oracle Communications Messaging Server 7u4-23.01(7.0.4.23.0) 64bit (built Aug
 10 2011)) with ESMTPSA id <0LZR00JE0PBD7J60@cardamom.apple.com> for
 git@vger.kernel.org; Tue, 21 Feb 2012 15:59:41 -0800 (PST)
In-reply-to: <7vsji3eoqs.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1426)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsUiON1OVfetvou/wfqPuhZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mo4MW0le8F5topjn56xNzAuZO1i5OSQEDCRaDp3nBnCFpO4cG89
	G4gtJNDKJHH6U3gXIxeQvYxJYsX0brAEs4CWxPqdx5lAbF4BPYlz++ayg9jCAtESbx6vZQGx
	2QQ0JD6dugs2lFPATGLh9QNgcRYBVYlrb4+wQMxJkfj9ZjM7hK0t8eTdBVaImTYS3x6+YoRY
	/JtJ4siSHWCDRATUJCa2HWKBuFRW4tCMlYwTGAVmIblpFpKbZiGZu4CReRWjYFFqTmKloaFe
	YkFBTqpecn7uJkZQ6DUUGuxgXPuT/xCjAAejEg9v4UZnfyHWxLLiytxDjBIczEoivOt/AYV4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzMj0HSgmkJ5akZqemFqQWwWSZODilGhg5g1jDPzf7PFLM
	/RJi5Wf1bfaic0uZKnnvrBbpMWjK0Z0aOHfXkz265Sv/7d1UZxzoJc5u9GdRX4e+0Nw/S6X+
	N29jLwl0/vrHo/FYlMtmCVb7sOMnA3rsuAvlb2YJbV/CdbSL5dTayEyR/B9Jr3aFX9+qvC3q
	92KGd82bvf+nnbhZrHf892QlluKMREMt5qLiRADdiww6OQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191200>


On Feb 21, 2012, at 6:43 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Johan Herland <johan@herland.net> writes:
> 
>> history"[1], but won't cause any false positives (and small enough
>> false negatives). If there really is no way to implement this, then we
>> shouldn't give users false hopes by putting it in the survey...
> 
> I think that question should be "warn before pushing out a commit that the
> user may later regret to have pushed out" ;-)

Why limit this proposal to just the commits that are reachable from upstream? What if somebody pulls from your repo?

In other words, wouldn't it be better to have a git track "unshared" commits and only let those be rewritten? The theory being that if the given commits haven't been pushed or pulled anywhere, then they are safe to rewrite.

davez
