From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Sat, 19 Jul 2014 08:21:13 +0200
Message-ID: <53CA0E59.5030103@web.de>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com> <20140717221056.GO12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 08:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8O1X-0005Ep-Em
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 08:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbaGSGVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 02:21:31 -0400
Received: from mout.web.de ([212.227.17.12]:52244 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbaGSGVb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 02:21:31 -0400
Received: from [192.168.1.87] ([178.165.128.194]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lj2I6-1WXf5s2WPG-00dGRe; Sat, 19 Jul 2014 08:21:27
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <20140717221056.GO12427@google.com>
X-Provags-ID: V03:K0:7jUhzjFWo7dbJmf5szV4g8Uuy2X6HROGH8/lWtdRgqr+T/Nmpu7
 NM8tahU+dLSzZxyizOO5vgZDVrSwQL+0Yewcg0EXTjipBcdsc5s41OQMdJo/lAIJp2m2wZ9
 kwus28qvsfUahLC4eYp+I+2keLIBybs+WWofE6FmyIdl2o7Ahxep6gXh9icizRC0qLek2TD
 GagTST9pyCJY0XmS5KxbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253867>

On 07/18/2014 12:10 AM, Jonathan Nieder wrote:
> Hi,
>
> Kyle J. McKay wrote:
>
>> When I then try to fetch using a "git://host/..." URL where "host"
>> is an mDNS host name, the 0010 patch causes git to attempt to lookup
>> a DNS SRV record on the non-mDNS regular DNS service (a violation of
>> RFC 6762 [4] section 22) and this is what has to time out before the
>> real fetch can start.
> That patch uses res_query from libresolv to do the lookup.  It doesn't
> know what DNS server to use and relies on system libraries to get it
> right.
>
> It was added to respond to a feature request within Debian but it is
> intended to eventually go upstream.  I'm glad you found this issue
> before that could happen. :)
>
> Should git automatically disable the SRV lookups when it sees one of
> the six domains named in RFC6762, or is there some system library call
> that can use mDNS when appropriate automatically (or get partway there
> without having to hard-code the domains)?
>
> Thanks,
> Jonathan
(My apologies, if this is spamish), but just to verify what is going on:

git fetch git://host.local/...
results in a DNS lookup ?

Kyle, did you verify the lookup with wireshark or a similar tool?

Jonathan, (I'm good in searching, but bad in finding)
could you point out where the source code for the git package for
debian is ?

I recently learned about mDNS, and will probably do some tests
and experiments later, and would like to test the lookup feature
of "0010".

Thanks.
/Torsten
