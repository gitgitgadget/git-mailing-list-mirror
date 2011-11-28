From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: in-page errors don't work with mod_perl
Date: Mon, 28 Nov 2011 23:32:06 +0100
Message-ID: <201111282332.07276.jnareb@gmail.com>
References: <CAKD0UuweWoY5ObXgyN9vrOXWrKdNYWuG7CGB0V7HvcuiwRJD+A@mail.gmail.com> <CAKD0Uuws=zU+Pg8afn91mm0t4Rp_GNF++dTYnjA9okndyR=cXQ@mail.gmail.com> <CAKD0UuzsV7A_j8YD4b0Lb95L2NcRcSu5PH8C9aZQmEx3tOuQjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Mon Nov 28 23:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV9kM-0003qT-Uu
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 23:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab1K1WcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 17:32:14 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63381 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab1K1WcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 17:32:12 -0500
Received: by bke11 with SMTP id 11so9157910bke.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 14:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=+SpIiSLAoiMRiF1kKy7JjszRjSy7SgqqSLrOnWEqusU=;
        b=VpswAcHfm6s2F1UWM3nmOZJOfWufOQiSf96sDOEhWOxLfJWE14iLbthvTsfJf7FbYk
         RG50GGydWX5ZXqQKso+8CPyGrT2OwB/2A1JWcSZML135Lr85+gI5I44ptv00GsLX7qOV
         MZd6H2/q/ggz1dXNNcypcT7JyfBuZYgsnYeP4=
Received: by 10.204.38.16 with SMTP id z16mr48658889bkd.66.1322519529129;
        Mon, 28 Nov 2011 14:32:09 -0800 (PST)
Received: from [192.168.1.13] (abwn156.neoplus.adsl.tpnet.pl. [83.8.237.156])
        by mx.google.com with ESMTPS id f14sm32749783bkv.3.2011.11.28.14.32.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 14:32:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CAKD0UuzsV7A_j8YD4b0Lb95L2NcRcSu5PH8C9aZQmEx3tOuQjQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186036>

J=C3=BCrgen Kreileder wrote:
> On Mon, Nov 28, 2011 at 21:13, J=C3=BCrgen Kreileder <jk@blackdown.de=
> wrote:
> > On Mon, Nov 28, 2011 at 17:54, Jakub Narebski <jnareb@gmail.com> wr=
ote:
> > =C2=A0[...]
> > >
> > > The configuration is very similar. =C2=A0Perhaps that is the diff=
erence between
> > > Apache 2.0.x (mine) and Apache 2.2.x (yours).
> > >
> > > Does adding `$r->err_headers_out();` before `$r->status(200);` he=
lps?
> > > I'm grasping at straws here. =C2=A0mod_perl documentation is not =
very helpful.
> >
> > Doesn't help unfortunately. =C2=A0It's hard to find any information=
 about
> > this on the net (except for your comment on stackoverflow :).
> >
> > The only way to get mod_perl to return a custom error message with
> > correct status code I've found so far is $r->custom_response($statu=
s,
> > $msg). =C2=A0Unfortunately mod_perl then ignores headers I set, e.g=
=2E
> > content-type.
>=20
> I guess this explains it:
> http://foertsch.name/ModPerl-Tricks/custom-content_type-with-custom_r=
esponse.shtml
> Requires quite some restructuring to gitweb.perl.

I'm coming close to declaring that ModPerl::Registry is horribly broken
with respect to error pages created by CGI, and say that we don't suppo=
rt
it, removing mod_perl configuration examples from gitweb documentation.

WTF 'return Apache2::Const::DONE;' doesn't work with ModPerl::Registry?
It is supposed to work with native mod_perl scripts...

--=20
Jakub Narebski
Poland
