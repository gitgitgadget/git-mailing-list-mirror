From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Thu, 21 May 2015 21:03:25 +0100
Organization: OPDS
Message-ID: <9AF4B2205E154BDA863E8CAAACAE0BDF@PhilipOakley>
References: <1432163517-22785-1-git-send-email-sbeller@google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <jrnieder@gmail.com>, <git@vger.kernel.org>,
	"Stefan Beller" <sbeller@google.com>, <pasky@suse.cz>,
	<hvoigt@hvoigt.net>
To: "Stefan Beller" <sbeller@google.com>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 22:03:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvWgk-00027c-Ly
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 22:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550AbbEUUDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 16:03:25 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:19313 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756302AbbEUUDY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 16:03:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CdDwCmOF5VPF4aFlxcgxCBMoZNbcMnBAQCgU5NAQEBAQEBBwEBAQFBJBtBA4NZBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMOBwwlFAEEGgYHAxQGARIIAgECAwGIEwy1N51sizqFBYMegRYFhmmEZDWGeHiLN44ahAKDWYEEgxg9MYJHAQEB
X-IPAS-Result: A2CdDwCmOF5VPF4aFlxcgxCBMoZNbcMnBAQCgU5NAQEBAQEBBwEBAQFBJBtBA4NZBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMOBwwlFAEEGgYHAxQGARIIAgECAwGIEwy1N51sizqFBYMegRYFhmmEZDWGeHiLN44ahAKDWYEEgxg9MYJHAQEB
X-IronPort-AV: E=Sophos;i="5.13,471,1427756400"; 
   d="scan'208";a="520492755"
Received: from host-92-22-26-94.as13285.net (HELO PhilipOakley) ([92.22.26.94])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 21 May 2015 21:03:23 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269652>

From: "Stefan Beller" <sbeller@google.com>
> It's better to start the man page with a description of what 
> submodules
> actually are instead of saying what they are not.
>
> Reorder the paragraphs such that
> the first short paragraph introduces the submodule concept,
> the second paragraph highlights the usage of the submodule command,
> the third paragraph giving background information,
> and finally the fourth paragraph discusing alternatives such
> as subtrees and remotes, which we don't want to be confused with.
>
> This ordering deepens the knowledge on submodules with each paragraph.
> First the basic questions like "How/what" will be answered, while the
> underlying concepts will be taught at a later time.
>
> Making sure it is not confused with subtrees and remotes is not really
> enhancing knowledge of submodules itself, but rather painting the big
> picture of git concepts, so you could also argue to have it as the 
> second
> paragraph. Personally I think this may confuse readers, specially 
> newcomers
> though.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> Documentation/git-submodule.txt | 54 
> ++++++++++++++++++++---------------------
> 1 file changed, 26 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt 
> b/Documentation/git-submodule.txt
> index 2c25916..6c38c0d 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -25,35 +25,12 @@ SYNOPSIS
>
> DESCRIPTION
> -----------
> -Submodules allow foreign repositories to be embedded within
> -a dedicated subdirectory of the source tree, always pointed
> -at a particular commit.
> +Submodules allow other repositories to be embedded within
> +a dedicated subdirectory of the source tree pointing
> +at a particular commit in the other repository.
>
> -They are not to be confused with remotes, which are meant mainly
> -for branches of the same project; submodules are meant for
> -different projects you would like to make part of your source tree,
> -while the history of the two projects still stays completely
> -independent and you cannot modify the contents of the submodule
> -from within the main project.
> -If you want to merge the project histories and want to treat the
> -aggregated whole as a single project from then on, you may want to
> -add a remote for the other project and use the 'subtree' merge 
> strategy,
> -instead of treating the other project as a submodule. Directories
> -that come from both projects can be cloned and checked out as a whole
> -if you choose to go that route.
> -
> -Submodules are composed from a so-called `gitlink` tree entry
> -in the main repository that refers to a particular commit object
> -within the inner repository that is completely separate.
> -A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
> -root of the source tree assigns a logical name to the submodule and
> -describes the default URL the submodule shall be cloned from.
> -The logical name can be used for overriding this URL within your
> -local repository configuration (see 'submodule init').
> -
> -This command will manage the tree entries and contents of the
> -gitmodules file for you, as well as inspect the status of your
> -submodules and update them.
> +This command will manage the submodules for you, as well as
> +inspect the status of your submodules and update them.
> When adding a new submodule to the tree, the 'add' subcommand
> is to be used.  However, when pulling a tree containing submodules,
> these will not be checked out by default;
> @@ -64,6 +41,27 @@ using the 'status' subcommand and get a detailed 
> overview of the
> difference between the index and checkouts using the 'summary'
> subcommand.
>
> +Submodules are composed from a so-called `gitlink` tree entry
> +in the main repository that refers to a particular commit object
> +within the inner repository that is completely separate.
> +A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
> +root of the source tree assigns a logical name to the submodule and
> +describes the default URL the submodule shall be cloned from.
> +The logical name can be used for overriding this URL within your
> +local repository configuration (see 'submodule init').
> +
> +Submodules are not to be confused with remotes, which are meant
> +mainly for branches of the same project;

This use of 'branches' didn't work for me. "remotes are meant mainly for 
branches of the same project" ?

>  submodules are meant for
> +different projects you would like to make part of your source tree,
> +while the history of the two projects still stays completely
> +independent and you cannot modify the contents of the submodule
> +from within the main project.
> +If you want to merge the project histories and want to treat the
> +aggregated whole as a single project from then on, you may want to
> +add a remote for the other project and use the 'subtree' merge 
> strategy,
> +instead of treating the other project as a submodule. Directories
> +that come from both projects can be cloned and checked out as a whole
> +if you choose to go that route.
>
--
Philip 
