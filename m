From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [BUG] Git add <device file> silently fails
Date: Sat, 17 Apr 2010 17:27:44 +0200
Message-ID: <g2h81b0412b1004170827y883c0cc8ofc72712c20e95dc8@mail.gmail.com>
References: <201004171624.17797.agruen@suse.de>
	 <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com>
	 <201004171700.22851.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Sat Apr 17 17:28:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O39wA-0008Sc-UD
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 17:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab0DQP1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 11:27:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53796 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab0DQP1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 11:27:46 -0400
Received: by gyg13 with SMTP id 13so1866782gyg.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=pJtjSP7OW8kp5ES0Pnl3IVT+CIDDLF8x4HD5zu/pufE=;
        b=dJnomHMlV1qef52u+on9JORq99k45J7b0osoK1nYmIQtKjBahnaCVv0AfGCxzAfX/m
         lf1NsK1U6/I+mxZtB6da+eBh3ixydAPsbBukdtK9lpDrLyYylgIAZOC9/JSuvIgO9Dh7
         O09DzechYYYpiXO7MxeBG+3RPk/uxBn9jPs0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PP5Y2DR/lCn+kG2DksnwcyOLRGoouWQzryr+/H7OTmLsGf2/bfecAwcxeROFHv39zm
         4r5EyIcxi3cyV9sUmBqxb9D9yqxsQK3F7qTPsoAdOrKhBVUpPVsctDgHuUAUQvQs5C7R
         Yxd8Kflu4gZ8SyEwKthJxv2MAxj6W18CEHv5o=
Received: by 10.100.212.9 with HTTP; Sat, 17 Apr 2010 08:27:44 -0700 (PDT)
In-Reply-To: <201004171700.22851.agruen@suse.de>
Received: by 10.101.210.6 with SMTP id m6mr6847139anq.207.1271518064362; Sat, 
	17 Apr 2010 08:27:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145151>

On Sat, Apr 17, 2010 at 17:00, Andreas Gruenbacher <agruen@suse.de> wrote:
> On Saturday 17 April 2010 16:44:05 Alex Riesen wrote:
>> I think something like this should make the accident more
>> noticable:
>
> Doesn't actually tell what the problem might be, though.
>

Oh, sorry. Somehow I thought, you did found what the problem is
(Git is not an archiving tool and does not store irregular files), and
just wanted to point at "git add" failing silently adding such a name.

In this particular case, the name you given to Git, is a device
entry point, which is filtered. Far too early, in my opinion, so
no sensible diagnostics can be produced. That's why I suggested
an exit with generic error message. I hope it is enough to at least
point the user to where a problem (like a fifo, device or socket
give in the command line) might be.
