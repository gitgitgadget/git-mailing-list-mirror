From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [QUERY] How do you sort completions?
Date: Tue, 28 May 2013 12:23:03 +0200
Message-ID: <20130528102303.GC2192@goldbirke>
References: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
 <CAMP44s3_BBPu0WSzYyaVLbdg0dBuaV7MFgy1SMuK1C8P2vKbYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 12:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhH3f-0006G7-QK
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 12:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156Ab3E1KXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 May 2013 06:23:07 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:59814 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889Ab3E1KXG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 06:23:06 -0400
Received: from localhost6.localdomain6 (f051074182.adsl.alicedsl.de [78.51.74.182])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LcC9p-1TyLKc3hbR-00jIGI; Tue, 28 May 2013 12:23:04 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3_BBPu0WSzYyaVLbdg0dBuaV7MFgy1SMuK1C8P2vKbYg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:9u9fg8QVe0wUIoH+i0667cA7VybS6dseAblRmVPVOS0
 m2YSDPWvXGcopA3voi2geJs/RSRe5MOvJz38heT6mSdfP/0aT3
 D4NlJfAy1DCO1OGkmBKISHbQYhN8V5nH8aapnR9pUj61glBZrm
 YHIsKdjv22Px1OFaUDl37Xfx48Y5JlCdSrNt+gc8I1gDqUHRUg
 NaF3LmlU4IPqhHQzOgi5SoWAx4k+rs4gE3qxLHRaab1mPbEOQb
 ydVsjMDbcorH3TDX009YDH7hbFH86sCjrt/aIEvCw+6xuAe2yH
 7gSc6u1BhQd/JO20+n87TUm8wFG/eahzcZK9MK9cQ2wls1vBpU
 AqgZp/LuuWcUcW++ug5c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225625>

Hi,

On Fri, May 24, 2013 at 08:11:00AM -0500, Felipe Contreras wrote:
> AFAIK bash needs the completions sorted, so we added some | sort |
> uniq.

Actually, it seems to sort and remove duplicates automatically:

$ _foo () { COMPREPLY=3D("bar" "foo" "bar" "baz") ; }
$ complete -F _foo foo
$ foo <TAB>
bar  baz  foo =20

So that | sort | uniq might not be necessary after all, and by
removing them we could spare two fork()+exec()s.

I'm not sure all supported Bash versions behave this way, though.


Best,
G=E1bor
