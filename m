From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache: fix indentation in read_index_from
Date: Mon, 31 Aug 2015 12:29:43 -0700
Message-ID: <xmqqpp23uuhk.fsf@gitster.mtv.corp.google.com>
References: <1441046609-24181-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:29:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUm6-00046Y-7e
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbbHaT3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:29:46 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32982 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbbHaT3p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:29:45 -0400
Received: by paczk9 with SMTP id zk9so438439pac.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8iU9UMhps3izl+bfGjmyVHQQGgfzAsWqXwXlqvTP6KA=;
        b=dRt9ORAwYqR8bQyE49VAUsaRMMDtPWObO7V1XAMZZJcirxiUZ/kkxFBXEncbCMPgcF
         vLULRogGdyNKOF4XRHmGRVqf2EvfGA3Ur35CxVJ0IaP6bgW4BTLpxnT7Mbjma8/po6fK
         k4w4QF/Ky5lY9SbfJweQKN8raAG/G5LXYzUUpiWp8NitfAHNwnape6uq59r7kDPKZns4
         ZXaEExFRq/GSdREJmRjoPpxf3xvRJ8Zcyxd9YablTfKsXarHnRceyViVck71ehDf7kMD
         Qmf/ZiU+uq3XqYgXBObisdr0+29igatHo2WraPpettJz9zYT79IaQXe/VC+lzf8Wf+8s
         JiJA==
X-Received: by 10.66.124.133 with SMTP id mi5mr40189086pab.92.1441049385487;
        Mon, 31 Aug 2015 12:29:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id fg5sm15470980pdb.33.2015.08.31.12.29.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 12:29:44 -0700 (PDT)
In-Reply-To: <1441046609-24181-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 31 Aug 2015 11:43:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276923>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 89dbc08..a3df665 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1653,7 +1653,7 @@ int read_index_from(struct index_state *istate, const char *path)
>  		die("broken index, expect %s in %s, got %s",
>  		    sha1_to_hex(split_index->base_sha1),
>  		    git_path("sharedindex.%s",
> -				     sha1_to_hex(split_index->base_sha1)),
> +			     sha1_to_hex(split_index->base_sha1)),

We allow two styles in our codebase, (1) indent to align with
opening parenthesis, or (2) indent sufficiently deeper than the
first line with HT.  The original is neither, so in that sense
it is a good thing to do in the long run.

I'll queue it for this time, but in general, I'd prefer if people
refrained from touching code only for style fixes in an area that is
touched actively in topics, unless it is done inside a topic that
has to touch that area of the code in order to do something more
than style fixes.

Thanks.

>  		    sha1_to_hex(split_index->base->sha1));
>  	merge_base_index(istate);
>  	check_ce_order(istate);
