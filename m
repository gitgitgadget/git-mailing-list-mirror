From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 01:20:04 -0500
Message-ID: <CAMP44s2+jqj4PCMG6vsA5keymoXanpW+Lhf8+yjx7S0oGWwdiQ@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<CAMP44s35HcjZ0sMjbOxHZt96v8S8eEFF+Y9JF_K9FKnFe-S9Xg@mail.gmail.com>
	<CACsJy8BTj8Vb5dyJJXhAtQ4soUTAAshKATYB+f9X2p1n6VFHMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 08:20:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX3vC-0003YD-2V
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 08:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab3D3GUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 02:20:07 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:48968 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab3D3GUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 02:20:06 -0400
Received: by mail-la0-f47.google.com with SMTP id em20so146588lab.34
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=T1Ou6z1rCbKcJhnHjhaU65OcTC4iD4jLz8lU5lRdVcE=;
        b=0h6tGx7CYOWodNhHXbLeI+T6i2byvR0eoVy1wvxtN+YLMEdrr3eHiX6O5af7UBUjY1
         B49wVFTbzSY+feLkV6u8DGqdBaAqy/Ubkuiy7hX9QKIJcgO5C0LN1wRr5SCGfhCym4kX
         us/wVzmIeMsGhB6FNJ+eoqfF4U9spTPzFm70xywnFjVoXzzCcC/WyIMg6fdxQH1ZWbEA
         uEWmYbaPFg8/uzjO4rGAYhi0gUHPu3t+zkL2kf3oB933eH5J4HYTRpzTMP63ZviquvvZ
         7eaP0C45KDHG2lPCoOQsc5gLr7NhCKNziVN6poxG2JUcmnPFmxwV4TjUUU6cJB6SUEbv
         FoZg==
X-Received: by 10.112.163.6 with SMTP id ye6mr27866308lbb.59.1367302804504;
 Mon, 29 Apr 2013 23:20:04 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 29 Apr 2013 23:20:04 -0700 (PDT)
In-Reply-To: <CACsJy8BTj8Vb5dyJJXhAtQ4soUTAAshKATYB+f9X2p1n6VFHMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222913>

On Tue, Apr 30, 2013 at 1:17 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Apr 30, 2013 at 1:10 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Apr 30, 2013 at 12:54 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>>>> use 'git show @~1', and all that goody goodness.
>>>
>>> I like this. I haven't spent a lot of time on thinking about
>>> ambiguation. But I think we're safe there. '@' is not overloaded much
>>> like ':', '^' or '~'.
>>>
>>>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>>>> 'master@'.
>>>
>>> I'm a bit reluctant to this. It looks like incomplete syntax to me as
>>> '@' has always been followed by '{'. Can we have the lone '@' candy
>>> but reject master@ and HEAD@? There's no actual gain in writing
>>> master@ vs master@{0}.
>>
>> That's what I tried first, but it just didn't feel elegant to have one
>> check for this case only. foo@ does follow naturally, and it doesn't
>> hurt.
>>
>>>> +'@'::
>>>> +  '@' alone is a shortcut for 'HEAD'
>>>> +
>>>
>>> And this does not explain about HEAD@ or master@. But because I prefer
>>> the candy part only. This documentation part looks good :)
>>
>> Yeah, there's no point in documenting things that are not useful for
>> the user. The fact that HEAD@ is translated to HEAD is just an
>> implementation detail.
>
> Exactly. As it's implementation detail, it should not be exposed to
> user as "huh?" moments when they type "HEAD@". I'm may be paranoid,
> but if some user finds it nice (or just different) to try master@ in
> scripts, then we change implementation details and master@ no longer
> works, people could be upset. Undefined behavior syntax should be kept
> to minimum. And to answer your other mail regarding the harmlessness
> of @{-1}@, I'd rather pay some extra code than leave some loose ends
> like that.

I don't see it as a loose end.

--- a/sha1_name.c
+++ b/sha1_name.c
@@ -443,8 +443,11 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
                return 0;

        empty_at = len && str[len-1] == '@';
-       if (empty_at)
+       if (empty_at) {
+               reflog_len = 0;
                len = len-1;
+               goto next;
+       }

        /* basic@{time or number or -number} format to query ref-log */
        reflog_len = at = 0;
@@ -460,6 +463,7 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
                }
        }

+next:

-- 
Felipe Contreras
