From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: squelch warning from Net::SMTP::SSL
Date: Fri, 5 Jul 2013 16:22:29 +0530
Message-ID: <CALkWK0nWvmuxfZJF_Mk2MmJNxz4+=46m_pBtzjSZprLxABhNeA@mail.gmail.com>
References: <1373019511-13232-1-git-send-email-artagnon@gmail.com> <20130705104557.GL9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jul 05 12:53:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv3db-00064N-EV
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 12:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251Ab3GEKxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 06:53:11 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:63911 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab3GEKxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 06:53:11 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so5072558ieb.16
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eBP4agQeYAvNT/C0X1daKNE72rrk1RuOITUR2k+ukjg=;
        b=wsG0O0TBrN3tnGZLuL40qz0gfLOnLVzU5cG8QxPVOHYGHHwo9KI8z72BCCctYL/Vjq
         qTvMWOU9xqp2DzZgV0LKY3bspzlkWalbE+cQlRpby3nHGACglcD+FqrFx9udoDV55PBI
         uVBRdSw54zDJrtlsdWfxYH/7duTQmAtD27fJbulT0OC0puUaadRthfjJ9AaC0D4qGJc/
         AuvvtwQufYjyBo4d0xdg1QchvXY2XDY6H38afGURg+MqgCSegzI2gBll9bgrBl5NO+3O
         Hh2ewn/moj7UoeOdHXRq8HWndyaYk9i04WOLJnS9FZaPax/JFckYloKsO/6iPILI4QRp
         xUqA==
X-Received: by 10.50.66.130 with SMTP id f2mr27956397igt.55.1373021590677;
 Fri, 05 Jul 2013 03:53:10 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 5 Jul 2013 03:52:29 -0700 (PDT)
In-Reply-To: <20130705104557.GL9161@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229649>

John Keeping wrote:
> I don't think this is really "fix", it's more plastering over the
> problem.

It defaulted to SSL_VERIFY_NONE before Net::SMTP::SSL was updated, and
the behavior hasn't changed now.  The new version simply asks us to be
explicit about SSL_VERIFY_NONE, so we are aware about it.

> I'd rather leave this as it is (complete with the big scary error
> message) and eventually fix it properly by letting the user specify the
> ca_file or ca_path.  Perhaps we can even set a sensible default,
> although I expect this needs to be platform-specific.

Nothing scary about it: it eats up real estate, and that is annoying.
I personally couldn't care less about ca_file, since all my emails are
to public mailing lists anyway.  Work on specifying a proper ca_file
as a follow-up, if you so desire.
