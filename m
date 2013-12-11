From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v7 2/4] gitweb: Return 1 on validation success instead of
 passed input
Date: Wed, 11 Dec 2013 17:08:39 +0100
Message-ID: <CANQwDwc5iagW+yLxG-DempZuoNk7Nc0W4rg8ZXA_bU=Eu2vTiA@mail.gmail.com>
References: <1386762884-7564-1-git-send-email-krzesimir@endocode.com> <1386762884-7564-3-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 17:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqmLk-0001e9-VW
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 17:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab3LKQJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 11:09:21 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:41913 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab3LKQJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 11:09:20 -0500
Received: by mail-wi0-f182.google.com with SMTP id en1so1100563wid.15
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 08:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7xS0GKrbaDQBxV7Zt+Kq6MU8ttdOViUhOz803Jaq8+Y=;
        b=lVFsnn1PBGnci4VRL8FqRF6bXigz17ukr6S7HE+vecfzPQEBGEH77B3gtQVU5u423L
         cfypB6CTfryVvjRz6xWA2uhSTXVaCJyntog/PNjWqg1a7yycoD6U0+7rmaWqzJVC+NLs
         0jGbWkcIotT8vTK2ye7e38tyfh6QhQfEtHSzTd4+A9dL3uqxzs+6DQPcynO/xnysYVp7
         xIXusr1mVb/ijvg1nMqdaI3wYINShG3Cxrf8WtC8PK5jfQMyzyswL7us35MQpXSTvOo2
         qOIJ4MjlwcJ/tMU0KvQySbL4jUxifovgRZiKZ6KxSsScs0ztwQQIa7vXISuyYbqfxNRY
         AfyQ==
X-Received: by 10.180.108.132 with SMTP id hk4mr3684927wib.12.1386778159283;
 Wed, 11 Dec 2013 08:09:19 -0800 (PST)
Received: by 10.227.86.201 with HTTP; Wed, 11 Dec 2013 08:08:39 -0800 (PST)
In-Reply-To: <1386762884-7564-3-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239205>

On Wed, Dec 11, 2013 at 12:54 PM, Krzesimir Nowak
<krzesimir@endocode.com> wrote:

> Users of validate_* passing "0" might get failures on correct name
> because of coercion of "0" to false in code like:
> die_error(500, "invalid ref") unless (check_ref_format ("0"));

Very minor issue: there is no check_ref_format() after v7; perhaps
validate_pathname / is_valid_pathname

> Also, the validate_foo subs are renamed to is_valid_foo.

is_valid_foo is better than validate_foo IMVHO, though still not perfect
(it does some validation, but complete validation is done by git command).

>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>

-- 
Jakub Narebski
