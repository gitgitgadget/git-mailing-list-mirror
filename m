From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] send-email: support NNTP
Date: Wed, 24 Apr 2013 09:38:24 +0200
Message-ID: <87zjwofken.fsf@linux-k42r.v.cablecom.net>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 09:38:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUuHj-0007qi-CF
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 09:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757842Ab3DXHib convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 03:38:31 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:37719 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755620Ab3DXHia convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 03:38:30 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 09:38:23 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 24 Apr 2013 09:38:24 +0200
In-Reply-To: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	(=?utf-8?Q?=22=C5=81ukasz?= Stelmach"'s message of "Tue, 23 Apr 2013
 13:13:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222232>

=C5=81ukasz Stelmach <l.stelmach@samsung.com> writes:

> Enable sending patches to NNTP servers (Usenet, Gmane).

I'm surprised Junio didn't mention this: your patch lacks the
Signed-off-by.

> +	if ($email_protocol eq 'nntp') {
> +		$header =3D "Newsgroups: $to\n" . $header;
> +	} else {
> +		$header =3D "To: $to${ccline}\n" . $header;
> +	}

Are you silently ignoring any Ccs that have been set if you're in NNTP
mode?

Would it be possible to instead send the Ccs by mail as usual, and only
the main message over NNTP?  (You don't need to run off and implement
this, but I'm curious how hard you think it would be.)

At least in the git@vger world with a lot of etiquette surrounding the
use of Ccs, NNTP mode isn't very useful if you can't also send Ccs.  Bu=
t
maybe you have another use-case where that is not a problem?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
