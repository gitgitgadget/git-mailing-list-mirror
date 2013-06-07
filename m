From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 22/22] git-remote-mediawiki: Clearly rewrite double dereference
Date: Fri, 7 Jun 2013 19:34:22 -0400
Message-ID: <CAPig+cSMgdjew6oDPd64Wjm0MgF=iwR1g2NNRu6O1gTzvYHVkg@mail.gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-23-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 01:34:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul6Az-0002Az-Vm
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 01:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009Ab3FGXe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 19:34:28 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55650 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005Ab3FGXeY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 19:34:24 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so2676952lbi.5
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mQU59cGwtS6FTq/ZGRyioSwCYKQrTGAQ0tQWzL8+GwU=;
        b=ExVb6HOXoOascwfdZ9DKNqwTKfg2yCSSnL/q/4O+BAf43GwdEuxoyI6J15GmQtNuL8
         EAPztqw4pbSFOyfZIchrWosmOI9B7mcwk/w39JM3ympHSrgIWxAfvd9SjdiY2NOYOnSz
         Xe3S3zRlVhMVp0ls3v5T9YvBriRCuPOJ/O8pbjtzWNe85g/RS1aXD+8Y9KfuwZwGvsnm
         Ij/F0a5hLl90tTBTcsFHmtobskP8fnJ9fH2msh18RbQBuaw1ieQ/hPCGZopgi8XO6hch
         odYDlWLKe9tpNBbPU575Gk0SjyZgd4N+DYxPQ0rMn+9M8gHCIjwDmwvzu4cOJD+PTMde
         VrEA==
X-Received: by 10.152.19.65 with SMTP id c1mr443374lae.24.1370648062985; Fri,
 07 Jun 2013 16:34:22 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 7 Jun 2013 16:34:22 -0700 (PDT)
In-Reply-To: <1370641344-4253-23-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: sYK3ixQPMO_BOm8MkrsWOpbUzxI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226765>

On Fri, Jun 7, 2013 at 5:42 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> @$var structures are re-written in the following way: @{$var}
> It makes them more readable.
>
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index be860c8..a13c33f 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -234,7 +234,7 @@ sub get_mw_tracked_pages {
>  sub get_mw_page_list {
>         my $page_list =3D shift;
>         my $pages =3D shift;
> -       my @some_pages =3D @$page_list;
> +       my @some_pages =3D @{$page_list};
>         while (@some_pages) {
>                 my $last_page =3D $SLICE_SIZE;
>                 if ($#some_pages < $last_page) {
> @@ -736,7 +736,7 @@ sub import_file_revision {
>
>         print {*STDOUT} "commit refs/mediawiki/${remotename}/master\n=
";
>         print {*STDOUT} "mark :${n}\n";
> -       print {*STDOUT} "committer ${author} <${author}\@${wiki_name}=
> " . $date->epoch . " +0000\n";
> +       print {*STDOUT} "committer ${author} <${author}\@{${wiki_name=
}}> " . $date->epoch . " +0000\n";

In this case, \@ is a literal '@' in the string, so it is not a @$var
reference, thus this change is incorrect.

>         literal_data($comment);
>
>         # If it's not a clone, we need to know where to start from
> @@ -762,7 +762,7 @@ sub import_file_revision {
>                 print {*STDOUT} "reset refs/notes/${remotename}/media=
wiki\n";
>         }
>         print {*STDOUT} "commit refs/notes/${remotename}/mediawiki\n"=
;
> -       print {*STDOUT} "committer ${author} <${author}\@${wiki_name}=
> " . $date->epoch . " +0000\n";
> +       print {*STDOUT} "committer ${author} <${author}\@{${wiki_name=
}}> " . $date->epoch . " +0000\n";

Ditto: \@ is a literal '@' in the string.

>         literal_data('Note added by git-mediawiki during import');
>         if (!$full_import && $n =3D=3D 1) {
>                 print {*STDOUT} "from refs/notes/${remotename}/mediaw=
iki^0\n";
> @@ -884,7 +884,7 @@ sub mw_import_revids {
>         my $n_actual =3D 0;
>         my $last_timestamp =3D 0; # Placeholer in case $rev->timestam=
p is undefined
>
> -       foreach my $pagerevid (@$revision_ids) {
> +       foreach my $pagerevid (@{$revision_ids}) {
>                 # Count page even if we skip it, since we display
>                 # $n/$total and $total includes skipped pages.
>                 $n++;
> @@ -919,7 +919,7 @@ sub mw_import_revids {
>                 my $page_title =3D $result_page->{title};
>
>                 if (!exists($pages->{$page_title})) {
> -                       print {*STDERR} "${n}/", scalar(@$revision_id=
s),
> +                       print {*STDERR} "${n}/", scalar(@{$revision_i=
ds}),
>                                 ": Skipping revision #$rev->{revid} o=
f ${page_title}\n";
>                         next;
>                 }
> @@ -952,7 +952,7 @@ sub mw_import_revids {
>                 # If this is a revision of the media page for new ver=
sion
>                 # of a file do one common commit for both file and me=
dia page.
>                 # Else do commit only for that page.
> -               print {*STDERR} "${n}/", scalar(@$revision_ids), ": R=
evision #$rev->{revid} of $commit{title}\n";
> +               print {*STDERR} "${n}/", scalar(@{$revision_ids}), ":=
 Revision #$rev->{revid} of $commit{title}\n";
>                 import_file_revision(\%commit, ($fetch_from =3D=3D 1)=
, $n_actual, \%mediafile);
>         }
>
> --
