From: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@bitplanet.net>
Subject: Re: [PATCH] Remove .git/branches from the .git template.
Date: Sun, 9 Dec 2007 23:34:56 -0500
Message-ID: <20071210043455.GA12941@bitplanet.net>
References: <20071209183856.GA5587@bitplanet.net> <7v3aubpvog.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 04:52:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ZhC-0008GK-4V
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 04:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbXLJDwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2007 22:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbXLJDwS
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 22:52:18 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:46203 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbXLJDwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 22:52:17 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1172648wra
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 19:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        bh=EdhUod5Q16/H8JxDq2KjjihRN9pP+VeJtjrq3I0jEqM=;
        b=PKdnzXaC2Jjvsd3bWC6k/94wYNzkSFE0VWX3R2lo+zAXjAaNrvkvEpu0fE1oQ4/m2VUKGhPDThZKJmlEbfqiDOwSa3I1KXPjB15dXHD1nrbsmPAZKA/RorGovDvn91TYeSEbhDPIL6N5mOUY/2o0xIvI54nLjPFGWyAu9295H2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=INbcZhHKOdeQyvQI+iZaQwFe3WMH4N8INlAdUXEffqwB0XY4xx8zWjGBglsO2l/tPSskz5nK9Nu6rVegKfRxChd713y48GFCFa6Mjf1wpE2pBCgoHybuQcKw7Gr3avc1/lPXHcJ8hGjFzwDrfLZYn/Wnw5rSramUAYs4NAEI2Vc=
Received: by 10.100.201.16 with SMTP id y16mr13997143anf.1197258735849;
        Sun, 09 Dec 2007 19:52:15 -0800 (PST)
Received: from localhost ( [76.24.237.133])
        by mx.google.com with ESMTPS id 8sm2176615hsp.2007.12.09.19.52.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2007 19:52:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v3aubpvog.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67675>

On Sun, Dec 09, 2007 at 10:30:55AM -0800, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@bitplanet.net> writes:
>=20
> > The code in git to read the info in .git/branches is still there,
> > but nothing ever writes to this, so lets stop creating it.
> >
> > Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> > ---
> >
> > As far as I can see this should be safe, but I admit to never reall=
y
> > knowing what .git/branches was originally used for - tracking remot=
e
> > branches or something?  In any case, we only ever read from this di=
r
> > so the only left in git to deal with this seems to be for compatibi=
lty
> > with older repos.
>=20
> This was done purely so that Cogito would not barf on a repository
> initialized with "git init" even if it did not bother creating necess=
ary
> leading directories when it writes its rough equivalent to .git/remot=
es/
> information.  I do not recall if Cogito had such a problem anymore, b=
ut
> I think it can safely go when Cogito is effectively dead.

OK, I don't know where cogito is in that respect, I thought maybe we ha=
d
just forgotten we still created that directory.  Should we just try to
apply the patch to find out how it might interact with cogito?

Kristian
