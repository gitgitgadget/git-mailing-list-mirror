From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Sat, 6 Dec 2008 02:09:42 +0100
Message-ID: <200812060209.42906.jnareb@gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com> <200812060134.22959.jnareb@gmail.com> <7vabbaxh8y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 02:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8lhH-0003qI-DX
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbYLFBJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2008 20:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754735AbYLFBJp
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:09:45 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:29072 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYLFBJp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:09:45 -0500
Received: by ey-out-2122.google.com with SMTP id 6so120478eyi.37
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 17:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=afVU09JaKvmzM0ti+ShgOi+2+yK4AvX7opQKpxxaWOk=;
        b=wR9qY8v84qsQ4u96ulezoLrSdrR5cod/x6JHeJZCTRA/21k4mqDdhQgy1K6VFgkhIV
         qsJnwDnCI+jd5sCIq6F+hbdoUm083ZlYbN30UzqpxY3KudM/moHOPzAqPPcIZxMzM7SN
         9a3C7XFTW/l7J2dJaU32tjwUPLLa7fJd05Z+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Fuia2Rlg/OGANvO0sqhk9C1LOUBqUODw+CM76eJSI0PenJYwReW1yVHw8O1r4cXIb6
         WQ18byTFIw6gE3oanTIwjSKruOSgvqExp1JdmU9ogVuG4Xdt1s+qNU1eser2JZiCBvRi
         OnUXknv3qCfkfN683diedYE/Td8Kv2TbloRJQ=
Received: by 10.210.29.11 with SMTP id c11mr583450ebc.141.1228525783109;
        Fri, 05 Dec 2008 17:09:43 -0800 (PST)
Received: from ?192.168.1.11? (abwe217.neoplus.adsl.tpnet.pl [83.8.228.217])
        by mx.google.com with ESMTPS id 7sm6525207eyg.42.2008.12.05.17.09.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Dec 2008 17:09:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vabbaxh8y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102428>

Dnia sobota 6. grudnia 2008 01:46, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>>> +	# The maximum number of patches in a patchset generated in patch
>>> +	# view. Set this to 0 or undef to disable patch view, or to a
>>> +	# negative number to remove any limit.
>>> +	'patches' =3D> {
>>> +		'override' =3D> 1,
>>> +		'default' =3D> [16]},
>>>  );
> >
> > [...]  Also features are usually not overridable
> > by default, which reduces load a tiny bit (by _possibly_ not readin=
g
> > config, although that shouldn't matter much now with reading whole
> > commit using single call to git-config, and not one call per variab=
le).
> > And I think the default might be set larger: 'log' view generates
> > as big if not bigger load, and it is split into 100 commits long
> > pages.
>=20
> I do not think defaulting to 'no' for overridability nor defaulting a=
 new
> feature to 'disabled' have much to do with the load, but they are mor=
e
> about the principle of least surprise.  Somebody who runs gitweb in t=
he
> playpen he was given on the server shouldn't be getting a phone call =
from
> his users late at night complaining that the page his gitweb serves l=
ook
> different and has one extra link per each line, only because the sysa=
dmin
> of the server decided to update git to 1.6.1 without telling him.
>=20
> Once a new version capable of serving a new feature is introduced, he=
 can
> plan, announce and deploy by switching the feature on in his gitweb
> configuration file.
>=20
> Some things, like sitewide default css changes, cannot be made disabl=
ed
> by default.  But a new feature can easily be kept disabled by default=
 not
> to cause needless surprises.

Well, 'search', 'grep' and 'pickaxe' features are enabled by default,
but I think it is cause by the fact that they predate %features.

But we have also 'snapshot' feature, which like 'patches' is not simply
on/off but is configurable feature, like 'patches' adds new action and
does modify existing actions only by adding extra links... and which is
enabled by default.

So there... ;-)
--=20
Jakub Narebski
Poland
