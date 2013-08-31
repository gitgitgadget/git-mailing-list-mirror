From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 05/11] Documentation/replace: add Creating Replacement Objects section
Date: Sat, 31 Aug 2013 23:19:48 +0100
Organization: OPDS
Message-ID: <23F4E42FEAEB41DCA9B6F18EED5DD4D0@PhilipOakley>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org> <20130831191215.26699.37641.chriscool@tuxfamily.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Thomas Rast" <trast@inf.ethz.ch>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Christian Couder" <chriscool@tuxfamily.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 00:19:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFtVT-0006tR-8G
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 00:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab3HaWSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 18:18:55 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:46311 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753290Ab3HaWSz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 18:18:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvgLAHxqIlJOl3GZ/2dsb2JhbABAGoMHNYk2t30EBAGBHRd0gh8FAQEEAQgBAS4eAQEhBQYCAwUCAQMOBwwlFAEEGgYHFwYBEggCAQIDAYdrCgg0uSsEj3+DJIEAA4h9hhKaTIE6KYE+O4EsJA
X-IPAS-Result: AvgLAHxqIlJOl3GZ/2dsb2JhbABAGoMHNYk2t30EBAGBHRd0gh8FAQEEAQgBAS4eAQEhBQYCAwUCAQMOBwwlFAEEGgYHFwYBEggCAQIDAYdrCgg0uSsEj3+DJIEAA4h9hhKaTIE6KYE+O4EsJA
X-IronPort-AV: E=Sophos;i="4.89,999,1367967600"; 
   d="scan'208";a="439916837"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with SMTP; 31 Aug 2013 23:18:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233552>

From: "Christian Couder" <chriscool@tuxfamily.org>
> There were no hints in the documentation about how to create
> replacement objects.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> Documentation/git-replace.txt | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/git-replace.txt 
> b/Documentation/git-replace.txt
> index aa66d27..736b48c 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -64,6 +64,19 @@ OPTIONS
>  Typing "git replace" without arguments, also lists all replace
>  refs.
>
> +CREATING REPLACEMENT OBJECTS
> +----------------------------
> +
> +linkgit:git-filter-branch[1], linkgit:git-hash-object[1] and
> +linkgit:git-rebase[1],

Let's not forget the obvious 'git commit' or 'git merge' on a temporary 
branch for creating a replacement commit.

In particular we need to have covered the alternate to a graft of "A B 
C" (i.e. A is now a merge of B & C) if we are to deprecate grafts with 
any conviction. (https://git.wiki.kernel.org/index.php/GraftPoint)

> among other git commands, can be used to create
> +replacement objects from existing objects.
> +
> +If you want to replace many blobs, trees or commits that are part of 
> a
> +string of commits, you may just want to create a replacement string 
> of
> +commits and then only replace the commit at the tip of the target
> +string of commits with the commit at the tip of the replacement 
> string
> +of commits.
> +
> BUGS
> ----
> Comparing blobs or trees that have been replaced with those that
> @@ -76,6 +89,9 @@ pending objects.
>
> SEE ALSO
> --------
> +linkgit:git-hash-object[1]
> +linkgit:git-filter-branch[1]
> +linkgit:git-rebase[1]
> linkgit:git-tag[1]
> linkgit:git-branch[1]
> linkgit:git[1]
> -- 
> 1.8.4.rc1.31.g530f5ce.dirty
>
>
> 
