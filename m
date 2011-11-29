From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Don't append ';js=(0|1)' to external links
Date: Tue, 29 Nov 2011 11:28:36 -0800 (PST)
Message-ID: <m3pqgaloda.fsf@localhost.localdomain>
References: <CAKD0UuzU4hAe7RGYukGyPpvfGeYJ3pgJ5pynupneMpQSaX5Cjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?iso-8859-15?q?J=FCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Nov 29 20:28:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVTMG-0001HF-F2
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 20:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab1K2T2n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 14:28:43 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40456 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab1K2T2m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 14:28:42 -0500
Received: by bkas6 with SMTP id s6so918319bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 11:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=3/d/BjXH1j00vR7oxxIBMFs2PWRGKlFuhwkDsDOH0Xo=;
        b=LHas+f0LEu+inji/OpEDvAoFDvZS7Q+bBNSN8zcL9iR6GykbM7GzzZzlvxo/UDiBdQ
         XKuXy0I/kbtd5CsLHKQiAUVDxSMz9Kve4OtdHsZQI9ell3zd9N7pzcA3cVSCjWeVPa/q
         vPOT/6BcgKDqXelVYpAe7TV/6PaQ3oK0/UGsI=
Received: by 10.204.141.2 with SMTP id k2mr49250250bku.81.1322594921002;
        Tue, 29 Nov 2011 11:28:41 -0800 (PST)
Received: from localhost.localdomain (abvz161.neoplus.adsl.tpnet.pl. [83.8.223.161])
        by mx.google.com with ESMTPS id hw14sm26146534bkc.16.2011.11.29.11.28.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 11:28:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pATJSY3u001913;
	Tue, 29 Nov 2011 20:28:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pATJSYKn001910;
	Tue, 29 Nov 2011 20:28:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAKD0UuzU4hAe7RGYukGyPpvfGeYJ3pgJ5pynupneMpQSaX5Cjw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186074>

J=FCrgen Kreileder <jk@blackdown.de> writes:

> Signed-off-by: Juergen Kreileder <jk@blackdown.de>
> ---
>  gitweb/gitweb.perl                       |    2 +-
>  gitweb/static/js/javascript-detection.js |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..dfe3407 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3974,7 +3974,7 @@ sub git_footer_html {
>  		print qq!<script type=3D"text/javascript">\n!.
>  		      qq!window.onload =3D function () {\n!;
>  		if (gitweb_check_feature('javascript-actions')) {
> -			print qq!	fixLinks();\n!;
> +			print qq!	fixLinks('$my_url');\n!;
>  		}
>  		if ($jstimezone && $tz_cookie && $datetime_class) {
>  			print qq!	var tz_cookie =3D { name: '$tz_cookie', expires: 14, pa=
th:
> '/' };\n!. # in days
> diff --git a/gitweb/static/js/javascript-detection.js
> b/gitweb/static/js/javascript-detection.js
> index fa2596f..36964ad 100644
> --- a/gitweb/static/js/javascript-detection.js
> +++ b/gitweb/static/js/javascript-detection.js
> @@ -29,11 +29,11 @@ var jsExceptionsRe =3D /[;?]js=3D[01](#.*)?$/;
>   *
>   * @globals jsExceptionsRe
>   */
> -function fixLinks() {
> +function fixLinks(baseurl) {
>  	var allLinks =3D document.getElementsByTagName("a") || document.lin=
ks;
>  	for (var i =3D 0, len =3D allLinks.length; i < len; i++) {
>  		var link =3D allLinks[i];
> -		if (!jsExceptionsRe.test(link)) {
> +		if (!jsExceptionsRe.test(link) && !link.href.indexOf(baseurl)) {
>  			link.href =3D link.href.replace(/(#|$)/,
>  				(link.href.indexOf('?') =3D=3D=3D -1 ? '?' : ';') + 'js=3D1$1');
>  		}
> --=20

Thanks for this, but I think a better solution would be to explicitly
mark the few external links we have e.g. with 'class=3D"external"', and
use that to avoid adding ';js=3D(0|1)' to them.

This has the advantage that we can use different style to mark
outgoing external links.

I even have such patch somewhere in the StGit stack...
-- >8 --
Subject: [PATCH] gitweb: Mark external links

=2E..and do not add 'js=3D1' to them with JavaScript.

Both $logo_url and $home_link links are now marked with "external"
class, and fixLink does not add 'js=3D1' to them on click.  We add
'js=3D1' to internal link to make server-side of gitweb know that it ca=
n
use JavaScript-only actions; we shouldn't do this for extrenal links,
as 'js=3D1' might mean something else to them.

Note that only links using A element matter: images (linked using
IMG), stylesheets (linked using STYLE) and JavaScript files (linked
using SCRIPT) were never affected.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl                       |    5 ++++-
 gitweb/static/js/javascript-detection.js |    5 +++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7456a4b..f1c1caa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3626,13 +3626,16 @@ EOF
 	print "<div class=3D\"page_header\">\n";
 	if (defined $logo) {
 		print $cgi->a({-href =3D> esc_url($logo_url),
+		               -class =3D> "external",
 		               -title =3D> $logo_label},
 		              $cgi->img({-src =3D> esc_url($logo),
 		                         -width =3D> 72, -height =3D> 27,
 		                         -alt =3D> "git",
 		                         -class =3D> "logo"}));
 	}
-	print $cgi->a({-href =3D> esc_url($home_link)}, $home_link_str) . " /=
 ";
+	print $cgi->a({-href =3D> esc_url($home_link)
+	               -class =3D> "external"},
+	              $home_link_str) . " / ";
 	if (defined $project) {
 		print $cgi->a({-href =3D> href(action=3D>"summary")}, esc_html($proj=
ect));
 		if (defined $action) {
diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static/j=
s/javascript-detection.js
index 2b51e55..fc59e42 100644
--- a/gitweb/static/js/javascript-detection.js
+++ b/gitweb/static/js/javascript-detection.js
@@ -60,6 +60,11 @@ function fixLink(link) {
 	 */
 	var jsExceptionsRe =3D /[;?]js=3D[01]$/;
=20
+	// don't change links marked as external ($logo_url, $home_link)
+	if (link.className =3D=3D=3D 'external') {
+		return;
+	}
+
 	if (!jsExceptionsRe.test(link)) { // =3D~ /[;?]js=3D[01]$/;
 		link.href +=3D
 			(link.href.indexOf('?') =3D=3D=3D -1 ? '?' : ';') + 'js=3D1';
