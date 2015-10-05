From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 7/9] ref-filter: make %(upstream:track) prints "[gone]"
 for invalid upstreams
Date: Mon, 5 Oct 2015 13:19:43 +0530
Message-ID: <CAOLa=ZRF6tVg6DSjXZb65pJz_D5_H5aix7JFx9pSW49iyFN+iQ@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-8-git-send-email-Karthik.188@gmail.com> <vpqio6o9mu1.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 05 09:50:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj0XT-0007vR-P4
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 09:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbbJEHuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 03:50:23 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34312 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbbJEHuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 03:50:13 -0400
Received: by vkat63 with SMTP id t63so91083172vka.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JvulJBXyOhUfazpl+xN0YI9/nnAYo7XVW0r4X+ZiBcI=;
        b=g0/8M8LrFvrGEsVA6pHrqw5wHQJszTPQCQ7NjNcFEnp4JBeaQalTCUy27XeU0IZU5k
         1FWdWGxulbrjbYy9UiNHHQEARDK2tLyLlKGp6ZRETlamDm4/gcKUF2LLFGGrlBCRu6dt
         Xb+0+2YX3eHfg9H09U7A6j+WIQCp3rtyJd3O8s5FD4GQfC7eck3HmiQLFLJbXfaFhglP
         asp8hgUijarmCxbjtkkIqCbsq2XOC9caLvlhlRCeZ50Vy0+nZttG9aEnoIj2YyWEXTwg
         u4DYiSZwMFKosxgEk8OClWI/BeuFOFgaVsCemy1HzVz3kOBe9LYTY7fhXrgs/Sw5CuOG
         eXLA==
X-Received: by 10.31.161.142 with SMTP id k136mr18792709vke.17.1444031413027;
 Mon, 05 Oct 2015 00:50:13 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 5 Oct 2015 00:49:43 -0700 (PDT)
In-Reply-To: <vpqio6o9mu1.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279041>

On Sat, Oct 3, 2015 at 5:38 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 099acd6..48b06e3 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1133,8 +1133,10 @@ static void populate_value(struct ref_array_item *ref)
>>                               char buf[40];
>>
>>                               if (stat_tracking_info(branch, &num_ours,
>> -                                                    &num_theirs, NULL))
>> +                                                    &num_theirs, NULL)) {
>> +                                     v->s = xstrdup("[gone]");
>
> I think just "[gone]" without the xstrdup is OK, and avoids leaking one
> string.

Will do.

-- 
Regards,
Karthik Nayak
