From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: t7061: comments and one failure
Date: Sat, 5 Jan 2013 12:29:33 +0100
Message-ID: <CALWbr2ytEBacYKnhVLZ7VHzmuAqp0zwq==LUYZW3WLR0yhJaiA@mail.gmail.com>
References: <50E8096C.7000501@web.de>
	<20130105112432.GA14666@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 12:35:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrS2P-0000Aw-8S
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 12:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab3AELfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 06:35:15 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:48017 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871Ab3AELfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 06:35:13 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so7253150eaa.33
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 03:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EmlqYp4oBPG67qQfjER+T5md2dHhEUvCiL3/zUYiiXY=;
        b=Dr8IrQA7TZp1cJVeyFMyw1ipHf4uEq6Q+V/L+JI0RxWJg3a8sDJLVteOJNg2CNelyQ
         xEA0ZY2avfDo1BTOkc2hwdnFmRL0+URRrluS7UL5rqfXGz4ffv80Tausu5QtbmOJVJ5c
         xAlYhsB8e7/6DGoep7voD9BnXs6sIJNzniBHddgqQF5/ByuydKcT0u/nmUT2odlApDzN
         VG156EUw8esu21axoQH6U0clhCfnz/zL39YR42PXRkfvVhMUK269FrMbn162NRmllnfU
         ie6TMbc0z/Tm2MRrYTpDPwTrzDkxnO2UhrCdVglHM+erlQvACzbejykqUJP4G7rN2AwL
         pJKQ==
Received: by 10.14.225.72 with SMTP id y48mr150509114eep.46.1357385374079;
 Sat, 05 Jan 2013 03:29:34 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Sat, 5 Jan 2013 03:29:33 -0800 (PST)
In-Reply-To: <20130105112432.GA14666@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212687>

> Yeah, I can reproduce the problem here on my OS X test box. It seems to
> be related to core.ignorecase. If you put
>
>   git config core.ignorecase false
>
> at the top of t7061, it passes on OS X. Likewise, if you set it to true,
> it will start failing on Linux.

Great, so I have a chance to reproduce and fix it. (and it gives me a
massive hint on where the bug can stand).
