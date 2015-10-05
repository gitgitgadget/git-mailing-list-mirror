From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 37/43] refs: move some defines from refs-be-files.c
 to refs.h
Date: Mon, 05 Oct 2015 10:57:34 +0200
Message-ID: <56123B7E.4030808@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-38-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 10:57:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj1al-0006KL-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 10:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbbJEI5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 04:57:51 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:46426 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751816AbbJEI5v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 04:57:51 -0400
X-AuditID: 1207440f-f79df6d000007c0f-28-56123b7f8d3c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.E9.31759.F7B32165; Mon,  5 Oct 2015 04:57:35 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t958vYip001395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 04:57:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-38-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqFtvLRRmsOGoocX8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7ox9Z5azFZzgrWjd8JK9gfEFVxcjJ4eEgInE
	jz3b2SBsMYkL99YD2VwcQgKXGSXuvV3JDOGcY5LYuuIWUIaDg1dAW6JhYhJIA4uAqsTvNYvA
	mtkEdCUW9TQzgdiiAkESK5a/YASxeQUEJU7OfMICYosIOEhc3nWUGcQWFgiT+HOslRFifhuj
	xOTZ18EaOAW8JOZfPwVWxCygJ7Hj+i9WCFteonnrbOYJjPyzkMydhaRsFpKyBYzMqxjlEnNK
	c3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCQpJ/B2PXeplDjAIcjEo8vAfiBcOEWBPL
	iitzDzFKcjApifLW6giFCfEl5adUZiQWZ8QXleakFh9ilOBgVhLhfWUGlONNSaysSi3Kh0lJ
	c7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfA6WwE1ChalpqdWpGXmlCCkmTg4QYZzSYkU
	p+alpBYllpZkxINiMr4YGJUgKR6gvekg7bzFBYm5QFGI1lOMilLivGIgCQGQREZpHtxYWKJ5
	xSgO9KUwryBIFQ8wScF1vwIazAQ0uF8ebHBJIkJKqoFxEe/rP8/z99avV3obY8mpyaZRxfRc
	YVYOS/HvAKEAjnOaydnZucbrtwcX5cleVX346uTMPIuCGbJbV+xOnPvwV93yjeJr0hedLGXR
	mj+rNu6k6JMd5XJHJ7kKFfW0Bpp2FTxcIKUQPNl5neuZzbt7pr4Q5wr+/ebs7TVa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279049>

On 09/29/2015 12:02 AM, David Turner wrote:
> This allows them to be used by other ref backends.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 24 ------------------------
>  refs.h          | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index 3bcfab3..2727943 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> @@ -14,30 +14,6 @@ struct ref_lock {
>  };
>  
>  /*
> - * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
> - * refs (i.e., because the reference is about to be deleted anyway).
> - */
> -#define REF_DELETING	0x02
> [...]
> diff --git a/refs.h b/refs.h
> index 823983b..d8ae9af 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -193,6 +193,30 @@ struct ref_transaction {
>  #define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
>  
>  /*
> + * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
> + * refs (i.e., because the reference is about to be deleted anyway).
> + */
> +#define REF_DELETING	0x02
> [...]

The fact that these constants might be used by multiple reference
backends is not a reason to put them in the ref API's public interface.
We don't want random code using these contants, right?

Maybe there should be a new file pair, refs-be-shared.{c,h}, for
"protected" constants and functions for the internal use of the
reference backends. In fact, maybe `struct ref_be` and the associated
typedefs could even be moved there.

Probably some of the functions that you have made public earlier in this
series could also go into the "protected" area.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
