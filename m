From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 02/43] refs: make repack_without_refs and is_branch
 public
Date: Mon, 05 Oct 2015 06:34:33 +0200
Message-ID: <5611FDD9.1050405@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 06:42:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZixbU-00038l-PL
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 06:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbbJEElw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 00:41:52 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:60974 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750793AbbJEElw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 00:41:52 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2015 00:41:52 EDT
X-AuditID: 1207440c-f79e16d000002a6e-64-5611fddb7b7b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A9.EC.10862.BDDF1165; Mon,  5 Oct 2015 00:34:35 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t954YYTE022796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 00:34:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-3-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqHv7r2CYQfNNS4v5m04wWnRd6Way
	+DehxoHZY8GmUo8Fz++ze3zeJBfAHMVtk5RYUhacmZ6nb5fAnTH12HLWgiecFbNuv2JtYHzL
	3sXIySEhYCKx7/wMNghbTOLCvfVANheHkMBlRokTC1qgnHNMEjNOHmABqeIV0JaYuf0OM4jN
	IqAq8WfGQVYQm01AV2JRTzMTiC0qECSxYvkLRoh6QYmTM5+A9YoIOEhc3nUUrJdZQFNi04YX
	YL3CAsESdztbmCGWtTJKHGqbCVbEKeAp0bz2PFSDnsSO679YIWx5ie1v5zBPYBSYhWTHLCRl
	s5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokRErw8Oxi/rZM5xCjA
	wajEwyuRJBgmxJpYVlyZe4hRkoNJSZQ3VA0oxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3+zug
	HG9KYmVValE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJgrf7D1CjYFFqempFWmZO
	CUKaiYMTZDiXlEhxal5KalFiaUlGPCha44uB8QqS4gHaOxGknbe4IDEXKArReopRUUqctwIk
	IQCSyCjNgxsLS0mvGMWBvhTmzQep4gGmM7juV0CDmYAGLzDkAxlckoiQkmpglJuh+36mjIRZ
	meGJ3zPErFv2sH7aoyHtsiL19ybB5K1fU9a1PpIS5sirMxOunFqRVHn9mcCNJ5yiC2cuWvs3
	R89iSuqzJeIax/cbzNeL/c+mP1HalLP9wwe/ptMp0+1ff19YWCcz9X1yc6dWo+Wr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279035>

On 09/29/2015 12:01 AM, David Turner wrote:
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.c |  9 +--------
>  refs.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index ce551e9..2741cc5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2826,14 +2826,7 @@ int pack_refs(unsigned int flags)
>  	return 0;
>  }
>  
> -/*
> - * Rewrite the packed-refs file, omitting any refs listed in
> - * 'refnames'. On error, leave packed-refs unchanged, write an error
> - * message to 'err', and return a nonzero value.
> - *
> - * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
> - */
> -static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
> +int repack_without_refs(struct string_list *refnames, struct strbuf *err)

I looked for the corresponding change to remove `static` from
is_branch(). Apparently that function already had external linkage, even
though it was not listed in the header file. As a convenience to readers
you might note that peculiarity in the commit message.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
