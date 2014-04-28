From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 15:33:40 +0530
Message-ID: <535E277C.9070502@gmail.com>
References: <535C47BF.2070805@game-point.net>	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>	<535D4085.4040707@game-point.net> <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com> <535DBD35.4080507@gmail.com> <535E16D4.9040509@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 12:03:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeiPf-0002Ko-8Y
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbaD1KDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 06:03:47 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:39606 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbaD1KDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:03:46 -0400
Received: by mail-pd0-f178.google.com with SMTP id fp1so3387197pdb.23
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ka0OUM0nKwh2CybIxWA0pXjDJHSWnWkAq1jENvcwm/8=;
        b=TDi8/ecrOEc0XRKNX2AsSptZEBOlFuL3nBjr6272nwhxP7sQLA2Mm+suMhSp6015tl
         0PWmOt7ekzK9gHU7E0nbJrAwdId4BWRm+5Ry7pOq3vgvxtW49LzB9/x02vTjbBnlVQh8
         zD1KceYkfpRabl16BdM/T80twRjNOMHaWRD3fv5czjw26w9Cwd+ljYwMIxfSmlXTo8XY
         NpiPolWIBVq/1o3+rg8IaMLvDbgV51XI+tsLanXmVKbfLRh63ZKw8m6XpckGTBOx+lbC
         ltIc6/1NvmY/B0V7v5lA4y244K+IwpG4vcN97HXInMdvXXEtEBW068VBDod5E9oi97uQ
         43zg==
X-Received: by 10.68.164.229 with SMTP id yt5mr28075566pbb.28.1398679425913;
        Mon, 28 Apr 2014 03:03:45 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id sy2sm33895457pbc.28.2014.04.28.03.03.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:03:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <535E16D4.9040509@game-point.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247266>

On 04/28/2014 02:22 PM, Jeremy Morton wrote:
> On 28/04/2014 03:30, Sitaram Chamarty wrote:
>> On 04/28/2014 01:03 AM, Johan Herland wrote:
>>> Yeah, sure. Author and Date (and Committer, for that matter) is just
>>> metadata, and the current branch name is simply just another kind of
>>> metadata. All of them are more-or-less free-form text fields, and off
>>
>> no they're not. In strictly controlled environments they form part of
>> the audit record for the source code.
>>
>> Yes they can be faked (explicitly), but -- again in strictly controlled
>> environments -- that can be limited to "before it was first pushed".
>
> Why these specific headers as part of the audit record, though?
> Aren't you just arbitrarily defining them as part of the audit record?

"who did it" and "when did they do it" are a fair bit more central to
"how did we get here" (viz., the SHA1 of the top commit, if you will)
than "what branch was this commit born in (or similar)".

Here's an example from somewhere I worked (indirectly) in the late 90s.
Nasty bug, easily fixable (a few characters to change).  Customer group
all p-ed off. Developer has access to the version control server.  He
changes something on the VC system to appear as if the bug never existed
in the version of the code he shipped to whoever. As a result, the bug
was deemed to have "mysteriously" appeared somewhere along the line.  It
didn't help that parts of the workflow were semi-manual, so he *did*
have vague things to point at.

I don't believe I can explain that any better or go into details without
some risk, so if you don't agree then that's all there is to it.

Suffice it to say I am strongly opposed to the idea, but as long as it's
optional -- and for the right reasons (see my other email) -- I'd be OK.
