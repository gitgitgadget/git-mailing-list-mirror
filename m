From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH try 2] gitweb: Add option to put a trailing slash on
 pathinfo-style project URLs
Date: Sat, 13 Dec 2008 20:13:55 -0500
Message-ID: <1229217235.3360.13.camel@mattlaptop2.local>
References: <1229195421.3943.8.camel@mattlaptop2.local>
	 <1229202689.31181.1.camel@mattlaptop2.local>
	 <m3tz97g329.fsf@localhost.localdomain>
	 <cb7bb73a0812131423h1f629ec1n9e8eacd657a4901@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 02:15:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBfZk-0000Hk-R5
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 02:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbYLNBN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 20:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbYLNBN6
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 20:13:58 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:49817 "EHLO
	jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751141AbYLNBN6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 20:13:58 -0500
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id C07F913EC0;
	Sat, 13 Dec 2008 17:13:56 -0800 (PST)
In-Reply-To: <cb7bb73a0812131423h1f629ec1n9e8eacd657a4901@mail.gmail.com>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103037>

On Sat, 2008-12-13 at 23:23 +0100, Giuseppe Bilotta wrote:
> On Sat, Dec 13, 2008 at 10:47 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > Matt McCutchen <matt@mattmccutchen.net> writes:
> >
> >> My Web site uses pathinfo mode and some rewrite magic to show the gitweb
> >> interface at the URL of the real repository directory (which users also
> >> pull from).  In this case, it's desirable to end generated links to the
> >> project in a trailing slash so the Web server doesn't have to redirect
> >> the client to add the slash.  This patch adds a second element to the
> >> "pathinfo" feature configuration to control the trailing slash.
> >>
> >> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> >
> > Did you check that it does not confuse gitweb if filename parameter is
> > passed using pathinfo?  Gitweb used to rely on final '/' to
> > distinguish directory pathnames from ordinary pathnames, but I think
> > currently thanks to the fact that gitweb now embeds action in pathinfo
> > URL, and does not need to guess type, it is not an issue.
> >
> > Or only project URLs (i.e. only with project parameter, i.e. only
> > "http://git.example.com/project.git/" but not other path_info links)
> > have trailing slash added?
> >
> > Errr... I see that it adds trailing slash only for project-only
> > path_info links, but the commit message was not entirely clear for me.
> 
> If indeed the additional / is only asked for in summary view, I think
> there's no need for a feature toggle, we can always put it there. If
> not, I'm really curious about seeing the rewrite rules (they might
> also be worth adding to the gitweb documentation as examples of 'power
> usage').

The trailing slash is used only when the URL refers to a project with no
appended parameters (i.e., summary view), because the URL refers to the
real git dir on disk (hence, pulling from the same URL) and it plays
nicer with the Web server configuration to have the trailing slash.

I was wary about changing the default behavior, but if you and Jakub
both think it's OK, that's great.

I was thinking of proposing the addition of some info about my setup,
including the rewrite rules, to the documentation.  Maybe we could do
that after dealing with the patches.

-- 
Matt
