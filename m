From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [[PATCH v3] 1/2] [submodule] handle multibyte characters in
 name
Date: Fri, 14 Jun 2013 20:27:41 +0200
Message-ID: <20130614182741.GA5812@paksenarrion.iveqy.com>
References: <1371225365-4219-1-git-send-email-iveqy@iveqy.com>
 <1371225365-4219-2-git-send-email-iveqy@iveqy.com>
 <7va9msppw7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 20:24:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnYft-0007EV-9w
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 20:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab3FNSYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 14:24:33 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:53661 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab3FNSYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 14:24:32 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so797620lab.21
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wks/11EGa78YSz37Zj94C3o2+Q0tWejyazLzhTFL588=;
        b=tJQMp8kVWQ51XrbsxEPp1WaV8oDb+TZ/ASd7fgl8xCPx0+r2P0z6heJH1xmXqje0az
         V5+CUye+d2yaGYHlhUxdp9A42svrOuVgsyveVaV4ExlxrN0zNhBiTkxQPHK3YIGEZsvh
         yTSV/zvE3+3YfJxE0RMTHMuRSFyi2jKyFpIirv2c3lyENYt5Ci+5ekhunNkI7YhzxDdl
         C4KnS9X7gkUhZOn7pLTC2h6vgfsAY9zGUAO2pbaVv0hRoDYNVYGqhoU2NJSXdpEjfBrc
         6wZXYK7mR4gAi2vQsBClwTOmaQ4mqEefqRaRDDHa1tqrMeKDkLWQtcUWzteJllKqpyu1
         qECg==
X-Received: by 10.112.235.104 with SMTP id ul8mr1658065lbc.36.1371234270995;
        Fri, 14 Jun 2013 11:24:30 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id t17sm1265062lbd.11.2013.06.14.11.24.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 11:24:30 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UnYir-0008PP-7M; Fri, 14 Jun 2013 20:27:41 +0200
Content-Disposition: inline
In-Reply-To: <7va9msppw7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227908>

On Fri, Jun 14, 2013 at 10:23:52AM -0700, Junio C Hamano wrote:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
>=20
> > ... The
> > correct approach to solve the problem for all pathnames may be to u=
se
> > "ls-files -z" and tell the Perl script that reads its output to rea=
d NUL
> > separated records by using $/ =3D "\0".
>=20
> I've tentatively queued the attached without 2/2; the scriptlet is
> small enough not to matter in an eventual rewrite, so it shouldn't
> make a difference either way.

Sorry, I didn't knew enough perl to understand that that was a
suggestion rather than a hint to a future developer.

Now when I see how you meant it's looks like the best solution to me.
To me it looks like we now should be able to handle the multiline case
here. However, git submodule add doesn't handle newline yet, so it
really doesn't matter for now.

Thanks for the help!

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
