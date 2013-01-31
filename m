From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [feature request] git-daemon http connection filtering of client types
Date: Thu, 31 Jan 2013 14:22:15 +0100
Message-ID: <CABPQNSYq-OO0CrEPjEcH5v+OSTqxYfRbdtaoSER3v+dCHzgyUA@mail.gmail.com>
References: <CAANzHtT83JXhQ8XRifdK5ah7NrnD6hvrCjBO4PnPx=qC=DTT9A@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: porpen+git@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 31 14:23:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0u6o-0002Xc-OT
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 14:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab3AaNW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 08:22:57 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:51317 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab3AaNW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 08:22:56 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so281960iea.14
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 05:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=x2JNQcU7obAstfNYxZchbzfEAVsn35GvO6uNzg1VsLY=;
        b=qmqrVnaNQBJ7oC3vyiXhBqTaoOoMhHTROgPRngkvcDZMfHNy3BjVwgrGfggg8EY9UT
         PXeNkJGw2lr6awugGPZKTQxvdcgR5HEk75qIhh8auGGvGbQEtYL0LpOqSG3W2BehuS5p
         W0LmejLiOvpdtNV655r+Qvf8hNWPqKLwrgigFR6jTa1oWMWHSUvKcub7yoJaScK+d3H6
         2wTJGCSKIx4m75bh4twxoj2uxTqrFWUpx4WMIZfJR8PKUxfNC3gUhNncv/YSR/bc31AQ
         RPZ758zN7DdgYO2rcQlv9k739Mnrv4nyjUK+PG8Fs3T99/9kYsL+rauDAxzxDJZTg0gQ
         BQsg==
X-Received: by 10.50.197.135 with SMTP id iu7mr1079732igc.85.1359638575594;
 Thu, 31 Jan 2013 05:22:55 -0800 (PST)
Received: by 10.64.14.161 with HTTP; Thu, 31 Jan 2013 05:22:15 -0800 (PST)
In-Reply-To: <CAANzHtT83JXhQ8XRifdK5ah7NrnD6hvrCjBO4PnPx=qC=DTT9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215115>

On Thu, Jan 31, 2013 at 1:46 PM,  <porpen+git@gmail.com> wrote:
> Hey folks,
>
> When I checked for false positives in my spam this morning, I spotted
> an interesting malformed img link at the top of a spam message.
>
> {snip}
>> <http://git.{snip}.n2.nabble.com/file/{snip}/t3.jpg>
>>
>> Employ a medal tiffany bracelet  <{snip}> a is
> {snip}
>
> So, apparently git-daemon's http features are being used by spammers.

Not at all. You appear to be referring to the message from
http://git.661346.n2.nabble.com/tiffany-bracelet-On-your-Significant-other-td7575440.html

This isn't a running instance of git-daemon, it's a web front-end for
the mailing list. It seems nabble allows image-attachments, and that's
what you're seeing; an attached image to a spam-email that was sent to
the git-mailing list through nabble.

The message contains HTML to display the image, and the git mailing
list rejects HTML messages. So the only ones who should be able to get
these spam-emails are users who subscribe through nabble. If you
subscribe through vger instead
(http://vger.kernel.org/vger-lists.html#git), you should get less
spam.

> In most cases, spam filters will correctly identify this junk.
>
> I wonder if there is a better way...  In my mental sandbox, git-daemon
> http could have a set of deny/allow rules for incoming connection
> client types.
> e.g.:
>
> git: allow
> git-http: allow
> thunderbird: deny
> outlook express: replace linked file with rickroll.jpg
>
> and so on..  An out-of-the-box install probably should default to
> allow all to keep backward compatibility.
>

Git-daemon doesn't have an http-feature. You are probably thinking
about git-http-backend, but that's an CGI; the http-daemon invoking it
should already be able to filter connections. So, I don't think
there's anything that needs to be done to be able to block spammers
from git-servers. Blocking spammers from nabble is a different manner,
and is something you'll have to take up with the nabble staff.
