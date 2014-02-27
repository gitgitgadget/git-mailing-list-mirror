From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Cygwin + git log = no pager!
Date: Thu, 27 Feb 2014 20:36:19 +1300
Message-ID: <530EEAF3.7080006@gmail.com>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>	<53085434.4060106@gmail.com>	<CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>	<530AFAFD.2060504@gmail.com>	<20140224090618.GB10698@sigill.intra.peff.net>	<CAHd499BDBgaAZFkoc=S9i9hG=NifAmqhaW86fqgkzjShZd07ww@mail.gmail.com>	<20140226092610.GB32537@sigill.intra.peff.net> <CAHd499Co9Amdf_gWnY81dkRa2uDTH0fVM8HSb99VHhrb1AAKhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, msysgit@googlegroups.com
To: Robert Dailey <rcdailey.lists@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 27 08:36:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIvWD-0003HM-Bg
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 08:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbaB0Hg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 02:36:27 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:62089 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbaB0HgX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 02:36:23 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so2068963pdj.40
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 23:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BF56jHXAGpSalZFimv0B3UQ0cTQfsrwyPzk7shNgcd4=;
        b=n3rDdby4aoiLVufZM9BM18/cHzpJCnIwmVBDnQlEqtLYfHgC+EFOnWbwdxQA3JFPC8
         JVd6J+WNSJ0hwhMxBiz148yzHB3fGhTJuhwyw5iMn+MnT+D/gcmNWeBk4gpp12V/8SQp
         6viJIPeIDBY8bRzUQjReT8d8UNsXhZgdCF4W3tdEc097MeyQBt5xi3vWNo9UjTStnTPu
         weXIA6S5WGWnrytEH3qgNHDhManSsNxfluzPWaaeaOIilCUqwX1BzqvnoyhLAWIH7Tgo
         XFo2kkADZQTPrEHpZfDmulCKwOwo9LQDgQf3BtrMxe4k/NSbWogwBhpdhJWUkqQbnx4e
         IoFg==
X-Received: by 10.66.231.104 with SMTP id tf8mr13973541pac.48.1393486583147;
        Wed, 26 Feb 2014 23:36:23 -0800 (PST)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id j3sm10435765pbh.38.2014.02.26.23.36.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 23:36:22 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CAHd499Co9Amdf_gWnY81dkRa2uDTH0fVM8HSb99VHhrb1AAKhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242788>

On 27/02/14 04:54, Robert Dailey wrote:
> On Wed, Feb 26, 2014 at 3:26 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, Feb 24, 2014 at 01:34:34PM -0600, Robert Dailey wrote:
>>
>>> So I set GIT_PAGER to 'echo custom pager' as you instructed, and I
>>> noticed that wasn't being printed when I ran my git log alias. So what
>>> I did after that was set GIT_TRACE=1 and here is the output I see
>>> before my logs start printing:
>>> [...]
>>> Does using an alias have something to do with this?
>>
>> The aliases shouldn't matter (and I constructed a scenario like the one
>> you showed and it starts the pager for me on Linux). It's more like git
>> is deciding not to show a pager at all (e.g., it thinks your stdout is
>> not a tty). Does running:
>>
>>   git log
>>
>> not use a pager, but:
>>
>>   git -p log
>>
>> does? In that case, I think that your stdout is not a tty for some
>> reason.
>>
>> If that is the case, try:
>>
>>   git -p lg
>>
>> That _should_ turn on the pager, but I think it does not due to a bug
>> with setup_pager and aliases. Something like the patch below would make
>> it work (but if you are having to use "-p" manually, there is something
>> to fix in your cygwin environment, which does not think you are on a
>> terminal).
>>
>> -Peff
>>
>> <snip>
> 
> I have tried `git -p log` and `git log` and neither use the pager.
> Should I apply the provided patch to the Git for Windows master
> branch? 

That may be relevant (refer to my previous questions about what version
you're using and how you got it). Are you using git via cygwin or "Git
For Windows"? I believe the two are different (*caveat* I haven't used
windows in years and I've never used Git For Windows, I've added the
msysgit list to this email thread).

If you're executing the Git For Windows installation from the cygwin
bash shell that's probably why the terminal detection is getting
confused. If you've installed Git For Windows you should use the Git
BASH shell that comes with it. If you want to use git with other bits of
cygwin I suggest uninstalling Git For Windows and installing the git
package via the cygwin setup tool.

> Also I'm not sure if there is a convenient way to apply a
> patch via email, so should I copy & paste it to a file & then apply
> the file?

Save the email file in your email client. Most support saving as plain
text or RFC822 format. Then 'git am <filename>' should do the trick.

> I'm assuming your patch depended on -p working but not without it, so
> I'm not sure if you still think the patch might help. Let me know!
> Thanks for your help.
> 
