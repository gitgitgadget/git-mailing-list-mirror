From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [Patch 2/5] Create html documents for all files in Documentation/technical
Date: Sat, 6 Oct 2012 19:45:11 +0100
Organization: OPDS
Message-ID: <3662216A9D714C08B8522340D420AEEA@PhilipOakley>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net> <652323221.269712.1349538906380.JavaMail.ngmail@webmail08.arcor-online.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Thomas Ackermann" <th.acker66@arcor.de>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 06 20:45:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZNS-0007O9-Np
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 20:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab2JFSpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 14:45:21 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:27359 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753801Ab2JFSpU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 14:45:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiwOAAJ8cFBcGnKf/2dsb2JhbABFi1ChdZBPAQKBC4EJghsFAQEFCAEBLh4BASwCAwUCAQMOBwwlFAEEGgYHFwYBEggCAQIDAYdiAxOvMgWJXIppgUoCd4NTYAOII4VGiRePGYJu
X-IronPort-AV: E=Sophos;i="4.80,545,1344207600"; 
   d="scan'208";a="400778046"
Received: from host-92-26-114-159.as13285.net (HELO PhilipOakley) ([92.26.114.159])
  by out1.ip03ir2.opaltelecom.net with SMTP; 06 Oct 2012 19:45:06 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207165>

From: "Thomas Ackermann" <th.acker66@arcor.de>
>- add missing files
> - fix some asciidoc layout problems
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
> Documentation/Makefile                    | 12 ++++++++++-
> Documentation/technical/index-format.txt  |  2 +-
> Documentation/technical/pack-format.txt   |  8 +++----
> Documentation/technical/pack-protocol.txt |  7 +++---
> Documentation/technical/shallow.txt       |  8 ++++++-
> Documentation/technical/trivial-merge.txt | 36 
> +++++++++++++++----------------
> 6 files changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 267dfe1..86594f6 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -25,6 +25,16 @@ SP_ARTICLES += howto/revert-branch-rebase
> SP_ARTICLES += howto/using-merge-subtree
> SP_ARTICLES += howto/using-signed-tag-in-pull-request
> API_DOCS = $(patsubst %.txt,%,$(filter-out 
> technical/api-index-skel.txt technical/api-index.txt, $(wildcard 
> technical/api-*.txt)))
> +API_DOCS += technical/index-format

Would it not be better to create a separate TECH_DOCS list, rather than 
confuse the API_DOCS list?

> +API_DOCS += technical/pack-format
> +API_DOCS += technical/pack-heuristics
> +API_DOCS += technical/pack-protocol
> +API_DOCS += technical/protocol-capabilities
> +API_DOCS += technical/protocol-common
> +API_DOCS += technical/racy-git
> +API_DOCS += technical/send-pack-pipeline
> +API_DOCS += technical/shallow
> +API_DOCS += technical/trivial-merge
> SP_ARTICLES += $(API_DOCS)
> SP_ARTICLES += technical/api-index
>
> @@ -231,7 +241,7 @@ clean:
>  $(RM) *.texi *.texi+ *.texi++ git.info gitman.info
>  $(RM) *.pdf
>  $(RM) howto-index.txt howto/*.html doc.dep
> - $(RM) technical/api-*.html technical/api-index.txt
> + $(RM) technical/*.html technical/api-index.txt
>  $(RM) $(cmds_txt) *.made
>  $(RM) manpage-base-url.xsl
>
> diff --git a/Documentation/technical/index-format.txt 
> b/Documentation/technical/index-format.txt
> index 9d25b30..57d6f91 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -1,7 +1,7 @@
> GIT index format
> ================
>
> -= The git index file has the following format
> +== The git index file has the following format
>
<snip> 
