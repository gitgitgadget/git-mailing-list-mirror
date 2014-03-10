From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 22:07:18 +0100
Message-ID: <531E2986.8050604@alum.mit.edu>
References: <531D9B50.5030404@alum.mit.edu> <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com> <20140310155230.GA29801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	git discussion list <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:07:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN7Q0-0001sT-C5
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 22:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbaCJVHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 17:07:24 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50664 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753491AbaCJVHX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 17:07:23 -0400
X-AuditID: 1207440e-f79c76d000003e2c-ff-531e298aa373
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E3.49.15916.A892E135; Mon, 10 Mar 2014 17:07:22 -0400 (EDT)
Received: from [192.168.69.148] (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2AL7Juk018875
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 17:07:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140310155230.GA29801@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqNulKRdssPSWksXOdRIWXVe6mSzm
	3d3FZPGjpYfZYv6hiawWHzsXMDuweeycdZfd49LL72weH58tZ/d41ruH0ePP+T2sHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ1z//5S1YLp4xZHzR1kaGJ8KdTFyckgImEjcWHGCFcIWk7hwbz1b
	FyMXh5DAZUaJbxN6oJzzTBIX/pxhA6niFdCWaNnZxNTFyMHBIqAqsfiPKkiYTUBXYlFPMxOI
	LSoQLLH68gMWiHJBiZMzn4DZIgKyEt8Pb2QEmckMsuD4wz5GkISwgLHEkxcLwa4QEpjPKLFn
	XgKIzSlgLXHm6ikWkF0SAuISPY1BICazgLrE+nlg9zMLyEtsfzuHeQKj4Cwk22YhVM1CUrWA
	kXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkgs8O1gbF8vc4hRgINRiYf3
	wFuZYCHWxLLiytxDjJIcTEqivIFycsFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjXiQPleFMS
	K6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvP4aQI2CRanpqRVpmTklCGkm
	Dk6Q4VxSIsWpeSmpRYmlJRnxoOiNLwbGL0iKB2hvGkg7b3FBYi5QFKL1FKMux+22X58YhVjy
	8vNSpcR5bUCKBECKMkrz4FbAEt8rRnGgj4V57UGqeIBJE27SK6AlTEBLmo9LgSwpSURISTUw
	iu12ME8SWDL5Z1tGSqPGRPEqff6c722iW5/qiTecnnEjv1u/oHx+XJdyEBtTYOPH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243816>

On 03/10/2014 04:52 PM, Jeff King wrote:
> On Mon, Mar 10, 2014 at 07:30:45AM -0700, Shawn Pearce wrote:
> 
>>> * Store references in a SQLite database, to get correct transaction
>>>   handling.
>>
>> No to SQLLite in git-core. Using it from JGit requires building
>> SQLLite and a JNI wrapper, which makes JGit significantly less
>> portable. I know SQLLite is pretty amazing, but implementing
>> compatibility with it from JGit will be a big nightmare for us.
> 
> That seems like a poor reason not to implement a pluggable feature for
> git-core. If we implement it, then a site using only git-core can take
> advantage of it. Sites with JGit cannot, and would use a different
> pluggable storage mechanism that's supported by both. But if we don't
> implement, it hurts people using only git-core, and it does not help
> sites using JGit at all.

I think it's important to distinguish between two types of backend:

* Exotic backends, optimized for servers, or embedded systems, or other
controlled environments where the person deploying Git can decide about
the whole technology stack.  Here I say let a thousand flowers bloom.
If user A wants to try an Oracle backend and only uses JGit, there's no
need for him to implement the equivalent backend for git-core or libgit2.

* Mainstream backends, intended for use by end-users on their
workstations and notebooks.  Such backends will be pretty worthless if
they are not supported more or less universally, because one user will
want to use the command line and Eclipse, another Visual Studio and
TortoiseGit, a third will use GitHub for Mac plus a bunch of shell
scripts written by his IT department.  A backend that is not supported
by the big three Git implementations (git-core, libgit2, and JGit) will
probably be rejected by users.  Realistically there will be at most a
couple of mainstream backends--in fact probably usually a single
established one and occasionally a single next-generation one waiting
for people to migrate slowly to it.  For mainstream backends I think it
is important for the implementations to plan and coordinate ahead of
time to make sure everybody's concerns are addressed.

It sounds to me like Shawn is saying "please don't make a SQLite-based
backend the new default git-core backend" and Peff is saying "there is
no reason that a Git hosting service shouldn't experiment with a
SQLite-based backend".  I see no contradiction there [1].

Also, please remember that I'm not advocating a SQLite backend or any
other at this time.  I'm only refactoring code to open the way for
*future* flamefests :-)

Michael

[1] There might of course be a technical argument about whether a
SQLite-based backend would be SO AWESOME for end-users that switching to
it would be worth the extra inconvenience for the JGit folks.
Personally I'm skeptical.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
