From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: git gc logs to standard error
Date: Mon, 14 Dec 2009 08:04:08 -0800
Message-ID: <8c9a060912140804t409030b4g168014bd80a0b88c@mail.gmail.com>
References: <4B264F7B.8070504@inf.utfsm.cl> <200912141655.01268.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Richard Rossel <rrossel@inf.utfsm.cl>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 17:04:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKDPX-0001RV-Fj
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 17:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624AbZLNQEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 11:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757622AbZLNQEa
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 11:04:30 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:45516 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619AbZLNQE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 11:04:29 -0500
Received: by pxi4 with SMTP id 4so1881870pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=fXJSLxiztXfNAc4jt2//Esy0QZNvvEncAARI0qOkI+Y=;
        b=F0OFCRKPdugcpzISZYFPDL4RCaA7fw4O/0+5Sy6+T/RqGNmbfh/xV83Tq53Aj7Ig/S
         FZW4clXHnokBdGQux2TlpASCdlmti+2MBSqER54yn0qyNpQJ/lKC/sVdSe+FOSyuLOe/
         WUcUqIkRBUiyb9y42Ryri0aHA9aDpg8682UsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YBBSfQP0+xYX5W6eiCxZ0E8rl2cysZl1RqmyW6wS6kmzQ/K7ClYQpaKwYvjjOOx9M3
         cjESFbqQoU0bWmMtkWhEAk3pCAVovGv8tftnEGJSBgX/IG9XOzwSLhRR+eWuQ4mbgZfw
         KzP+r4tiNqvlw5wvKwKwnCGgm6no6OqB3ALEA=
Received: by 10.141.107.6 with SMTP id j6mr2474228rvm.3.1260806668448; Mon, 14 
	Dec 2009 08:04:28 -0800 (PST)
In-Reply-To: <200912141655.01268.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135221>

On Mon, Dec 14, 2009 at 07:55, Johan Herland <johan@herland.net> wrote:
> On Monday 14 December 2009, Richard Rossel wrote:
>> Hi,
>> I have a question related to the output of git gc logs. Let me
>> explain,
>>
>> [...]
>>
>> I realized that the message are sent to standard error,
>> so the question is why is the reason to do that?
>>
>> The quick solution to my problem of annoying mails is send the output
>> error to /dev/null
>> but what happens when an error really occur, there will be no message
>> to alert me.
>
> Try the --quiet parameter to "git gc" (and other git commands).
>
>
> ...Johan
>
> --
> Johan Herland, <johan@herland.net>
> www.herland.net

I think the real problem that Richard is experiencing is that git
fetch isn't respecting the --quiet option.  The output being similar
to git gc, and also being on STDERR seems to be a red-herring.

Richard,

What version of git are you using?

Also, what is the output from 'git fetch --q; echo $?' if you just run
that in your repo?  If the last line you see is '0', then that should
be the only output you see.

-Jacob
