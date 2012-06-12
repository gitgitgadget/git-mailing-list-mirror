From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv6 1/4] Read (but not write) from $XDG_CONFIG_HOME/git/config
 file
Date: Tue, 12 Jun 2012 18:42:50 +0100
Message-ID: <4FD77F9A.6060202@ramsay1.demon.co.uk>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr> <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr> <7vpq9aenl0.fsf@alter.siamese.dyndns.org> <20120608115711.Horde.-kmJPHwdC4BP0cx3RNFDX2A@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Tue Jun 12 20:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVYs-0002tr-Sf
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 20:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab2FLSLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 14:11:16 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:46396 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753621Ab2FLSLP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 14:11:15 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SeVYf-0005me-o8; Tue, 12 Jun 2012 18:11:14 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20120608115711.Horde.-kmJPHwdC4BP0cx3RNFDX2A@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199827>

nguyenhu@minatec.inpg.fr wrote:
> Junio C Hamano <gitster@pobox.com> a =E9crit :
>=20
>>> +char *mkpathdup(const char *fmt, ...)
>>> +{
>>> +	char path[PATH_MAX];
>>> +	va_list args;
>>> +	unsigned len;
>>> +
>>> +	va_start(args, fmt);
>>> +	len =3D vsnprintf(path, sizeof(path), fmt, args);
>>> +	va_end(args);
>>> +	if (len >=3D sizeof(path))
>>> +		return xstrdup(bad_path);
>>> +	return xstrdup(cleanup_path(path));
>>> +}
>> Hrmph. If a new helper is introduced anyway, wouldn't it be a better
>> idea to get rid of the hardcoded PATH_MAX limitation, perhaps using
>> strbuf_vaddf() or something in the implementation of this function?
>=20
> Ramsay Jones, what do you think about this ?

I think that I'm sorry for the late reply, I've been away ...  :-D

I noticed your new series (v7 I think) which looked good (as far as the
mkpathdup() implementation is concerned) and I don't think it will tick=
le
the cygwin bug. (I haven't actually fetched that mail yet, I've only re=
ad
it using my ISPs web-mail interface, but will do so soon and test it on
cygwin).

Thanks!

ATB,
Ramsay Jones
