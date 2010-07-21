From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: clarify search results page when no matching commit found
Date: Wed, 21 Jul 2010 19:51:16 +0200
Message-ID: <201007211951.18439.jnareb@gmail.com>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil> <AANLkTinhyFD4RhLLxS-jj-oX5VWqGyy7AiXJ3VJlcU2W@mail.gmail.com> <20100721152311.GA12726@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Erick Mattos <erick.mattos@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 19:51:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObdSA-0007zm-V0
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 19:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883Ab0GURv1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 13:51:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62800 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab0GURv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 13:51:26 -0400
Received: by eya25 with SMTP id 25so1757212eya.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RsaGfiy/YDh8ZAw8w8oCXgUIHRbdmtgdwkRmI41oHlw=;
        b=nkuT4/yi6uOYUWxf2pSqjourLg/e8unUK71bUKGWasjH251lHwFeLjfy/VSGSV2PL7
         p1BXlkq+daEuNWaalwc3tKydy6A6BkUZ01+adQn1/sPLxD7QY9BNFDLPa33JqqfIRXcJ
         0IA6UESCgkWxzZDjFFl1RDsl3vS6WWLjE/Ly0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PtqOH+79EFjspTDuG9osxTpaT8kyD+WOEh1Bw+6D6NOI3zkBmweVxnQXgcG5KLGJYR
         p0xGbfg+0vvXJDs7GdHrWBvcbTVw5NA8ccUr5YCl4C8XC7tVyV1X0in+fsrpo1qXEjMm
         bpjMhuf38F/P2R6KypE6B9tBD8oMg+lu+ewQM=
Received: by 10.213.16.140 with SMTP id o12mr627798eba.20.1279734685535;
        Wed, 21 Jul 2010 10:51:25 -0700 (PDT)
Received: from [192.168.1.13] (aeho173.neoplus.adsl.tpnet.pl [79.186.196.173])
        by mx.google.com with ESMTPS id a48sm53783618eei.0.2010.07.21.10.51.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 10:51:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100721152311.GA12726@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151409>

On Wed, 21 Jul 2010, Jonathan Nieder wrote:
> Erick Mattos wrote:
>=20
> > I did a search in gitweb
> > (http://git.kernel.org/?p=3Dgit/git.git;a=3Dsummary) by commit
> > e2007832552ccea9befed9003580c494f09e666e.
> >=20
> > Looks as gitweb's search is broken and giving false results.
>=20
> Maybe something like the following would help.
>=20
> -- 8< --
> When searching commits for a string that never occurs, the results
> page looks something like this:
>=20
> 	projects / foo.git / search                                     \o/
> 	summary | ... | tree            [commit] search: [ kfjdkas ] [ ]re
> 	first =E2=8B=85 prev =E2=8B=85 next
>=20
> 	Merge branch 'maint'
>=20
> 	Foo: a demonstration project
>=20
> Without a list of hits to compare it to, the header describing the
> commit named by the hash parameter (usually HEAD) may itself look
> like a hit.  Add some text (=E2=80=9CNo match.=E2=80=9D) to replace t=
he empty
> list of hits to avoid this confusion.
>=20
> Noticed-by: Erick Mattos <erick.mattos@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Very good idea

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index cedc357..a47eed2 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6522,12 +6522,13 @@ sub git_search {
>  			$paging_nav .=3D " &sdot; next";
>  		}
> =20
> -		if ($#commitlist >=3D 100) {
> -		}
> -

P.S. I wonder WTF was that...

--=20
Jakub Narebski
Poland
