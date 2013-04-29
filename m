From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: "git grep" parallelism question
Date: Mon, 29 Apr 2013 20:04:10 +0200
Message-ID: <877gjldxid.fsf@hexa.v.cablecom.net>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
	<7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
	<CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
	<7vip39w14d.fsf@alter.siamese.dyndns.org>
	<CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
	<CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
	<20130429161814.GJ472@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:04:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsR0-0005pJ-FY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab3D2SEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:04:13 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:25770 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab3D2SEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:04:12 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 29 Apr
 2013 20:04:09 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 29 Apr
 2013 20:04:10 +0200
In-Reply-To: <20130429161814.GJ472@serenity.lan> (John Keeping's message of
	"Mon, 29 Apr 2013 17:18:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222832>

John Keeping <john@keeping.me.uk> writes:

> On Mon, Apr 29, 2013 at 07:35:01PM +0530, Ramkumar Ramachandra wrote:
>> On a related note, one place that IO parallelism can provide massive
>> benefits is in executing shell scripts.  Accordingly, I always use the
>> following commands to compile and test git respectively:
>> 
>>     make -j 8 CFLAGS="-g -O0 -Wall"
>>     make -j 8 DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="-j 16" test
>> 
>> i.e. always use 8 threads when the task is known to be CPU intensive,
>> and always use 16 threads when the task is known to be IO intensive.
>
> On this tangent, I recently added a TEST_OUTPUT_DIRECTORY line to my
> config.mak which points into a tmpfs mount.  Keeping all of the test
> repositories in RAM makes the tests significantly faster for me and
> works nicely when you have the patches in jk/test-output (without those
> patches the individual tests work but the reporting of aggregate results
> doesn't).

But that's been possible for quite some time now, using --root, or am I
missing something?

(Not that the fix as such is a bad idea, but other readers might not
want to wait for it to hit master.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
