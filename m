From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] GSoC2014 microprojects #6 Change bundle.c:add_to_ref_list()
 to use ALLOC_GROW()
Date: Thu, 27 Feb 2014 22:51:41 +0100
Message-ID: <530FB36D.6060103@alum.mit.edu>
References: <1393517894-670-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 22:58:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ8yi-0004XE-E9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 22:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbaB0V6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 16:58:48 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64427 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155AbaB0V6r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 16:58:47 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 16:58:46 EST
X-AuditID: 12074412-f79d46d000002e58-cb-530fb36f498a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 04.44.11864.F63BF035; Thu, 27 Feb 2014 16:51:43 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RLpfR0024427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 16:51:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393517894-670-1-git-send-email-sunheehnus@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqJu/mT/Y4MRHFYuuK91MFm23tzM6
	MHnsnHWX3ePzJrkApihum6TEkrLgzPQ8fbsE7oyTZz+yFOzmqnj8YhNLA+M6ji5GTg4JAROJ
	y8eWsELYYhIX7q1n62Lk4hASuMwoMWPaVyjnPJPEig9tbCBVvALaErOPv2DuYuTgYBFQlXj+
	oRYkzCagK7Gop5kJxBYVCJZYffkBC0S5oMTJmU/AbBEBRYmDx7eCtTILiEv0/wMLCwukSbya
	+IYRxBYScJJ4t/8p2CZOAWeJF7NeMIKUSwCV9zQGgYSZBXQk3vU9YIaw5SW2v53DPIFRcBaS
	ZbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukmRkjwCu1gXH9S
	7hCjAAejEg/vBE/+YCHWxLLiytxDjJIcTEqivDVrgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
	eH3nAOV4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4hTYCNQoWpaan
	VqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoje+GBi/ICkeoL3Nm0D2Fhck5gJFIVpPMRpz
	dDb++sTIcbsNSAqx5OXnpUqJ8wqBlAqAlGaU5sEtgqWtV4ziQH8L85qAVPEAUx7cvFdAq5iA
	Vh2V5gFZVZKIkJJqYLTdonVG+XrjnbMfn56QnP9+T+nOTRGbZAxcO0WC5ol12C6aXBHjunjf
	kt2lASFiTdP0a62+151a1PAxP7iG/fWcM5F8OzNWqJ4XYV4l+n3P3FJluY6oYrN9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242863>

On 02/27/2014 05:18 PM, Sun He wrote:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>  bundle.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/bundle.c b/bundle.c
> index 7809fbb..1a7b7eb 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -14,11 +14,7 @@ static const char bundle_signature[] = "# v2 git bundle\n";
>  static void add_to_ref_list(const unsigned char *sha1, const char *name,
>  		struct ref_list *list)
>  {
> -	if (list->nr + 1 >= list->alloc) {
> -		list->alloc = alloc_nr(list->nr + 1);
> -		list->list = xrealloc(list->list,
> -				list->alloc * sizeof(list->list[0]));
> -	}
> +    ALLOC_GROW(list->list,list->nr,list->alloc);
>  	hashcpy(list->list[list->nr].sha1, sha1);
>  	list->list[list->nr].name = xstrdup(name);
>  	list->nr++;
> 

Many of my comments about the formatting of your other patches apply
here.  Also, we put spaces after ",", as you can see in the very next line.

I'm also pretty sure there is a serious error in your code.  But I'd
rather you stick to one microproject and get it perfect rather than do
them all--especially all at once, with no time to incorporate feedback
from one microproject into the attempt at the next one.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
