From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: gravatar support
Date: Sat, 20 Jun 2009 00:31:53 +0200
Message-ID: <200906200031.55576.jnareb@gmail.com>
References: <1245405495-7712-1-git-send-email-giuseppe.bilotta@gmail.com> <200906191325.00248.jnareb@gmail.com> <cb7bb73a0906190757o4d083735t1a3f37396af76c2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 00:33:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHmeE-0005rl-OU
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 00:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759311AbZFSWcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759324AbZFSWcK
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 18:32:10 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:60852 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759256AbZFSWcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 18:32:04 -0400
Received: by bwz9 with SMTP id 9so2037388bwz.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tm0rC4D3/Wbsox0DVMYJ9rNNS1BslQ57iwv7Nlb+0m0=;
        b=RnwgDrtFsBiiBGgiCoZpi6uyM4r48B9jn6VvpXwiYAOdSR0aOtWxSHdyhbUZ9cKkWI
         LqYuxB/otV+nCOPD2FQu05jU8gshxYuA01cDue9IS4P5sqq7aRLCHOPnD8cmv0SoEsKy
         RvhJk0yt4n19KRiyFnpL9QJpJxYLUXrz8FqEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=g7vpR+Uw842/nir8yTwlwsYDGmOABRTHhJHaAMcZ+kDtTRVtBDCIncGGar+ZtIpC4n
         5RQ3o7tI/HXktwnPbBiJraRo9CNcER1h8C9skvlx409nGsM/P3m6LhuaTA447JIwBt02
         AWiUrgDr1isgxI8g3QgQzoV3yIk3RvRMpD0Qc=
Received: by 10.103.240.15 with SMTP id s15mr2153992mur.102.1245450723894;
        Fri, 19 Jun 2009 15:32:03 -0700 (PDT)
Received: from ?192.168.1.13? (abvl170.neoplus.adsl.tpnet.pl [83.8.209.170])
        by mx.google.com with ESMTPS id g1sm10713522muf.56.2009.06.19.15.32.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 15:32:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0906190757o4d083735t1a3f37396af76c2f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121918>

On Fri, 19 June 2009, Giuseppe Bilotta wrote:

> thanks for the comments, I'll send a new patch taking them into
> consideration soon.

Errr... I had a few additional comments to this reply, but I was a bit
late I think with replying.

>=20
> A few additional replies:
>=20
>>> + =A0 =A0 # Gravatar support. When this feature is enabled, views s=
uch as
>>> + =A0 =A0 # shortlog or commit will display the gravatar associated=
 with
>>> + =A0 =A0 # the email of the committer(s) and/or author(s). Please =
note that
>>> + =A0 =A0 # the feature depends on Digest::MD5.
>>> +
>>> + =A0 =A0 # To enable system wide have in $GITWEB_CONFIG
>>> + =A0 =A0 # $feature{'gravatar'}{'default'} =3D [1];
>>> + =A0 =A0 # Project specific override is not supported.
>>> + =A0 =A0 'gravatar' =3D> {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 'override' =3D> 0,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 'default' =3D> [0]},
>>
>> Yet another global feature without project specific override. =A0Hmm=
m...
>> I wonder if project specific and global (non-overridable) features
>> should be separated. =A0But it is question for a separate commit.
>>
>> Question: why it is not overridable (why project specific override
>> is not supported for this feature)? =A0Some projects may use Gravata=
rs,
>> some might not, although I guess that usually it is deployment speci=
fic
>> feature.
>=20
> I see it as a deployment feature, and considering that it adds an
> (admittedly small) extra load on the server, I thought it was sensibl=
e
> to make it non-overridable. OTOH, since the load is small, it might b=
e
> possible to make it per-project without big issues.

Well, I was not asking you to change it; I was asking about=20
justification behind making it non-overridable.

>=20
>> You would probably want to protect against $size being undefined:
>>
>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 $size =3D 32 if (!defined($size) || $si=
ze <=3D 0);
>>
>> Because currently when you are not passing size parameter to use
>> default size you would get the following warning:
>>
>> =A0Use of uninitialized value in numeric le (<=3D) ...
>=20
> Oh right.

Well, as you use 'undef' (do not pass parameter) for default value
and you _do not_ use negative (or zero) value, then

+             $size =3D 32 if !defined($size);

would be enough (in Perl 6 / Perl 5.10 it would be "$size //=3D 32" ;-)

The question is: does gravatar.com accepts any size?  What does it do
if it gets negative size passed?  I have not used gravatar as=20
developer...

>=20
>> Did you run the t9500, adding test enabling gravatars?
>=20
> Ehrm, no 8-P

Well, it is always nice to have test for new feature.  Unfortunately
due to the smart way it is done currently unmodified (not extended)
t9500 wouldn't catch above issue.

[...]

>> Also gravatars are
>> not shown in 'history' view, but I guess that could wait for proper
>> refactoring of all log-like views/actions to use common infrastructu=
re.
>=20
> That's part of the reason, the other being that I couldn't find a
> satisfactory way to do it 8-P

What is the problem?

>=20
>> Those all look nice with the *default* font sizes. =A0But as the siz=
e of
>> gravatar is used when constructing gravatar URL, to pass to gravatar=
=2Ecom
>> I don't see how this problem can be resolved... =A0Beside making it
>> configurable, I guess...
>=20
> That's something I hadn't thought about, honestly. The problem of
> course is that the font sizes get customized via CSS, but the gravata=
r
> size would get customized at the cgi level ... so unless we parse the
> CSS from the cgi it cannot be done automatically.

What I though here was to use %gravatar_size hash, with keys such as
'default' and 'double' (for "double line height").  If you change or
add CSS, changing configuration, you can change also this in config.

More comments to follow in v2 and replies.
--=20
Jakub Narebski
Poland
