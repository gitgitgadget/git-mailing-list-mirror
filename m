From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Sat, 16 May 2015 10:44:04 +0100
Organization: OPDS
Message-ID: <CF195F7BDDED481EA064C0C30098017C@PhilipOakley>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com> <1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>,
	<git@vger.kernel.org>, <gitster@pobox.com>,
	<sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat May 16 11:39:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtYZA-0007wW-NE
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 11:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbbEPJj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 May 2015 05:39:26 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:64052 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752912AbbEPJjX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 May 2015 05:39:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2COBwDTD1dVPHwlFlxcgxCBMoMegy5txH8EAoEuTQEBAQEBAQcBAQEBQSQbhB0FAQEBAQIBCAEBGQ8BBR4BASELAgMFAgEDFQUCBSECAhQBBAgSBgcDFAYBEggCAQIDAYgGAwoMsleGVJhGDYUKAQEIAiCBIYoZgk2COIJvL4EWBYs8hyl2iC2CfI5ngyCDWIEEgQWCEz0xgkYBAQE
X-IPAS-Result: A2COBwDTD1dVPHwlFlxcgxCBMoMegy5txH8EAoEuTQEBAQEBAQcBAQEBQSQbhB0FAQEBAQIBCAEBGQ8BBR4BASELAgMFAgEDFQUCBSECAhQBBAgSBgcDFAYBEggCAQIDAYgGAwoMsleGVJhGDYUKAQEIAiCBIYoZgk2COIJvL4EWBYs8hyl2iC2CfI5ngyCDWIEEgQWCEz0xgkYBAQE
X-IronPort-AV: E=Sophos;i="5.13,439,1427756400"; 
   d="scan'208";a="681326693"
Received: from host-92-22-37-124.as13285.net (HELO PhilipOakley) ([92.22.37.124])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 16 May 2015 10:39:21 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269193>

=46rom: "S=C3=A9bastien Guimmara" <sebastien.guimmara@gmail.com>
> Add a [commands] header before the actual command list, then make the
> following files ignore this header in their parsing:
>
> * cmd-list.perl
> * Makefile (check-docks target)

s/docks/docs/
or even fuller as "(the check-docs target)"?
I'd misunderstood this as (verb) check the doumentation targets within=20
the Makefile, rather than the (definite article) 'check-docs' target=20
within the Makefile ~#L2554.
--
Philip

>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> Documentation/cmd-list.perl         | 4 ++++
> Documentation/howto/new-command.txt | 4 +++-
> Makefile                            | 3 ++-
> command-list.txt                    | 1 +
> 4 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.per=
l
> index 04f9977..06a5fd6 100755
> --- a/Documentation/cmd-list.perl
> +++ b/Documentation/cmd-list.perl
> @@ -38,6 +38,10 @@ sub format_one {
>  }
> }
>
> +while (<>) {
> + last if /^\[commands\]/;
> +}
> +
> my %cmds =3D ();
> for (sort <>) {
>  next if /^#/;
> diff --git a/Documentation/howto/new-command.txt=20
> b/Documentation/howto/new-command.txt
> index d7de5a3..6d772bd 100644
> --- a/Documentation/howto/new-command.txt
> +++ b/Documentation/howto/new-command.txt
> @@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
> that categorizes commands by type, so they can be listed in=20
> appropriate
> subsections in the documentation's summary command list.  Add an entr=
y
> for yours.  To understand the categories, look at git-commands.txt
> -in the main directory.
> +in the main directory.  If the new command is part of the typical Gi=
t
> +workflow and you believe it common enough to be mentioned in 'git=20
> help',
> +map this command to a common group in the column [common].
>
> 7. Give the maintainer one paragraph to include in the RelNotes file
> to describe the new feature; a good place to do so is in the cover
> diff --git a/Makefile b/Makefile
> index 25a453b..0cb2045 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2454,7 +2454,7 @@ check-docs::
>  esac ; \
>  test -f "Documentation/$$v.txt" || \
>  echo "no doc: $$v"; \
> - sed -e '/^#/d' command-list.txt | \
> + sed -e '1,/^\[commands\]/d' -e '/^#/d' <command-list.txt | \
>  grep -q "^$$v[ ]" || \
>  case "$$v" in \
>  git) ;; \
> @@ -2463,6 +2463,7 @@ check-docs::
>  done; \
>  ( \
>  sed -e '/^#/d' \
> +     -e '1,/^\[commands\]/d' \
>      -e 's/[ ].*//' \
>      -e 's/^/listed /' command-list.txt; \
>  $(MAKE) -C Documentation print-man1 | \
> diff --git a/command-list.txt b/command-list.txt
> index 54d8d21..caed872 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,5 +1,6 @@
> # List of known git commands.
> # command name                          category [deprecated] [common=
]
> +[commands]
> git-add                                 mainporcelain common
> git-am                                  mainporcelain
> git-annotate                            ancillaryinterrogators
> --=20
> 2.4.0
