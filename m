From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Thu, 26 Feb 2015 17:15:54 +0700
Message-ID: <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
 <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
 <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
 <CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
 <CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
 <xmqqsidtoojh.fsf@gitster.dls.corp.google.com> <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 11:16:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQvUd-0004d9-3n
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 11:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbbBZKQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 05:16:27 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34946 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbbBZKQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 05:16:25 -0500
Received: by iecrl12 with SMTP id rl12so12823504iec.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dZx4Z0UE9ZTDRjDoX37e0V9niIeARlSsJ/ON3C9IU3k=;
        b=bapnVdRoaPqSlI09dauTHWDXcRWt3v/+qxuB0o6LfZb7YMAFHiaXh7KK/sINzWqWSM
         PodvWERYz+i/oVzcAfbw+r0pXXK7lg//jxZNCShww+Mx6uafl/J0KPKF8iAUxBGwTTnd
         0225aTWMZoqqU0+q8F39JOPHEdUuiuAg+2tLiZqIZZI//SsGcRhp7HMGCq4pWYZoDeXd
         Mseks2zB2p/lgQDe+WQ9O1Ov0BYKBHNYlpjEsq85Tsf6HZ98CgwhaLfvvk1NycSuHmK6
         ORlMkpZk8lAP6Jvy3qYaH/rWGePVMjd8LFwtE1cB7X3bmx8n6FZpesh0URo3hEJ+pEY3
         v+vA==
X-Received: by 10.107.11.140 with SMTP id 12mr10412268iol.5.1424945784768;
 Thu, 26 Feb 2015 02:16:24 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Thu, 26 Feb 2015 02:15:54 -0800 (PST)
In-Reply-To: <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264427>

On Thu, Feb 26, 2015 at 2:31 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Feb 25, 2015 at 10:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Wed, Feb 25, 2015 at 6:37 AM, Stefan Beller <sbeller@google.com> wrote:
>>>> I can understand, that we maybe want to just provide one generic
>>>> "version 2" of the protocol which is an allrounder not doing bad in
>>>> all of these aspects, but I can see usecases of having the desire to
>>>> replace the wire protocol by your own implementation. To do so
>>>> we could try to offer an API which makes implementing a new
>>>> protocol somewhat easy. The current state of affairs is not providing
>>>> this flexibility.
>>>
>>> I think we are quite flexible after initial ref advertisement.
>>
>> Yes, that is exactly where my "I am not convinced" comes from.
>>
>
> We are not. (not really at least). We can tune some parameters or
> change the behavior slightly,
> but we cannot fix core assumptions made when creating v2 protocol.
> This you can see when when talking about v1 as well: we cannot fix any
> wrongdoings of v1 now by adding another capability.

Step 1 then should be identifying these wrongdoings and assumptions.

We can really go wild with these capabilities. The only thing that
can't be changed is perhaps sending the first ref. I don't know
whether we can accept a dummy first ref... After that point, you can
turn the protocol upside down because both client and server know what
it would be.

> So from my point
> of view we don't waste resources when having an advertisement of
> possible protocols instead of a boolean flag indicating v2 is
> supported. There is really not much overhead in coding nor bytes
> exchanged on the wire, so why not accept stuff that comes for free
> (nearly) ?

You realize you're advertising v2 as a new capability, right? Instead
of defining v2 feature set then advertise v2, people could simply add
new features directly. I don't see v2 (at least with these patches)
adds any value.

> I mean how do we know all the core assumptions made for v2 hold in the
> future? We don't. That's why I'd propose a plain and easy exchange at
> first stating the version to talk.

And we already does that, except that we don't state what version (as
a number) exactly, but what feature that version supports. The focus
should be the new protocol at daemon.c and maybe remote-curl.c where
we do know the current protocol is not flexible enough.
-- 
Duy
