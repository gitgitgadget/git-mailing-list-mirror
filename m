From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 22/43] refs-be-files.c: add do_for_each_per_worktree_ref
Date: Mon, 05 Oct 2015 10:19:05 +0200
Message-ID: <56123279.4060605@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-23-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 10:19:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj0zO-0007Ow-SO
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 10:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbJEITN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 04:19:13 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43948 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbbJEITM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 04:19:12 -0400
X-AuditID: 1207440d-f79136d00000402c-e1-5612327b251a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DE.98.16428.B7232165; Mon,  5 Oct 2015 04:19:07 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t958J5x1032259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 04:19:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-23-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixO6iqFttJBRm8Owkr8X8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7ow3x1uYCmbyVnxavJC1gfEkVxcjJ4eEgInE
	72fPmCFsMYkL99azdTFycQgJXGaU6OyawgThnGOSuDhrLTtIFa+AtsT3nY9YQGwWAVWJk+t+
	sYLYbAK6Eot6mplAbFGBIIkVy18wQtQLSpyc+QSsXkTAQeLyrqNg24QF/CXmTV7DDLGgjVGi
	4/kVsGZOAS+JlyfPgi1jFtCT2HEdYgGzgLzE9rdzmCcw8s9CMncWkrJZSMoWMDKvYpRLzCnN
	1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJSt4djP/XyRxiFOBgVOLhPRAvGCbEmlhW
	XJl7iFGSg0lJlLdWRyhMiC8pP6UyI7E4I76oNCe1+BCjBAezkgivthZQjjclsbIqtSgfJiXN
	waIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwXvVAKhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4
	NS8ltSixtCQjHhSV8cXAuARJ8QDtZTQE2VtckJgLFIVoPcWoKCXO6wWSEABJZJTmwY2FpZpX
	jOJAXwrzPgXZzgNMU3Ddr4AGMwEN7pcHG1ySiJCSamBU+cGUluHvtObEwdZ/nPcs9Vn9xd3L
	LO52qGwqWHNp8+c+SakJ4mzP2T+b9IVOlk/euqIxfX+GOjtf1sfergVmCQ4Npkf1/OOunJlj
	27nf64mOp3j4MYX128K2fZCUnHUgL2uSFA9vRe+elDPiCbf9Te78dZbw/Xv2elzK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279044>

On 09/29/2015 12:01 AM, David Turner wrote:
> Alternate refs backends might still use files to store per-worktree
> refs.  So the files backend's ref-loading infrastructure should be
> available to those backends, just for use on per-worktree refs.  Add
> do_for_each_per_worktree_ref, which iterates over per-worktree refs.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 15 ++++++++++++---
>  refs.h          | 11 +++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index eb18a20..dc89289 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> @@ -587,9 +587,6 @@ static void sort_ref_dir(struct ref_dir *dir)
>  	dir->sorted = dir->nr = i;
>  }
>  
> -/* Include broken references in a do_for_each_ref*() iteration: */
> -#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
> -
>  /*
>   * Return true iff the reference described by entry can be resolved to
>   * an object in the database.  Emit a warning if the referred-to
> [...]
> diff --git a/refs.h b/refs.h
> index 5875fe5..09d140d 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -152,6 +152,12 @@ struct ref_transaction;
>   */
>  #define REF_BAD_NAME 0x08
>  
> +/* Include broken references in a do_for_each_ref*() iteration */
> +#define DO_FOR_EACH_INCLUDE_BROKEN 0x01

Why do you move this definition from refs-be-files.c?

> +
> +/* Only include per-worktree refs in a do_for_each_ref*() iteration */
> +#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02

And why do you define this one here instead of in refs-be-files.c?

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
