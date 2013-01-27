From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 6/8] git-remote-testpy: hash bytes explicitly
Date: Sun, 27 Jan 2013 05:44:37 +0100
Message-ID: <5104B0B5.1030501@alum.mit.edu>
References: <cover.1358686905.git.john@keeping.me.uk> <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk> <20130126175158.GK7498@serenity.lan> <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 05:56:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzKII-0005sz-AP
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 05:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab3A0Eon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jan 2013 23:44:43 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:46034 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754727Ab3A0Eom (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jan 2013 23:44:42 -0500
X-AuditID: 12074411-b7fa36d0000008cc-55-5104b0b90480
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 75.6E.02252.9B0B4015; Sat, 26 Jan 2013 23:44:41 -0500 (EST)
Received: from [192.168.69.140] (p57A25FD5.dip.t-dialin.net [87.162.95.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0R4ibu2032724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 26 Jan 2013 23:44:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqLtzA0ugwd4D3BZdV7qZLBp6rzBb
	3Di/i9Vi/o2zjA4sHjtn3WX3OPvoAbPHxUvKHp83yQWwRHHbJCWWlAVnpufp2yVwZxxeGFVw
	TKvi5aO0BsbXil2MnBwSAiYSl1f+ZoewxSQu3FvP1sXIxSEkcJlRYsLM5cwQzhkmib1vtjOC
	VPEKaEtsb+ljA7FZBFQl1rT0MoHYbAK6Eot6msFsUYEwid7X56DqBSVOznzCAmKLCKhJTGw7
	BGYzC+RI3O/4DTZHWMBF4lRLCxPEsouMEvObzoMN4hQwk9j0o4MRokFH4l3fA2YIW16ieets
	5gmMArOQ7JiFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MULC
	WXAH44yTcocYBTgYlXh4gzNZAoVYE8uKK3MPMUpyMCmJ8s5YDxTiS8pPqcxILM6ILyrNSS0+
	xCjBwawkwju/EijHm5JYWZValA+TkuZgURLn5Vui7ickkJ5YkpqdmlqQWgSTleHgUJLgTQYZ
	KliUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1PhiYKyCpHiA9kpuANlbXJCYCxSF
	aD3FqMux/Xf7c0Yhlrz8vFQpcd6tIDsEQIoySvPgVsCS1ytGcaCPhXlbQap4gIkPbtIroCVM
	QEuye5lBlpQkIqSkGhg3C945anmC9dr1VO+ZaSy/DoW/y897y7+hfvrfrmd8CRObTlapLZDf
	Mi3CVcA9f62ow/FdDSwFR2KD9ER3Ce05q7+HV9Kq89ya/MoNq4/VdXklzOvx/eOR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214675>

On 01/26/2013 10:44 PM, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>=20
>> Junio, can you replace the queued 0846b0c (git-remote-testpy: hash b=
ytes
>> explicitly) with this?
>>
>> I hadn't realised that the "hex" encoding we chose before is a "byte=
s to
>> bytes" encoding so it just fails with an error on Python 3 in the sa=
me
>> way as the original code.
>>
>> Since we want to convert a Unicode string to bytes I think UTF-8 rea=
lly
>> is the best option here.
>=20
> Ahh.  I think it is already in "next", so this needs to be turned
> into an incremental to flip 'hex' to 'utf-8', with the justification
> being these five lines above.
>=20
> Thanks for catching.
>=20
>>
>>  git-remote-testpy.py | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/git-remote-testpy.py b/git-remote-testpy.py
>> index d94a66a..f8dc196 100644
>> --- a/git-remote-testpy.py
>> +++ b/git-remote-testpy.py
>> @@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExp=
orter
>>  from git_remote_helpers.git.importer import GitImporter
>>  from git_remote_helpers.git.non_local import NonLocalGit
>> =20
>> -if sys.hexversion < 0x01050200:
>> -    # os.makedirs() is the limiter
>> -    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or =
later.\n")
>> +if sys.hexversion < 0x02000000:
>> +    # string.encode() is the limiter
>> +    sys.stderr.write("git-remote-testgit: requires Python 2.0 or la=
ter.\n")
>>      sys.exit(1)
>> =20
>>  def get_repo(alias, url):
>> @@ -45,7 +45,7 @@ def get_repo(alias, url):
>>      repo.get_head()
>> =20
>>      hasher =3D _digest()
>> -    hasher.update(repo.path)
>> +    hasher.update(repo.path.encode('utf-8'))
>>      repo.hash =3D hasher.hexdigest()
>> =20
>>      repo.get_base_path =3D lambda base: os.path.join(

This will still fail under Python 2.x if repo.path is a byte string tha=
t
contains non-ASCII characters.  And it will fail under Python 3.1 and
later if repo.path contains characters using the surrogateescape
encoding option [1], as it will if the original command-line argument
contained bytes that cannot be decoded into Unicode using the user's
default encoding:

    $ python3 --version
    Python 3.2.3
    $ python3 -c "
    import sys
    print(repr(sys.argv[1]))
    print(repr(sys.argv[1].encode('utf-8')))
    " $(echo fran=E7ais|iconv -t latin1)
    'fran\udce7ais'
    Traceback (most recent call last):
      File "<string>", line 4, in <module>
    UnicodeEncodeError: 'utf-8' codec can't encode character '\udce7' i=
n
position 4: surrogates not allowed

I'm not sure what happens in Python 3.0.

I think the "modern" way to handle this situation in Python 3.1+ is via
PEP 383's surrogateescape encoding option [1]:

    repo.path.encode('utf-8', 'surrogateescape')

Basically, byte strings that come from the OS are automatically decoded
into Unicode strings using

    s =3D b.decode(sys.getfilesystemencoding(), 'surrogateescape')

If the string needs to be passed back to the filesystem as a byte strin=
g
it is via

    b =3D s.encode(sys.getfilesystemencoding(), 'surrogateescape')

My understanding is that the surrogateescape mechanism guarantees that
the round-trip bytestring -> string -> bytestring gives back the
original byte string, which is what you want for things like filenames.
 But a Unicode string that contains surrogate escape characters *cannot=
*
be encoded without the 'surrogateescape' option.

'surrogateescape' is not supported in Python 3.0, but I think it would
be quite acceptable only to support Python 3.x for x >=3D 1.

But 'surrogateescape' doesn't seem to be supported at all in Python 2.x
(I tested 2.7.3 and it's not there).

Here you don't really need byte-for-byte correctness; it would be enoug=
h
to get *some* byte string that is unique for a given input (ideally,
consistent with ASCII or UTF-8 for backwards compatibility).  So you
could use

    b =3D s.encode('utf-8', 'backslashreplace')

Unfortunately, this doesn't work under Python 2.x:

    $ python2 -c "
    import sys
    print(repr(sys.argv[1]))
    print(repr(sys.argv[1].encode('utf-8', 'backslashreplace')))
    " $(echo fran=E7ais|iconv -t latin1)
    'fran\xe7ais'
    Traceback (most recent call last):
      File "<string>", line 4, in <module>
    UnicodeDecodeError: 'ascii' codec can't decode byte 0xe7 in positio=
n
4: ordinal not in range(128)

Apparently when you call bytestring.encode(), Python first tries to
decode the string to Unicode using the 'ascii' encoding.

So to handle all of the cases across Python versions as closely as
possible to the old 2.x code, it might be necessary to make the code
explicitly depend on the Python version number, like:

    hasher =3D _digest()
    if sys.hexversion < 0x03000000:
        pathbytes =3D repo.path
    elif sys.hexversion < 0x03010000:
        # If support for Python 3.0.x is desired (note: result can
        # be different in this case than under 2.x or 3.1+):
        pathbytes =3D repo.path.encode(sys.getfilesystemencoding(),
'backslashreplace')
    else
        pathbytes =3D repo.path.encode(sys.getfilesystemencoding(),
'surrogateescape')
    hasher.update(pathbytes)
    repo.hash =3D hasher.hexdigest()

Michael

[1] http://www.python.org/dev/peps/pep-0383/

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
