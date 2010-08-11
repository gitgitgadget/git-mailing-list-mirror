From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCH v4] Allow HTTP user agent string to be modified.
Date: Wed, 11 Aug 2010 13:35:58 -0700
Message-ID: <AANLkTikzCVAb8YOZQhZ-sd6uhngiAQnhkB-k_JFZMem=@mail.gmail.com>
References: <7v62zgyks6.fsf@alter.siamese.dyndns.org> <1281558725-29938-1-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Wed Aug 11 22:36:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjI2D-0001bu-PU
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 22:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757153Ab0HKUgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 16:36:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58519 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158Ab0HKUgU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 16:36:20 -0400
Received: by wyb32 with SMTP id 32so554789wyb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YUd1K14boEY6hvhx4/d7pPmUGxCLI/y8Kh11bYHWdyE=;
        b=ja7HvOrBKY2+uFhdgs7WdoqwYE7JBC164Dwsceqr0SBI5tHiZ/orPyE1pjxMdXMtEg
         Fkei1bWhHYsSEPzq7mzlTC0GInerXP1jnftQNzv7/9LRZJGCfbAHarr76+vbzCobvC2e
         F9rzdYX6f6UY/TudLqrI+ECPTGc9RdIps7CWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=w7fqMrYAPLLYPYt7VSsct91HUMK1tGpruziXu3I/EaMXDye/A6Ie7pXlXuGDXW/AVr
         g7hHF5q3apsj8oyNt6QYAeYm0WqfIgWRVEvmtCvZrpguuYmaGbmaybw71WkkKNyvsBXU
         Q9cfq3sIlm4hb4faWddxeMb1EmsIAVJaYLSIA=
Received: by 10.227.138.2 with SMTP id y2mr16419573wbt.18.1281558978188; Wed, 
	11 Aug 2010 13:36:18 -0700 (PDT)
Received: by 10.216.151.25 with HTTP; Wed, 11 Aug 2010 13:35:58 -0700 (PDT)
In-Reply-To: <1281558725-29938-1-git-send-email-olsonse@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153302>

On Wed, Aug 11, 2010 at 13:32, Spencer E. Olson <olsonse@umich.edu> wro=
te:
> Some firewalls restrict HTTP connections based on the clients user ag=
ent. =C2=A0This
> commit provides the user the ability to modify the user agent string =
via either
> a new config option (http.useragent) or by an environment variable
> (GIT_USER_AGENT). =C2=A0Relevant documentation is added to Documentat=
ion/config.txt.
>

Missed switching GIT_USER_AGENT to GIT_HTTP_USER_AGENT here, in the
commit message, but that seems like something easily enough fixed when
applying.

> Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
> ---
>
> All,
>
> This includes the changes suggested by Ray Chuan and by Junio Hamano,=
 with one
> minor additional change: =C2=A0This changes the internal -DGIT_USER_A=
GENT to
> -DGIT_HTTP_USER_AGENT.
>
> Since GIT_HTTP_* seems to follow what several of the other HTTP relat=
ed
> environement variables, I agree that using GIT_HTTP_USER_AGENT is bet=
ter for the
> user interface (via env variables) than GIT_USER_AGENT. =C2=A0I would=
 like to
> additionally change the internal token also to GIT_HTTP_USER_AGENT ju=
st because
> it is clearer for other developers.
>
>
> =C2=A0Documentation/config.txt | =C2=A0 =C2=A09 +++++++++
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A02 +-
> =C2=A0http.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A09 ++++++++-
> =C2=A03 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f81fb91..7253b71 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1243,6 +1243,15 @@ http.noEPSV::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0support EPSV mode. Can be overridden by th=
e 'GIT_CURL_FTP_NO_EPSV'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0environment variable. Default is false (cu=
rl will use EPSV).
>
> +http.useragent::
> + =C2=A0 =C2=A0 =C2=A0 The HTTP USER_AGENT string presented to an HTT=
P server. =C2=A0The default
> + =C2=A0 =C2=A0 =C2=A0 value represents the version of the client git=
 such as git/1.7.1.
