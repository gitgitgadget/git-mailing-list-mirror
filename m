From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Configuring (future) committags support in gitweb
Date: Sat, 8 Nov 2008 23:35:48 +0100
Message-ID: <200811082335.49505.jnareb@gmail.com>
References: <200811082007.55045.jnareb@gmail.com> <200811082102.44919.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 23:37:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KywQc-0000tX-JM
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 23:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYKHWfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 17:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbYKHWfz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 17:35:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:8916 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbYKHWfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 17:35:54 -0500
Received: by nf-out-0910.google.com with SMTP id d3so870796nfc.21
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 14:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zZXWX8VgsjzjPukuZ52GO8N4nA/z9l+Yo5YcOdeEux4=;
        b=VCRXrEcuaONpz+IUS5F47E6Kg2A6HV9H8Rkq4CPhLCMtd4KOPq9csBUZsKEzzim/IG
         VhRinwaLa2J5ES2r/yUCTqEwd1v0TqQCzE4bmAD7mamz5bhuvhgdENLE3cO2G42aQwkK
         tCqMby9IkglhngtvvnOiBk6F7Qx48U7gIn2vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wn1hYCQ3pSyhNT3+AnVh/Z75udb2wlDeg/BFQtzeXbqc3M+BxdMAZUazyZ9kr49QUr
         OD9HjrFoRYvxHoO4xAWA/3IfZd+g49v0+H3SX+kUMUI5pAbFgyPxRGMdtntETx6yaJmq
         cnVedWW6o14QFBvj3VO3Tlsx4QytIPWOMETv8=
Received: by 10.210.109.10 with SMTP id h10mr5269074ebc.154.1226183751208;
        Sat, 08 Nov 2008 14:35:51 -0800 (PST)
Received: from ?192.168.1.11? (abva119.neoplus.adsl.tpnet.pl [83.8.198.119])
        by mx.google.com with ESMTPS id 20sm6905719eyc.9.2008.11.08.14.35.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Nov 2008 14:35:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811082102.44919.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100428>

Dnia sobota 8. listopada 2008 21:02, Francis Galiegue napisa=C5=82:
> Le Saturday 08 November 2008 20:07:53 Jakub Narebski, vous avez =C3=A9=
crit=C2=A0:
>> Francis Galiegue <fg@one2team.net> writes
>> in "Need help for migration from CVS to git in one go..."
>>
>>> * third: also Bonsai-related; Bonsai can link to Bugzilla by
>>> matching (wild guess) /\b(?:#?)(\d+)\b/ and transforming this into
>>> http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1. Does gitweb ha=
ve
>>> this built-in? (haven't looked yet) Is this planned, or has it been
>>> discussed and been considered not worth the hassle?
[...]

>> Committags are "tags" in commit messages, expanded when rendering co=
mmit
>> message, like gitweb now does for (shortened) SHA-1, converting them=
 to
>> 'object' view link.  It should be done in a way to make it easy
>> configurable, preferably having to configure only variable part, and=
 not
>> having to write whole replacement rule.
>>
>> Possible committags include: _BUG(n)_, bug _#n_, _FEATURE(n),
>> Message-Id, plain text URL e.g. _http://repo.or.cz_, spam protecting
>> of email addresses, "rich text formatting" like *bold* and _underlin=
e_,
>> syntax highlighting of signoff lines.
>>
>=20
> What do you mean with "not having to write whole replacement rule"?

Like in example with 'link' rule, not having to write whole
<a href=3D"http://example.com/bugzilla.php?id=3D$1">$&</a>
(or something like that).

>> I think it would be good idea to use repository config file for
>> setting-up repository-specific committags, and use whatever Perl
>> structure for global configuration. The config language can be
>> borrowed from "drivers" in gitattributes (`diff' and `merge' drivers=
).
>>
>> So the example configuration could look like this:
>>
>>   [gitweb]
>>   	committags =3D sha1 signoff bugzilla
>>
>>   [committag "bugzilla"]
>>   	match =3D "\\b(?:#?)(\\d+)\\b"
>>   	link  =3D "http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1"
>>
>> where 'sha1' and 'signoff' are built-in committags, committags are
>> applied in the order they are put in gitweb.committags;
>=20
> I don't understand what the "signoff" builtin is : is that a link to =
see only=20
> commits "Signed-off-by:" a particular person?

Committags doesn't need to be replaced by links. In this case I meant
here using 'signoff' class for Signed-off-by: (and the like) lines, by
wrapping it in '<span class=3D"signoff">' ... '</a>'.

> And also, what about the sha1 builtin? AFAIK, a SHA1 can point to a c=
ommit, a=20
> tree, and others... In fact, it points to any of these right now, but=
 how=20
> would you tell apart these different SHA1s in a commit message? The o=
nly=20
> obvious use I see for it is the builtin "Revert ..." commit message, =
that the=20
> commiter _can_ override...

SHA1 (or shortened SHA1 from 8 charasters to 40 characters, or to be
even more exact something that looks like SHA1) is replaced by link
to 'object' view, which in turn finds type of object and _redirect_
to proper view, be it 'commit' (most frequent), 'tag', 'blob' or 'tree'=
=2E

We could have used instead gitweb link with 'h' (hash) parameter, but
without 'a' (action) parameter, which currently finds type of object
and _uses_ correct view...
=20
> Finally, is there any reason to think that a sha1 or signoff committa=
g will=20
> ever need to be overriden in some way?

One might not want to link SHA1, for example if there are lots of false
positives because of commit message conventions or something, or refine
'signoff' committag to use different styles for different types of
signoff: Signed-off-by, Acked-by, Tested-by, other.  Having explicit
'signoff' committag allows us also to put some committags _after_ it,
for example SPAM-protection of emails, or add some committag before
'sha1' to filter out some SHA1 match false positives.
=20
>> possible actions=20
>> for committag driver include:
>>  * link: replace $match by '_<a href=3D"$link">_$match_</a>_'
>>  * html: replace $match by '_$html_'
>>  * text: replace $match by '$text'
>> where '_a_' means that 'a' is treated as HTML, and is not expanded
>> further, and 'b' means that it can be further expanded by later
>> committags, and finally is HTML-escaped (esc_html).
>>
>=20
> What use do you see for the html match? Just asking...

=46or example 'signoff' committag... well, it is not exactly pure "html=
"
but rather something like template.

  [committag "signoff"]
  	match =3D "(?i)^ *(signed[ \\-]off[ \\-]by[ :]|acked[ \\-]by[ :]|cc[=
 :])"
  	templ =3D "{<span class=3D\"signoff\">}$1{</span>}"

Or simpler

  [committag "signoff"]
  	match =3D "(?i)^ *(signed[ \\-]off[ \\-]by[ :]|acked[ \\-]by[ :]|cc[=
 :])"
  	class =3D signoff

> And I don't see what you '_a_' and '_b_' are about...

=46or example in link match, the text of the link can be further refine=
d
by committags later in sequence.

--=20
Jakub Narebski
Poland
