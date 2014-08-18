From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Location of git config on Windows
Date: Mon, 18 Aug 2014 20:17:26 +0200
Message-ID: <CABPQNSbqT1CO3tXn7S3DA88BuEQpz__5D1e4gJLvYeZZy0Ztzg@mail.gmail.com>
References: <ygfvbpqooog.fsf@corbe.net> <CABPQNSZDizccths0b_RZ5FXYYq=+4_2N35DMj9h4Rha_2voekw@mail.gmail.com>
 <53F135F8.60508@gmail.com> <ygflhqlvni7.fsf@corbe.net> <CABPQNSZ=BKqNPCWUmaCSz+gJtBRhjkWtpcDbirsV+KJX=c0kpg@mail.gmail.com>
 <ygf7g25vm9v.fsf@corbe.net> <CABPQNSZayAr0jf9C55wtEH_AJ_hSUkwFsGV4ZxVixizthojkRA@mail.gmail.com>
 <CABPQNSZGYDnSfyS7X+MdskhUrmFx5Kzoi+A5+pgoBiX5kPruyg@mail.gmail.com> <ygfsiktu3rl.fsf@corbe.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Daniel Corbe <corbe@corbe.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 20:18:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJRVV-0003iS-VU
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 20:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbaHRSSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 14:18:09 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:63303 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbaHRSSI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 14:18:08 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so8847165igb.2
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JmSuhfbPuUpmuowypCgHU/LTYmYJffRU2ow0pcSTDFs=;
        b=td2PYenLC+oZB/LKxYuik2wuIJ0BGv6KIanKYTiH9ztZQI/XPKQUe4Y8ez3lCN1CTO
         uLsP+WGzHDlZh3PNppnvc1GMahMzqk/R3/DAGkR8Tl3Yy3fWEcJEqEgo6MrXR/pmr6py
         KETlF3s3TvMBZTlpemE8TN2iBEe0h8DMlfNXL8Mlow4v46W/E2mtDN3Lur4sy6OHLaiZ
         P4tNERxnmXBQNshB/winhRiHj5woa/ofIOQugCc3PihPCw8VnNXXQROswHmq1nfVEDXK
         xtTgvAYo2qx/7Af4nTSSNjiJFG9jnyT/4+WIDL1WYYjZLU/2qPxzy+CmXKHQI8XwgerZ
         Y5Mg==
X-Received: by 10.50.50.229 with SMTP id f5mr630570igo.42.1408385886592; Mon,
 18 Aug 2014 11:18:06 -0700 (PDT)
Received: by 10.64.123.5 with HTTP; Mon, 18 Aug 2014 11:17:26 -0700 (PDT)
In-Reply-To: <ygfsiktu3rl.fsf@corbe.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255405>

On Mon, Aug 18, 2014 at 7:05 PM, Daniel Corbe <corbe@corbe.net> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Mon, Aug 18, 2014 at 5:47 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> On Mon, Aug 18, 2014 at 5:40 PM, Daniel Corbe <corbe@corbe.net> wrote:
>>>>
>>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>>>
>>>>> Or you could just restart your shell when you disconnect...
>>>>
>>>> Well I'm not that daft.  I tried that and if it had resolved my problem
>>>> I wouldn't have posted.
>>>
>>> Hm, but isn't that what Karsten explains in his last paragraph? What
>>> shell are you running msys or cmd?
>>
>> Our /etc/profile does this:
>>
>> https://github.com/msysgit/msysgit/blob/master/etc/profile#L38
>>
>> ...however, our git-wrapper only does this:
>>
>> https://github.com/msysgit/msysgit/blob/master/src/git-wrapper/git-wrapper.c#L71
>>
>> So yeah, we don't seem to actually check if %HOMEDRIVE%%HOMEPATH%
>> exists. Perhaps fixing this is the right thing to do then? Since the
>> git-wrapper is run for *every* invokation of git, you wouldn't even
>> have to restart the shell in this case.
>
> But again, restarting the shell doesn't fix the problem.
>

Not for cmd, no. But for Git Bash, it should.
