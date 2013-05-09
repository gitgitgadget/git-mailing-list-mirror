From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 9 May 2013 14:23:04 -0500
Message-ID: <CAMP44s3XsVb6k1Oynw_y7yvV1fWaSDGquFoRNMcaN0yGD5_UNQ@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
	<7vbo8k9exd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 21:23:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaWQr-00013Z-NL
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 21:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab3EITXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 15:23:07 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:65195 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab3EITXG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 15:23:06 -0400
Received: by mail-la0-f46.google.com with SMTP id fk20so3231918lab.19
        for <git@vger.kernel.org>; Thu, 09 May 2013 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=T5nXi7npY1ULVwZsnKG2TaPA5QnK2CLwI83I9ZAgFyk=;
        b=lQX9+zZOXvZEDYsRHO5dlQKKW6yQMY/rzEuwKcm23UcdVyGhWGX++9oEv3zu+kp9Lt
         NPC9Kd1EtQMSlQ6P6Gg3a4LnEgIu+XMgHGqUAiZiYzXvtdRAvx4HpUstGopoU80M/mqB
         8zV4xdrdOi5cAUI3m1onMKXIZs8K7ZVV03kAwOf2qSsGLuv4VePESDJ+ZlqeVtlZRKIM
         P3YqejSde1BWIhb+OrmP2FPYzZeAHEnvK0HHTDZWO2SJuuvw3paFwcEAcL0RFlweHfHY
         MzzZ55Jfe0YMbBHo0Ve/Rzi3tePFsrHCGNHB62/yCT/qY1Cai9qAk9wllFYdJYhrZQ14
         Fb9Q==
X-Received: by 10.112.145.72 with SMTP id ss8mr6184623lbb.12.1368127384336;
 Thu, 09 May 2013 12:23:04 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 12:23:04 -0700 (PDT)
In-Reply-To: <7vbo8k9exd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223774>

On Thu, May 9, 2013 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>>         if (!author)
>>>> -               die ("Could not find author in commit %s",
>>>> +               die("Could not find author in commit %s",
>>>>                      sha1_to_hex(commit->object.sha1));
>>>
>>> It looks like your simple replace didn't account for calls with
>>> multiple lines.  Now the remaining lines don't line up.
>>> :-)  There's several more places like this in the patch.
>>
>> AFAIK neither the git or the Linux code-style specify how multiple
>> lines with open parenthesis should align.
>
> Then the usual "follow the style of surrounding code" rule would
> apply, no?

The surrounding code has all the open parentheses wrong for these
functions, that doesn't mean the surrounding code is correct.

> It is clear that the original wants to align the opening
> dq of "Could..."  and 's' at the beginning of sha1_to_hex().
>
> Why is it so hard for you to say "Good eyes, thanks"?

Because I didn't miss it, it was deliberate from my side, if nobody
can be bothered to add a rule on the coding style guidelines, why
should I bother? As I said, this pops up from time to time in Linux
mailing lists[1], but at the end of the day the CodingStyle doesn't
specify what should be the way to align these, so any discussion about
whether they are properly aligned or not is futile.

If it was up to me, I would use the alignment that makes more sense,
which is to align two tabs always, this way, each time somebody
decides to change the first line, the rest of the lines don't need to
change, which is something I see through the CodingStyle; try to avoid
a style that would generate bigger diffs.

But if I did such alignment I might create even more discussion, so I
deliberately decided not to change the alignment at all, which still
leaves the code in accordance with the CodingStyle.

[1] http://article.gmane.org/gmane.linux.kernel/1407801

-- 
Felipe Contreras
