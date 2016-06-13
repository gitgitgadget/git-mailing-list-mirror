From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] lib-httpd.sh: print error.log on error
Date: Mon, 13 Jun 2016 18:40:14 +0700
Message-ID: <20160613114014.GA15562@ash>
References: <20160612104154.31446-1-pclouds@gmail.com>
 <20160612125921.GA15289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 13 13:40:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCQEP-0003pu-IH
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 13:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422982AbcFMLke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 07:40:34 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33755 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423005AbcFMLkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 07:40:20 -0400
Received: by mail-pa0-f68.google.com with SMTP id ts6so3329119pac.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lY/hxLKzMSwLAvJxUssFf2fysxSGx4Ue5U6VVUaHWuE=;
        b=niPtMS2Az8QCT/i7Jrl8T6tCx0J+yiryIRcaYv1GTFEYwP9l8BqaMZAwZRPlHIu3F5
         akFTzaKoIX8iMnqzjJzND1VTqYAzrBvpU9LQM4lxEhykev1Hi1CejU7l28l9+QxY4rFG
         Xd1Rn2ZPDFSg4A//m/fv8Yftx4l7KUqO/gv89YBlXU/UPqhGe422woS/v9Jj5MFdGYoG
         EIUS+li6dQpCxTIhRUxj51Xh4gmY0H1TyFWv6O/ypODwMg7qKuKy+K/S8ZsdcQ79sL7d
         es57DiBMy9zAgVUge0LKRzSK2MwQU6aDpfQtW/yZOzpavN3Pk20JF+ccHJRFgNfsagvB
         OV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lY/hxLKzMSwLAvJxUssFf2fysxSGx4Ue5U6VVUaHWuE=;
        b=S4xFADKZR68b3jAimCo29s+pW2m3BaiiY2c/kWQhF7XsZtvzyb5qP8hP90qD1l0WRd
         vWow/jO+KeZLWtmZ6wuHJvTErYXtwXV47KyiHk5p5huv1IJ3i1jJZeSIzRFi4wuNisD2
         s7w2amQTZT4M2qgzZ6I2tL2BRBK6iRWHrO3d/3GcKHEuuARv8BxxMZO1prfhZ3r0Z52a
         B0oFHm7uo21+sfX96DPsYjCKK8zYh68L9W/AjEOH3FaelyWW7rlBKBYBBb9umEZRX/7q
         iyPTOBpJcaax0gMYiU8zWU2IUPuQW97h3GjR5lQOilgFLuWOkfjaHPTSeFN/q4mrcYS9
         Na1A==
X-Gm-Message-State: ALyK8tLd3eMIEjdZCHeWXga4IEvyCdFPknWM3nR5bq/xsAtrE7wcFH+OXlA4qijdJ7Md0A==
X-Received: by 10.66.159.163 with SMTP id xd3mr21652148pab.23.1465818019813;
        Mon, 13 Jun 2016 04:40:19 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id bt5sm4750748pac.47.2016.06.13.04.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 04:40:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Jun 2016 18:40:14 +0700
Content-Disposition: inline
In-Reply-To: <20160612125921.GA15289@sigill.intra.peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297179>

On Sun, Jun 12, 2016 at 08:59:21AM -0400, Jeff King wrote:
> On Sun, Jun 12, 2016 at 05:41:54PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>=20
> > Failure to bring up httpd for testing is not considered an error, s=
o the
> > trash directory, which contains this error.log file, is removed and=
 we
> > don't know what made httpd fail to start. Improve the situation a b=
it.
> >=20
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
> > ---
> >  t/lib-httpd.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> > index f9f3e5f..5b8de38 100644
> > --- a/t/lib-httpd.sh
> > +++ b/t/lib-httpd.sh
> > @@ -180,6 +180,7 @@ start_httpd() {
> >  	if test $? -ne 0
> >  	then
> >  		trap 'die' EXIT
> > +		cat "$HTTPD_ROOT_PATH"/error.log 2>/dev/null
> >  		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
> >  	fi
>=20
> I like the idea of giving more data on error, but I think this will
> break the TAP output and confuse anything parsing the output of the
> tests, like prove (I think arbitrary output should have "#" prepended=
).
>=20
> Also (or alternatively), it should probably only happen when we are i=
n
> verbose mode (it's not taken care of for us as usual because tests ca=
ll
> start_httpd outside of a test_expect_ block). I think this eliminates
> the need to deal with the TAP thing (because our usual "-v" output is
> not TAP-compliant).

I like the verbose route, so here's v2

-- 8< --
Subject: [PATCH v2] lib-httpd.sh: print error.log on error

=46ailure to bring up httpd for testing is not considered an error, so
the trash directory, which contains this error.log file, is removed
and we don't know why httpd failed. Improve the situation a bit, print
error.log but only in verbose mode.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/lib-httpd.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index f9f3e5f..67bc7ad 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -180,6 +180,8 @@ start_httpd() {
 	if test $? -ne 0
 	then
 		trap 'die' EXIT
+		test "$verbose" =3D t && \
+			cat "$HTTPD_ROOT_PATH"/error.log 2>/dev/null
 		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
 	fi
 }
--=20
2.8.2.524.g6ff3d78
-- 8< --
