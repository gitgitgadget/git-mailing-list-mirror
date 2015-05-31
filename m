From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make
 them public
Date: Sun, 31 May 2015 10:11:51 +0200
Message-ID: <CAP8UFD1TTMfruCE-+GT-LzhK5C9LorStPbn64tZ-hhAkC=8Bdw@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-6-git-send-email-karthik.188@gmail.com>
	<CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:12:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyyLg-0005Dw-GN
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172AbbEaIL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:11:56 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34267 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbEaILw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 04:11:52 -0400
Received: by wgv5 with SMTP id 5so91764820wgv.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ovwQWVeFuaXUE96G7Zdun/KvwrdrFGAIR99Z0heh0O4=;
        b=zWyf3jMDTWXqwXZN8dG2UyXHWCmqyT3YocL7+XFY6V47SJ35KX+Y+f/eSTJ/ALJvQ0
         JpPIDloqcS8FCeDbeqToYFoLGGZeRMwfz8qbufgx6HRVLiVOk71GSj+KVivbVglTYsrO
         5l0xlSkBfWXqzn9Vm4SCdB8qBmoNwY+45POvBJZKKCmHjhqsLbDEM2uujb5Yrgn5Pgd+
         nBS7vE/Cr+iCmkDt4LarPook83Lo2uDDLr1cWKC7RubHuXzHvw5k9TTUpYZd1JX1xjrI
         AoaDb8LpP4oTqWft21xF1qjGid6pK3i69UlOE17PZ2lBWxWz4pR211Gj1EfpyokL37N9
         a/gQ==
X-Received: by 10.181.13.198 with SMTP id fa6mr10609618wid.41.1433059911213;
 Sun, 31 May 2015 01:11:51 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 31 May 2015 01:11:51 -0700 (PDT)
In-Reply-To: <CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270318>

On Sun, May 31, 2015 at 10:04 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, May 30, 2015 at 7:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> -static void sort_refs(struct ref_sort *sort, struct ref_array *array)
>> +void sort_ref_array(struct ref_sort *sort, struct ref_array *array)
>
> It is probably better to call the above function ref_array_sort()...
>
> [...]
>
>> -static struct ref_sort *default_sort(void)
>> +/*  If no sorting option is given, use refname to sort as default */
>> +struct ref_sort *ref_default_sort(void)
>
> ... especially since you call the above ref_default_sort()...
>
>> -static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
>> +int opt_parse_ref_sort(const struct option *opt, const char *arg, int unset)
>
> ... and the above opt_parse_sort().

After saying that I realize that these two other functions are not
doing the same thing.
This might suggest that they are not named very well as well.
