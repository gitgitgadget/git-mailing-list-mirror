From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 0/2] upload-pack: pre- and post- hooks
Date: Tue, 02 Feb 2010 01:15:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002020114200.1681@xanadu.home>
References: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com>
 <1265013127-12589-1-git-send-email-ford_prefect@gentoo.org>
 <20100201152010.GC8916@spearce.org>
 <alpine.LFD.2.00.1002011116320.1681@xanadu.home>
 <20100201163618.GB9394@spearce.org>
 <6f8b45101002012152y76bccb65n78235fce170675ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_LlAbfi5BSw1RCYmNRlioBg)"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Arun Raghavan <ford_prefect@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 07:15:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcC34-0003Pf-Jy
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 07:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab0BBGPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 01:15:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62926 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab0BBGPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 01:15:21 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX700GK1APKRL90@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Feb 2010 01:15:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <6f8b45101002012152y76bccb65n78235fce170675ef@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138684>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_LlAbfi5BSw1RCYmNRlioBg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 2 Feb 2010, Arun Raghavan wrote:

> On 1 February 2010 22:06, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Nicolas Pitre <nico@fluxnic.net> wrote:
> >> On Mon, 1 Feb 2010, Shawn O. Pearce wrote:
> >> I think such hooks could be allowed only if triggered explicitly by the
> >> upload-pack caller, such as git-daemon.  That's probably the only
> >> scenario where a useful use case can be justified for them anyway.
> >>
> >> And of course, to avoid any security problems, the actual hooks must not
> >> be provided by the repository owner but provided externally, like from
> >> git-daemon, via some upload-pack command line arguments.  This way the
> >> hooks are really controlled by the system administrator managing
> >> git-daemon and not by any random git repository owner.
> >>
> >> That should be good enough for all the use cases those hooks were
> >> originally designed for.
> >
> > Oooh, I like that.
> >
> > If the paths to the hooks are passed in on the command line of
> > git-upload-pack, and git-daemon takes those options and passes
> > them through, you're right, we probably get everything we need.
> >
> > Gitosis can still use the hooks if it wants, since it controls
> > the call of git-upload-pack.
> 
> I can add the uid check before running the hook as well. Is that good
> enough, or would you guys like me to start from scratch with the
> command-line argument approach?

Please forget the uid check and go with the command-line argument 
approach.  That's the only sane solution.


Nicolas

--Boundary_(ID_LlAbfi5BSw1RCYmNRlioBg)--
