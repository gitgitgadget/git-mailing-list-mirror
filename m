From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Fri, 8 Mar 2013 10:32:49 -0500
Message-ID: <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de>
	<494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Mar 08 16:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDzIK-0005Zt-Fi
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 16:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934260Ab3CHPcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 10:32:50 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:43361 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759355Ab3CHPcu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 10:32:50 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so1265535pbc.17
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 07:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=VV255EmLiqDhhjfVo984rw52jNoZcBy2gNJN6CSUubU=;
        b=TDTe3C/Te3KxRwxvCZakWZ5y91zGCo9MBS3+FQ+euaPVuGZrvyCoj/4IktlkkMrT8E
         azwnOUX+E28GRcKsDMHJS276CAPZZYgiRxcNw43C3+6+PBJ/pmS4WSyAy7bvAHWb5aiT
         5Z8VJOkZX0a7TWn+fogQIfoIfNy+j646D8Q4mVqmWDSfjquEe7j+D+lz11CxlmJxMyE1
         KHHYjGToVjDcH/g6bsvByey5f+5f39sW4jAclYRYx1WgKvpZu21QEa9cIIH51W3dcRkU
         ZwT5NXIMbdWZgkdFpnPrMMBTS4CTS+nTz72IKA7RnibyYcIKHa3ai+U3SO5znGdBn/1y
         LzBQ==
X-Received: by 10.68.211.8 with SMTP id my8mr3998898pbc.7.1362756769805; Fri,
 08 Mar 2013 07:32:49 -0800 (PST)
Received: by 10.68.235.144 with HTTP; Fri, 8 Mar 2013 07:32:49 -0800 (PST)
In-Reply-To: <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de>
X-Google-Sender-Auth: ShYpABTuOKCJFqpzTNKwuy0swr0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217665>

On 3/8/13, Max Horn <max@quendi.de> wrote:
> All in all, I suspect that Mac OS X and/or the filesystem (HFS+ with
> journaling, not case sensitive (the default)) might be at fault. Still, this
> is quite puzzling and annoying, and so I still wonder if anybody has any
> insights on this.

When "rebase" errors out at COMMIT A, try manually running "git apply"
on the patch file (rebase-apply/patch) a couple times, and see if the
error occurs randomly. You'd have to do a "reset --hard" to revert the
changes done by "git apply" every time before you run it again. The
error from "git apply" might shed more light on the issue.
