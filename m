From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 18:18:33 +0200
Message-ID: <48A06659.6010004@lsrfire.ath.cx>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 18:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSa7W-0000Ui-QF
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 18:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbYHKQSo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 12:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbYHKQSo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 12:18:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:33013 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbYHKQSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 12:18:43 -0400
Received: from [10.0.1.200] (p57B7DEB3.dip.t-dialin.net [87.183.222.179])
	by india601.server4you.de (Postfix) with ESMTPSA id A87C32F8041;
	Mon, 11 Aug 2008 18:18:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91956>

=46rancis Moreau schrieb:
> I found this in git bisect:
>=20
>               printf >&2 'Are you sure [Y/n]? '
>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
>=20
> which looks very weird since read(1) returns a status and not the
> string reads from std input.

Good catch.  You need to press Ctrl-C in order to exit, answering "no"
means the same as "yes" here -- not very nice.  Care to send a patch?

Thanks,
Ren=E9
