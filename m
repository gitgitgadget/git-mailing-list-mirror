From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 19:34:03 +0700
Message-ID: <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
 <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com> <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 14:34:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlIM8-00044P-0L
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 14:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab3FHMee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 08:34:34 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:33340 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab3FHMee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 08:34:34 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so4208400oag.27
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ek9aZS5sFAzsJchW8CxycUiPGnqvym4Le3XgThRkEKI=;
        b=NZSxoeaVgSQZvHda7w7H819chIVMTNgs7Z8shRxa6yGCWmUjzMZjRdZ17PIzKetIh2
         zKQMHTSF9ISAkw49W7cvCCh/JGDz50ZAlsYiU+PaCbmSzTUOYG7J8Ve7gdK95L3KinBO
         xrnRnLSv4U9dEd2ZRfeV9Y+A/L9Wyl9A7N7qCAseiHoDYyIsXeuzUfMr3zXNjqSIfhKH
         PxtHJvv+NxNmllo5vmJZUKHGkFWi/jS768Nj9xj1ZEBI8FJ3CcfVxllq6bxk3DCgkwKA
         z8AHeDtLBqowAWPXfB+7P7Cn9GKP7QECWbIjxnB3jj8vDMg50PdOnUhWIiRJEDiFmk9b
         H2aw==
X-Received: by 10.182.32.4 with SMTP id e4mr2149407obi.50.1370694873450; Sat,
 08 Jun 2013 05:34:33 -0700 (PDT)
Received: by 10.76.76.69 with HTTP; Sat, 8 Jun 2013 05:34:03 -0700 (PDT)
In-Reply-To: <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226812>

On Sat, Jun 8, 2013 at 7:25 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Jun 8, 2013 at 6:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Jun 8, 2013 at 5:14 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Fri, Jun 7, 2013 at 9:35 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Sat, Jun 8, 2013 at 5:16 AM, Felipe Contreras
>>>> <felipe.contreras@gmail.com> wrote:
>>>>> This code is only useful for cherry-pick and revert built-ins, nothing
>>>>> else, so let's make it a builtin object, but make sure 'git-sequencer'
>>>>> is not generated.
>>>>
>>>> As you can see, the convention is builtin/foo.c corresponds to git-foo
>>>> (and maybe more). Why make an exception for sequencer?
>>>
>>> Why not?
>>
>> And while we are at "why not", why don't you fork git?
>
> That's not an answer.

Neither is "Why not?"

>> and not meant to be. If you aim something more organized,
>> please show at least a roadmap what to move where.
>
> I already did that; we move code from libgit.a to builtin/*.o

what code besides sequencer.c?

> until libgit.a == libgit2. Done.

Read up about the introduction of libgit2, why it was created in the
first place instead of moving a few files around renaming libgit.a to
libgit2.a. Unless you have a different definition of "==" than I do.
--
Duy
