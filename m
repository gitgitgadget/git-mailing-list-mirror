From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git rebase --continue with goofy error
Date: Thu, 4 Dec 2008 17:27:57 +0100
Message-ID: <20081204162757.GA23360@atjola.homenet>
References: <5AC243B6-F048-4286-80E1-1D0E695792B9@illumaware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adrian Klingel <Adrian.Klingel@illumaware.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 17:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8H4w-0000Om-59
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 17:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYLDQ2E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 11:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbYLDQ2D
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 11:28:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:50089 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751214AbYLDQ2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 11:28:01 -0500
Received: (qmail invoked by alias); 04 Dec 2008 16:27:59 -0000
Received: from i577B9D5C.versanet.de (EHLO atjola.local) [87.123.157.92]
  by mail.gmx.net (mp067) with SMTP; 04 Dec 2008 17:27:59 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+pf+Fver+ph6FX0Fa5mC93cSUjONJ0Jw1Tx3HY48
	cozuilp5XFtQLf
Content-Disposition: inline
In-Reply-To: <5AC243B6-F048-4286-80E1-1D0E695792B9@illumaware.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102347>

On 2008.12.04 09:55:55 -0500, Adrian Klingel wrote:
> And I get the following:
>
> *********
> mymac:/Library/mydir/code/myapp me$ git rebase --continue
> Unknown option: 1
> Usage: head [-options] <url>...
>     -m <method>   use method for the request (default is 'HEAD')
>     -f            make request even if head believes method is illega=
l
>     -b <base>     Use the specified URL as base
>     -t <timeout>  Set timeout value
>     -i <time>     Set the If-Modified-Since header on the request
>     -c <conttype> use this content-type for POST, PUT, CHECKIN
>     -a            Use text mode for content I/O
>     -p <proxyurl> use this as a proxy
>     -P            don't load proxy settings from environment
>     -H <header>   send this HTTP header (you can specify several)
>
>     -u            Display method and URL before any response
>     -U            Display request headers (implies -u)
>     -s            Display response status code
>     -S            Display response status chain
>     -e            Display response headers
>     -d            Do not display content
>     -o <format>   Process HTML content in various ways
>
>     -v            Show program version
>     -h            Print this message
>
>     -x            Extra debugging output

That comes via git-am which used to call "head -1", but using -<n> is
deprecated and apparently not supported anymore by modern versions of
coreutils. Was fixed in:

1d9b2656: git-am: head -1 is obsolete and doesn't work on some new syst=
ems

Which is in git 1.5.6.

Bj=F6rn
