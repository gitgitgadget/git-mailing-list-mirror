From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 11/18] Modify strings for a better coding-style
Date: Fri, 7 Jun 2013 00:31:56 -0400
Message-ID: <CAPig+cT+uczSH3SfXR6LuXY+mGMF_9HcpzygjHY1RM83VHyucQ@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-12-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 06:32:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkoLW-0004SM-MF
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 06:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108Ab3FGEcC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 00:32:02 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:63920 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab3FGEcB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 00:32:01 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so1425120lab.39
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 21:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QlzJor9snBM9bNMql9sCLHPjLzonEpUZQc2+Ftnq554=;
        b=eNjpU5Swbz9ZFMv2aKU9G346+ERRA/s4+pHuq1wsPBJRzupoXZKskoqOVjYjwgxlqm
         qqiWya/J6gIvD8L4nhdDeevHzHD5gFYl7+OOC9CuyExAtz3LMGYxpIDifty3Gohy6fcp
         k3QNmNiUFqO5Vs0OYaO8v/zwAJTNQYhP7B0QuxRKrQgxLQKuchBtkpUNbFFIUctisoKX
         AEE57jquu1U9srFREnTD7BDaaovqMmtYq5tEmmefcnkh4GauRuXpTEeGg3aVyUM5QTFk
         CKx3yEa2/8L8MV5A5rL6ck73YDKBZJkmUAV86I54SKAwx+pVj3lEGj7+DIel4cTf5Yze
         +gSw==
X-Received: by 10.112.205.69 with SMTP id le5mr415684lbc.3.1370579516732; Thu,
 06 Jun 2013 21:31:56 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 21:31:56 -0700 (PDT)
In-Reply-To: <1370547263-13558-12-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: MNLK1imeRf5GYDajGLCCxYY5_Ek
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226587>

On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> - strings which don't need interpolation are single-quoted for more c=
larity and
> slight gain of performance
> - interpolation is preferred over concatenation in many cases, for mo=
re clarity
> - variables are always used with the ${} operator inside strings
> - strings including double-quotes are written with qq() so that the q=
uotes do
> not have to be escaped
>
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |  250 +++++++++++++----=
----------
>  1 file changed, 124 insertions(+), 126 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 1271527..0e2152d 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -344,10 +344,10 @@ sub get_mw_pages {
>  #        $out =3D run_git("command args", "raw"); # don't interpret =
output as UTF-8.
>  sub run_git {
>         my $args =3D shift;
> -       my $encoding =3D (shift || "encoding(UTF-8)");
> -       open(my $git, "-|:$encoding", "git " . $args)
> -           or die "Unable to open: $!\n";
> -       my $res =3D do {
> +       my $encoding =3D (shift || 'encoding(UTF-8)');
> +       my $res =3D do {
> +               open(my $git, "-|:$encoding", "git ${args}")
> +                   or die "Unable to fork: $!\n";
>                 local $/ =3D undef;
>                 <$git>
>         };

A change sneaked in here not mentioned by the commit message and not
related to the other changes. open() is now inside the do{} block.
