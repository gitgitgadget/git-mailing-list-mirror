From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/6] strbuf: add string-chomping functions
Date: Tue, 29 Jan 2013 11:15:34 +0100
Message-ID: <5107A146.4000309@alum.mit.edu>
References: <20130129091434.GA6975@sigill.intra.peff.net> <20130129091540.GB9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 11:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U08ET-0006pa-RB
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 11:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab3A2KPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 05:15:40 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:43150 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753343Ab3A2KPj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2013 05:15:39 -0500
X-AuditID: 1207440c-b7fde6d00000088a-17-5107a14a2a46
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 64.59.02186.A41A7015; Tue, 29 Jan 2013 05:15:38 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0TAFaLw002016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 29 Jan 2013 05:15:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130129091540.GB9999@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqOu1kD3Q4McEaYuuK91MFt1T3jJa
	/GjpYbaYf2giqwOLx85Zd9k9nvXuYfT4c34Pq8fnTXIBLFHcNkmJJWXBmel5+nYJ3Blzr79m
	LFjJX/Fx3Re2BsYFPF2MnBwSAiYSbz4+ZIewxSQu3FvPBmILCVxmlDiw3aaLkQvIPs4k8fh4
	N1gRr4C2xOFT+4GKODhYBFQlWmYyg4TZBHQlFvU0M4HYogJhEr2vzzFClAtKnJz5hAXEFhGQ
	lfh+eCNYnFkgU2LjvyVgvcICdhLbz99nhNibLvFm6lOwOKeAlcTOJXsYQVYxC6hLrJ8nBNEq
	L7H97RzmCYwCs5BsmIVQNQtJ1QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuoZ6uZkleqkp
	pZsYIaHMs4Px2zqZQ4wCHIxKPLzNC9gChVgTy4orcw8xSnIwKYnyZsxlDxTiS8pPqcxILM6I
	LyrNSS0+xCjBwawkwutaC5TjTUmsrEotyodJSXOwKInzqi5R9wN6LLEkNTs1tSC1CCYrw8Gh
	JMErsgCoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4Uo/HFwCgFSfEA7RUEaect
	LkjMBYpCtJ5iNObY/6T9OSPH9t9AUoglLz8vVUqc99N8oFIBkNKM0jy4RbAk9opRHOhvYd7H
	IFU8wAQIN+8V0ComoFVGbWCrShIRUlINjA2N15Zc3NnUcvJN77H7u+RLkyzXPmRrWHGVuyXQ
	ZlkUd2zv9JhpLt4TnvZtsmAyjpBVl/pu0vmltN36zSrVnLaQ7kcdcRyy237YF0+I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214923>

On 01/29/2013 10:15 AM, Jeff King wrote:
> Sometimes it is handy to cut a trailing string off the end
> of a strbuf (e.g., a file extension). These helper functions
> make it a one-liner.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  strbuf.c | 11 +++++++++++
>  strbuf.h |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/strbuf.c b/strbuf.c
> index 9a373be..8199ced 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -106,6 +106,17 @@ void strbuf_ltrim(struct strbuf *sb)
>  	sb->buf[sb->len] = '\0';
>  }
>  
> +void strbuf_chompmem(struct strbuf *sb, const void *data, size_t len)
> +{
> +	if (sb->len >= len && !memcmp(data, sb->buf + sb->len - len, len))
> +		strbuf_setlen(sb, sb->len - len);
> +}
> +
> +void strbuf_chompstr(struct strbuf *sb, const char *str)
> +{
> +	strbuf_chompmem(sb, str, strlen(str));
> +}
> +
>  struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>  				 int terminator, int max)
>  {
> diff --git a/strbuf.h b/strbuf.h
> index ecae4e2..3aeb815 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -42,6 +42,8 @@ extern void strbuf_ltrim(struct strbuf *);
>  extern void strbuf_trim(struct strbuf *);
>  extern void strbuf_rtrim(struct strbuf *);
>  extern void strbuf_ltrim(struct strbuf *);
> +extern void strbuf_chompmem(struct strbuf *, const void *, size_t);
> +extern void strbuf_chompstr(struct strbuf *, const char *);
>  extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
>  
>  /*
> 

It might be handy to have these functions return true/false based on
whether the suffix was actually found.

Please document the new functions in
Documentation/technical/api-strbuf.txt.  Personally I would also
advocate a "docstring" in the header file, but obviously that preference
is the exception rather than the rule in the git project :-(

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
