From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 4/8] gitweb: (gr)avatar support
Date: Sat, 27 Jun 2009 00:58:15 +0200
Message-ID: <200906270058.16686.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <200906262142.28845.jnareb@gmail.com> <cb7bb73a0906261508s47e8834fuc9b3313bd9f127ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKKNi-0002wH-SP
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 00:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbZFZW6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 18:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756544AbZFZW6V
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 18:58:21 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:53616 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbZFZW6U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 18:58:20 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so2290024bwz.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0vL58aORIUwFvQp+9dyEOxDmKv0vRRAUUr5PhknUy9A=;
        b=lbM/xcIcXegyUKhE8yZB0gRx9n8dBV9gj+4qrxMbGwiei6FuZ+Htn2kqB3Blk0pE+3
         k+/qN4Dvqrkt1lMZ0aEjzILyZpxGvSYTWzPouNEkrC4kx6vx5JGHIXhtua8A9WicWepJ
         0aJN/sCaG2nTCoeJLPKrrDC+Q2xRsG/fHA67Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jAWeuNzrWUAZwbZTO9jSbeR5u3MuQVma91N1dSq76yMp6WMMsQivyA/b0V/tu3FDie
         Bj4jd9i3bkU4ft96rmpK1HQUr281Wfvh3LHqmtNN6I+zxC6j5FZcgKeCTXnuc+8om6rG
         l7002xiB4RO30z1oyHA9lhlfxKoKEUIGiT7s8=
Received: by 10.103.52.2 with SMTP id e2mr2600418muk.33.1246057102471;
        Fri, 26 Jun 2009 15:58:22 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id n10sm19718372mue.17.2009.06.26.15.58.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 15:58:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0906261508s47e8834fuc9b3313bd9f127ce@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122331>

On Sat, 27 Jun 2009, Giuseppe Bilotta wrote:
> 2009/6/26 Jakub Narebski <jnareb@gmail.com>:
>> On Thu, 25 June 2009, Giuseppe Bilotta wrote:
>>
>>> Introduce avatar support: the featuer adds the appropriate img tag =
next
>>> to author and committer in commit(diff), history, shortlog and log =
view.

[...]
>> There is also 'feed' action (Atom and RSS formats), but that is cert=
ainly
>> separate issue, for a separate patch.
>=20
> I'm not entirely sure we want avatars there.

I think you are right. I have thought that Atom/RSS have place for icon=
s
for each entry in feed, but it is not the case. Also feed reader can
use gravatars by itself. Sorry for the noise, then.

>> Sidenote: Gravatar API description[1] mentions 'identicon', 'monster=
id',
>> 'wavatar'. =A0There are 'picons' (personal icons)[2]. =A0Also avatar=
s doesn't
>> need to be global: they can be some local static image somewhere in =
web
>> server which serves gitweb script, or they can be stored somewhere i=
n
>> repository following some convention.
>>
>> Current implementation is flexible enough to leave place for extendi=
ng
>> this feature, but also doesn't try to plan too far in advance. =A0YA=
GNI
>> (You Ain't Gonna Need It).
>>
>> [1] http://www.gravatar.com/site/implement/url
>> [2] http://www.cs.indiana.edu/picons/ftp/faq.html
>=20
> The forthcoming series has picons provider and gravatar fallback;
> however, we might want to have some way to make the gravatar fallback
> configurable.

Do I understand this correctly that there is additional patch planned
in new release of this series providing support for gitweb.avatar =3D p=
icon?

>>> + =A0 =A0 # To enable system wide have in $GITWEB_CONFIG
>>> + =A0 =A0 # $feature{'avatar'}{'default'} =3D ['gravatar'];
>>> + =A0 =A0 # To have project specific config enable override in $GIT=
WEB_CONFIG
>>> + =A0 =A0 # $feature{'avatar'}{'override'} =3D 1;
>>> + =A0 =A0 # and in project config gitweb.avatar =3D gravatar;
>>> + =A0 =A0 'avatar' =3D> {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 'override' =3D> 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 'default' =3D> ['']},

NOTE, NOTE, NOTE!

One thing I forgot about (and would be discovered when running t9500
with provided patch... among other errors) is that you need to provide
'sub' subroutine for feature to be overridable.

=2E..And that subroutine would be responsible for returning '' (empty
string) when feature is overridable.  See other feature_* subroutines.

>>
>> Note that to disable feature with non-boolean 'default' we use empty
>> list [] (which means 'undef' when parsing, which is false); see
>> description of features 'snapshot', 'actions'; 'ctags' what is stran=
ge
>> uses [0] here... =A0Using [''] is a bit strange; and does not protec=
t
>> you, I think.
>=20
> Using an empty string (or 0 like ctags do) is nice because it spares
> the undef check you mention later on, and since empty strings and 0
> evaluate to false in Perl, it's a good way to handle it. Moreover, an=
y
> string which is not an actual provider would result in no avatars.
> More about this later.

[...]
>>> +if (($git_avatar eq 'gravatar') &&
>>> + =A0 !(eval { require Digest::MD5; 1; })) {
>>> + =A0 =A0 $git_avatar =3D '';
>>> +}
>>
>> Here you would have to protect against $git_avatar being undefined..=
=2E
>> but you should do it anyway, as gitweb_get_feature() can return
>> undef / empty list.
>=20
> Using '' as defalt instead of [] shields me from this problem, and
> works properly for boolean checks.

Well, I can understand that.  I was wrong: it is up to (currently not
defined) 'sub' to ensure that gitweb_get_feature would return ''
('default').


Still,

  +our ($git_avatar) =3D gitweb_get_feature('avatar') || '';

is quite simple... and can be in future subtly wrong (unless it would
be gitweb_check_feature, which always return scalar / single element).


>> This might be good enough starting point, but I wonder if it wouldn'=
t
>> be a better solution to provide additional column with avatar image
>> when avatar support is enabled. =A0You would get a better layout in
>> a very rare case[3] when 'Author' column is too narrow and author is
>> info is wrapped:
>>
>> =A0[#] Jonathan
>> =A0H. Random
>>
>> versus in separate columns case:
>>
>> =A0[#] | Jonathan
>> =A0 =A0 =A0| H. Random
>>
>> But this is a very minor problem, which can be left for separate pat=
ch.
>>
>> [3] unless you use netbook or phone to browse...
>=20
> I had considered going this way, but it made the code somewhat more
> complex so I went for the simpler solution. I'll look into putting it
> in separate cells further on.

Well, by "left for later" here I thought about later as in after this
patch series about gravatars get accepted :-)

--=20
Jakub Narebski
Poland
