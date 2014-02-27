From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] GSoC2014 microprojects #5 Change bundle.c:add_to_ref_list()
 to use hashcpy()
Date: Thu, 27 Feb 2014 22:45:04 +0100
Message-ID: <530FB1E0.5030501@alum.mit.edu>
References: <1393513127-32399-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 22:45:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ8lW-0003al-Ch
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 22:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbaB0VpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 16:45:09 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64093 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942AbaB0VpH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 16:45:07 -0500
X-AuditID: 1207440d-f79d86d0000043db-50-530fb1e2bfc2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.8D.17371.2E1BF035; Thu, 27 Feb 2014 16:45:06 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RLj47l024107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 16:45:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393513127-32399-1-git-send-email-sunheehnus@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqPtoI3+wwbR/+hZdV7qZLNpub2d0
	YPLYOesuu8fnTXIBTFHcNkmJJWXBmel5+nYJ3BmtN5+xFDRzV+zbfZ29gfEbRxcjJ4eEgInE
	6lcLGCFsMYkL99azdTFycQgJXGaUuN55lhXCOc8kMf36ZmaQKl4BbYn72x6zgdgsAqoSq36t
	YAKx2QR0JRb1NIPZogLBEqsvP2CBqBeUODnzCZgtIqAocfD4VqA5HBzMAuIS/f9YQExhgWSJ
	kwfBbhAScJHY1TGPFcTmFHCVmNPxhAmkRAKouqcxCCTMLKAj8a7vATOELS+x/e0c5gmMgrOQ
	7JqFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MUKCl3cH4/91
	MocYBTgYlXh4J3jyBwuxJpYVV+YeYpTkYFIS5a1ZAxTiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wus7ByjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgvbwBqFGwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFL3xxcD4BUnxAO29D9LOW1yQmAsUhWg9xWjM
	0dn46xMjx+02ICnEkpeflyolzrsDpFQApDSjNA9uESxtvWIUB/pbmJcNmMSEeIApD27eK6BV
	TECrjkrzgKwqSURISTUwzlV/L/beX1v+70tr8R/GqVv2X7y4r67YbfbS3SGTHxfb6az9JhDW
	dPm0b/HXe3tjiz/K75heY+Twj+n009xUh9wDTvf5Dq79fc/kgpnQpINLlxqwdorH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242862>

On 02/27/2014 03:58 PM, Sun He wrote:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>  bundle.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/bundle.c b/bundle.c
> index e99065c..7809fbb 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -19,7 +19,7 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
>  		list->list = xrealloc(list->list,
>  				list->alloc * sizeof(list->list[0]));
>  	}
> -	memcpy(list->list[list->nr].sha1, sha1, 20);
> +	hashcpy(list->list[list->nr].sha1, sha1);
>  	list->list[list->nr].name = xstrdup(name);
>  	list->nr++;
>  }
> 

Correct (except for the patch formatting problems I mentioned WRT your
other patch).  Please also note that the subject line after "[PATCH...]"
is taken as the first line of the commit message, so it is inappropriate
to mention "GSoC2014" etc. there.

> -- 1.7.1
>> See if you can find other places where hashcpy() should be used instead of memcpy()
> grep.c:grep_source_init()
> reflog-walk.c:read_one_reflog()
> ppc/sha1.c:ppc_SHA1_Final()
> refs.c:resolve_gitlink_packed_ref()
> 
> We can find those by the shell command:
> $ find . | xargs grep "memcpy\(.*20.*\)

It would have been much more helpful if you had submitted patches to fix
those other sites.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
