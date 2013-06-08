From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 16/22] git-remote-mediawiki: Modify strings for a
 better coding-style
Date: Fri, 7 Jun 2013 20:39:43 -0400
Message-ID: <CAPig+cT6Qw1w4x95oT7PctMz_HnpU0Vwv5Bh=n-uqZQWJjFnBw@mail.gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-17-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 02:39:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul7CC-0006OV-Gp
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 02:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760Ab3FHAjs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 20:39:48 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:57152 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3FHAjs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 20:39:48 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so4250020lab.19
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 17:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mDtZTiBKgNtP07iOSZO26marbxJLjxHU//FBGwkvw/c=;
        b=LlGWhObFMe607ZTgTrfgzicJu8seMyJwi63rijqOrU2iTviWgs8SntspJ8t5FDWPRw
         Rfebv5J9yyBzRwL8EgNp1WnBGVGP/Mp3JMeOh/tAVMCBRp7XTBGZuK+a3gnc+wlEL1Ve
         eL6QPWN2h24F172AnI/Qa4bpu5dHoNXWzlsE9MlygpvQQ1H1sdpR4PfqaHhk2afhIkAD
         Obc3ToDrGQawLDozctKSJxzJJrIpi2b+KJ5/NBfLzXquLISdmuZQ6ozDcFBx68rO+R0D
         SQec8BsNtK425+STMDFs+ChAfqcAsd/Pp6ckhrSssRwrQqfxm3jkMrAgALiBAntzXriG
         MxoA==
X-Received: by 10.112.219.133 with SMTP id po5mr2175529lbc.80.1370651983695;
 Fri, 07 Jun 2013 17:39:43 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 7 Jun 2013 17:39:43 -0700 (PDT)
In-Reply-To: <1370641344-4253-17-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: CA9oPCfx4Yer_gBxqx5IJ0CwjA0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226773>

On Fri, Jun 7, 2013 at 5:42 PM, C=E9lestin Matte
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

Distinct changes could (IMHO) be split into separate patches for easier=
 review.

> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>
> Conflicts:
>
>         contrib/mw-to-git/git-remote-mediawiki.perl

Conflict information is not interesting to reviewers or even in final
commit messages since (hopefully) you will have resolved conflicts
before committing. They can be stripped.

More below.

> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |  244 +++++++++++++----=
----------
>  1 file changed, 121 insertions(+), 123 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index f37488b..2d4ea1d 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -199,10 +199,10 @@ sub mw_connect_maybe {
>                                lgdomain =3D> $wiki_domain};
>                 if ($mediawiki->login($request)) {
>                         Git::credential \%credential, 'approve';
> -                       print STDERR "Logged in mediawiki user \"$cre=
dential{username}\".\n";
> +                       print STDERR qq(Logged in mediawiki user "$cr=
edential{username}".\n);
>                 } else {
> -                       print STDERR "Failed to log in mediawiki user=
 \"$credential{username}\" on $url\n";
> -                       print STDERR "  (error " .
> +                       print {*STDERR} qq(Failed to log in mediawiki=
 user "$credential{username}" on ${url}\n);
> +                       print {*STDERR} '  (error ' .

This change from patch 17/22 (adding braces around file handles)
sneaked in early with this patch (16/22).

>                                 $mediawiki->{error}->{code} . ': ' .
>                                 $mediawiki->{error}->{details} . ")\n=
";
>                         Git::credential \%credential, 'reject';
> @@ -473,27 +473,27 @@ sub download_mw_mediafile {
>         if ($response->code =3D=3D 200) {
>                 return $response->decoded_content;
>         } else {
> -               print STDERR "Error downloading mediafile from :\n";
> -               print STDERR "URL: $download_url\n";
> -               print STDERR "Server response: " . $response->code . =
" " . $response->message . "\n";
> +               print {*STDERR} "Error downloading mediafile from :\n=
";
> +               print {*STDERR} "URL: ${download_url}\n";
> +               print {*STDERR} 'Server response: ' . $response->code=
 . q{ } . $response->message . "\n";

Ditto: Sneak in from 17/22.

>                 exit 1;
>         }
>  }
>
>  sub get_last_local_revision {
>         # Get note regarding last mediawiki revision
> -       my $note =3D run_git("notes --ref=3D$remotename/mediawiki sho=
w refs/mediawiki/$remotename/master 2>/dev/null");
> +       my $note =3D run_git("notes --ref=3D${remotename}/mediawiki s=
how refs/mediawiki/${remotename}/master 2>/dev/null");
>         my @note_info =3D split(/ /, $note);
>
>         my $lastrevision_number;
> -       if (!(defined($note_info[0]) && $note_info[0] eq "mediawiki_r=
evision:")) {
> -               print STDERR "No previous mediawiki revision found";
> +       if (!(defined($note_info[0]) && $note_info[0] eq 'mediawiki_r=
evision:')) {
> +               print STDERR 'No previous mediawiki revision found';
>                 $lastrevision_number =3D 0;
>         } else {
>                 # Notes are formatted : mediawiki_revision: #number
>                 $lastrevision_number =3D $note_info[1];
>                 chomp($lastrevision_number);
> -               print STDERR "Last local mediawiki revision found is =
$lastrevision_number";
> +               print STDERR "Last local mediawiki revision found is =
${lastrevision_number}";
>         }
>         return $lastrevision_number;
>  }
> @@ -690,8 +690,7 @@ sub fetch_mw_revisions {
>         my $n =3D 1;
>         foreach my $page (@pages) {
>                 my $id =3D $page->{pageid};
> -
> -               print STDERR "page $n/", scalar(@pages), ": ". $page-=
>{title} ."\n";
> +               print {*STDERR} "page ${n}/", scalar(@pages), ': ', $=
page->{title}, "\n";

Again 17/22.

>                 $n++;
>                 my @page_revs =3D fetch_mw_revisions_for_page($page, =
$id, $fetch_from);
>                 @revisions =3D (@page_revs, @revisions);
> @@ -705,7 +704,7 @@ sub fe_escape_path {
>      $path =3D~ s/\\/\\\\/g;
>      $path =3D~ s/"/\\"/g;
>      $path =3D~ s/\n/\\n/g;
> -    return '"' . $path . '"';
> +    return qq("${path}");
>  }
>
>  sub import_file_revision {
