From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] TIG: Fix to reinstate proper operation with no arguments
Date: Wed, 24 Jul 2013 08:29:37 -0400
Message-ID: <51EFC8B1.20405@gmail.com>
References: <1374123113-3889-1-git-send-email-n1xim.email@gmail.com> <51E7EDE3.4080205@gmail.com> <CAFuPQ1K=hWUSCEhaGsuW8PeoGQcj6AoPo61zUTDbjLE802h+7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Jul 24 14:35:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1yCS-0002px-Gh
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 14:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab3GXM3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 08:29:44 -0400
Received: from mail-vb0-f50.google.com ([209.85.212.50]:52618 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab3GXM3o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 08:29:44 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so6384524vbb.9
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=W9rTEShncRKCM0QxXNNtQUWhx17JZeo7bf/zMlYpE3w=;
        b=a00YVg9oMhVi/c+jwbf4bbz8sCGqWN9yMffOpzz+sw5U/RRI9vk4bLtG2KCT2Bbsee
         kbzf6pLHx9VugPKD5SSXegIBmOKh3UmZwGCYEgQEBU2prDSLJZJn0a8HXsr+8zUUOXdg
         L8HVSqTpioCcJLjuOKjC/JtR6WFLnFIq9CyNNeWFelLN3Nr7bEfufCahCf5jNpSCIDpm
         de3vhKcldYoWFW0mgAU+Ky5/KcOls4FplPYCUGdbJg9kkhVQtzZMqqWeNZW2CK2eU7jP
         hQmvpQXPZbYkQEkGKeyNN/MKjfe6axorLaJym/22zsrR7eOCgJvped+YAMB8qxXmgrwl
         xZhA==
X-Received: by 10.58.2.137 with SMTP id 9mr14216680veu.50.1374668981062;
        Wed, 24 Jul 2013 05:29:41 -0700 (PDT)
Received: from [192.168.0.37] (pool-70-16-204-240.man.east.myfairpoint.net. [70.16.204.240])
        by mx.google.com with ESMTPSA id kk6sm14310990vdb.5.2013.07.24.05.29.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Jul 2013 05:29:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120314 Thunderbird/3.1.20
In-Reply-To: <CAFuPQ1K=hWUSCEhaGsuW8PeoGQcj6AoPo61zUTDbjLE802h+7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231093>

On 07/19/2013 12:07 AM, Jonas Fonseca wrote:
> On Thu, Jul 18, 2013 at 9:30 AM, Drew Northup<n1xim.email@gmail.com>  wrote:
>>
>> Somehow this patch breaks the main view to not open the correct commit in diff view when<enter>  is pressed. Back to the debugger...
>
> Does this (possibly white-space damaged) patch work for you?

It does, but I prefer to actually fix the problem this highlights and 
not to paper it over. Patch V2 will be on the way shortly.

> diff --git a/tig.c b/tig.c
> index ba9ba98..74a2928 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -3104,7 +3104,7 @@ format_expand_arg(struct format_context *format,
> const char *name)
>   static bool
>   format_append_arg(struct format_context *format, const char
> ***dst_argv, const char *arg)
>   {
> - format->bufpos = 0;
> + format->buf[0] = format->bufpos = 0;
>
>    while (arg) {
>    char *next = strstr(arg, "%(");
>
>
> --
> Jonas Fonseca


-- 
--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
