From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] merge-file: let conflict markers match end-of-line
 style of the context
Date: Tue, 26 Jan 2016 10:04:53 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601260955320.2964@virtualbox>
References: <cover.1453632296.git.johannes.schindelin@gmx.de> <cover.1453709205.git.johannes.schindelin@gmx.de> <26c973eb3414a8634d515f3621c0ded77cf030ed.1453709205.git.johannes.schindelin@gmx.de> <xmqqr3h5fmf4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 10:07:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNzb0-0003Ve-Im
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933401AbcAZJHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:07:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:62765 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964906AbcAZJFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 04:05:09 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MCwbX-1aEKdf1NFj-009g4M; Tue, 26 Jan 2016 10:04:56
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqr3h5fmf4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:it5B4qjKv6hilut/9k+/JRgwO0P+nkZtgZuHLJ05xyRkdxeURPp
 dzdjn3s6vYDWIxKVeX4Dk3xOKf8cd9NWiDAonJQYYBSOjQlLibf+I46re4SD3sFA0dKNN3d
 SgOVnnP+fKv3fgKG96ou0S3cjbYG53+2/pUWv8sanFIgYpuaLRVupngvnN7hPUEqVx0199Q
 rh3Dsd31bgTu6LJw+DJeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qOTRNowt8ew=:VrdZfWP4j24YZCCMEVb4sj
 SP6El6hbsIgbEMAoIPlfYbm0FhjLFtldiBAt/mEhWIu9KNwUKfaM/wwWyWfdbleFUwLj0kxLu
 whXNIWbo/Hm+rlDaIoZ2soYfLDoXpa6Q7XfMH8PN/RauSQe6+NyAzEWTp7oQJa5SJyxT+HHCC
 0DQkaIj1j1QIkSD/H9tQdwQNLqMbE1v7PYMEVcjFgZn5OMCUdMXMHOqRKCT9FN65Hg3yOZGJr
 WNfrhwxQ6LAcNBOIHAVGUdEVd4U4bIBAR7/R7ur1A96z5rJDJAyysZFe3EQ4NIGxEJvCQ907l
 ge6g6f8KL+L+bC7XBzIlwTE5WecgYqUBqXVeq/8GbGL3I4R9wut5bwiGAQheenft1m2Y4U6PN
 /rirK2oiyXHl+FiHkOwENBTjUbd15aVxsRpTe0UuEpGK4XXMaVmm9KTOrp0fU8h9kQwCsDNkU
 MRfAmJJ20cfO+tcY7vXaZ0dtbn1x9f88VKQuWVvnUFpS/175ld83kt7R8hLIQSMnYHIXzdmQu
 haf9PS/f6MJkwICyNyWe/6WpdMKtjpv/7nGGlg+HiHP2xOMWAToVKWWYQykft1qgwG98b6DTx
 thWI/fwxhPsDKWhT17HnKIXFp9Ob/QlILJEGMp9OtZbJ8H6YtODsOPmyH8+v+n28rgfB2tx8t
 HYS313j1Bu9KbJ9fETUaNuO/twUl74FZv26LcrkDLg9TVfmgj2y5PqdjYiV7rSmpfmc8Xd/pf
 4pXyuYoOdTos2TjSVYdsFIX7e4ae494jGWxmoxebZGK0aePdlhSDd4pn5ipEiHQBjcV7RPDF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284789>

Hi Junio,

On Mon, 25 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > We actually do not have to look at the *entire* context at all: if the
> > files are all LF-only, or if they all have CR/LF line endings, it is
> > sufficient to look at just a *single* line to match that style. And if
> > the line endings are mixed anyway, it is *still* okay to imitate just a
> > single line's eol: we will just add to the pile of mixed line endings,
> > and there is nothing we can do about that.
> 
> Isn't there one thing we can do still?  If we use CRLF for the
> marker lines when the content is already mixed, I'd think it would
> help Notepad (not necessary for Notepad2 or Wordpad IIUC) by making
> sure that they can see where the marker lines end correctly.

Not sure. You might end up with a very long line (containing plenty of LF
"characters") and the conflict marker *at the end* of said line, with a
CR/LF after it. I would not call that particularly helpful.

Seeing as we really cannot do anything in this case, I thought it would be
a good idea to avoid trying (and failing) to be smart here.

> > Note that while it is true that there have to be at least two lines we
> > can look at (otherwise there would be no conflict), the same is not true
> > for line *endings*: the three files in question could all consist of a
> > single line without any line ending, each. In this case we fall back to
> > using LF-only.
> 
> Yeah, this is tricky, and from the same "helping Notepad that
> concatenates lines with LF-only" perspective I should perhaps be
> suggesting to use CRLF in such a case, too, but I would say we
> should not do so.  Three variants of a LF-only file may have
> conflict at the incomplete last line, and if we only look at their
> "no EOL"-ness and decide to add CRLF to the result, that would be
> irritatingly wrong.

Oh, but there is the fall-back to the first line. So if we have three
variants of an LF-only file, the logic will figure out that LF-only
end-of-lines are to be used.

So the *only* case where we really have to pick and choose is when all
three files contain only one (or no) line that is not terminated by a line
feed.

I briefly considered to choose EOL_NATIVE in that case, but I really do
not like that unnecessary deviation from Linux Git.

Ciao,
Dscho