> + =C2=A0 =C2=A0 =C2=A0 This option allows you to override this value =
to a more common value
> + =C2=A0 =C2=A0 =C2=A0 such as Mozilla/4.0. =C2=A0This may be necessa=
ry, for instance, if
> + =C2=A0 =C2=A0 =C2=A0 connecting through a firewall that restricts H=
TTP connections to a set
> + =C2=A0 =C2=A0 =C2=A0 of common USER_AGENT strings (but not includin=
g those like git/1.7.1).
> + =C2=A0 =C2=A0 =C2=A0 Can be overridden by the 'GIT_HTTP_USER_AGENT'=
 environment variable.
> +
> =C2=A0i18n.commitEncoding::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Character encoding the commit messages are=
 stored in; git itself
> =C2=A0 =C2=A0 =C2=A0 =C2=A0does not care per se, but this information=
 is necessary e.g. when
> diff --git a/Makefile b/Makefile
> index e151516..f84f4a1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1873,7 +1873,7 @@ builtin/init-db.s builtin/init-db.o: EXTRA_CPPF=
LAGS =3D \
>
> =C2=A0config.s config.o: EXTRA_CPPFLAGS =3D -DETC_GITCONFIG=3D'"$(ETC=
_GITCONFIG_SQ)"'
>
> -http.s http.o: EXTRA_CPPFLAGS =3D -DGIT_USER_AGENT=3D'"git/$(GIT_VER=
SION)"'
> +http.s http.o: EXTRA_CPPFLAGS =3D -DGIT_HTTP_USER_AGENT=3D'"git/$(GI=
T_VERSION)"'
>
> =C2=A0ifdef NO_EXPAT
> =C2=A0http-walker.s http-walker.o: EXTRA_CPPFLAGS =3D -DNO_EXPAT
> diff --git a/http.c b/http.c
> index 1320c50..0a5011f 100644
> --- a/http.c
> +++ b/http.c
> @@ -41,6 +41,7 @@ static long curl_low_speed_time =3D -1;
> =C2=A0static int curl_ftp_no_epsv;
> =C2=A0static const char *curl_http_proxy;
> =C2=A0static char *user_name, *user_pass;
> +static const char *user_agent;
>
> =C2=A0#if LIBCURL_VERSION_NUM >=3D 0x071700
> =C2=A0/* Use CURLOPT_KEYPASSWD as is */
> @@ -196,6 +197,9 @@ static int http_options(const char *var, const ch=
ar *value, void *cb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (!strcmp("http.useragent", var))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return git_config_=
string(&user_agent, var, value);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fall back on the default ones */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return git_default_config(var, value, cb);
> =C2=A0}
> @@ -279,7 +283,8 @@ static CURL *get_curl_handle(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (getenv("GIT_CURL_VERBOSE"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_easy_seto=
pt(result, CURLOPT_VERBOSE, 1);
>
> - =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(result, CURLOPT_USERAGENT, GI=
T_USER_AGENT);
> + =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(result, CURLOPT_USERAGENT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user_agent ? user_=
agent : GIT_HTTP_USER_AGENT);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (curl_ftp_no_epsv)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_easy_seto=
pt(result, CURLOPT_FTP_USE_EPSV, 0);
> @@ -380,6 +385,8 @@ void http_init(struct remote *remote)
> =C2=A0#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO"=
);
>
> + =C2=A0 =C2=A0 =C2=A0 set_from_env(&user_agent, "GIT_HTTP_USER_AGENT=
");
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0low_speed_limit =3D getenv("GIT_HTTP_LOW_S=
PEED_LIMIT");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (low_speed_limit !=3D NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_low_speed=
_limit =3D strtol(low_speed_limit, NULL, 10);
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
