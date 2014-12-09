From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 11:48:02 -0800
Message-ID: <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
	<20141206020458.GR16345@google.com>
	<xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:48:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQlV-0005OW-NA
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 20:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbaLITsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 14:48:05 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:37859 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaLITsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 14:48:04 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so1241247ieb.35
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 11:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=J5LQ0ekGK/QYI6x6uA/z10V8dpmKZkFzkQvMIiGGZWo=;
        b=Rgzf6ptW3EzbunYaeRKAQdn6GvMeLottACp2Hh7vd58V8FfXWoWu/A14N9ipQ5hY/a
         AS4iCo5At4bT/Rde+B/xUpgTQz04mdTjSiWmm1vTHdU/CHnWUJbSz4Luk3cSgC+w0u/2
         7GCx9Dgu33QCOatjNMPzehkVDiFzws3ABfWD4psz1aQky7Ir7XFWypnBqHOITTvxjTQA
         yYlzLzOEliayor84hVfg1hI8JU63tya6kDOVbGGWvY31v51r2dgVMA3ymmDE7Wu/NuBx
         q5dXWZRi9dr761bafxRGnzQn8YhLmFMjdKA3WVypvN3SvGqoCJjUy95jaz1meEw2TAb+
         RaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=J5LQ0ekGK/QYI6x6uA/z10V8dpmKZkFzkQvMIiGGZWo=;
        b=KKYmD4ix7gzE3OhlsiNKhto6ErZam0Z+8I5WhBfSvkVvIoUDiNnUj0wnG32+jaFuRO
         yKMoP3ADpp7bCAlJQNW07nQ3//M852ecdF4eD1pjAsfHnzD4/ez9GxAgSYMmZBFGazv+
         miZOjVYwaN3mo+b70GySZ/gCQt3+gDs3asg2jP/e9SRes+c+p8NAIRY+nd9/af8Z/rSb
         5Zj/Y2QE8QJJGiq/30sYiu6LXnnUUzfv7+7yPX8T3J2GpAmOaQ0/nr5iaJFREXVw61G/
         Exc7MVCYR72JGqf8KR3DN1kOP7peZKBg8xZRpGclyWy0jENUCll18sAGApEhIs3dA+g+
         H49w==
X-Gm-Message-State: ALoCoQnX/AI9INv5d1oYR6WxV6Qgx9vj79mP2znzeogsgexgdE3fT/2ABM8iZFnzDamkHzwRZjGD
X-Received: by 10.50.79.229 with SMTP id m5mr4170036igx.10.1418154482861; Tue,
 09 Dec 2014 11:48:02 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Tue, 9 Dec 2014 11:48:02 -0800 (PST)
In-Reply-To: <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261147>

On Tue, Dec 9, 2014 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Perhaps the API doc that currently says "Free" is the only thing
> that needs fixing?  And perhaps add "See $doc" at the beginning of
> the header and remove duplicated comments we already have in the
> file?

The reason I wrote this patch originally was because I seem to forget we have
more than one place to document our APIs. If there are comments in the header
I seem to have thought it were the only place where we have documentation.
But as we have some comments in the header for about half the functions there,
I missed looking into the Documentation at all.

I'd support Jeffs efforts to only write doc into the headers and then
export it or just
have documentation in the Documentation/technical dir. If there is
only one way to obtain
the information I wouldn't send in patches duplicating information.

Personally I first visit the header files to see if there is
documentation/comments on the
desired function. Looking at Documentation/technical/ is only reserved
for high lievel discussion on
API choices, so everything not prefixed with "api-" there.
