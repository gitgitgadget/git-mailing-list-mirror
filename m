From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: [PATCH] git-remote.txt: describe behavior without --tags and
 --no-tags
Date: Mon, 02 Mar 2015 15:56:17 +0100
Message-ID: <54F47A11.9090701@gmail.com>
References: <54F431E8.3050009@gmail.com> <932c9cd452718ad5e88677fc90985ef7fafd5078.1425301543.git.git@drmicha.warpmail.net> <54F46758.4070207@gmail.com> <54F47841.6060009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 15:56:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSRls-000636-Kc
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 15:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbbCBO4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 09:56:25 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:42933 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbbCBO4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 09:56:23 -0500
Received: by wghl2 with SMTP id l2so33967085wgh.9
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 06:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=YWmTBebAp8e+AjEgM8XIje0adFtt1hXfl8sttX1QlhA=;
        b=uqnVPKBDURwI9ukCvGtIgz3MTFy4vYq7LfeohWd8VvGWwopOHOIAutTX/wL9Xv+vsH
         TjkrFjUewpK3PX99iYVsmVwqWUmZpy3A5thw8Pj3OqVe+rCETmoRnJF04+vh6S4EW6zd
         FWwuOnZzL7WeZBnMpzqWduHv3/WiUOhJv4fs8H264WBgI6yKOhMMvkxnTSmc4JoYS/Sb
         uHy+a1DNr8pbSbW/AlW5/yExzinjTf9lX1EC6fShZtF67lK453TuomaygyAX73lCpSx2
         ODX/2Jl1xVf1cxRsaIFdFWh7ePCp+L6TkDI5JOuNXzgky0+Ely36rflBNUKwzGfZByCK
         Eeiw==
X-Received: by 10.194.61.100 with SMTP id o4mr60084418wjr.28.1425308180401;
        Mon, 02 Mar 2015 06:56:20 -0800 (PST)
Received: from [192.168.0.17] (gem13-1-78-228-1-221.fbx.proxad.net. [78.228.1.221])
        by mx.google.com with ESMTPSA id gf11sm1257264wic.18.2015.03.02.06.56.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 06:56:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54F47841.6060009@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264600>

On 03/02/2015 03:48 PM, Michael J Gruber wrote:
> Francis Moreau venit, vidit, dixit 02.03.2015 14:36:
>> Hi,
>>
>> On 03/02/2015 02:08 PM, Michael J Gruber wrote:
>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>> ---
>>>  Documentation/git-remote.txt | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
>>> index a77607b..f3f6f0d 100644
>>> --- a/Documentation/git-remote.txt
>>> +++ b/Documentation/git-remote.txt
>>> @@ -56,7 +56,10 @@ With `--tags` option, `git fetch <name>` imports every tag from the
>>>  remote repository.
>>>  +
>>>  With `--no-tags` option, `git fetch <name>` does not import tags from
>>>  the remote repository.
>>> ++
>>> +By default, only tags on fetched branches are imported
>>> +(see linkgit:git-fetch[1]).
>>>  +
>>
>> So the default is neither --no-tags nor --tags ?
>>
>> Thanks.
>>
> 
> By default, only tags on fetched branches are imported. That is: When
> the fetch is done, all tags are imported that point to commits that are
> reachable from refs that you are fetching, in short: "tags on fetched
> branches". That is in between "none" (--no-tags) and "all" (--tags).
> 

just my 2 cents, I would find easier to read it like this:

-----
By default, only tags on fetched branches are imported. This can be
changed by the --tags and --no-tags options.

With `--tags` option, `git fetch <name>` imports every tag from the
remote repository (including not reachable tags from fetched refs).

With `--no-tags` option, `git fetch <name>` does not import tags from
the remote repository.
-----

Thanks.
