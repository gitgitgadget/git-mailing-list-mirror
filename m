From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Grafts workflow for a "shallow" repository...?
Date: Wed, 17 Sep 2008 03:12:32 +0400
Message-ID: <20080916231232.GK28210@dpotapov.dyndns.org>
References: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com> <20080916052425.GA14644@spearce.org> <7v3ak08v5l.fsf@gitster.siamese.dyndns.org> <20080916080908.GA14272@atjola.homenet> <48CFB44F.8060609@drmicha.warpmail.net> <20080916135022.GA19466@atjola.homenet> <bd6139dc0809161502t121c5aa5la53784bb8ff273a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Wed Sep 17 01:13:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfjjx-0004H7-S3
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbYIPXMl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 19:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYIPXMl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:12:41 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:15903 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYIPXMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:12:40 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2159888muf.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 16:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dYdwk3x3HcqSNwJosZbIdraNFlAYiScncjg0G6ee0fY=;
        b=HVMvmlLOWtaF99hwWR0FPq7yzUvxrzPHkLDxCb3Ehgq1seegXW0AMIVv6hOv5mDFT+
         V81dP71dK0yHxpBau61JtLPNGhK+YlKWpfgwtQwQu3YdKiJIDTn1MYPs8koxzifv3n1m
         CqglmcU2BZdXvYMPZvrjewL5znd1jol42gqDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=eOAnJeyqjwWVDMBATbmsUPIoKbuO8PI/8GzpMLRE4A3ddAhNGJSDM/oo2eDHaiLbWi
         MfvBW+aHBmqFkm9HKteM/4THaRVQ1tpa2ekLgQiJHCEIFnnOdWFWXVDwl6LHck4y/aVh
         RRx9+/mKs4pVgI7ZVH9jQuxauS8yil5NiXW3U=
Received: by 10.180.248.10 with SMTP id v10mr1316804bkh.21.1221606757018;
        Tue, 16 Sep 2008 16:12:37 -0700 (PDT)
Received: from localhost ( [85.141.190.51])
        by mx.google.com with ESMTPS id h2sm15894580fkh.11.2008.09.16.16.12.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 16:12:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bd6139dc0809161502t121c5aa5la53784bb8ff273a2@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96042>

On Wed, Sep 17, 2008 at 12:02:25AM +0200, Sverre Rabbelier wrote:
> On Tue, Sep 16, 2008 at 15:50, Bj=F6rn Steinbrink <B.Steinbrink@gmx.d=
e> wrote:
> > Maybe instead of providing "pre-shallowed" repos to clone from, tha=
t
> > should have been an RFE to support shallow clones starting at a giv=
en
> > commit in the DAG? I have no idea whether that's feasible though.
>=20
> Would it be like grafts, only the graft is set up by the fetcher,
> instead of the host?

No, the idea is to have it in the $GIT_DIR/shallow format, which differ=
s
from grafts in that it cannot add new parents. So, it can only truncate
history, while grafts adding new parents can modify history in differen=
t
ways.

> (E.g., the graft is created on clone, instead of
> -before- the clone, by means of the --depth parameter?) Which means
> the mentioned security risk is not there (what with the fetcher
> setting it up himself).

The important difference between grafts and shallow is that the latter
does not allow you to add new parents. So, you cannot modify history bu=
t
only truncate existing one. So I am not sure about what security risk
you are talking about. Obviously, that git blame will attribute all
changes that were done before to the earliest downloaded commit. Other
than that, I don't think that you can fake anything here. All downloade=
d
history will be correct and that can be verified based on SHA-1.

Also, I believe that the default mode should be to ignore this shallow
file on server unless the user specified the corresponding option to
make a shallow copy.

BTW, the current implementation of shallow copy has some limitations.
See Documentation/technical/shallow.txt for details.

Dmitry
