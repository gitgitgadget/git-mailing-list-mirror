From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sat, 20 Sep 2008 20:01:27 +0200
Message-ID: <200809202001.28383.jnareb@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com> <m31vzen4v5.fsf@localhost.localdomain> <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 20:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh6nG-0000w0-QH
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 20:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYITSBl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 14:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbYITSBk
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 14:01:40 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:40887 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbYITSBj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 14:01:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so893153fkq.5
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=gIdS/HMXTY+9g9FcAO1yNpUBSAM7t0Pj347JENzGvoI=;
        b=b1CI9TMqSB+wuLp2T0l/ms2M2SzrN8ARBQlKvXrShDyXAJ5erfuTCokxdDAXO2rLmY
         OVer08EvzXgsmXY75sGN8kRQJ6u3gfUKpX1F7Cgno11mF2/R36OULUUtCnx2WtvYdvOn
         /cibyBk9gNQMUz+YexMaMj9xw4BANXcGLhKs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=whVt6zLsEr/HDaG3/tD86vNZK1MQpI5gDSr72j8ducb5BSJPBr7X+cnMGsgYTHed9c
         ICEGR8783cRr4m8m/VziaElcx32DIiQ86emzDXlL1JfiNlON61KRRNcKYzg20LcXXgjB
         4C3EZy8mncXyuSvabrfJJWvbQwM4edjqvzJBI=
Received: by 10.103.20.7 with SMTP id x7mr1259807mui.75.1221933697964;
        Sat, 20 Sep 2008 11:01:37 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.200.201])
        by mx.google.com with ESMTPS id j2sm15193865mue.4.2008.09.20.11.01.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 11:01:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96359>

On Sat, 20 Sep 2008, Nguyen Thai Ngoc Duy wrote:
> On 9/20/08, Jakub Narebski <jnareb@gmail.com> wrote:
>>>
>>>  - "git clone --path" =3D> "git clone --narrow-path"
>>>  - "git checkout --path" =3D> "git checkout --reset-path"
>>
>>
>> I am not sure about that change, especially the fact that git-clone
>> and git-checkout use differently named options, because those option=
s
>> affect clone only as they affect the checkout part of the clone.  On=
e
>> would think that git-clone =3D git-init + git-remote add + git-fetch=
 +
>> git-checkout, and that git-clone would simply pass sparse checkout
>> flags to git-checkout.
>>
>=20
> Johannes sixt said --path was too generic so I changed the name. Hmm.=
=2E
> I did not think the same option name for git-checkout and git-clone
> was important, rather worry about people may misunderstand that it is
> "narrow clone" (do not fetch objects outside given paths for all
> history). Maybe "git clone --narrow-checkout" would be better.

True, I didn't thought that git-clone can have option with explicit
'checkout' in a name, for example --checkout-paths, or --checkout-only,
or --narrow-checkout (although for me this one doesn't look as it
accepts arguments, at least on first glance), or --sparse-checkout
(the same).

> "--reset-path", I think, is a better name though. It would express th=
e
> relation compared to --add-path and --remove-path.

I don't like very much '--reset-path' option name, because it is not
about 'reset' or 'resetting', but about limiting checkout to specified
paths.  Unfortunately --include / --exclude looks like are for ignoring
files, not marking files with "no-checkout" bit etc.

But I am not native English speaker.

=46urther proposals: --only ("git checkout --only <pattern>") with
--checkout-only as counterpart in git-clone; --limit-to, --sparse.


GNU tar uses --exclude and --exclude-file (with --no-recurse,
--no-wildcards, --no-wildcards-match-slash). wget uses --accept
and --reject for filename patterns, and --include / --exclude for
directories.  Neither looks right for sparse checkout in Git.

>>>  - New narrow spec (or "sparse patterns" from now) resembles
>>>    .gitignore patterns
>>
>>
>> You mean here that rules for patterns to select which parts of tree
>>  mark as "no-checkout" and/or checkout/leave in checkout are the sam=
e
>>  (or nearly the same) as rules for ignoring files, isn't it?
>=20
> Yes, almost the same, exceptions include "./" support (this may have
> worked already for .gitignore, I dunno) and backslash escape for
> colons.

'./', or rather '/' support works for gitignore: this is the only way
to have pattern which matches only files in given directory,=20
nonrecursively.  For example last line in last example on gitignore(5)
man page.

>>  BTW I think that the same rules are used in gitattributes, aren't
>>  they?
>=20
> They have different implementations. Though the rules may be the same=
=2E

Were you able to reuse either one?

>>> Nguy=C3=A1=C2=BB=E2=80=A6n Th=C3=83=C2=A1i Ng=C3=A1=C2=BB c Duy (14=
):
>>
>>  Errr... what happened here? For me it doesn't look like correct UTF=
-8
>>  encoding, but perhaps that it is just my news client (Gnus)...
>=20
> The cover letter lacks MIME-Version and Content-Type, hmm..

Bug in git-format-patch? IIRC --cover-letter was added quite late, and
is quite a new option; some bugs might have been not ironed out yet.

--=20
Jakub Narebski
Poland
