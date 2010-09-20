From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Mon, 20 Sep 2010 10:59:05 +0200
Message-ID: <201009201059.07742.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <201009200102.22960.jnareb@gmail.com> <AANLkTim0X-3PFccXTjH3Mo5eEHL+7zBcifqHu9hWp_RP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 10:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxcDh-0002jd-TA
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab0ITI7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 04:59:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62327 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab0ITI7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:59:19 -0400
Received: by bwz11 with SMTP id 11so4080962bwz.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+rrs0lUVCnFyLI9Xga0+/gYSTpJEv6hLaL4oJTH54Co=;
        b=WuzQPSpj3ntLYiC4GuLQmnxPbc4FoPVOlHRxO1RfD9IcXJw7nS7pY04kbMYp6dg2yw
         5oTIpvOCEU361j6ZnDE2kPg3+OpA0n1n5C2ZA8kwNH9wMttinVPDhFFJ7lAAoLiperpY
         Jg7o6ejaflTCeGGyjR6/eQ57bVoIymEpDWrEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ttCIUygzcDwJRoegFU2EUESQCzY8h7i1hudAHuCEy+M8sdgLplMJWFj59AoDJUorCt
         JFM44QmpTmNU4z1NTGVP3WxS6AOhIqpK+4V0yIci3Fd3YalEcqQyWQPgHY97i/dC9hOg
         j0hv5D+jGF06ntDjf2SJcO6hakRbtlZI9cpGU=
Received: by 10.204.81.39 with SMTP id v39mr6397462bkk.149.1284973157849;
        Mon, 20 Sep 2010 01:59:17 -0700 (PDT)
Received: from [192.168.1.13] (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id d27sm6269306bku.10.2010.09.20.01.59.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:59:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTim0X-3PFccXTjH3Mo5eEHL+7zBcifqHu9hWp_RP@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156600>

Giuseppe Bilotta wrote:
> On Mon, Sep 20, 2010 at 1:02 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
> >
> > When thinking about how display information about remotes and
> > remote-tracking branches in 'summary' view, we have to consider tha=
t
> > this view is meant to be what it says: a *summary*. =A0That is why =
both
> > the 'heads' and the 'tags' section displays only 15 items.
> >
> > Without grouping remote heads the natural solution was to simply re=
peat
> > what we used for 'heads' subsection, namely limit displaying to 15
> > remote-tracking branches in 'remotes' subsection of the 'summary' v=
iew.
> >
> > With grouping it is more complicated. =A0We can limit number of rem=
ote
> > head *per remote*, we can limit number of remotes... but what makes
> > IMVHO least sense is limit number of remote heads *then* do groupin=
g.
>=20
> This is something I absolutely agree with, BTW. It is the way it's
> implemented currently because it was the quickest way to ship a
> prototype out for discussion.

All right.  Prototyping is good.

> > The solution (1) i.e. limiting number of remote heads per remote, w=
ith
> > or without limiting number of remotes behaves, as you wrote, most
> > similarly to other components of 'summary' view. =A0On the other ha=
nd
> > with large number of remotes, and large number of remote heads in t=
hose
> > remotes it might be too large for a *summary* view.
>=20
> So you maintain that limiting the amount of data in summary view
> should be primary wrt to limiting the amount of time?

Well, what really affect gitweb performance is calling git commands, bo=
th
because of fork overhead, and because it means disk access (and gitweb
performance from what I have heard is affected mainly by IO, and not CP=
U).
With grouping (displaying remotes) the difference between displaying
remote-tracking branches (or information from them) and not displaying
them is an argument to git-for-each-ref.  So I don't think it would=20
affect performance much.

> > The solution (3) i.e. displaying only list of remotes (perhaps limi=
ted
> > to 15 remotes) is simple and fast to render. =A0On the other hand i=
t offers
> > least information and might be too little in the case of single rem=
ote.
>=20
> If time spent processing is not an issue, we can retrieve the number
> of heads for each remote and display that, for example. Or even play
> with some more dynamic stuff like making each group collapsible,
> starting with it collapsed and then display the content when the user
> hovers it with the mouse, for example.

The dynamic stuff is IMHO a good idea... provided we can either do it
without JavaScript, or we can ensure that browser supports JavaScript
(see current hack used for turning 'blame' into 'blame_incremental'
view in gitweb).

Yet another solution would be to display only abbreviated list of remot=
es
if its more of them than some threshold, and list remotes with abbrevia=
ted
list of remote-tracking branches if there are only a few remotes.
=20
> > > If we go with option 3, it does make sense to get all remote name=
s and
> > > all remote branches at once, and thus to make the git_get_remotes=
()
> > > call do all of the work.
> >
> > Not if subroutine is called git_get_remotes(), IMVHO. =A0Perhaps
> > git_group_remotes()?
>=20
> That I can do.

> > If remote doesn't have remote-tracking branches associated with it
> > (e.g. push-only remote, or remote predating separate remotes layout=
)
> > the value would be undef for given remote as key in hash.
>=20
> Yes, this is something I have to take into consideration. Skip
> displaying them is probably the best idea (unless we have other ways
> to gather information about them).

Right.

P.S. It is not necessary for this series, but I think we should think
about "single remote" view... also because your code currently links
to such views, which do not exist yet (remotes/<remote> in path_info:
how it would be represented in CGI query format?).

--=20
Jakub Narebski
Poland
