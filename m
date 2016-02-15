From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] http: add option to try authentication without username
Date: Mon, 15 Feb 2016 20:29:37 +0000
Message-ID: <20160215202937.GA57185@vauxhall.crustytoothpaste.net>
References: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
 <1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
 <CAPig+cTr1eW1KLsZGpY98hUhJ2EHdPopz9C_gTztZRdNPBQTmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Cc: Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:29:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVPmF-00007H-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 21:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbcBOU3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 15:29:44 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:40108 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447AbcBOU3n (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 15:29:43 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3C2BF282CA;
	Mon, 15 Feb 2016 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1455568180;
	bh=lPyLekdVg9Aw9S955qyhNlmKdmxKOpfCcndQuHJJI6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1mzva8rpekvFzOU0f0ZqwATbV92qEQtap34chOPMVulXBYM4++gEYb2JWuV6MpBa
	 3p8J0CSq1SKHebfNB5PWZRn67cXZcaNdEGR2rGuwhjWqs2b3KwRYA12el1gHA8qpD9
	 yNzlE7UAHCJzdDWgO5VDaqfTv1PxQ8gMrsOrZnYlBpoyMibR8pidqhLaYu8xdzz86o
	 VM+4d9dYcKcw65mRfZ1hx3IDIFSpf57PNefafFeJ4V1EEkddGc63+UY0rcgqYo/Eim
	 XIUBAh6lcGlG7ByVpZCpM7yI/7p6OfRRbpDoGMHzKKmUeD6Gs40yIEWaZllfFXZMKO
	 R+OIxRFd9JC+k6x3Y3/MbzQ6m/xDsbWteoD5J/TMH705Sj88W7KrW8n+MF2KjLL8DH
	 EVsSWDsiB/PubXSaR17E/KXSfuBEdHBD2K77ka6rcWMvOeQACWDmuPNVjPkesu/h0S
	 i3osjXYhM3V+l16L7kfT/vUI1EGlv6vmih+gn+c3ifij6rXgKG1
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <CAPig+cTr1eW1KLsZGpY98hUhJ2EHdPopz9C_gTztZRdNPBQTmQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286233>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 03:19:25PM -0500, Eric Sunshine wrote:
> On Mon, Feb 15, 2016 at 1:44 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Performing GSS-Negotiate authentication using Kerberos does not require
> > specifying a username or password, since that information is already
> > included in the ticket itself.  However, libcurl refuses to perform
> > authentication if it has not been provided with a username and password.
> > Add an option, http.emptyAuth, that provides libcurl with an empty
> > username and password to make it attempt authentication anyway.
>=20
> I'm not familiar with this code, so let me know if my comments (below)
> are off the mark...
>=20
> > ---
> > diff --git a/http.c b/http.c
> > +++ b/http.c
> > @@ -299,14 +300,22 @@ static int http_options(const char *var, const ch=
ar *value, void *cb)
> >  static void init_curl_http_auth(CURL *result)
> >  {
> > -       if (!http_auth.username)
> > +       if (!http_auth.username) {
> > +               if (curl_empty_auth)
> > +                       curl_easy_setopt(result, CURLOPT_USERPWD, ":");
>=20
> Does this need to take LIBCURL_VERSION_NUM into account? Other code
> which uses CURLOPT_USERPWD only does so for certain versions of
> libcurl, otherwise CURLOPT_USERNAME and CURLOPT_PASSWORD is used.

This is the oldest version, which means it's the most compatible.  Since
we don't need to consider odd usernames, it seemed silly to have both
cases present in the code.  The benefit of using the pair of options is
that we don't leak memory in the non-empty auth case.

> >                 return;
> > +       }
> >
> >         credential_fill(&http_auth);
> >
> > @@ -827,7 +836,7 @@ struct active_request_slot *get_active_slot(void)
> >  #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> >         curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_method=
s);
> >  #endif
> > -       if (http_auth.password)
> > +       if (http_auth.password || curl_empty_auth)
> >                 init_curl_http_auth(slot->curl);
> >
> >         return slot;
>=20
> Rather than sprinkling curl_empty_auth special cases here and there,
> would it be possible to simply set http_auth.username and
> http_auth.password to empty strings early on if they are not already
> set and curl_empty_auth is true, and then let the:
>=20
>     strbuf_addf(&up, "%s:%s",
>         http_auth.username, http_auth.password);
>=20
> in init_curl_http_auth() handle them in the normal fashion, with the
> end result being the same ":" set explicitly by this patch?

That would work.  I was concerned about the credential_fill call
actually prompting the user, but it appears that it doesn't do that if
the password already exists.  I don't know if we want to rely on that
functionality, though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJWwjUxAAoJEL9TXYEfUvaLOnoQALzz4hgVSipztc5adDS8Zlcl
U0hPbdfrZoXX/mAUwRNwjrJPo9PDAOE7RS4arc18gIYGXqmBstcsrVu7QKZf/DyZ
WkLsR961Ww6uxbnTGhfyXvIOoahGTXOkSWXaT9C2TpV4UQxDD5uo3tU/FE0kE6bz
2M/G9L/jguwzPVseZZtppKHFhVMOiI9hIj9WrwvwOU/aP84aSMuNVNhmtcA4rw/I
CsC8g5P7cLN9GqAOl6ZdtYSir47UkGmNfrCS2kJzpisdhN/KvK4np6gwx1MkeOO4
hyEj5CgiquMi90eDZy2LgFlo1lq7R7Y3OpxKhp9dt1TUFZqlBgvj478DOPRy4jfE
pWCSjlvcPzFCZzB5HA96oIFTDxl1nXXBj7Qljo/akKnz38DzvWGEkcx8xKZipj5P
a2qVArOnHgB+3UsmUTcp5cOXQ2mZp4Jw4TV5yZhEUQRabbQYLAnRvwM5z0ovIFo/
9rAv1AcLkslM04EI9zE7lZeMjClXES4ZNJVAgDiFn6K++PBVNRSRUzCD678FAWab
9CNCBKu/C4HH6g8ExWlB7aei/Pcj3zfPjRO/Yc2r/g2sHSlmjhW7qWkE/gakSOup
3UO5xT0fHQnvbY+qTqwDhDTDGQlhD01pVizdzkrEz+vCdsT3gjOSrZyb8phDcRmN
g4n/MWPYSno7Xf3Gx/+B
=3GEs
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
