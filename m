From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 1/5] gitweb: Add a comment explaining the meaning of $/
Date: Wed, 04 Dec 2013 16:46:17 +0100
Message-ID: <1386171977.2173.23.camel@localhost.localdomain>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	 <1386164583-14109-2-git-send-email-krzesimir@endocode.com>
	 <CANQwDwdiNHFCChVdkKxkEa+HOKzzhgfzy4d6iZB6ejSfva3Z3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 16:46:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoEej-000484-CT
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 16:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709Ab3LDPqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 10:46:24 -0500
Received: from mail-ee0-f49.google.com ([74.125.83.49]:52347 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932532Ab3LDPqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 10:46:21 -0500
Received: by mail-ee0-f49.google.com with SMTP id c41so2309738eek.22
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 07:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=BTi8TdVbuWOgsgu/EYe+uaxjKT59lTlJP8HQm4lxwlk=;
        b=iMkA/y2fVM9aUEX6m6QxSb37qVd0c/JDtkKAffH0TVMbM+HEPDlLZmCqXrdinAfdhb
         vE4kZrmOLF/WO/qUg/sXl8Ysmzf85rc8nnAkpCDeyUOnRt9Uu/dpveaGVlqswDpSfqf6
         Y34oOj0Iot0KV3gshvlZyoCl+dMJsV9SniGyHkQy6mf6Za9NeeM+EZOfc5RU45Pj+b0h
         XZXwUrE1tYCpOAoHJZUCJJjeDPFROQWk0mfdvFKwnF0SmrXuCCwWvVAuMmU2hqzfjw6U
         WbpN4FhFdlTArk7+7ePHl+Gm0cPyeL6C9I+vPJKHtT51HjKSbtNtmRUv0xfZvTRCXFNF
         hcaw==
X-Gm-Message-State: ALoCoQnLsCKv9FgOWMSDMGS4WYSJcQyD98aSU5Ww7KnS68wES8RzAG9E47npo6Qpj8zQ2k0YQUJD
X-Received: by 10.14.104.201 with SMTP id i49mr8192752eeg.78.1386171980155;
        Wed, 04 Dec 2013 07:46:20 -0800 (PST)
Received: from [192.168.1.100] (95-91-240-208-dynip.superkabel.de. [95.91.240.208])
        by mx.google.com with ESMTPSA id m1sm89836008eeg.0.2013.12.04.07.46.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Dec 2013 07:46:19 -0800 (PST)
In-Reply-To: <CANQwDwdiNHFCChVdkKxkEa+HOKzzhgfzy4d6iZB6ejSfva3Z3A@mail.gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238785>

On Wed, 2013-12-04 at 16:11 +0100, Jakub Nar=C4=99bski wrote:
> On Wed, Dec 4, 2013 at 2:42 PM, Krzesimir Nowak <krzesimir@endocode.c=
om> wrote:
>=20
> > So future reader will know what does it mean without running "perld=
oc
> > perlvar".
>=20
> Hmmm... shouldn't future reader know it anyway?  It is not that crypt=
ic.
> I'd say it is idiomatic Perl.
>=20

It's plainly obscure. And I think it is not that often used - I keep
forgetting what that pair of punctuation is actually meaning. In this
case I guess it would be more readable to use the following code
instead:
$fh->input_record_separator ("\0");

> Besides, it is not the only place where we set input record separator=
 to NUL,
> to match corresponding option to git command to separate records with=
 NUL
> (the '-z' option in this case).  Others are git_get_path_by_hash(),
> parse_commit(),
> and parse_commits(), git_tree(), not including places where we set $/=
 to undef
> to slurp whole file: git_get_link_target(), git_blobdiff() for $forma=
t
> =3D=3D 'plain', etc.

Yes, but I stumbled upon that one when trying to understand how config
parsing works. So I added a comment.

>=20
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> > ---
> >  gitweb/gitweb.perl | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 68c77f6..ee61f9e 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -2629,6 +2629,8 @@ sub git_parse_project_config {
> >         my $section_regexp =3D shift;
> >         my %config;
> >
> > +       # input record separator, so getline does end on null, not
> > +       # newline
> >         local $/ =3D "\0";
>=20
> It is here because of '-z' option below (to account for values with
> embedded newlines).
>=20
> >
> >         open my $fh, "-|", git_cmd(), "config", '-z', '-l',
> > --
> > 1.8.3.1
> >
>=20
>=20
>=20

--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
