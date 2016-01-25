From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/19] mingw: do not use symlinks with SVN in t9100
Date: Mon, 25 Jan 2016 17:53:45 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601251752450.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <f016fde3118f5028b7e589f36bc9c916464a9de9.1453650173.git.johannes.schindelin@gmx.de> <xmqqegd6bf4j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 17:54:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNkPD-0006qt-Ep
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 17:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035AbcAYQxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 11:53:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:60104 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbcAYQxw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 11:53:52 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MaaOf-1ahlBb0fRR-00KBwc; Mon, 25 Jan 2016 17:53:46
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqegd6bf4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:RtEoirdJXEVRzyebymSX/q9NCT+zda7Dz1kEOMZD1qnum5DaIa0
 U77J4pY3DoEz/46LMjtK0FvApl5OD7QhnwBwQnfsnDGxhJWhYyU6viPbsAmLb/qHWi2vmM7
 2ccVY/0JxRX8kwiuAbDA0qKeWdDAD0u0R+4/6+9vwo6jnXX735GcvnDPmhVs6MdlUOJuZbT
 2Wbcn/HEkso9O2IvCRkrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VbMgOn40Drk=:irHdUVs5BYoyBSS4u8xJkG
 uUyHfDGJnzfnG0tTQe1eRWo5qTgycPw7GLuzemLMDgdU0wDqo0F0sarIpwCHYkJ3o1fAPXm5s
 YZJLWurx7QyJOTNlbZwAa0jAILAL+thdBQXqY05Hni6WCBgQ5x+wShbngSDz3JuP0WDxaDsOT
 YOdYrR5Kw31+oWVE+BPxLIVfVoZ/1eC6gL2ggq16xexnbZXtDh3bL6sZTUECI14z8qYnDbeFp
 MmN36lYmjxNlum6JtS/OzZ2Xh28Twb1UAexgie3XRpJMQcQ/khsbb8cYBOkkzUBvT90XTKBtv
 SgZFs2Ad3+LXpygmKx30hI12t0A2s3Qff8LcrAnFIHr2M7bcH5IdsbDUILPXSlMGEnFLidsMC
 qX1mgS/SRy8te4YvY1NsUmgqlCz1aqrJoA80ghW4bTo7mF1w8L5So6TPFNj2bb78hzDXdDMIF
 B6fV4eMIDfacwLPC5fxZyqAXnv9oEFJD0gx9O1plT4yxsvCWCQysvXHnt/wOr563eK4eoO+iW
 PDu1NNyVDQ0M2pLgld8wN+iLbgF91od2ivpixycQ6eoiXRsEC/eBWXUk6H1oHixR/xSK7UTaP
 t5eOMra2uU5xEzyjZT4yoZsBUNXplMjebZSD21voFjk4FUxsmgneXX+TljfToT1dh3DFenj6Y
 IGdxHsA66vZaisXvrdvO1z3ENBRsm/lTPckQ27Q8diSr5t2za9jEqYgM/ke5U5nkL1UCn3f5s
 lPNF37IlXYTsbFC2G6n8X1RNlh8ZmR+qr4GqHUF4mAbs2czJbJdEVVlqPsgc2Eh1Qd9qUVq0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284740>

Hi Junio,

On Sun, 24 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > From: Karsten Blees <blees@dcon.de>
> >
> > The SVN library does not seem to support symlinks, even if symlinks are
> > enabled in MSYS2 and Git. Use 'cp' instead of 'ln -s'.
> >
> > This partially fixes t/t9100-git-svn-basic.sh
> >
> > Signed-off-by: Karsten Blees <blees@dcon.de>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t9100-git-svn-basic.sh | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> For the purpose of SVN test, is it important that foo.link is a link
> to foo?  I am wondering what would be the fallout from making this
> change without "only on MINGW do this".

(I originally sent the following response as a reply to 13/19 by mistake.)

Your comment made me inspect the entire t9100 again, wondering why things
work when we copy the contents instead of symlinking them. And you know
what, even if I could have sworn that I verified for every patch in this
series that it is actually necessary to pass the test suite, it is *not*
necessary.

So I backed it out and it won't be part of v2 anymore.

Ciao,
Dscho
