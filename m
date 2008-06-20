From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH] graph.c: make many functions static
Date: Thu, 19 Jun 2008 23:00:37 -0700
Message-ID: <20080620060035.GA22345@adamsimpkins.net>
References: <20080619082110.6117@nanako3.lavabit.com> <7vhcbptev8.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 08:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9ZhH-0005xN-KF
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 08:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbYFTGAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jun 2008 02:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbYFTGAj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 02:00:39 -0400
Received: from smtp152.sat.emailsrvr.com ([66.216.121.152]:37627 "EHLO
	smtp152.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbYFTGAj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 02:00:39 -0400
Received: from relay5.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay5.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 7AB9E23A78C;
	Fri, 20 Jun 2008 02:00:38 -0400 (EDT)
Received: by relay5.relay.sat.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 59C7123A773;
	Fri, 20 Jun 2008 02:00:38 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 3B91A14100D0; Thu, 19 Jun 2008 23:00:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhcbptev8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85597>

On Thu, Jun 19, 2008 at 12:16:11PM -0700, Junio C Hamano wrote:
> =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nan=
ako3@lavabit.com> writes:
>=20
> > ---
> >  graph.c |   57 +++++++++++++++++++++++++++++++++++++++++++--------=
------
> >  graph.h |   40 ----------------------------------------
> >  2 files changed, 43 insertions(+), 54 deletions(-)
> >
> > diff --git a/graph.c b/graph.c
> > index e2633f8..5f82170 100644
> > --- a/graph.c
> > +++ b/graph.c
> > @@ -4,6 +4,43 @@
> >  #include "diff.h"
> >  #include "revision.h"
> > =20
> > +/* Internal API */
> > + ...
> > +static int graph_next_line(struct git_graph *graph, struct strbuf =
*sb);
> > +static void graph_padding_line(struct git_graph *graph, struct str=
buf *sb);
> > +static void graph_show_strbuf(struct git_graph *graph, struct strb=
uf const *sb);
>=20
> I think these are probably fine, not in the sense that nobody calls t=
hese
> functions _right now_ but in the sense that I do not foresee a callin=
g
> sequence outside the graph.c internal that needs to call these direct=
ly,
> instead of calling graph_show_*() functions that use these.

Documentation/technical/api-history-graph.txt should also be updated
to remove the discussion of these functions if they are no longer
publicly exposed.

--=20
Adam Simpkins
adam@adamsimpkins.net
