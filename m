From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Git submodule first time update with proxy
Date: Fri, 23 Jan 2015 22:23:46 -0600
Message-ID: <CAHd499A+K=uh=wt4P_qy+8XOEttTziJEPvhE+=03oD_MRxna2Q@mail.gmail.com>
References: <CAHd499BEmV2zeosE9th59QTWPA0CPsU8eyHnONhsZqEb=bH+rA@mail.gmail.com>
	<CAFOYHZAiZkXqSkso+=Eh_THEkh+qi9k8xWsP0yt1dbw5ymwDDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 05:23:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEsGI-0001ez-W0
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 05:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbbAXEXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 23:23:48 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37389 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbAXEXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 23:23:47 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so877961igb.5
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 20:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zMTPdB+ShUkdMwrLTzbmqNU4QuE2SCWjDCcc21GMQ4o=;
        b=EcbdO1XLROxgiK1Xef1yc6779iG8MvLgCg1igWWu1o/BxFdIWevQLORmwrDMD8Vc9F
         wqs8Nrj2ZDm9Oi530pTZiRjETDLC5gIcKkfZJNJd9tDekx0nolJvNKWB9SpVSHdglCIc
         2ctmTl9gk3obo+dfax3wcdSFObvgFE/izBTU3JbPB71WZsMBzvncojuLp+w1tLoqshct
         2EPWGZ6RBDu1OG/TUH5MNh8scL13UDAkeHxCYCErOyCjCIm8KTj78oE1qhsVZD9HSWN3
         vcp9A55TNtJ5VO1ufjhnETBAKNpro+ywd3eW8dyE9g4xW9GJr2+cQ5HiJHQPoVb2dIvy
         ncHQ==
X-Received: by 10.42.103.7 with SMTP id k7mr11960015ico.33.1422073426656; Fri,
 23 Jan 2015 20:23:46 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.56.70 with HTTP; Fri, 23 Jan 2015 20:23:46 -0800 (PST)
In-Reply-To: <CAFOYHZAiZkXqSkso+=Eh_THEkh+qi9k8xWsP0yt1dbw5ymwDDQ@mail.gmail.com>
X-Google-Sender-Auth: krXtSDVhCz-KJmtwY0fgQBRGriI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262987>

On Fri, Jan 23, 2015 at 4:13 PM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi,
>
> On Fri, Jan 23, 2015 at 3:50 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> I have a submodule using HTTP URL. I do this:
>>
>> $ git submodule init MySubmodule
>> $ git submodule update MySubmodule
>>
>> The 2nd command fails because the HTTP URL cannot be resolved, this is
>> because it requires a proxy. I have "http.proxy" setup properly in the
>> .git/config of my parent git repository, so I was hoping the submodule
>> update function would have a way to specify it to inherit the proxy
>> value from the parent config.
>
> Your not the first to suggest it and you probably won't be the last.
> It is hard to decide _which_ config variables, if any, should
> propagate from the parent. What works for one use-case may not
> necessarily work for another.
>
>> How can I set up my submodule?
>
> Probably the easiest thing would be to make your http.proxy
> configuration global i.e.
>
>   $ git config --global http.proxy ....
>
> If you don't want to make it a global setting you can setup the
> submodule configuration after running init but before running update
> i.e.
>
>   $ git submodule init MySubmodule
>   $ (cd MySubmodule && git config http.proxy ...)
>   $ git submodule update MySubmodule

 For some reason, the init call does not create the submodule
directory as you indicate. I also checked in .git/modules and it's not
there either.
