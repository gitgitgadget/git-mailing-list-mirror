From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] Fix two unused variable warnings in gcc 4.6
Date: Mon, 28 Mar 2011 06:05:51 -0700
Message-ID: <92140045-86C2-4525-A867-7654D3FE53FB@gmail.com>
References: <1301275939-17018-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 15:06:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4C9R-0004bE-CL
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 15:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab1C1NG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 09:06:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36801 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab1C1NG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 09:06:27 -0400
Received: by yxs7 with SMTP id 7so1153045yxs.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=WlADY4hnuVYW1SGjzv0T9jXrep9XdOhgIz71w3majLw=;
        b=AZspokWuX4qJpRsgDSPvQYcmuogWr3smqaoXL9JN2EkpdXCqSNTeOfV6NSQndAERgQ
         18M6sai+o21kvbNbN2HG1c6fI/hPqS1in6wsNFBWt1OK3seX6bv8Jfn9+JOu27xv5SeR
         7YJc+RS4vjEx4XzzBKEOZzfCYo7yRWL8fc5fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=GxqlFfb2tvcXxxZc5suOclXfcAKqYSpAPINFKxaeixjiZb0SUjh/05j78o3Bz+w5ub
         k36mw+yxGTvub6X27yKO7fBEMP5bUInrbXgVIEg5JV2E7OcIT8LyY0G/kr07odbgjydr
         VH78nRSdgnXRxSqzQXY0VxGjMhlQVpeV116wo=
Received: by 10.43.57.80 with SMTP id wf16mr6115743icb.332.1301317559277;
        Mon, 28 Mar 2011 06:05:59 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id he40sm2945747ibb.50.2011.03.28.06.05.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 06:05:55 -0700 (PDT)
In-Reply-To: <1301275939-17018-1-git-send-email-dpmcgee@gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170124>

On Mar 27, 2011, at 6:32 PM, Dan McGee wrote:

> diff --git a/http-fetch.c b/http-fetch.c
> index 923904f..3af4c71 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -8,7 +8,6 @@ static const char http_fetch_usage[] = "git http- 
> fetch "
>
> int main(int argc, const char **argv)
> {
> -	const char *prefix;
> 	struct walker *walker;
> 	int commits_on_stdin = 0;
> 	int commits;
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 8e82a8b..af13150 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -356,7 +356,6 @@ static void  
> make_room_for_directories_of_df_conflicts(struct merge_options *o,
> 	 */
> 	const char *last_file = NULL;
> 	int last_len = 0;
> -	struct stage_data *last_e;
> 	int i;
>
> 	for (i = 0; i < entries->nr; i++) {
> @@ -961,7 +959,6 @@ static int process_renames(struct merge_options  
> *o,
> 	}
>
> 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
> -		char *src;
> 		struct string_list *renames1, *renames2Dst;
> 		struct rename *ren1 = NULL, *ren2 = NULL;
> 		const char *branch1, *branch2;

Looks like three unused variables, not two.

Josh
