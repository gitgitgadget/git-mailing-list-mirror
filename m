From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/2] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 20:37:55 -0500
Message-ID: <CAPig+cRhbCRJhrOFcjY2avFZ0rQgCP-JT-6RTCiihOQB8nWeMw@mail.gmail.com>
References: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 02:38:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVr47-0007ha-IQ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 02:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbcBQBh7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 20:37:59 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35259 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964854AbcBQBh4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 20:37:56 -0500
Received: by mail-vk0-f52.google.com with SMTP id e6so1850789vkh.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 17:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=6FxDNYj2568voneOWe1vqhIEJmBdNEQCcpv3kKId2+U=;
        b=U02mXUcQioqIyc5487iHg3kiAXQlVsnB/PGyp4vMp6PVXgo3LTyKncdow6AIVd6fQJ
         qIAvKrklr/k5vduO9ItilH4LWLLZGd/Vqjac0uxpmv7+gVNO7DxkgomYGloOktj5Ktp9
         O4TD0tzdCATdgatCIL1ZETtNNRv82izOtLTCtEQP6PCZ1xLOheFYbMQJVYlFX0ve+DgO
         TfA43aULKD5IzWWQZQEtIqn0K6YnCqa76pF70RKcy61wZh+iNZUq27i6wsIiUtQHxods
         RbLEoubTkej9WLTkt36y1UWEpjtRPVmxOYwXkvMKkXeeKbZ+TWWu47k06/mY01hFby+3
         X14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6FxDNYj2568voneOWe1vqhIEJmBdNEQCcpv3kKId2+U=;
        b=BBxzrM0GCF03dzq0PvEIKscGBWiDnhx1YSdAN82pnZ84sa+fdE47xMj3l0584nIJKT
         BGHvr5TwwGfUnxa0bjRe7XZk9uQK81gjX8ru0BGw+OHzneXNmHc2WbGUcUZYvTGhpvM0
         QL7dOkXHjHAXnmta5r5JLz8aAPzo8EGdJyoqXTr9djec9JjAio3a++rzjl4dtDr6bMqT
         9YGC9EEusY+5lCAb/cNNHou9HWvbRQIXlZRCm7hO5CJ9/ZRNZfMeatT6uAdbyn0V7MMX
         uqn44m01QQ8jXdMMrkuIBHE+2s9WwcsA6v9ECH9QBTc7FbG5kPRZSBW9GtQhHmqertmM
         bcvw==
X-Gm-Message-State: AG10YORYcBmkUdwcYaOL4EsfdPZEyGwOtQSOXolvyb2qV1lDmZv+b3fttwdUWmeXlL8O8PEHb85BK8rK/FfBZA==
X-Received: by 10.31.47.135 with SMTP id v129mr20734089vkv.115.1455673076059;
 Tue, 16 Feb 2016 17:37:56 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 16 Feb 2016 17:37:55 -0800 (PST)
In-Reply-To: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
X-Google-Sender-Auth: 1xSuGcWab-S9RAfAxyOoVurnKRc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286472>

On Tue, Feb 16, 2016 at 8:11 PM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> No more renames option. rename-threshold enables renames.

Can you add some tests? Off the top of my head, I'd expect to see at
least three new tests:

1. --no-renames works as expected
2. last wins in "--no-renames --rename-threshold=3Dx"
3. last wins in "--rename-threshold=3Dx --no-renames"

> A second optional patch is included, teaching merge-recursive to take
> "find-renames[=3D<n>]" as well, for consistency.

Tests should also accompany this change. A couple obvious ones:

1. --find-rename=3Dx works as synonym for --rename-threshold=3Dx
2. --fine-rename (without "=3Dx") works as expected

Thanks.

> Felipe Gon=C3=A7alves Assis (2):
>   merge-recursive: option to disable renames
>   merge-recursive: more consistent interface
>
>  Documentation/merge-strategies.txt | 14 ++++++++++++--
>  merge-recursive.c                  | 12 +++++++++++-
>  merge-recursive.h                  |  1 +
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> --
> 2.7.1.288.gfad33a8
