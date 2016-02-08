From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH] Documentation/git-clean.txt: don't mention deletion of
 .git/modules/*
Date: Mon, 08 Feb 2016 17:36:50 -0500
Message-ID: <1454971010.2511.89.camel@mattmccutchen.net>
References: <1454790889.23898.225.camel@mattmccutchen.net>
	 <xmqqvb5y6dx2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:37:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSuQW-0004VT-0g
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 23:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbcBHWg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 17:36:56 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:50920 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752997AbcBHWgz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 17:36:55 -0500
Received: from homiemail-a5.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id 07A37704063;
	Mon,  8 Feb 2016 14:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=
	mattmccutchen.net; bh=Bq+g6oH9NIhjZvFwqzRWufnqI04=; b=jACsbSByAn
	pof0+Yl8Q+X+3qEkeFyqGdgj2o1UtS5/N200XHr8Gs7P7ftgL4KpHZxe0ncX1LWq
	jBHXrfdQTlKTtTeso3TYMy33MYkAkYVfO81yO2tSeC3qm+v/PonaX11EnshrOxgq
	A9mpyq6xkZkN2TF1Pimwy7cxfptwtmsJI=
Received: from main (30-9-161.wireless.csail.mit.edu [128.30.9.161])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTPSA id 8644D70406E;
	Mon,  8 Feb 2016 14:36:54 -0800 (PST)
In-Reply-To: <xmqqvb5y6dx2.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285819>

On Mon, 2016-02-08 at 14:22 -0800, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
>=20
> > I found no evidence of such behavior in the source code.
> >=20
> > Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> > ---
>=20
> That was added last year at bcd57cb9 (Documentation/git-clean.txt:
> document that -f may need to be given twice, 2015-02-26).=C2=A0=C2=A0=
It would
> be better to know what got changed since then--that is, was the
> additional text unnecessary even back then, or we made changes to
> the system since then and forgot to remove the added text.
>=20
> Mikko, is this need to give -f twice still the case?

I know you probably want confirmation from Mikko, but I'll offer my
understanding. =C2=A0There were two statements added in=C2=A0bcd57cb9:

1. -f may need to be given twice to delete nested worktrees and
embedded repositories. =C2=A0This is still true.

2. Deletion of submodule repositories under .git/modules is conditional
on -f being given twice. =C2=A0AFAICT, this was wrong even back then: "=
git
clean" has never deleted such repositories under any conditions.

My patch is only removing #2.

Matt
