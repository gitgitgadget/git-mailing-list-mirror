From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] GSoC2014 Microproject rewrite finish_bulk_checkin()
Date: Thu, 27 Feb 2014 23:17:19 +0100
Message-ID: <530FB96F.5080406@alum.mit.edu>
References: <1393527740-16765-1-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 23:17:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ9Gh-0004O4-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 23:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbaB0WRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 17:17:23 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64298 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751573AbaB0WRX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 17:17:23 -0500
X-AuditID: 1207440d-f79d86d0000043db-86-530fb972d4f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 52.9E.17371.279BF035; Thu, 27 Feb 2014 17:17:22 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RMHJiM025619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 17:17:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393527740-16765-1-git-send-email-faiz.off93@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqFu0kz/YYO0KTov7G1+xWHRd6WZy
	YPLYOesuu8fnTXIBTFHcNkmJJWXBmel5+nYJ3BlNFw6yFjwXq5h08iVbA+NpoS5GTg4JAROJ
	OcumsEPYYhIX7q1nA7GFBC4zSuw8l9/FyAVkn2eS2PHhOStIgldAW+LKvi9gRSwCqhKNfRtZ
	QGw2AV2JRT3NTCC2qECwxOrLD1gg6gUlTs58AmaLCKhLzPnxBsjm4GAWEJfo/wcWFhbwkPj4
	9BUTxF4Xie2P+hlBSjgFXCXe/ZMHMSWAqnsag0AqmAV0JN71PWCGsOUltr+dwzyBUXAWkl2z
	kJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZI6PLuYPy/TuYQ
	owAHoxIP7wRP/mAh1sSy4srcQ4ySHExKorxPtwKF+JLyUyozEosz4otKc1KLDzFKcDArifD6
	zgHK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeNV2ADUKFqWmp1ak
	ZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2I3vhgYvSApHqC9SiDtvMUFiblAUYjWU4y6HLfb
	fn1iFGLJy89LlRLnZQcpEgApyijNg1sBS1SvGMWBPhbmlQap4gEmObhJr4CWMAEtOSrNA7Kk
	JBEhJdXAOLEgO7o26GmtV3L3xdMe3s0cb6+GGF0Km/f5nbPjcbG7syZnpX7f6V1yRP303g9/
	1Hf++nH4wOOvlx9V6PBm2ZZ0aZ0tKT2nd2fb88+brmjFHbedVKJXXmmXz32S9Yoi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242867>

On 02/27/2014 08:02 PM, Faiz Kothari wrote:
> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
> ---
>  bulk-checkin.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 118c625..feeff9f 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -23,7 +23,7 @@ static struct bulk_checkin_state {
>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  {
>  	unsigned char sha1[20];
> -	char packname[PATH_MAX];
> +	struct strbuf packname;
>  	int i;
>  
>  	if (!state->f)
> @@ -42,9 +42,11 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  					 state->offset);
>  		close(fd);
>  	}
> -
> -	sprintf(packname, "%s/pack/pack-", get_object_directory());
> -	finish_tmp_packfile(packname, state->pack_tmp_name,
> +	
> +	packname.len = packname.alloc = 64 + strlen(get_object_directory());
> +	packname.buf = (char *)malloc(packname.len * sizeof(char));
> +	sprintf(packname.buf, "%s/pack/pack-", get_object_directory());
> +	finish_tmp_packfile(packname.buf, state->pack_tmp_name,
>  			    state->written, state->nr_written,
>  			    &state->pack_idx_opts, sha1);
>  	for (i = 0; i < state->nr_written; i++)
> @@ -53,7 +55,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  clear_exit:
>  	free(state->written);
>  	memset(state, 0, sizeof(*state));
> -
> +	free(packname.buf);
>  	/* Make objects we just wrote available to ourselves */
>  	reprepare_packed_git();
>  }
> -- 1.7.9.5
>> Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for handling packname, and explain why this is useful.
>> Also check if the first argument of pack-write.c:finish_tmp_packfile() can be made const.
> 
> Adding 64 to strlen(get_object_directory()) to accomodate sha1_to_hex(sha1) and itself.
> Using the APIs for strbuf is giving me test failures(12/15) during t1050-large.sh 
> So, I used the malloc() and free() instead.

This is not OK.  I promise you, the strbuf API works correctly if it is
used correctly.  (And if it really *were* broken, you should fix the
problem or at least diagnose and document it rather than working around it.)

> Instead of having packname on stack and cause stackoverflow because of MAX_PATH ~ 4KB, have it on heap.
> Can have first parameter to pack-write.c:finish_tmp_packfile() as const because packname is not required to be modified.
> 
> I apologise for my two earlier patches not being in proper format. I have finally got it working properly. Will make sure,
> it does not happen again.

Almost.  This last set of comments should be moved to directly after the
"---" line.

But: please rather stick to *one* microproject and get it perfect, and
leave the others to other students.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
