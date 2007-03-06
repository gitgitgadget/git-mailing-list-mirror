From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 6 Mar 2007 14:23:17 +0100
Message-ID: <200703061423.18417.jnareb@gmail.com>
References: <20070306093917.GA1761@coredump.intra.peff.net> <989B956029373F45A0B8AF02970818902DAA12@zch01exm26.fsl.freescale.net> <7vzm6qps51.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Li Yang-r58472" <LeoLi@freescale.com>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 14:21:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOZbD-00085B-Nh
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 14:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbXCFNVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Mar 2007 08:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbXCFNVA
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 08:21:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:61113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964981AbXCFNU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 08:20:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2471236nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 05:20:57 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AFWnuBpBrW1inikNnTtz3QWWk9gpdhC5Kfr1GAM9N407GPY8UW6bbQfc3bKeHVCz3ta920vkWOKg9aEHEzTOH7Pxq4b6BEcPI4k7uBz9VwH81AlOjqMEMpK5NcCtFSlLAOfWx81k6qN3OQsCICU4cO6r+l7RO6IZK2cMNvkCuVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gceFe98DV2nTt2HB5zjO6EldRalLNZgH269AcOlHXQMWTB8XIpDn0SgL368xtptcGdQVyyz2R/jGqxx0bYqmFW5YNbC+X/QxTMFKiC4dSThwZwPGf3I+MBmRRf3W4fiDu7dY6cWC4cgHtyFM5QRPHqHbyCp1wQpJzPF91XDW4PI=
Received: by 10.82.167.5 with SMTP id p5mr6995317bue.1173187256544;
        Tue, 06 Mar 2007 05:20:56 -0800 (PST)
Received: from host-81-190-22-152.torun.mm.pl ( [81.190.22.152])
        by mx.google.com with ESMTP id w5sm22796169mue.2007.03.06.05.20.52;
        Tue, 06 Mar 2007 05:20:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzm6qps51.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41582>

Junio C Hamano wrote:

> Speaking of -title, I see "sub git_project_list_body" does this:
>=20
> =A0 =A0 $cgi->a({ ... -title =3D> $pr->{'descr_long'}}, esc_html($pr-=
>{'descr'}));
> =A0=A0=A0=A0=A0=A0=A0=A0
> which seems inconsistent with the earlier quoted $fullname
> handling (unless $pr->{'descr_long'} is already quoted and $pr->{'des=
cr'}
> is not, which I find highly unlikely).

CGI::a() subroutine automatically quotes properly _attribute_ values,
but it does not (and it should not) quote _contents_ of a tag.

So the above code is correct.

--=20
Jakub Narebski
Poland
