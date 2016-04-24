From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] string_list: use string-list API in
 unsorted_string_list_lookup()
Date: Sun, 24 Apr 2016 09:06:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604240901570.2896@virtualbox>
References: <20160422173500.32329-1-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 09:06:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auE7d-0000ff-OQ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 09:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbcDXHGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 03:06:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:55483 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbcDXHGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 03:06:17 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MYfJW-1bGemd011m-00VRzN; Sun, 24 Apr 2016 09:06:13
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160422173500.32329-1-ralf.thielow@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:DbKqn0CJHrFynD7HP6JgRUkR2LlKl+FWQm+scXsOT3ps49koIln
 UjejDSzC2j9SC4ejQGb8Nflfd0CgyZ/p1inSZcoXkbopTnwMb/ECF0PU2zcxbJK/nWpGHG9
 EJcGjHaYwKm3unKT3nWsTTtpJZquV2tJ55/Zjy0lq7elwspQgIwgiwKJln2IbbHmqFSSpfq
 EXRcPcspj1EZ0TyPQvOGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eWlVCtzXne0=:uowCbGf6WQxanxrKccLtC4
 yB41ty5jgjUYOHvoTV72DUaCtPIzFUmhqX/dDJWmW5KvX+rHAXw1l4pYpqXND1v28f2U3hkwK
 ch+Ls8O8ObnopYevrTIWS5l1YWMyb4OyQyu0Scr32s5ZXYjWc1nN8ZIz7xUighQy4o9LGewTN
 i3OwzcuNrWn6Jbz3IOWfYjPiwOuxbfTV9zIq7GYn3PaboPMC4UlhKZjX8GWd4mBPrxgSTVr/k
 tAUayD96cDGvBMsbN+ljs7dL1cebc8fbQ7FWogQ4CNayhyI5gUBKU51BG6auF8uPO1Ecb8B5H
 Y4WFTz2Ytlwfi66lkp49HpRjQu3wkDnZAn8PsYdOW7kQopAz1fZ0R5uy8PPRvSq8LE1ZF1pCs
 4Dny9O/LgQwPJBr1zdNgBzq/qJhkXEU8exEokyOrEb/2er6ls3nGL2G4bpys3W5UxpszpFqmz
 7liryMGmn+6HdeuX/fityKQwA8hpAsB57v1/3JEG3MlPKkhRjxlua0x6XgtjKMjuCbw1Qzkrm
 ZV3iw1n3Jh34NX4N2GD4PUm9uc9adH7UwdIcwMdLi0s/yQbt5i724AkYKtITMa4KQjr0iSV21
 c44H1zDFoIqjDPg9dXVA19DBR6wAdDaaAVMhWNUqKsmhGn76aRH84Xwgco6CtHcuJ6HdqfPFb
 qkttQHCZPGE99u3a8gNKr9nTAyKiPrLHAxPdsv0fOpMlUZZXYvrmw/HAToUftHj1kNIvRtciS
 l9b/CH+gaiFpnYoUvz4KU0B49M/aG5JGlO4VLZSQXmJqae4/MIrtJBEEQb3jKh0GS7YTctvY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292316>

Hi Ralf,

On Fri, 22 Apr 2016, Ralf Thielow wrote:

> Using the string-list API in function unsorted_string_list_lookup()
> makes the code more readable.  So let's do this.
> 
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  string-list.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Oh. I hoped for a reduction, not an increase.

> diff --git a/string-list.c b/string-list.c
> index 2a32a3f..8127e12 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -231,12 +231,13 @@ void string_list_sort(struct string_list *list)
>  struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
>  						     const char *string)
>  {
> -	int i;
> +	struct string_list_item *item;
>  	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
>  
> -	for (i = 0; i < list->nr; i++)
> -		if (!cmp(string, list->items[i].string))
> -			return list->items + i;
> +	for_each_string_list_item(item, list) {
> +		if (!cmp(string, item->string))
> +			return item;
> +	}
>  	return NULL;

If you drop the extra curly braces (thereby matching Git's coding style as
an additional bonus), at least the patch won't increase the number of
lines.

In any case, I like the simplification of the code.

Ciao,
Dscho
