From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 13:55:19 +0200
Message-ID: <20080725115519.GA32487@atjola.homenet>
References: <alpine.DEB.1.00.0807241821440.8986@racer> <7vy73q4jzp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 13:56:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMLuJ-0005E3-Sx
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 13:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbYGYLzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 07:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbYGYLzX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 07:55:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:34254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752249AbYGYLzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 07:55:23 -0400
Received: (qmail invoked by alias); 25 Jul 2008 11:55:21 -0000
Received: from i577BBE25.versanet.de (EHLO atjola.local) [87.123.190.37]
  by mail.gmx.net (mp019) with SMTP; 25 Jul 2008 13:55:21 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/PM71Z3GvP77MsPOY2IzjROQmJtrL274hSgHKnb4
	i8CfuLRskthqBQ
Content-Disposition: inline
In-Reply-To: <7vy73q4jzp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90040>

On 2008.07.24 22:21:14 -0700, Junio C Hamano wrote:
> Reading get_data_from_pack(), it does rely on hdr_size, idx.offset an=
d
> idx.offset of the next entry to be set correctly.  The function does =
not
> seem to use type (which the patch is also setting) nor real_type (whi=
ch
> the patch does not set).

type is used in get_base_data().

> However, the code checks objects[nth].real_type all over the place in=
 the
> code.  Doesn't the lack of real_type assignment in append_obj_to_pack=
()
> affect them in  any way?

I had thought that resolve_delta() would set that, but it seems that we
never call that function like that. Hm...

Bj=F6rn
