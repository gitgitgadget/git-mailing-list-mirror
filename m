From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Understanding behavior of git blame -M
Date: Sat, 16 Aug 2014 07:06:28 +0700
Message-ID: <CACsJy8DhfUY7uL91UGZUbC4g7WsMKkmj+7BF3xZ9RZyf8NcB4g@mail.gmail.com>
References: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
 <874mxderwj.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 02:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIRWf-0004z5-5h
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 02:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbaHPAHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 20:07:00 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38420 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbaHPAG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 20:06:59 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so3236801igd.14
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oYrlN1CWydi+/1blZA1+TKoiUDhWdByr3BbW1XKn3i4=;
        b=LgE/xKPIC2kPe0FS46bHWudHhD1aX62zptTJxnNNU9SORzXF+nQQpwshu9GkSiAWSC
         +HEBzk+xgI9nbPXmDr6auOmf1SGRxxuSi+ZPFlHE4jESn1in73aoOewkb1cdgYsoS33Y
         OUjVg2O9B6a8mvNPjFwpWn39GNfg9AXStHdBsA/Jsg7izUCa9VJ7u9QOaLu6e/AqElFM
         r/323wq0sSDPEZon5m0bCA7ZmIH4pEBaTa7644Z3BYDQ7+HkVQAEsaVNin1FgxVSXlDA
         hjThrOkSqobnGxdyGYR9W+aGpw7U9Yprz4d12nbz6UUuUMTEVWQUOJFFyOA5BMy3Vdfi
         I7rQ==
X-Received: by 10.51.17.66 with SMTP id gc2mr28711025igd.40.1408147618598;
 Fri, 15 Aug 2014 17:06:58 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Fri, 15 Aug 2014 17:06:28 -0700 (PDT)
In-Reply-To: <874mxderwj.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255310>

On Fri, Aug 15, 2014 at 9:42 PM, David Kastrup <dak@gnu.org> wrote:
> The function diff_hunks is a wrapper for the diff engine.  Putting the
> context length explicitly into this wrapper (rather than not passing an
> argument and just setting the context length to zero anyway in the
> function) clearly indicates that somebody _wanted_ it called with
> different values.
>
> There is no documentation or rationale in the file _why_ as far as
> I remember.  Maybe it can crash or end up in an infinite loop.  Maybe it
> could do so at one point of time but no longer does.

Not sure if it helps, but ctxlen = 1 seems to be added back in d24bba8
(git-pickaxe -M: blame line movements within a file. - 2006-10-19), if
I track the changes correctly.
-- 
Duy
