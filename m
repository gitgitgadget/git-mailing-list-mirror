From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 23:42:28 +0100
Message-ID: <CALWbr2wtAzz7yWb_Z_V0LFt5ddZcRSs7_rea2w=ghdC847mEyQ@mail.gmail.com>
References: <A0DB01D693D8EF439496BC8B037A0AEF322039A7@xmb-rcd-x15.cisco.com>
	<20130111212325.GA18193@sigill.intra.peff.net>
	<CALWbr2xasF1y9j3G=-fQ9Wwg41Ymv=MMsWoqyuhweDov9KpRvg@mail.gmail.com>
	<7vy5fz9xdl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"Matt Seitz (matseitz)" <matseitz@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:42:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtnJO-0004hv-53
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 23:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab3AKWmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 17:42:32 -0500
Received: from mail-ea0-f172.google.com ([209.85.215.172]:52700 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab3AKWm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 17:42:29 -0500
Received: by mail-ea0-f172.google.com with SMTP id f13so932053eaa.31
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 14:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wO1KdT7aHCxsAvZCAckk79HUlVIzPU/tdGfyFOK6WP4=;
        b=sbqgEvWw3XVoXjAb7irM/PlUDgMVjDyHSyl/2wZBXp+NPAnXWRQfTj6gJ+HUcCaKn4
         j2rIxrro+RtcmwJw3RdkX6KTIMh4Xfct4JmgWhoDTcuRSMm1icm0vQ0CUoE63drdsnTC
         rw24dcRpvknNMaEvQsKU94ptIsw1ZFl7o9ENS2Vd4raYA7zRvEVRadIFXccom/M2l0m+
         tZ1+DxploM23UWTLMn2UFnJz2idAtX5JEFzcQKHkjiQcubgO4fxdY2wwaAIn94P5xNLv
         yf4Cs10F2ZEYdlFucd0x2lX9HTb1jBXfnjyqQhffoGQQgQxCg41+Tc7MQQeG3k+4mwfO
         avBg==
Received: by 10.14.206.197 with SMTP id l45mr205611100eeo.17.1357944148199;
 Fri, 11 Jan 2013 14:42:28 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Fri, 11 Jan 2013 14:42:28 -0800 (PST)
In-Reply-To: <7vy5fz9xdl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213251>

On Fri, Jan 11, 2013 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The exchange, when you do not have a configuration, goes like this:
>
>     $ git send-email 0001-filename-of-the-patch.patch
>     0001-filename-of-the-patch.patch
>     Who should the emails be sent to (if any)? junio
>     Are you sure you want to use <junio> [y/N]? y
>     Message-ID to be used as In-Reply-To for the first email (if any)?
>
> Why not do this instead?
>
>     $ git send-email 0001-filename-of-the-patch.patch
>     0001-filename-of-the-patch.patch
>     Who should the emails be sent to (if any)? junio
>     Are you sure you want to use <junio> [y/N]? y
>     Is this a response to an existing message [y/N]? y

I'm not sure about the extra question. If the user doesn't care, he
will probably use the empty default, which will result in the same
number of steps. If the user cares, he probably knows what he's doing
and will give a sensible value.

>     What is the Message-ID of the message you are replying to?

I would simply go for:

  What Message-ID are you replying to (if any)?

If I don't know what to answer, I would definitely not say y/yes/n/no,
but press enter directly.
