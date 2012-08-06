From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Mon, 6 Aug 2012 18:06:26 +0200
Message-ID: <20120806160626.GA1198@tgummerer>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com>
 <7vzk68yq5d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7IG4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 18:06:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyPpI-0005F5-Eh
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 18:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147Ab2HFQGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 12:06:35 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64328 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085Ab2HFQGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 12:06:34 -0400
Received: by vcbfk26 with SMTP id fk26so2776936vcb.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QT/FwHWtlEk1ZsJ76+8DNcHDKNspk6fZ1llgG9MN8Xo=;
        b=XQL1rCXxNJFZdgWX6ndJL2D6t4qFjgUjJcCHpAXnM6kaPvvO0pmRBCuH6H0uFtm3zm
         54ghhzqAehq1ipyMrA7wXDzNyKZFG1Phs39tmtF25FdwK8wSmWuv4JAo2izp0bLz42eQ
         8+2k9M2uM/gzIWIxydRVhledVV/wtaR9deio24QY8+m/9t5W75KvTlmApolTCjK4yQsB
         vTN+3mFPZarg5HX66WlaoCYaUhFYks29WP95OdwZx8vcwzJ8q3HPuI7Y2VM0shWLU7vr
         uhANWuRPkACUCxyWmrJv8tKWbMSzVsBGZ01QT4EINc7EQ4PySppnqqIFzYfjXU1n4lGF
         4+xA==
Received: by 10.52.22.38 with SMTP id a6mr7409059vdf.37.1344269193891;
        Mon, 06 Aug 2012 09:06:33 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id cy18sm16255245vdb.9.2012.08.06.09.06.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Aug 2012 09:06:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzk68yq5d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202968>

On 08/06, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > These mails are about cosmetics only. But I think it helps maintena=
nce
> > in long term. I notice in your series we have many functions with _=
v2
> > and _v5 mixed together. Worse, some functions that are _v2 only are
> > not suffixed with _v2. I still think separating v2/v5 changes is a
> > good idea. So I played a bit, see how it might become.
> >
> > The next two emails demonstrate how we take v2-specific code out to
> > read-cache-v2.c, then add v5 code in the next patch. Notice there's=
 very
> > little change in read-cache.c in the second patch. I wanted to see =
how
> > v5 changes affects v2 users and the second patch shows it.
>=20
> I like the splitting of the backend into two files; it is a good
> direction to go, but I really prefer to see it done way before in
> the series, so that many symbols in read-cache-v2.c do not have to
> be contaminated with foo_v2 suffix, and similarly _v5 suffix for
> symbols in read-cache-v5.c when they are added.

I agree. I planned to make those changes in the re-roll of this series,
basically making patch 1/2/3/4 in this series in one commit, moving it
to read-cache-v2.c and building read-cache-v5.c along the commits in th=
is
series. The re-roll should be out by tomorrow.
