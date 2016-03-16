From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Thu, 17 Mar 2016 00:40:59 +0800
Message-ID: <CAKqreuwRpS3uP6=afm-0pBkPW0-bqoJconnKO5q3qTgZwdU_xQ@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
	<xmqqr3fa5rdi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Your friend <pickfire@riseup.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:41:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEW6-0000FJ-31
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbcCPQlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 12:41:15 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36211 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbcCPQlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 12:41:13 -0400
Received: by mail-ob0-f177.google.com with SMTP id m7so56530896obh.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=zeRMSZ8iKRMk24ZJzJEjrAKTL3VGXnnG9kwLZYAWgRc=;
        b=fnlrmqnKz0+6VczUI3MLmhH81TWI1pEKcGoxkmSK2m/Lz3eiZ3zDxhfLAdoql3IIII
         lKWXe33oUPb04Ix5fflroTPziTNNFcQ10tE/TP/Ptqu0Rkcli8sj4crutAVV6YY+tGww
         17hckAEYBgfUg55BIjREhOCwtwUnEoniYZtqJl0irhRE2y2tHUiwH4gRn8/1756cLSTj
         wRKWHqQLfdKgdhS+XRBi/8peHbRY10W1ctjGmrnK7GvJuZueTbbQhn9T0Ibfh6NM6OyT
         1xAcZUMOaskv4ZwXc6fzae5oywcWkrHZo61A7fJMlbTdHLV/O7D0y2MwvTp6eCgHROkY
         7yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zeRMSZ8iKRMk24ZJzJEjrAKTL3VGXnnG9kwLZYAWgRc=;
        b=dIFGyg/B5aaFE/5x+qYiufgUT1qQ8EEEX4SKNZO200GQNDWsaLu6yiXloep+ar6fhS
         lgemsZh0S929V5asO5sLY/A94C2tV5kgriTo7cVkpW6i09mH/oZ4uiNEfK6oEgfFKXS7
         I7gi7+lDS0Z2CS5wKpO5L3Gc2bl9jrOG97e+JmgENCdI5/linZkybkVtyOGpZ46XtZLR
         NEqmumFph5LcjMm8D26QJeYEaUFwcC/S6aNPvCi6V0SSetGYNbXnZltu35m2kkmVZHHT
         CVO7WhhsVmheTdxlwvmIw8T297z4PuYk1PjZMtt/4RcqBSU29j0BJIrfK+R42HZuM3Go
         JuFg==
X-Gm-Message-State: AD7BkJJ43tcFb4hRDzHtVaDotWi4H3H9iI6zz/ddjbT2hivcIQunKfqqvQPfBSHEK2m29sgKEiPibruqS9WnAg==
X-Received: by 10.60.147.228 with SMTP id tn4mr3007642oeb.33.1458146459689;
 Wed, 16 Mar 2016 09:40:59 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Wed, 16 Mar 2016 09:40:59 -0700 (PDT)
In-Reply-To: <xmqqr3fa5rdi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288990>

2016-03-17 0:17 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Hui Yiqun <huiyiqun@gmail.com> writes:
>
>> t0301 now tests git-credential-cache support for XDG user-specific
>> runtime file $XDG_RUNTIME_DIR/git/credential.sock. Specifically:
>>
>> * if $XDG_RUNTIME_DIR exists, use socket at
>>   `$XDG_RUNTIME_DIR/git/credential-cache.sock`.
>>
>> * otherwise, `/tmp/git-$uid/credential-cache.sock` is taken.
>
> Is it better to have the fallback in /tmp, and not in
> ~/.git-credential-cache/, and why?
>
> Is it because the wish is to always use /tmp/git-$uid/ as a fallback
> for $XDG_RUNTIME_DIR (as opposed to ~/.git-credential-cache/, which
> is specific to the credential-cache and would look strange if we
> used it for other "runtime" things)?

Yes, I mean to use it as a general fallback for git.

xdg base dir spec does not specify where to fallback when
$XDG_RUNTIME_DIR is not defined. It just says:

If $XDG_RUNTIME_DIR is not set applications should fall back to
a replacement directory with similar capabilities and print a warning
message. Applications should use this directory for communication
and synchronization purposes and should not place larger files in it,
since it might reside in runtime memory and cannot necessarily be
swapped out to disk.

tmpfs is just like what it describes. And many other applications
put socket under which, such as tmux.

On the other hand, I think, falling back to $HOME/.git-credential-cache/socket
doesn't make any sense for back-compability cannot be ensured.

>
> Just being curious, and wanting to see the reasoning behind the
> design decision the patch series makes in the log message of one of
> these patches.
>
> Thanks.
>
