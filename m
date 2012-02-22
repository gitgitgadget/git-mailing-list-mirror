From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: [RFC] pre-rebase: Refuse to rewrite commits that are reachable
 from upstream
Date: Wed, 22 Feb 2012 03:00:56 -0500
Message-ID: <DB452638-24EA-44D0-B0EA-9FD4112C0CAB@apple.com>
References: <201202111445.33260.jnareb@gmail.com>
 <1329772071-11301-1-git-send-email-johan@herland.net>
 <7vobstjfcs.fsf@alter.siamese.dyndns.org>
 <CALKQrgcDDVH8rxn80ZTMyR3y3n3Vs1LSCtH=ZiwG7it_LE2wgQ@mail.gmail.com>
 <7vehtoiqae.fsf@alter.siamese.dyndns.org>
 <CALKQrgfLBKG5ssL8ua_EtfyQeOp0h9HPC7vdOM_Yc_AVaa39xw@mail.gmail.com>
 <7vsji3eoqs.fsf@alter.siamese.dyndns.org>
 <1AD297DA-6E85-4808-94F8-907BA890E7F6@apple.com>
 <20120222070957.GB17015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	jnareb@gmail.com, philipoakley@iee.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 22 09:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S07Ab-0005vN-LK
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 09:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab2BVIDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 03:03:19 -0500
Received: from crispin.apple.com ([17.151.62.50]:55187 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab2BVIDS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 03:03:18 -0500
Received: from relay13.apple.com ([17.128.113.29])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPS id <0LZS00LASBLMB5D0@mail-out.apple.com> for git@vger.kernel.org;
 Wed, 22 Feb 2012 00:00:59 -0800 (PST)
X-AuditID: 1180711d-b7b88ae00000602c-c0-4f44a0bbb89e
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay13.apple.com (Apple SCV relay)
 with SMTP id 18.6F.24620.BB0A44F4; Wed, 22 Feb 2012 00:00:59 -0800 (PST)
Received: from [17.168.164.36] (unknown [17.168.164.36])
 by koseret.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPSA id <0LZS00GI7BLLSI60@koseret.apple.com> for git@vger.kernel.org;
 Wed, 22 Feb 2012 00:00:59 -0800 (PST)
In-reply-to: <20120222070957.GB17015@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1426)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsUiON1OXXf3Ahd/g/OvVSy6rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJVxbNZMpoI7/BVn12s1MB7k6WLk5JAQMJFY9KCZGcIWk7hwbz1b
	FyMXh5BAJ5PEpmPdTBDOYiaJT7u/sIBUMQtoSazfeZwJxOYV0JM4t28uO4gtLBAt8ebxWrAa
	NgENiU+n7oJN5RSwlmj+vgyshkVAVWL6w2ssIEOZBToYJW5/mcwEMVRb4sm7C6xdjBxAQ20k
	XuwogFh8n1li7+fdrCA1IgKyEt8Pb2SEOFVW4tCMlYwTGAVmIblpFpKbZiEZu4CReRWjYFFq
	TmKlobFeYkFBTqpecn7uJkZQ6DUUyu5g3P+T/xCjAAejEg9v0UZnfyHWxLLiytxDjBIczEoi
	vJKTXfyFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8zI+B6oWSE8sSc1OTS1ILYLJMnFwSjUwxqnZ
	rPnxv3fVnSexiimbLOJWPtqvaNbWKbHx7kmmH8JMzaX3375SOTPJeIZ36cyZx+rmrVm+Oeku
	96qYe/q9T7bFP75/nSMh4ZyL8tzfulHS/SKCudo7Lh1J2v3rHvO+9zv/3vC8tbDWSzT44VZR
	nyn3QlR0HjAEr5WvSY74+WTZuysHunoPr1RiKc5INNRiLipOBADqOAU1OQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191235>

On Feb 22, 2012, at 2:09 AM, Jeff King <peff@peff.net> wrote:

> On Tue, Feb 21, 2012 at 06:59:38PM -0500, Dave Zarzycki wrote:
> 
>>> I think that question should be "warn before pushing out a commit that the
>>> user may later regret to have pushed out" ;-)
>> 
>> Why limit this proposal to just the commits that are reachable from
>> upstream? What if somebody pulls from your repo?
>> 
>> In other words, wouldn't it be better to have a git track "unshared"
>> commits and only let those be rewritten? The theory being that if the
>> given commits haven't been pushed or pulled anywhere, then they are
>> safe to rewrite.
> 
> You don't necessarily know who has read from you. Depending on your
> setup, the user running git code may not have write access to the
> repository (e.g., Alice runs "git pull ~bob/project.git"). Where would
> Alice write the list of commits she pulled so that when Bob later runs
> git, he knows that she has pulled them?
> 
> There is also the issue of "dumb" transports in which no git code is
> running on the remote repo at all (e.g., Alice fetches from Bob via dumb
> http; Bob's server doesn't even have git at all).
> 
> There may be clever or complex ideas to tackle those problems, but I
> suspect that handling push would cover most practical cases (e.g., in
> the dumb http case, Bob's commits probably ended up on the server via
> push). So perhaps it is a good place to start.

Fair points. Honestly, I was thinking more about a developer pulling changes between locations within his or her control, say a laptop and a desktop, or simply between multiple clones on the same machine. In this scenario, it would be useful to warn the developer that: "[some of] the commits you are about to rewrite, while not in the upstream repository, have been replicated into other repositories within your control. These other repositories will not be rewritten. Are you sure you want to continue?"

davez
