From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 22:21:31 +0100
Message-ID: <20110322212131.GB30604@neumann>
References: <4D871972.7080008@elegosoft.com>
	<7vhbawno11.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1103212302000.1561@bonsai2>
	<7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
	<20110322085027.GF14520@neumann>
	<7vsjufkqxl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>, <lee.marlow@gmail.com>,
	<markus.heidelberg@web.de>, <spearce@spearce.org>,
	<bebarino@gmail.com>, <ted@tedpavlic.com>, <tlikonen@iki.fi>,
	<trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:21:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q291I-00079W-Tl
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 22:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab1CVVVf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 17:21:35 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:18413 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab1CVVVe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 17:21:34 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 22 Mar
 2011 22:21:30 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 22 Mar
 2011 22:21:31 +0100
Content-Disposition: inline
In-Reply-To: <7vsjufkqxl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169777>

On Tue, Mar 22, 2011 at 10:25:58AM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > I think this is not necessary.  We already run __git_aliases() ever=
y
> > time after 'git <TAB>', and it was not an issue so far.
>=20
> If we allow that line of reasoning, the cached $__git_all_commands th=
at
> can go stale needs to be removed, no?  I think folks running bash on
> windows wanted it and it would be helping them.

Well, Shawn wrote that it was your request ;)

  http://thread.gmane.org/gmane.comp.version-control.git/32444
  http://thread.gmane.org/gmane.comp.version-control.git/32438

But there was indeed a remark shortly before that about bad fork-exec
performance under Cygwin on an other topic.

> One valid looking argument against caching aliases but still caching
> commands is that the former could change on the end user's whim while=
 the
> latter is more or less stable across releases,

Agreed.

> but people can throw their
> own "git-frotz" in their path and run it as "git frotz"

Also agreed, and been annoyed by it not being recognized
automatically.  In fact I've even tried to make the completion script
detect user's commands on the fly but still without that huge loop
over the 'git help -a' output in __git_list_porcelain_commands(), but
couldn't come up with anything acceptable so far.  And simply
re-sourcing the completion script is not all that difficult,  which
will also take care of refreshing cached aliases, so...

> so that is not
> entirely a valid argument, either.

agreed here, too.


Best,
G=E1bor
