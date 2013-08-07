From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Wed, 07 Aug 2013 18:51:35 +0200
Message-ID: <52027B17.7040602@googlemail.com>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0F937C2591A6685531DCB1DA"
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 18:51:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V76xe-0007Ph-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 18:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630Ab3HGQvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 12:51:40 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:50274 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932395Ab3HGQvi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 12:51:38 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so4068549wib.16
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=xzUvt8fVS2M/cGP5RxZZdXYD7VIfOHPy0pViuGb5zsQ=;
        b=W/dYxaaYYRH1mQX4YDTseH4PAHzj3r8D26Be9kOelheem0WxWWfub2p19waZqJ4n3w
         ALrQten+k0XnyU511Ch5/tCsTKEU3jV1wdCtXy6Hn2EZH7MrczOJo0uEipYpxDcdOxH/
         FCg9sI0SmoUQVMe59sPU44qHHe5cLJl/El2BroIcnpzipgvHZKrRHSOKbkRVlbsN3ptZ
         u3lrubAVlwiyxIWEBP2nVdhotL9WfRfVZEQ6S9P9QTfn/I67TMYPR/Y5RbH6mMstj2G+
         Lu157QtQIxj3PNURZ4wpCCg26Lj3dgCrimg1A2/6rKdWDZi+qTg9L0vc7qm2jShrtXhA
         Wr6Q==
X-Received: by 10.194.78.110 with SMTP id a14mr898480wjx.84.1375894297042;
        Wed, 07 Aug 2013 09:51:37 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id v9sm13454210wiw.8.2013.08.07.09.51.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 09:51:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231837>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0F937C2591A6685531DCB1DA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2013 06:00 PM, Ramkumar Ramachandra wrote:
> Hi,
>=20
> This is the difference between whatchanged and log:
>=20
> diff --git a/whatchanged b/log
> index fa1b223..004d9aa 100644
> --- a/tmp/whatchanged
> +++ b/tmp/log
> @@ -1,4 +1,4 @@
> -int cmd_whatchanged(int argc, const char **argv, const char *prefix)
> +int cmd_log(int argc, const char **argv, const char *prefix)
>  {
>         struct rev_info rev;
>         struct setup_revision_opt opt;
> @@ -7,13 +7,10 @@ int cmd_whatchanged(int argc, const char **argv,
> const char *prefix)
>         git_config(git_log_config, NULL);
>=20
>         init_revisions(&rev, prefix);
> -       rev.diff =3D 1;
> -       rev.simplify_history =3D 0;
> +       rev.always_show_header =3D 1;
>         memset(&opt, 0, sizeof(opt));
>         opt.def =3D "HEAD";
>         opt.revarg_opt =3D REVARG_COMMITTISH;
>         cmd_log_init(argc, argv, prefix, &rev, &opt);
> -       if (!rev.diffopt.output_format)
> -               rev.diffopt.output_format =3D DIFF_FORMAT_RAW;
>         return cmd_log_walk(&rev);
>  }
>=20
> Should we remove it?

I'd deprecate it first for a year or such and remove it then.
In the meantime we could implement already remove the code
and change it to:

+ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
+ {
+ 	return cmd_log(argc, argv, prefix)
+ }

Also we should make sure everything git whatchanged can do,
can easily be done with git log <options>.

Stefan


--------------enig0F937C2591A6685531DCB1DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSAnsXAAoJEJQCPTzLflhqbgwP/A1PI9bicjPgres4Xw/wC6Z/
J/IU2Lzh7J03bXyl8YF9abF70fm+jUnthTvT2d0pyfEYFV78Bc62kHBm8O7tHG0L
m3A2Wlfb6Pw7FTrVLUMr/0nZ27cs+y7cR3qIlPoDArYDlJFA4Mr1ob2OR9fkZizH
rqaxBZfYNPPMPo0y8F3O4oaL3hn3T1AfjFg+1GFx43cp4tOciJPEWvZku9BZNOwZ
HT4zePfp03ySVfsgr5N82kxuTl6aC3ipbJaTjZGvrQkmqHwk6WlxJ/Dilv5oikVh
QiLplXh19x7Elb0CRMxGsUczieKvnPers4kjNJ9IMFMDjsR9+iuOsVZ0zCfkzXFY
Z09RAq9zbTG6XKOM2MQ5a0oW3qOGCVIZJ41iXaOHXwbD7WBzYfMrIGWDsYnbHtaA
tbmjvxrraKTemCpMfCrlTOOufL69Gkfw75JBNjlpdPb8JNbMp/gJvDMef3D8l4DP
d9rUlS5LMUrMQRZehwsUYxViySbCmmrmA7D/mSsRL/aOk53JR1CMQj8kHrd4VABg
PR3xUwFjl2BMjh2BFuQ/OPRGg0ur3XaQABQo10Df76C0yk2NAE3TJliSy1WCpu8/
Q3qRXrE4o83LVDko7DHLOYTOOHCmfVOD6TjURcOw8L7+scR4PIQlc/HF2XmYnTxg
gDN8GXCYX6RF8bJxGhub
=LmpY
-----END PGP SIGNATURE-----

--------------enig0F937C2591A6685531DCB1DA--
