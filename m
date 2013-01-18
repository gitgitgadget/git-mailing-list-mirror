From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 7/8] git-remote-testpy: don't do unbuffered text I/O
Date: Thu, 17 Jan 2013 19:50:19 -0800
Message-ID: <CAGdFq_jcp-XKoTkz0iVKiVb0csrfcmCWEEiTBC-c0Bg2HP+e3g@mail.gmail.com>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
 <6bc90f3afc86d53eb6e4b4d6b87f6afd20023769.1358448207.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 18 04:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw2zF-0001zx-MR
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 04:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab3ARDvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 22:51:02 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:37913 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab3ARDu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 22:50:59 -0500
Received: by mail-qa0-f45.google.com with SMTP id bv4so1036640qab.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 19:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=LKbt90LZUAyNpmyL8MnQBlOvGsSBpFJhb8AklKCCDgQ=;
        b=vkSwE8kBum4ayY0G6dbPuY7wOpDIdxDUsVnlPXFJTDi2k51mVngi/jvTpUwZ5Z6jGb
         au1g1HpCcgrGkHW+Ft5g4zNbjwBDgFg8apEahkQwk00EplcD9YtEMTLXzTsIT7vuvEub
         TPO5d4aG7p8K/C4UNgrYdt+VI1W1zYK6iyFhk9pBWDmDG4WUoB6YZJ3LipWWtTbPirZY
         JC8bmzo+/dzBwut0sHwZ8iOtDtVW9iFrx7mhGdG3ra1tAMpRSB+/2rxP/LMsIi6Efhv6
         jPKtinc4B889BtJ/Hnd4HA5kauevW88IA1nT7+GB4iBu+1ZpRC60xYbSsJOEMoreYOPY
         TgAA==
X-Received: by 10.49.59.48 with SMTP id w16mr8849809qeq.38.1358481059121; Thu,
 17 Jan 2013 19:50:59 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Thu, 17 Jan 2013 19:50:19 -0800 (PST)
In-Reply-To: <6bc90f3afc86d53eb6e4b4d6b87f6afd20023769.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213899>

On Thu, Jan 17, 2013 at 10:54 AM, John Keeping <john@keeping.me.uk> wrote:
> -    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
> +    sys.stdin = os.fdopen(sys.stdin.fileno(), 'rb', 0)

It is not immediately obvious why you would open stdin in rb mode,
please add a comment.

--
Cheers,

Sverre Rabbelier
