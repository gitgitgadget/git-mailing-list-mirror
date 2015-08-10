From: Gaurav Chhabra <varuag.chhabra@gmail.com>
Subject: Re: Error pushing new branch: value too great for base (error token is...
Date: Mon, 10 Aug 2015 15:24:07 +0530
Message-ID: <CAGDgvc1FJ0K+OLQBj8iXPCnqMFyBD3mp32k0aTztQkKKuxNxtQ@mail.gmail.com>
References: <CAGDgvc3Gxn=pKBfYC+yrUhCmL9X6bqjPVwVokF0qPsXmhx_EaQ@mail.gmail.com>
	<CAPig+cTXO3699MdqSFVDBcnKcHAT=Mkp=c=r3C8F5nT8tfr6gw@mail.gmail.com>
	<CAGDgvc2hc+f5CuPXc2pr5uYd9kniVpuffrb6z416CicxBgVxJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 12:08:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOk02-0004BD-9g
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 12:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084AbbHJKIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 06:08:05 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33334 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933043AbbHJJyH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:54:07 -0400
Received: by ioii16 with SMTP id i16so164077317ioi.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=HUp4ZejP/GEok9uwWErshuvt8GXR8xhwuQXEAOUXYUc=;
        b=tKijudYiTFeGUj/1He30MyFZKS6EYlGQJhKQMQvar4KS/iXEYEh7cKP85wgA7RqyD8
         QOdwva5N+QKVnVrAFHlzQtEvvhO1PLe5q+0JLJ73rrA7GTU+redES4ro+pqFhQ1qAKyz
         akYkUsdgHmbEHHSnkhQ7TnLUnadr78kLBx9/a33wPA6LLTntgxy8L3XhG/ms7A7W3unh
         Yeowmq1iimP19CN50bWnvsQN2PTL6cU+wY1pJ8Orw7ySUSlso1hfXgQ/qapVU9bb7mPN
         9GuYKJby8fTXmZuK83cGWSbyjWxJyFWa4pcTgQm2xf8JpkeOH7nXpZ0kzVUAMuYFBvcj
         YIUA==
X-Received: by 10.107.10.144 with SMTP id 16mr24116868iok.43.1439200447116;
 Mon, 10 Aug 2015 02:54:07 -0700 (PDT)
Received: by 10.79.105.2 with HTTP; Mon, 10 Aug 2015 02:54:07 -0700 (PDT)
In-Reply-To: <CAGDgvc2hc+f5CuPXc2pr5uYd9kniVpuffrb6z416CicxBgVxJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275605>

Apologies for the delay in reply! I tried your suggestion and it
works. Thanks! :)

I'm curious why integer comparison is throwing error. Shouldn't i be
comparing numbers with numeric operator?

On Mon, Aug 10, 2015 at 3:23 PM, Gaurav Chhabra
<varuag.chhabra@gmail.com> wrote:
> Apologies for the delay in reply! I tried your suggestion and it works.
> Thanks! :)
>
> I'm curious why integer comparison is throwing error. Shouldn't i be
> comparing numbers with numeric operator?
>
>
> On Wed, Aug 5, 2015 at 11:23 PM, Eric Sunshine <sunshine@sunshineco.com>
> wrote:
>>
>> On Wed, Aug 5, 2015 at 1:32 PM, Gaurav Chhabra <varuag.chhabra@gmail.com>
>> wrote:
>> > I had written the following code to check whether a push is for branch
>> > deletion:
>> >
>> > #!/bin/bash
>> >
>> > NULL="0000000000000000000000000000000000000000"
>> >     if [[ "$new_sha" -eq "$NULL" ]]; then   # Line 17
>> > remote: Stdin: [0000000000000000000000000000000000000000]
>> > [9226289d2416af4cb7365d7aaa5e382bdb3d9a89] [refs/heads/rel-a]
>> > remote:
>> > remote: hooks/pre-receive: line 17: [[:
>> > 9226289d2416af4cb7365d7aaa5e382bdb3d9a89: value too great for base
>> > (error token is "922628
>> > 9d2416af4cb7365d7aaa5e382bdb3d9a89")
>> >
>> > Although the new branch gets pushed to remote but i'm not sure why i'm
>> > getting this error and how can i fix it. I checked online and i get
>> > few links where folks had similar issue but in each such case, the
>> > error token was 08 or 09. I still tried the suggestion of using "10#"
>> > in front of my $new_sha variable but to no avail.
>> >
>> > Any suggestions?
>>
>> Yes, try using the string comparison '=' operator rather than the
>> numeric comparison operator '-eq'.
>>
>>     if [[ "$new_sha" = "$NULL" ]]; then
>
>
