From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] Introduce --current option to git-branch builtin command.
Date: Thu, 07 Jun 2012 10:43:17 +0200
Message-ID: <4FD069A5.1040905@lyx.org>
References: <CAECJ0BmcxeS1q8bw4hN9jDja2g8GGzNyN_v7jC3ehOW70x6CRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?IktlbnRhIE11cmF0YSAo5p2R55SwIOizouWkqiki?= 
	<mrkn@cookpad.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 10:43:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScYJa-0003m5-8r
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 10:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478Ab2FGIn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 04:43:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36979 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab2FGInW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 04:43:22 -0400
Received: by eaak11 with SMTP id k11so114825eaa.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 01:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=bENEg5W1XpAsHcNZa67QdgDaa0Q/lsLr2DsjONyQyoo=;
        b=VyB4LEZdhBJXGajPdmdWkgEZCopE2LppwU7VQYmJYNUjShMUQgd4s6Drc4uuYEfW1Y
         54Ca7ajEDHXxhPtccmjyrMqJdgTk0ujsm6TdbTZxioTIzz7cfXedaem4ohapPfPIu1Pt
         kJuBu+l0hywjg7cKTa8jSCeP2eablMmSQqW1ll+tw9TsXvE/9YLjmEI9qqSxzcget08T
         HLfta5iZVUGmlmAUo7m4dPQbD02H9FBtgb027rZdF1YMsOBkChqRMNwplGr/HJmPzKAO
         /gzauiUMYMSuCz8ldsNvdKZLBf23NSulJU2568qNaPiq+Lad6efINMxydJJMjvzOHGi+
         14Gg==
Received: by 10.14.119.80 with SMTP id m56mr817891eeh.37.1339058600272;
        Thu, 07 Jun 2012 01:43:20 -0700 (PDT)
Received: from [192.168.1.2] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id f16sm8322004eec.2.2012.06.07.01.43.18
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 01:43:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAECJ0BmcxeS1q8bw4hN9jDja2g8GGzNyN_v7jC3ehOW70x6CRA@mail.gmail.com>
X-Gm-Message-State: ALoCoQmLP9PCDHYXxIuJDCKtkaQYZ8t0EGT5nkhTSMxnDBYjTZ2k2r4/DHPAUBmHrQomM+lCQWj0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199382>

Op 7-6-2012 9:23, Kenta Murata (=E6=9D=91=E7=94=B0 =E8=B3=A2=E5=A4=AA) =
schreef:
> Introducing --current option to git-branch builtin command.
> This option allows us to simply show the current branch name.

I don't know whether we would need such an option. To me it feels this=20
is a missing option indeed, but at the same time you can use 'git=20
status' or 'git branch' to see the current branch. It might be useful i=
n=20
case you have lots of branches and lots of untracked files, but in that=
=20
case "git status | head -n1" or "git branch | grep '*'" would do the tr=
ick.

>
> ---
>   builtin/branch.c |   12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0e060f2..21e4675 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -19,6 +19,7 @@
>   #include "column.h"
>
>   static const char * const builtin_branch_usage[] =3D {
> +       "git branch --current",
>          "git branch [options] [-r | -a] [--merged | --no-merged]",
>          "git branch [options] [-l] [-f]<branchname>  [<start-point>]=
",
>          "git branch [options] [-r] (-d | -D)<branchname>...",

git-branch has four modes: 'list', 'create', 'delete', and 'rename'.=20
Isn't --current then just another option to the 'list'-mode?  Then it=20
would be  something like:

"git branch [options] [-r | -a] [--current] [--merged | --no-merged]"


> @@ -794,7 +796,7 @@ int cmd_branch(int argc, const char **argv, const
> char *prefix)
>          argc =3D parse_options(argc, argv, prefix, options, builtin_=
branch_usage,
>                               0);
>
> -       if (!delete&&  !rename&&  !edit_description&&  argc =3D=3D 0)
> +       if (!delete&&  !rename&&  !edit_description&&  !show_current
> &&  argc =3D=3D 0)
>                  list =3D 1;

In line with what I wrote above, show_current should imply 'list'-mode.

>
>          if (!!delete + !!rename + !!force_create + !!list>  1)
> @@ -852,6 +854,12 @@ int cmd_branch(int argc, const char **argv, cons=
t
> char *prefix)
>                          rename_branch(argv[0], argv[1], rename>  1);
>                  else
>                          usage_with_options(builtin_branch_usage, opt=
ions);
> +       } else if (show_current) {
> +               const char *branch_name =3D head;
> +               if (detached) {
> +                       branch_name =3D _("(no branch)");
> +               }
> +               printf("%s\n", branch_name);
>          } else if (argc>  0&&  argc<=3D 2) {
>                  if (kinds !=3D REF_LOCAL_BRANCH)
>                          die(_("-a and -r options to 'git branch' do
> not make sense with a branch name"));

If '--current' implies the 'list'-mode, it would use 'print_ref_list'.=20
There already is code in print_ref_list to detect whether a branch is=20
the current one, it outputs the branch list in a formatted way, it take=
s=20
care of 'columns', so wouldn't it be better to modify that code to only=
=20
print the current branch ?

Vincent
