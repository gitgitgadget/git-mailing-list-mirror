From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Dokumenting api-paths.txt
Date: Thu, 22 Aug 2013 00:43:14 +0200
Message-ID: <52154282.60701@googlemail.com>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com> <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com> <52136F9C.6030308@kdbg.org> <5213DE72.3000308@googlemail.com> <20130820213452.GI4110@google.com> <5213E240.9080106@googlemail.com> <20130820215911.GJ4110@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA0EB42D61D4364B973268CD5"
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 00:43:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCH7U-0006kj-BR
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 00:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab3HUWnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 18:43:12 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:35424 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab3HUWnL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 18:43:11 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so556276eaj.39
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=m/jEzFTK4MRTT1DWt7jD14yEULlb2IuvoHNPW4Yf97o=;
        b=0IVauo1PiGhov5PLh5XQRmt7epvhrXakQ0K0MLjw4KPeMbGJB6pmV7W59ZflUgx3p5
         auxSUxj5hLq/ds+G4LbeHdqPhFR0mrZUea0cOce41LEHPejTG6VHm2MYLcdzo1jL99m+
         AUxnQHplu2Q2EYm9VQuIW0jGp9CcOblN/35LSvD7XscLBjowRdq7niq/FMU4rUSEdb9J
         ooueDYlwxPAapdw2g0Jklthex0VnYs2kxVISsBkc6ig6InirQ5iVMqom2f6k602ym7VT
         OfsKB6hepfHFVWyBGEucax2cGe9KsmWhi8826Q4q9YQS0RHRoInxH/MlXmAwOlUOXp6s
         TzaQ==
X-Received: by 10.14.111.9 with SMTP id v9mr13169063eeg.35.1377124989436;
        Wed, 21 Aug 2013 15:43:09 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k7sm13144061eeg.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 15:43:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130820215911.GJ4110@google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232745>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0EB42D61D4364B973268CD5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/20/2013 11:59 PM, Jonathan Nieder wrote:
> Stefan Beller wrote:
>>>> On 08/20/2013 03:31 PM, Johannes Sixt wrote:
>>>>> Stefan Beller wrote:
>=20
>>>>>> +    packdir =3D mkpathdup("%s/pack", get_object_directory());
>>>>>> +    packtmp =3D mkpathdup("%s/.tmp-%d-pack", packdir, getpid());
>>>>>
>>>>> Should this not be
>>>>>
>>>>>     packdir =3D xstrdup(git_path("pack"));
>>>>>     packtmp =3D xstrdup(git_path("pack/.tmp-%d-pack", getpid()));
> [...]
>> So if I have=20
>> 	packdir =3D xstrdup(git_path("pack"));
>> 	...
>> 	path =3D git_path("%s/%s", packdir, filename)
>>
>> This produces something as:
>> .git/.git/objects/pack/.tmp-13199-pack-c59c5758ef159b272f6ab10cb9fadee=
443966e71.idx
>> definitely having one .git too much.
>=20
> The version with get_object_directory() was right.  The object
> directory is not even necessarily under .git/, since it can be
> overridden using the GIT_OBJECT_DIRECTORY envvar.
>=20
>> Also interesting to add would be that git_path operates in the
>> .git/objects directory?
>=20
> git_path is for resolving paths within GIT_DIR, such as
> git_path("config") and git_path("COMMIT_EDITMSG").
>=20
> Jonathan
>=20

Before we're doing double work, I just wrote down my understanding
so far. Feel free to tweak it, or remove obvious parts.

Thanks,
Stefan


---
path API
=3D=3D=3D=3D=3D=3D=3D=3D

The functions described in this document are meant to be
used when dealing with pathes in the filesystem. The functions
are just for the string manipulations of the pathes, none of
the functions touches the actual filesystem.


`mkpath`::
	The parameters are in printf format. This function can be
	used to construct short-lived filename strings. It is meant
	to be used for direct use in system functions such as
	dir(mkpath("%s/pack", get_objects_directory())).
	The return value is a pointer to such a sanitized filename
	string, but it resides in a static buffer, so it will
	be overwritten by the next call to mkpath (or other functions?)
	This function only does string handling. It doesn't actually
	change anything on the filesystem. (This is not Gits mkdir -p)

`mkpathdup`::
	The same as mkpath, but the memory is duplicated into a new
	buffer, so it is not short-lived, but stays as long as the
	caller doesn't free the memory, which the caller is supposed
	to do.

`xstrdup`::
	Duplicates the given string, making the caller responsible
	to free the return value. Basically the same as strdup(2)
	with errorhandling.

	I am not sure if this belongs into the path api documentation,
	but it's not documented anywhere else.

`git_path`::
	git_path is for resolving paths within GIT_DIR, such as
	git_path("config") and git_path("COMMIT_EDITMSG").
	This is similar to mkpath, returning a pointer to a static
	buffer, which may be overwritten soon.

`git_pathdup`::
	The same as git_path, but creating a new buffer. The caller
	is responsible to free the returned buffer.


`git_path_submodule`::

`mksnpath`::

`git_snpath`::

`sha1_file_name`::
	Returns the filename to a given sha1 value within
	the objects directory.

`sha1_pack_name`::
=09
`sha1_pack_index_name`::



--------------enigA0EB42D61D4364B973268CD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSFUKCAAoJEJQCPTzLflhqHawQAMBlTtK55Nbd0x9vICEKaG9O
Sa7OV2Yq7jyUE8KPrYDt4kvDDPMZYiR/VJZRuyH7cLd/IJZ968Su+zprbiWCI72x
kPLVj+stfghp/QRlqtAxYmaEkFjAvOujdawDxBGJ9TY7pozP3csgikxR/PU9tJcz
ud4vl9vLKe42PzXLMLWljuxAahLKzV8bxCdqRYs8L9O9JA1wKnx12CByG/8e670/
xYKODPsuPfbNGdP1BhTwqSl2TrreWSyVs/MPho0slJIwAj13W89CSqa1E1wJ+CTv
LBodR2D8NrPoJjstM6XxObM2JpVUOo36nQln7XX5Zsz9OzUfB3JtwhBgFl8TWzH8
rJw2SV3aHEow4EslYJjSC0anRRVaAnwMn9UOavJ98sfMEGxRZKl5W6eK1gQiUrf0
bn3C4kDTXf1BC5uz1zuGptNKWrsmgyiy2CUETi7+HoFyBiWLvFGbchpRzoCM/X3E
/fynv2y/jA2OI7O1mbDaldISMuZh0/CB1sTLKzjAnh9OknHCMqYaEiZEy7811EGK
3iASeW9z7qzOHbh45RMCtW+1z+cmHXIjOUTftk59eWoriV7HF+O8iQIRTTeAIm6v
0dd1LTNw+jGpaI95xfg4bY7y4kAn9zjIY8RdawrvqapBTghNRZ6OGrZYfPQ4QNT0
kv8u9iV6K5X6YlHDckWS
=c0Gx
-----END PGP SIGNATURE-----

--------------enigA0EB42D61D4364B973268CD5--
