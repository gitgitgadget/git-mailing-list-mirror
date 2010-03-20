From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/16] xdl_merge(): add optional ancestor label to
 diff3-style output
Date: Sat, 20 Mar 2010 17:47:36 -0500
Message-ID: <20100320224736.GC31098@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
 <20100317114653.GA25641@progeny.tock>
 <36ca99e91003170722m6642ca5q93b2669feaf3dea2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 23:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt7RO-0008MF-CA
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 23:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab0CTWql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 18:46:41 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:41699 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab0CTWqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 18:46:40 -0400
Received: by yxe12 with SMTP id 12so1171485yxe.33
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5+EQhCCbhZQAnQXxUInRB0OZ20zSBQMXTev7VLE6ZJ0=;
        b=DV7qh2dg4XqShx5EMy2rJUpKo3udLwl4nOjIw3gT+LQF/nw4dr8W2GKDCZJ/9kfq32
         Zdqjyxw9+ZBDwoxr0LUYOHj9N23KNtQEJ7aFjfSTv3u1Icq+Sk1LCIfTq9jyFHmWaqZt
         NgDxgbdPBj+a7BAIhh9YZaeoUYdVm+TK4mp9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LaWnIi2A9xVPZyheCNfvnc2JbB1eo4gsft/0JAIt2PilnEHRybBxW7v/OulrXEp2hE
         +7c6ms6B1XS5/VCGot4S80pVysrhKrd1+NuOJ/LW88bf1Rt6vUkYeU8BULdeobEGu0b5
         ilhQMMqYi3TCeAqq0Ca4T5043KvxyshpmMQac=
Received: by 10.100.23.19 with SMTP id 19mr3655150anw.15.1269125200143;
        Sat, 20 Mar 2010 15:46:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1773598iwn.11.2010.03.20.15.46.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 15:46:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <36ca99e91003170722m6642ca5q93b2669feaf3dea2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142764>

Bert Wesarg wrote:
> On Wed, Mar 17, 2010 at 12:46, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> --- a/xdiff/xmerge.c
>> +++ b/xdiff/xmerge.c
>> @@ -397,6 +406,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_=
t *xscr1, const char *name1,
>>=C2=A0 	int flags, xmparam_t const *xmp, mmbuffer_t *result) {
>>  	xdmerge_t *changes, *c;
>>  	xpparam_t const *xpp =3D &xmp->xpp;
>> +	const char * const ancestor_name =3D xmp->ancestor;
>
> Style. * should be aligned to the variable name.

Not so clear to me:

 $ git grep -e '\* const' origin/master | wc -l
 90
 $ git grep -e '\*const' origin/master | wc -l
 23

I do prefer the style you suggest, so I=E2=80=99ve fixed it.

> FWIW:
>=20
>     Acked-by: Bert Wesarg <Bert.Wesarg@googlemail.com>

Thanks for looking it over.  I=E2=80=99ll be sending a rebased version =
in a
moment including your ack; I hope that=E2=80=99s okay.

Jonathan
