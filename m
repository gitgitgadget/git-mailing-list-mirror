From: <Ken.Fuchs@bench.com>
Subject: RE: FW: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Date: Thu, 28 Feb 2008 16:04:02 -0600
Message-ID: <AA28F077645B324881335614E4F7C428034C11@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 28 23:05:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUqs2-0007Yd-5T
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 23:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbYB1WER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 17:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbYB1WER
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 17:04:17 -0500
Received: from tx-smtp02.bench.com ([12.163.172.138]:57317 "EHLO
	tx-smtp02.bench.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbYB1WEQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 17:04:16 -0500
Received: from unknown (HELO smtp.corp.bench.com) ([167.67.199.67])
  by tx-smtp02.bench.com with ESMTP; 28 Feb 2008 16:02:50 -0600
Received: from win-ex01.bench.com ([167.67.1.16]) by smtp.corp.bench.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Feb 2008 16:04:03 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Thread-Index: Ach5nmafQ6X1s1CBRnuVMh4VmfnzuQAr58rg
X-OriginalArrivalTime: 28 Feb 2008 22:04:03.0598 (UTC) FILETIME=[D47F4AE0:01C87A55]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75468>

On Wed, 27 Feb 2008, Johannes Schindelin wrote:

> On Wed, 27 Feb 2008, Ken Fuchs wrote:
> 
> [Ken did not say who said this:]

Sorry, Mike Hommey wrote the following on 27 Feb 2008:

> > > git-clone is not a builtin yet. When it is (and a patch 
> > > has come for that), it will correctly use proxys.
> > 
> > Is there a work-around for cloning a git repository via a proxy?

> Yes.
> 
> Just export "http_proxy".  AFAICT this works... See
> 
>
http://repo.or.cz/w/msysgit.git?a=commitdiff;h=257a62710c0253d940a59b6fb
2f371afa84dcf56

> for a working example.

Unfortunately, this will not work because "git clone" is
implemented by git-clone.sh and has no support for dealing
with proxies at all.  Note that the example uses "git fetch"
and not "get clone".

So it seems that git's http protocol via a proxy isn't completely
supported.  For example, "git fetch" works with a proxy, since
it is implemented via a builtin (executable) which includes
proxy support.

At least that is my understanding of Mike's comments above.

The only work-around for "git clone" that I'm aware of is a
"proxy agent" that intercepts and modifies all Internet bound
requests and responses so they go (transparently) through the
proxy server rather than directly to the Internet.  Thus, none
of the clients being used need to be proxy aware, including
"git clone" (or any git function for that matter).

However, I was looking for a different work-around for
using "git clone" via http protocol and proxy (NTLM auth.),
but there do not appear to be any.

Thanks,

Ken Fuchs
