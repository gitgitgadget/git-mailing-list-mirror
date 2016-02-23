From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: whither merge-tree?
Date: Tue, 23 Feb 2016 13:36:36 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602231334050.3152@virtualbox>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com> <20160222221209.GA18522@sigill.intra.peff.net> <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com> <20160223050210.GA17767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Stefan_Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:36:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYCD4-0000lz-Ts
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 13:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbcBWMgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 07:36:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:59006 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbcBWMgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 07:36:54 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LnUna-1a0mOO2yuk-00hbF3; Tue, 23 Feb 2016 13:36:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160223050210.GA17767@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gftVCHvDqDnlypOhMqKbDfk6pYCXKtnGQ0tiTinD2m8T471UDwS
 DDSPXxggYe5xd5Hea8YoFprD0XDqwXR+BNRXOCnULS6q68wwk+pjwR6yeatzKeuy7oMAvB5
 8birxQ4LEhvDt+ckXkdAyTkb+Svsja3BbNiXH54Lqz7mGHjxCTBKBY5CCyazj9NruEs4+zO
 Qs0IuXMSEdHc8OlUeppMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ln9ZMq+8cjc=:Kj3Xaj/YD/sLld4HRBL8r4
 /8gxHUbjsXDTzjXoiQaqzas6Rz0Nw+rHVA1vFEZ5uaWlEfOQgzO0u4bnR7LLJImCvh7DwSpZr
 mw/DcUaUs7asln7/PMDssL2mEBNe83e3vQtEXXIXlI02E24cn5ynAyt5M1TdiCaxE9LWznkek
 0M7X3Up5nYeQMvnN3Lj6YLhnU5ukDk2ClDq7t6rDY9IfQJQCzSSQ1A6TT1OzNjf5oeEGdGUh/
 ZT5E4g4R5+lMwTXoUjjdzh42j5oDicLtddqmFz4VvQgCkx2EQ8C0bg6PE/H68o+IOiSNzm7uc
 mYNT6ga1o7HQfQ9WtInTnQ1T6b8J3x90gH2HOgbzzvB//1K6UWtVcjxFpECbL4x7bo5LzxlOq
 KX3fAtvME0/drZOgFWG/Ama55V7OfQAT8rFdKHI5nMwqoVz1sHtEXaupk6UeWiHNcWZlpHkwj
 Mas8qpwNs7lV1J6YEEHXrEhmW+q18NPPxqQz8m7x4PTZH1RZTkCBHMJcyK1Jj93k14WOOIQJq
 EIXLaSywZDwqq4uFxoZg5c9kt8tYNL49vN8IqMLOvRwYA8kXRHLFBWRb+yhhNUdg2Y7WjDwYf
 eUdqkUnfZCu0A6i0xDYgc3QAS0COBvnrHE42P0x/3xFqzIdM/7pgYyWYVG4W70eK3z1HR1rpK
 lRPtY3bSP4L1BucKa4NrAt1T9y1hpmNlIZUb1gZtHvvf4UOKT9u/7ccisR9jyfF/TpYwxDmRk
 0iTom2/QXLApIF+5Ot6MaRoLYKbrJoa0cqM48qdnDL/W2u8799cMD3LPvdb2w8mdRzjqFSe7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287048>

Hi Peff,

On Tue, 23 Feb 2016, Jeff King wrote:

> On Mon, Feb 22, 2016 at 02:45:45PM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > >   3. Drop merge-tree completely. This deletes even more code, and
> > >   helps the people in (2) realize that it is utterly unmaintained.
> > >   :)
> >
> > Let's wait and see how many "please don't"s we hear, perhaps, before
> > deciding to go 3.?
> 
> I'm guessing we won't see much either way.

We could encourage more voices by issuing a warning when merge-tree is
called, e.g.:

	warning: merge-tree is unsupported (please contact
		 git@vger.kernel.org if you use it actively)

Ciao,
Dscho
