From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Wed, 23 Sep 2015 20:41:40 +0000
Message-ID: <1443040900.29498.119.camel@transmode.se>
References: <1440157010.1759.83.camel@transmode.se>
	 <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
	 <1442245035.10125.18.camel@transmode.se>
	 <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
	 <1442508864.21964.26.camel@transmode.se>
	 <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
	 <xmqqpp1bbtvz.fsf@gitster.mtv.corp.google.com>
	 <1442855328.29498.30.camel@transmode.se>
	 <37ca95b3fef79e348fb5ba68cd21c590@dscho.org>
	 <1442955525.29498.94.camel@transmode.se>
	 <5f56381a3cf5a5ccf6a1e4e3ea48f516@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"pclouds@gmail.com" <pclouds@gmail.com>
To: "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:41:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeqrO-00045j-7I
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 22:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbbIWUlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 16:41:46 -0400
Received: from smtp.transmode.se ([31.15.61.139]:52268 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753991AbbIWUlp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 16:41:45 -0400
Received: from exch1.transmode.se (exch1.transmode.se [192.168.201.16])
	by smtp.transmode.se (Postfix) with ESMTP id 042421186FAE;
	Wed, 23 Sep 2015 22:41:41 +0200 (CEST)
Received: from exch1.transmode.se (192.168.201.16) by exch1.transmode.se
 (192.168.201.16) with Microsoft SMTP Server (TLS) id 15.0.1076.9; Wed, 23 Sep
 2015 22:41:40 +0200
Received: from exch1.transmode.se ([fe80::3029:ce14:7d42:cc5]) by
 exch1.transmode.se ([fe80::3029:ce14:7d42:cc5%17]) with mapi id
 15.00.1076.000; Wed, 23 Sep 2015 22:41:40 +0200
Thread-Topic: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Thread-Index: AQHQ9I1i4MUVkjVcJE+EJNOGRY0lNp5HFboAgAHCMwCAABBhgIAA7gCAgACfjwA=
In-Reply-To: <5f56381a3cf5a5ccf6a1e4e3ea48f516@dscho.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.16.5 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.200.4]
Content-ID: <E682096AA3C7A340B1941DF4EA095A36@transmode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278514>

On Wed, 2015-09-23 at 13:10 +0200, Johannes Schindelin wrote:
> Hi Joakim,
> 
> On 2015-09-22 22:58, Joakim Tjernlund wrote:
> > On Tue, 2015-09-22 at 22:00 +0200, Johannes Schindelin wrote:
> > > 
> > > The reason should be easy to understand: Git's concept is based on the idea that you have full control
> > > over
> > > your repository. Other repositories you might only have read access.
> > 
> > Yes and some repos I only have partial write access to(config, hooks
> > etc. might be readonly)
> 
> The partial write access idea is definitely not part of the original idea of Git, and your use case is
> actually the first I heard of.

Ouch, that cannot be so?? The first thing one would do for some level of accident protection 
would be to just change privs on a few selected files/dirs. 

> 
> The original idea was really that you either own your repository, or you do not. And that includes the
> repositories that can be accessed publicly: you own them or you don't.
> 
> Now, I know that in particular in some corporate setups, there needs to be a permission system in place that
> disallows certain users from doing certain things (such as editing the config).

Exactly! This is what we are doing.

> 
> The Git solution is to set up a server, usually with SSH, and allow users to push and fetch from the
> repositories, but nothing else (i.e. no shell access), then set up hooks to implement the permission system.

But this is too big of an ax just to get any protection at all. Dedicating a server just for this
is very costly, both the physical/virtual server and to maintain it. 

> 
> This is much less error prone than partially locking down a repository on some network drive because the
> file system structure simply does not reflect the permission structure. That is where all your troubles come
> from.

Sure, but here is room for improvement.

 Jocke
