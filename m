From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Git public repository naming convention (was: Re: users.txt patch)
Date: Wed, 24 Oct 2007 10:41:21 +0200
Message-ID: <FD3A6F4E-1570-4AF0-ADDC-5680B4E83C7D@lrde.epita.fr>
References: <471E50AA.2020004@gnu.org> <200710232339.05948.bruno@clisp.org> <471E6A74.1050402@podval.org> <loom.20071023T215212-99@post.gmane.org> <87sl41cvpj.fsf@penguin.cs.ucla.edu> <86C7B590-6DF9-4785-92CB-B1466641256F@lrde.epita.fr> <87y7dtt0gk.fsf@rho.meyering.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4-159716363"
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib@gnu.org, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 10:41:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikbo6-0001Ij-Fa
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 10:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbXJXIlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 04:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbXJXIla
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 04:41:30 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:39125 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbXJXIl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 04:41:29 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Ikbnr-0001JK-HU; Wed, 24 Oct 2007 10:41:27 +0200
In-Reply-To: <87y7dtt0gk.fsf@rho.meyering.net>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62201>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4-159716363
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

[CC: Git-ML]

On Oct 24, 2007, at 9:51 AM, Jim Meyering wrote:
> Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
>>> On Oct 24, 2007, at 12:28 AM, Paul Eggert wrote:
>>>> Index: gnulib.html
>>>> ===================================================================
>>>> RCS file: /web/gnulib/gnulib/gnulib.html,v
>>>> retrieving revision 1.13
>>>> retrieving revision 1.16
>>>> diff -p -u -r1.13 -r1.16
>>>> --- gnulib.html	22 Oct 2007 21:41:43 -0000	1.13
>>>> +++ gnulib.html	23 Oct 2007 22:22:18 -0000	1.16
>>>> @@ -57,14 +57,20 @@ You can also view the <a href="MODULES.h
>>>>  anonymous <a href='http://git.or.cz/'>Git</a>, using the following
>>>>  shell command:</p>
>>>>
>>>> -<pre><samp>git clone git://git.savannah.gnu.org/gnulib.git
>>>> +<pre><samp>git clone git://git.savannah.gnu.org/gnulib
>>>>  </samp></pre>
>>
>> Is there any reason why this has changed?  I learned (the hard way)
>> that for bare public repositories, it's better to stick to what turns
>> out to be more than a naming convention of `project.git'.  I don't
>
> What are the consequences of not doing that?

You can't git-clone the remote repo because it tries to fetch the  
wrong URL (if the url isn't of the form `foo.git' it will try to  
fetch `foo/.git' which will fail).

>> know if these issues are only related to dumb protocols (HTTP*) or if
>> they also affect the Git protocol.  I can't find the relevant thread
>
> Hmm... maybe it's http-specific?
> Things seem to work fine with the git protocol.

Yeah, that's what I wondered.

>> on the Git ML but the thing is that it seems that several tools rely
>> on the fact that a repository name of the form `foo.git' implies that
>> it's a bare repository (and thus it doesn't need to look for a   
>> nested
>> .git directory).
>
> It has always worked -- on that server, at least.
> I use that form because I prefer the shorter URL:
>
>     git clone git://git.sv.gnu.org/gnulib
>
> In general, if you control the server repo,
> you can simply add a symlink in project.git:
>
>     .git -> ..
>
> I suppose that avoids any such problems, but I haven't
> done that on any of the savannah repositories.

Yeah well that's more of a workaround than anything else.

My guess: it works with the Git protocol, probably because git-http- 
fetch works differently than whatever tool does the fetch for the  
native Git protocol.  OTOH, isn't it better to have a consistent  
naming?  If you look at the gitweb of gnulib [ http:// 
git.savannah.gnu.org/gitweb/?p=gnulib.git ], it says "URL git:// 
git.sv.gnu.org/gnulib.git".  Oddly enough, whether you add the `.git'  
or not doesn't seem to change anything.

The documentation (Documentation/urls.txt) only shows examples of the  
form `git://host.xz/path/to/repo.git/'.  So do Documentation/core- 
tutorial.txt, Documentation/git-clone.txt and Documentation/ 
repository-layout.txt (among others).

Maybe the Git gurus will be able to shed some light on this issue.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-4-159716363
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHHwUxwwE67wC8PUkRAolBAJ403rWO5YmMqJWUWA4ZL0kKV4fWtACgoZV6
ByPYD8MkhfIZGHNIJteZ03U=
=L7Na
-----END PGP SIGNATURE-----

--Apple-Mail-4-159716363--
