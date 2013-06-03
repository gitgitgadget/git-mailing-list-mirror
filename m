From: Devin Rhode <drhode@amobee.com>
Subject: Re: info/exclude not working
Date: Mon, 3 Jun 2013 13:44:06 -0700
Message-ID: <CALy29p+pdXSLmMOGcJ+YcWe4TDDUsE3=Shg=jNp-=Nhw+OkORg@mail.gmail.com>
References: <CALy29pLQ-LWg0knzbzLoQfwSt+df_b3tNdWk7OeSN-CjkJhfsQ@mail.gmail.com>
 <20130603203226.GA23224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Devin Rhode <drhode@amobee.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 03 22:44:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbcH-0001cz-N5
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757776Ab3FCUo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:44:29 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:58708 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757635Ab3FCUo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:44:28 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so4301453lbi.18
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adjitsu.com; s=google;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=s0z5XjUqz3yzFbJlaaaemdnhj8IcWnnzJpQ+0DHff/8=;
        b=GoDZphIOEANmvIhkEC3PqudaFAhM38XaDyoU3VopLz+dFc8tnqU48JIT4QHuhwXabU
         5tZkY1QOQ9gBjNInxIiGDaUHh/Bqv6MiATcEridOGBd/GUdow7BCjmODcS7a5SRjMMQc
         VzkzTa9Rzrs4E67Ix87Y8LZBN/oK6jmQEFq5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=s0z5XjUqz3yzFbJlaaaemdnhj8IcWnnzJpQ+0DHff/8=;
        b=Rmv4HENJdf/LTSmRWTY8yguuOM9TzYyvGzlaC72uwZb3nRL5Ett1TKzgfJZ8Wf2+Lh
         3LaFOdp5UsA1e5peSYwZ06/7+u0pPOSx2+P7n/cZho45EkbKAgaT+woj1e0U7O7rYy9b
         GPpCVpVqjss/U/NByEk+8vezJE28k3kbqFpAsqEIh0DdiA6Iz54zi9QaLyU7trZJ6RFj
         J1KKejUBZsVGo6GXzNnuCTKKSMvzWQaZ9VqQT02FcgqMv0IxmdEU/SmACEdXOSzEumsy
         oHqChvoMMA6aX+t/sxrPAhtOEybK7QyQI+QMSyK20kGRFH9uEnIfE8k0SV9hDs79MG+F
         +OjQ==
X-Received: by 10.152.22.199 with SMTP id g7mr10929318laf.20.1370292266528;
 Mon, 03 Jun 2013 13:44:26 -0700 (PDT)
Received: by 10.112.167.228 with HTTP; Mon, 3 Jun 2013 13:44:06 -0700 (PDT)
X-Originating-IP: [50.76.62.185]
In-Reply-To: <20130603203226.GA23224@sigill.intra.peff.net>
X-Google-Sender-Auth: gO8idB15XF6Z1aoeGwAN-FfyByQ
X-Gm-Message-State: ALoCoQlHERbp6uIMlgkl2jH7+gYYKzMnYxH+jjN7FZ5l4Jfw6PNdFU6cJraOuomgajvIudMm3bLp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226286>

I wouldn't worry too much about this use case, we have a pretty lame workflow

On Mon, Jun 3, 2013 at 1:32 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 03, 2013 at 01:04:39PM -0700, Devin Rhode wrote:
>
>> MBP:dish devin$ cat ../.git/info/exclude
>> # git ls-files --others --exclude-from=.git/info/exclude
>> # Lines that start with '#' are comments.
>> # For a project mostly in C, the following would be a good set of
>> # exclude patterns (uncomment them if you want to use them):
>> # *.[oa]
>> # *~
>> models/CAFE.json
>> dish/models/CAFE.json
>>
>> MBP:dish devin$ git status
>> # On branch master
>> # Changes not staged for commit:
>> #   (use "git add <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working directory)
>> #
>> # modified:   models/CAFE.json ***Shouldn't appear
>
> The exclude mechanism does not mean "do not ever look at this file". It
> means "when you are adding untracked files, do not include this one".
> Somebody has already added the file to the repository before your
> exclude was in place, so it is a tracked file.
>
> There is currently no official mechanism in git to do what you want
> (there are some hacks, but they include many pitfalls).
>
> -Peff
>
>
