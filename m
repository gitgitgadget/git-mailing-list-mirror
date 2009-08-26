From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Wed, 26 Aug 2009 18:56:18 +0200
Message-ID: <20090826165618.GA7477@atjola.homenet>
References: <20090826121600.GA29098@atjola.homenet>
 <1251298007-18693-1-git-send-email-catap@catap.ru>
 <20090826155029.GA5750@atjola.homenet>
 <20090826161059.GC32741@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 26 18:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgLnV-0001GU-2T
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 18:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbZHZQ4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 12:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbZHZQ4W
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 12:56:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:55226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752081AbZHZQ4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 12:56:21 -0400
Received: (qmail invoked by alias); 26 Aug 2009 16:56:22 -0000
Received: from i59F555FB.versanet.de (EHLO atjola.homenet) [89.245.85.251]
  by mail.gmx.net (mp071) with SMTP; 26 Aug 2009 18:56:22 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19JawJXDTNJe7EiHTKBa8Oab+Y3mmYatQQWdTnZSg
	kYvDTzD9PHroLQ
Content-Disposition: inline
In-Reply-To: <20090826161059.GC32741@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127106>

On 2009.08.26 12:10:59 -0400, Jeff King wrote:
> So I think the code should probably look like this (totally untested)=
:
>=20
>   remote_head =3D find_ref_by_name(refs, "HEAD");
>   if (option_branch) {
>           strbuf_addf(&branch_head, "%s%s", src_ref_prefix, option_br=
anch);
>           head_points_at =3D find_ref_by_name(refs, branch_head.buf);
>           if (!head_points_at)
>                   warning("remote branch not found, etc");
>   }
>   if (!head_points_at)
>     head_points_at =3D guess_remote_head(remote_head, mapped_refs, 0)=
;

Hm, why "refs" for find_ref_by_name(), but "mapped_ref" for
guess_remote_head()?

Bj=F6rn
