From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 19:24:54 +0300
Message-ID: <20150813162454.GA18545@LK-Perkele-VII>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
 <55CCBF6F.3070808@web.de>
 <CA+EOSBkzU=6pKkqYdGqRRcbbudTJkRwcXxswP+zMshVrZaM_mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:25:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPvJN-0006nv-DM
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbbHMQY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2015 12:24:57 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:54978 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbbHMQY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 12:24:56 -0400
Received: from LK-Perkele-VII (a91-155-194-207.elisa-laajakaista.fi [91.155.194.207])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id B909923407B;
	Thu, 13 Aug 2015 19:24:54 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <CA+EOSBkzU=6pKkqYdGqRRcbbudTJkRwcXxswP+zMshVrZaM_mw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275857>

On Thu, Aug 13, 2015 at 06:10:48PM +0200, Elia Pinto wrote:
> 2015-08-13 18:01 GMT+02:00 Torsten B=C3=B6gershausen <tboegi@web.de>:
> >> +
> > from
> > https://en.wikipedia.org/wiki/Transport_Layer_Security#SSL_1.0.2C_2=
=2E0_and_3.0
> > sslv2 and sslv3 are deprecated.
> > Should there be a motivation in the commit message why we want to s=
upport them ?
> They are those provided by the documentation (TLS in particular). We
> let the underlying library to say what is deprecated or not. In this
> case the call fail.

The statement from the relevant SDO is much stronger than "deprecated",
it is "not to be used under any cirmumstances".

Option like this looks only useful for connecting to really broken
servers, damn security.

It could be useful for connecting to buggy servers after TLS 1.3
comes out and is implemented, as there are lots of servers (IIRC, on
order of 10%) that can't deal with TLS 1.3 properly (but very few, IIRC
<<0.1%, that can't deal with TLS 1.2 correctly[1]).

Also, is this option settable globally for all HTTP servers? One
definitely does not want that to be possible. Configurations like
this need to be per-server if they exist at all.



[1] Where correctly includes secure downnegotiation, as TLS
is intended to do when faced with version mismatch.


-Ilari
