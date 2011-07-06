From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 2/4] xdiff/xprepare: refactor abort cleanups
Date: Thu, 7 Jul 2011 02:10:21 +0800
Message-ID: <CALUzUxqPf0nReHHhQ3zJoVbPAN7GNuzWeunWoxbzLuoYtuEbUw@mail.gmail.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
	<1309970337-6016-2-git-send-email-rctay89@gmail.com>
	<1309970337-6016-3-git-send-email-rctay89@gmail.com>
	<7vliwbmgv0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 20:10:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeWYP-0007J3-32
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 20:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831Ab1GFSKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 14:10:23 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45188 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab1GFSKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 14:10:22 -0400
Received: by eyx24 with SMTP id 24so56796eyx.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sAgCcG5ai+M8+0GYiXwmfy0l8LlIErR3x/PuqlgUa70=;
        b=JWMYxJTMTRB9Qv7WG4Q+3Aq/Y5UlwsnonwXYRPEd0cQ/JM+iUvF/r3DUj44FdJlPz3
         T56Np8YEXq0tUWBNCIPvA/U2C/whrbPdSy1Eh3KDqvfPqef+shuTvaq5occOVS8RtIJm
         /LyzxcVPQgyJK6aOmLIUF/XPOJ2ETSn4JyxmQ=
Received: by 10.14.97.132 with SMTP id t4mr1480397eef.37.1309975821513; Wed,
 06 Jul 2011 11:10:21 -0700 (PDT)
Received: by 10.14.37.138 with HTTP; Wed, 6 Jul 2011 11:10:21 -0700 (PDT)
In-Reply-To: <7vliwbmgv0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176721>

On Thu, Jul 7, 2011 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> Group free()'s that are called when a malloc() fails in
>> xdl_prepare_ctx(), making for more readable code.
>
> Nicer, but I wonder if we can get away with a single label that lets us
> abort with freeing whatever we have allocated by making sure that the
> various pointer fields and variables are initialized to NULL, which may
> lead to even more readable code.

Pardon my dullness. Do you mean to check if the various fields are set
to NULL upon allocation, and free()'ing them if so?

-- 
Cheers,
Ray Chuan
