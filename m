From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv6 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Fri, 08 Jun 2012 11:57:11 +0200
Message-ID: <20120608115711.Horde.-kmJPHwdC4BP0cx3RNFDX2A@webmail.minatec.grenoble-inp.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
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
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jun 08 11:57:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScvwV-0007hq-S7
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 11:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762005Ab2FHJ5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 05:57:14 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:59558 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751276Ab2FHJ5N (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 05:57:13 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 983FB1A030D;
	Fri,  8 Jun 2012 11:57:11 +0200 (CEST)
Received: from wifi-028244.grenet.fr (wifi-028244.grenet.fr
 [130.190.28.244]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Fri, 08 Jun 2012 11:57:11 +0200
In-Reply-To: <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199479>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>> +char *mkpathdup(const char *fmt, ...)
>> +{
>> +	char path[PATH_MAX];
>> +	va_list args;
>> +	unsigned len;
>> +
>> +	va_start(args, fmt);
>> +	len =3D vsnprintf(path, sizeof(path), fmt, args);
>> +	va_end(args);
>> +	if (len >=3D sizeof(path))
>> +		return xstrdup(bad_path);
>> +	return xstrdup(cleanup_path(path));
>> +}
>
> Hrmph. If a new helper is introduced anyway, wouldn't it be a better
> idea to get rid of the hardcoded PATH_MAX limitation, perhaps using
> strbuf_vaddf() or something in the implementation of this function?

Ramsay Jones, what do you think about this ?
