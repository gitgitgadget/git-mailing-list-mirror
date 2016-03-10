From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Disown ssh+git and git+ssh
Date: Thu, 10 Mar 2016 15:51:44 -0500
Message-ID: <CAPig+cTtHFnRKUnpShQYbzfqCLW48o9FdCB=EgJ3=q2+TVLOWw@mail.gmail.com>
References: <xmqq7fi8s4dx.fsf@gitster.mtv.corp.google.com>
	<1455546546-65710-1-git-send-email-cmn@dwim.me>
	<CAPig+cQ6JC65QkH=8nJ9Qwghr6cwv0BsB5TRDeg=gZmDpcdcHg@mail.gmail.com>
	<xmqqbn6ngvs8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 21:51:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae7Yo-00066l-44
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 21:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbcCJUvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2016 15:51:49 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36295 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbcCJUvq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 15:51:46 -0500
Received: by mail-vk0-f44.google.com with SMTP id c3so110845630vkb.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=7oDKkItPs0ofP0QDV5lmO+Z23I8QZA259rdMllaCAIY=;
        b=fSdgpjqOQPs6hcuc5N4DCiLKifQYaZwibbMQZrP0xTlKLww7IqNLn1uQnHAkqJu78x
         p2WZZU5SNfLweu9d8cdkVoIhcjf8WsAypZeIvd/b8U/gwVGWmd2npASSMf+tiEmwLB68
         Tajw1wLSCHXkNVAElEw2LsHVB/Q95MEo6LHJAdiXU9cPiFd5hOgagMAKQEPnIrKW/6/l
         aqdzG+5e9WvfyjwfacSUZBI52L+jmhF3TuIC1aJGkYYdfHtOTTUl9bkTkzF5NYPLwrJi
         4tizA85ErRcLLNRFrUDNpWIH5JVG16bdiQTIy+g5KS1vtBJ3rMC5b8mTwobApNVHD3su
         DruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=7oDKkItPs0ofP0QDV5lmO+Z23I8QZA259rdMllaCAIY=;
        b=meks1G4JJtZQiu8m4XkM1LoLLQeWfYYCIdoNpkG8Ri0DvlpJJi8vz+8/kyfpdcTfnl
         XF03/+0AvdA8DIqOrcBPyBuxiwUhvTuchGykdoPOXDjpelHCQd4tvJ1MyLEyJdryKWLq
         ZsGOAHgCtOOL7pDz8y/I0ToO7h0NahxMMfteqyidkDN4EcrIc+IDa/U0puc8L14UbAr0
         JA25z1AmSEAeyEmkbWZfkguCTls+HdrnRVagR39PerQ1MZl7V6Ewns1SglUepcnPrDur
         snr37AeHGwIjbTfZdf+nprq3AMlxxxfnR+6LE/eDFa3TgAjEccXKtiHzab64RojVxd5s
         ruuw==
X-Gm-Message-State: AD7BkJKRS+EMCJIsyuYG8RjZJTYMkD3ZS2p7cwhwCs3WHITpVoJ9wJ7FQH6eMNRNCY2o6C771DFq0ukzU4vcCQ==
X-Received: by 10.31.146.2 with SMTP id u2mr5090883vkd.19.1457643105113; Thu,
 10 Mar 2016 12:51:45 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 10 Mar 2016 12:51:44 -0800 (PST)
In-Reply-To: <xmqqbn6ngvs8.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: T0UVBZdEkr-wT1X5R2IsZK6o9zs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288638>

On Wed, Mar 9, 2016 at 4:56 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> It might be helpful to cite some reference to support the claim that
>> they are "silly" since it's not necessarily obvious to readers who d=
id
>> not following the discussion.
>> ...
>>>                 || starts_with(url, "ssh://")
>>> +               /*
>>> +                * These ways to spell the ssh transport remain sup=
ported for
>>> +                * compat but are undocumented and their use is dis=
couraged
>>> +                */
>>>                 || starts_with(url, "git+ssh://")
>>>                 || starts_with(url, "ssh+git://")) {
>>
>> A little "comment" bikeshedding: Aside from undesirably interrupting
>> the code flow, these large comment blocks draw far too much attentio=
n
>> from the reader than these deprecated spellings of "ssh" deserve, th=
us
>> making them seem overly important.
>
> I've been waiting for an update for it but got tired of it.
> Instead of discarding the topic, let's amend it like so:

Minor redundancy[1] aside, this looks good to me. Thanks.

[1]: "do not use" is already implied by "deprecated"

> -- >8 --
> From: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> Date: Mon, 15 Feb 2016 15:29:06 +0100
> Subject: [PATCH] Disown ssh+git and git+ssh
>
> Some people argue that these were silly from the beginning (see
> http://thread.gmane.org/gmane.comp.version-control.git/285590/focus=3D=
285601
> for example), but we have to support them for compatibility.
>
> That doesn't mean we have to show them in the documentation.  These
> were already left out of the main list, but a reference in the main
> manpage was left, so remove that.
>
> Also add a note to discourage their use if anybody goes looking for t=
hem
> in the source code.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d987ad2..2f90635 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1122,7 +1122,7 @@ of clones and fetches.
>             connection (or proxy, if configured)
>
>           - `ssh`: git over ssh (including `host:path` syntax,
> -           `git+ssh://`, etc).
> +           `ssh://`, etc).
>
>           - `rsync`: git over rsync
>
> diff --git a/connect.c b/connect.c
> index fd7ffe1..3babb81 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -267,9 +267,9 @@ static enum protocol get_protocol(const char *nam=
e)
>                 return PROTO_SSH;
>         if (!strcmp(name, "git"))
>                 return PROTO_GIT;
> -       if (!strcmp(name, "git+ssh"))
> +       if (!strcmp(name, "git+ssh")) /* deprecated - do not use */
>                 return PROTO_SSH;
> -       if (!strcmp(name, "ssh+git"))
> +       if (!strcmp(name, "ssh+git")) /* deprecated - do not use */
>                 return PROTO_SSH;
>         if (!strcmp(name, "file"))
>                 return PROTO_FILE;
> diff --git a/transport.c b/transport.c
> index 67f3666..908e08b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1001,8 +1001,9 @@ struct transport *transport_get(struct remote *=
remote, const char *url)
>                 || starts_with(url, "file://")
>                 || starts_with(url, "git://")
>                 || starts_with(url, "ssh://")
> -               || starts_with(url, "git+ssh://")
> -               || starts_with(url, "ssh+git://")) {
> +               || starts_with(url, "git+ssh://") /* deprecated - do =
not use */
> +               || starts_with(url, "ssh+git://") /* deprecated - do =
not use */
> +               ) {
>                 /*
>                  * These are builtin smart transports; "allowed" tran=
sports
>                  * will be checked individually in git_connect.
> --
> 2.8.0-rc1-142-g215006a
