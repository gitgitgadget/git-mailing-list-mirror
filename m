From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 7/9] bundle.c: convert leaf functions to struct object_id
Date: Tue, 06 May 2014 16:42:16 +0200
Message-ID: <5368F4C8.2060604@alum.mit.edu>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net> <1399147942-165308-8-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 20:50:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiUZ-0008Jm-TX
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469AbaEFOmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 10:42:22 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50255 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755110AbaEFOmV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2014 10:42:21 -0400
X-AuditID: 1207440d-f79d86d0000043db-6f-5368f4ccb5b9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 18.01.17371.CC4F8635; Tue,  6 May 2014 10:42:20 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97C6E.dip0.t-ipconnect.de [79.201.124.110])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s46EgHb1029574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 6 May 2014 10:42:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399147942-165308-8-git-send-email-sandals@crustytoothpaste.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqHvmS0awwa+pohZdV7qZLNpm/mBy
	YPJYfvMvk8fnTXIBTFHcNkmJJWXBmel5+nYJ3BlL/s9hL/guVPFmxgKWBsZPfF2MnBwSAiYS
	LUc7GSFsMYkL99azdTFycQgJXGaUOHzsDQuEc55J4v2f5SwgVbwC2hIzmnaB2SwCqhKP7pxg
	BbHZBHQlFvU0M3UxcnCICgRJ/DmrCFEuKHFy5hOwchEBL4n5j2aAlQsL+EqcPHebEWJ+P6PE
	s/Mb2UASnAJ+EotWLWEGmSMhIC7R0xgEEmYW0JF41/eAGcKWl9j+dg7zBEaBWUhWzEJSNgtJ
	2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIYHKu4Px/zqZQ4wCHIxK
	PLwdLzKChVgTy4orcw8xSnIwKYnyTvgMFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCe+Y9UI43
	JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMF7DWSoYFFqempFWmZOCUKa
	iYMTZDiXlEhxal5KalFiaUlGPChS44uBsQqS4gHaexWknbe4IDEXKArReopRl+NCw4oWJiGW
	vPy8VClx3v2fgIoEQIoySvPgVsDS0itGcaCPhXnvgIziAaY0uEmvgJYwAS3hMk4HWVKSiJCS
	amC0qM9hmHZI+O3bm9tLBUOStp9Zo3fqzF/HXTO3Cemfs1VY4a43M1REOD51Fl9vq7jR//a2
	Bac755r/lNnvuGfj2rKaGa3f+Q4yiDztu7Xo1HfFfceZO44vuvp4z4odksl3rbiE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248212>

On 05/03/2014 10:12 PM, brian m. carlson wrote:
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  bundle.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/bundle.c b/bundle.c
> index 1222952..798ba28 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -11,11 +11,11 @@
>  
>  static const char bundle_signature[] = "# v2 git bundle\n";
>  
> -static void add_to_ref_list(const unsigned char *sha1, const char *name,
> +static void add_to_ref_list(const struct object_id *sha1, const char *name,
>  		struct ref_list *list)
>  {
>  	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
> -	hashcpy(list->list[list->nr].sha1, sha1);
> +	hashcpy(list->list[list->nr].sha1, sha1->oid);
>  	list->list[list->nr].name = xstrdup(name);
>  	list->nr++;
>  }
> @@ -39,7 +39,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
>  	/* The bundle header ends with an empty line */
>  	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
>  	       buf.len && buf.buf[0] != '\n') {
> -		unsigned char sha1[20];
> +		struct object_id sha1;
>  		int is_prereq = 0;
>  
>  		if (*buf.buf == '-') {
> @@ -53,9 +53,9 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
>  		 * Prerequisites have object name that is optionally
>  		 * followed by SP and subject line.
>  		 */
> -		if (get_sha1_hex(buf.buf, sha1) ||
> -		    (buf.len > 40 && !isspace(buf.buf[40])) ||
> -		    (!is_prereq && buf.len <= 40)) {
> +		if (get_sha1_hex(buf.buf, sha1.oid) ||
> +		    (buf.len > GIT_OID_HEXSZ && !isspace(buf.buf[GIT_OID_HEXSZ])) ||
> +		    (!is_prereq && buf.len <= GIT_OID_HEXSZ)) {
>  			if (report_path)
>  				error(_("unrecognized header: %s%s (%d)"),
>  				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
> @@ -63,9 +63,9 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
>  			break;
>  		} else {
>  			if (is_prereq)
> -				add_to_ref_list(sha1, "", &header->prerequisites);
> +				add_to_ref_list(&sha1, "", &header->prerequisites);
>  			else
> -				add_to_ref_list(sha1, buf.buf + 41, &header->references);
> +				add_to_ref_list(&sha1, buf.buf + 41, &header->references);

I think that 41 here is GIT_OID_HEXSZ + 1.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
