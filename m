From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 9/8] t0060: split absolute path test in two to exercise
 some of it on Windows
Date: Mon, 10 Sep 2012 13:52:50 +0200
Message-ID: <504DD492.8030800@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu> <504CB8DC.90202@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Sep 10 13:53:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB2Y1-0004zE-Fx
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 13:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474Ab2IJLwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 07:52:54 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:63902 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756874Ab2IJLwx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 07:52:53 -0400
X-AuditID: 12074413-b7f786d0000008bb-2f-504dd494e1c9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 05.07.02235.494DD405; Mon, 10 Sep 2012 07:52:52 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8ABqofL026989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 07:52:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <504CB8DC.90202@kdbg.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqDvlim+AQfs/FYuuK91MFg29V5gt
	nsy9y2yxflEDq0X3lLeMDqweO2fdZfd4+KqL3ePiJWWPz5vkAliiuG2SEkvKgjPT8/TtErgz
	zi6by1awha/i3e9XLA2MZ7i7GDk4JARMJE6+culi5AQyxSQu3FvP1sXIxSEkcJlRovt2NzuE
	c5xJYtr9D+wgDbwC2hKn7tWDmCwCqhInH0SC9LIJ6Eos6mlmArFFBUIkZlyezAxi8woISpyc
	+YQFxBYRUJA4sG8hK8hIZoHFjBI/Z7aDJYQFkiUapz1hB7GFBOIk9ty5C7aKU0BN4tA1LxCT
	WUBdYv08IZAKZgF5ie1v5zBPYBSYhWTDLISqWUiqFjAyr2KUS8wpzdXNTczMKU5N1i1OTszL
	Sy3SNdfLzSzRS00p3cQICWjhHYy7TsodYhTgYFTi4W3W9Q0QYk0sK67MPcQoycGkJMr78wJQ
	iC8pP6UyI7E4I76oNCe1+BCjBAezkgjvn71AOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU
	7NTUgtQimKwMB4eSBO+Ny0CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAIjS8G
	xihIigdo7zOQdt7igsRcoChE6ylGXY67H1fcZxRiycvPS5US570LUiQAUpRRmge3Apa+XjGK
	A30szMsCTGZCPMDUBzfpFdASJqAlvh4+IEtKEhFSUg2M065VvNl8W2vTvCssj2/Xxfzb8NFD
	f8UH209npppt3HIoVi7g2b69yXKa4n1ZP6w8ixt25Pe/KFnNXXJoh41N5GxPG12/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205120>

Looks fine to me.  Thanks!

Michael

On 09/09/2012 05:42 PM, Johannes Sixt wrote:
> Only the first half of the test works only on POSIX, the second half
> passes on Windows as well.
> 
> A later test "real path removes other extra slashes" looks very similar,
> but it does not make sense to split it in the same way: When two slashes
> are prepended in front of an absolute DOS-style path on Windows, the
> meaning of the path is changed (//server/share style), so that the test
> cannot pass on Windows.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  The series passes for me as is, but one test needs POSIX only in
>  the first half. This patch splits it in two.
> 
>  t/t0060-path-utils.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index e40f764..4ef2345 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -148,10 +148,14 @@ test_expect_success 'real path rejects the empty string' '
>  	test_must_fail test-path-utils real_path ""
>  '
>  
> -test_expect_success POSIX 'real path works on absolute paths' '
> +test_expect_success POSIX 'real path works on absolute paths 1' '
>  	nopath="hopefully-absent-path" &&
>  	test "/" = "$(test-path-utils real_path "/")" &&
> -	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&
> +	test "/$nopath" = "$(test-path-utils real_path "/$nopath")"
> +'
> +
> +test_expect_success 'real path works on absolute paths 2' '
> +	nopath="hopefully-absent-path" &&
>  	# Find an existing top-level directory for the remaining tests:
>  	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
>  	test "$d" = "$(test-path-utils real_path "$d")" &&
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
