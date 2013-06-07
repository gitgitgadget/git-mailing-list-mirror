From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/18] Turn double-negated expressions into simple expressions
Date: Fri, 7 Jun 2013 00:12:54 -0400
Message-ID: <CAPig+cSDxhT=WVMQz_88z0xEmPVENDSyp5mE7XWCf_99yQTkTA@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-6-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 06:13:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uko2w-0007KQ-5I
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 06:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771Ab3FGEM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 00:12:57 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33052 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3FGEM4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 00:12:56 -0400
Received: by mail-lb0-f172.google.com with SMTP id p10so3821073lbi.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 21:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hjY6Bwmre895uo8DlIGYmi6QD7a3egURDnoxTsCJMl4=;
        b=oR1iUlzIe8GCUWPZlElTIa4Lgu1/49sRWmBftw5fjM/BxxGuk8iyzj27MQOXMbjDgg
         oWr2it6FKYuDjPlEQ/NhMzp3cgjt7Uwva+P67BSB4NjAaTeYxGsGFEKKRzQhzbgTc8iB
         H2ybrOvyJ+eqjVNQRozWldJ7kSChtKeb+nBAIiP0f4mkzy85G37x194oVeviXo13y93l
         hi9mB7NVS3J9G1E5f+uPeF3rtrpbeBwjMElovDHLeeH0a2KpD9dhHku+Ad03KvxzleKl
         BSezQhYWuvt8WoBssgahtJFsP3rru9LsKOC/+m3oluPoKjv2iRltIaq3ABzp409reS2W
         tcEw==
X-Received: by 10.112.219.133 with SMTP id po5mr319731lbc.80.1370578374330;
 Thu, 06 Jun 2013 21:12:54 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 21:12:54 -0700 (PDT)
In-Reply-To: <1370547263-13558-6-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: Ac5ORRkse2eScdWNITU1GeYCZCM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226586>

On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 68fd129..a6c7de2 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -136,16 +136,16 @@ while (<STDIN>) {
>         if (defined($cmd[0])) {
>                 # Line not blank
>                 if ($cmd[0] eq "capabilities") {
> -                       die("Too many arguments for capabilities\n") =
unless (!defined($cmd[1]));
> +                       die("Too many arguments for capabilities\n") =
if (defined($cmd[1]));
>                         mw_capabilities();
>                 } elsif ($cmd[0] eq "list") {
> -                       die("Too many arguments for list\n") unless (=
!defined($cmd[2]));
> +                       die("Too many arguments for list\n") if (defi=
ned($cmd[2]));
>                         mw_list($cmd[1]);
>                 } elsif ($cmd[0] eq "import") {
> -                       die("Invalid arguments for import\n") unless =
($cmd[1] ne "" && !defined($cmd[2]));
> +                       die("Invalid arguments for import\n") if ($cm=
d[1] eq "" || defined($cmd[2]));
>                         mw_import($cmd[1]);
>                 } elsif ($cmd[0] eq "option") {
> -                       die("Too many arguments for option\n") unless=
 ($cmd[1] ne "" && $cmd[2] ne "" && !defined($cmd[3]));
> +                       die("Too many arguments for option\n") if ($c=
md[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));

Not new in this patch, but isn't this diagnostic misleading? It will
(falsely) claim "too many arguments" if $cmd[1] or $cmd[2] is an empty
string. Perhaps it should be reworded like the 'import' diagnostic and
say "Invalid arguments for option".

>                         mw_option($cmd[1],$cmd[2]);
>                 } elsif ($cmd[0] eq "push") {
>                         mw_push($cmd[1]);
> --
