From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 8 Feb 2013 01:44:49 +0530
Message-ID: <CALkWK0k=k5P8gL-1gNXQ4gO7uNiw9QUUqWrbuf8=iUFfn=TRNg@mail.gmail.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com> <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <CALkWK0=_0hZP_SjMCjooUAr+MrRoXCCzdQF8y9RhW1g7ShsC7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 21:15:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Xsd-0001nz-S1
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646Ab3BGUPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:15:10 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:62110 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759291Ab3BGUPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:15:09 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so3306875oag.18
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 12:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jyS9ebfuxDHAtV5nA9Wh2B2dD4rxp5moNY/zfPHSuKk=;
        b=R+KBdw11rkuUpOCBDt7fngPqscSiRxvDLqkfP7h1yIKoHnXzWnB1H6Ytxlz13QFMmB
         ojYt/q5+UDUJa+GYt5nlceq3s2YIMiL/CvXhvo9eurzaaRlh85TP+WuWZe923O+iMvjm
         /AARB+5Lsefb1KG/7j1npX8T1KzooxTjU4gokb/pQQAeQNOrMpXedodbYyopz9AxhIc8
         nZOZ1m5l3qktUcE+f80Jr080Jsv/v/6sV6I8HdgN2tSCU223qHsjhFg5TekIg/YLvFwK
         IERA18Yz9VgeaLMuNgIcbRwuSnqyTll1/XqShxCDvOOl7BUgIYMsfo3SYEo7WJZgQji5
         ZYHw==
X-Received: by 10.182.157.44 with SMTP id wj12mr2198529obb.41.1360268109139;
 Thu, 07 Feb 2013 12:15:09 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Thu, 7 Feb 2013 12:14:49 -0800 (PST)
In-Reply-To: <CALkWK0=_0hZP_SjMCjooUAr+MrRoXCCzdQF8y9RhW1g7ShsC7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215721>

Ramkumar Ramachandra wrote:
> Ramkumar Ramachandra wrote:
>> And yes, a regular `git push origin refs/for/master` is just retarded.
>
> Actually a git config remote.origin.push refs/heads/*:refs/for/* makes
> more sense here.

Sorry about all that confusion.  The first line should be `git push
origin master:refs/for/master`, but a rule like refs/head/*:refs/for/*
is insufficient: what if I want refs/head/*:refs/heads/* for one set
of branches (private ones that I don't send for review), and
refs/heads/*:refs/for/* for another set (which I send for review)?
That certainly won't play well will the existing remote.origin.push;
it'd have to behave as an override.
