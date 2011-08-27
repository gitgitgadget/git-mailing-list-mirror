From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v2] xdiff/xprepare: improve O(n*m) performance in
	xdl_cleanup_records()
Date: Sat, 27 Aug 2011 12:50:31 +0400
Message-ID: <1314435031.9095.2.camel@n900.home.ru>
References: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org>
	  <1313546037-4104-1-git-send-email-rctay89@gmail.com>
Reply-To: Marat Radchenko <marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 27 10:50:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxEbL-0003X6-3w
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 10:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab1H0Iup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Aug 2011 04:50:45 -0400
Received: from static.231.38.47.78.clients.your-server.de ([78.47.38.231]:47874
	"EHLO slonopotamus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1H0Iun (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 04:50:43 -0400
Received: from [176.57.72.68] (helo=[192.168.0.40])
	by slonopotamus.org with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <marat@slonopotamus.org>)
	id 1QxEWV-0000gP-K1; Sat, 27 Aug 2011 12:45:53 +0400
X-Mailer: Modest 3.90.7
In-Reply-To: <1313546037-4104-1-git-send-email-rctay89@gmail.com>
Content-ID: <1314435031.9095.1.camel@n900.home.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180226>

On =D1=81=D1=80 17 =D0=B0=D0=B2=D0=B3 2011 05:53:57 MSD, Tay Ray Chuan =
<rctay89@gmail.com> wrote:

> In xdl_cleanup_records(), we see O(n*m) performance, where n is the
> number of records from xdf->dstart to xdf->dend, and m is the size of=
 a
> bucket in xdf->rhash (<=3D by mlim).
>=20
> Here, we improve this to O(n) by pre-computing nm (in rcrec->len(1|2)=
)
> in xdl_classify_record().

Thanks for your patch, btw, now diff is much faster
