From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Wed, 8 Dec 2010 20:47:42 +0100
Message-ID: <201012082047.44022.jnareb@gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 20:48:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQPze-0005H8-Gf
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 20:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab0LHTr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 14:47:57 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:58717 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab0LHTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 14:47:56 -0500
Received: by ewy10 with SMTP id 10so1190427ewy.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 11:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dB7VHMiROgQ3G0NhvqvhvbQ8XrAaY+DQZlJWvSVFmRk=;
        b=FXYkhiESyCet0QWjLToiieP/BncurmltRHE1PiNs6Z+jWDGhsuGICF9kC9E8ZO2h0d
         ks1+V//7tAwlmvhaBKzwVroExp3fHPfonxezYM2cfWMZGBNaBGnkkqCBXUfZkbKrHLf4
         ezYJMkpHlLJIYRhj7RD3k38eaHdXucwpMa0xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bKKqhAMrcq1BDeyKkmnL4MBtmi9awMmMOPsSAvUaMNsXeOJFIcNdh5m87LZQUw58lQ
         srEhtJw6hW/2W9qM28CGor1ucQL/aAnOVrNyn/BOWFL36MdOhmURWPoXxUcYPUkvT56A
         HfttSM9yFrk1rV6S+aDe9RprXrXtVqRm/9E2Y=
Received: by 10.213.29.144 with SMTP id q16mr10328783ebc.91.1291837675259;
        Wed, 08 Dec 2010 11:47:55 -0800 (PST)
Received: from [192.168.1.13] (abvw115.neoplus.adsl.tpnet.pl [83.8.220.115])
        by mx.google.com with ESMTPS id b52sm678527eei.7.2010.12.08.11.47.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 11:47:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163215>

On Wed, 8 Dec 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Let's start off from where the previous discussion [1] stopped. Peopl=
e
> seem to agree ref^{/regex} is a good choice. But we have not come to
> conclusion how to specify the count yet. Possible suggestions are
>=20
>  - ref^{/foo}2
>  - ref^{2/foo}
>  - ref^{:2/foo}
>  - ref^{2nd/foo}
>=20
> For whatever syntax chosen, :/ should benefit too. I notice that :/!
> is reserved for future use. Perhaps :/!2/regex is not too cryptic?

I wonder if it would be possible to make :/<regex> (which looks a bit
like searching the index) to be an alias to --all^{/<regex>}...

Or if we can make ^{/<regex>} to act on revision range specified by
earlier commits, so for example foo..bar^{/<regex>} would work.

> I'd also like to do case-insensitive regex, by the way. :/!2i/regex
> looks a bit ugly.

The '2nd' idea came from Perl 6 regexp / grammars, see for example
https://github.com/perlpilot/perl6-docs/blob/master/intro/p6-regex-intr=
o.pod

 There are two other modifiers for matching a pattern some number of ti=
mes
 or only matching, say, the third time we see a pattern in a string. Th=
ese
 modifiers are a little strange in that their short-hand forms consist =
of
 a number followed by some text:

    modifier        short-hand              meaning
    :x()            :1x,:4x,:12x            match some number of times
    :nth()          :1st,:2nd,:3rd,:4th     match only the Nth occuranc=
e

 Here are some examples to illustrate these modifiers:

    $_ =3D "foo bar baz blat";
    m :3x/ a /              # matches the "a" characters in each word
    m :nth(3)/ \w+ /        # matches "baz"

So it could be e.g. 'foo^{:2nd/<regexp>}' (note that there is no traili=
ng
/ closing regexp, i.e. it is not 'foo^{:2nd/<regexp>/}').

So if we chose this, why don't we follow Perl 6 rule of combining modif=
iers
http://perlcabal.org/syn/S05.html#Modifiers, so it would be

   foo^{:2nd:i/<regexp>}

or

   foo^{:i:nth(2)/<regexp>}


As to :/!<regexp> form: isn't it reserved for non-match?  If not, then
perhaps

  :/!2nd:i/<regexp>

> [1] http://mid.gmane.org/9D675671-693D-4B59-AF2A-0EFE4C537362@sb.org
>=20
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
>   get_sha1_oneline: allow to input commit_list
>   get_sha1: support ref^{/regex} syntax
>=20
>  Documentation/revisions.txt |    7 ++++++
>  sha1_name.c                 |   45 ++++++++++++++++++++++++++++++++-=
---------
>  2 files changed, 41 insertions(+), 11 deletions(-)

Thank you for working on this.
--=20
Jakub Narebski
Poland
