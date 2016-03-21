From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 21:22:50 +0000
Message-ID: <CA+39Oz6A8WSFcXa4oALtuQK-uYJ+y43ZnFgqn3MRxQ4KSePWAw@mail.gmail.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
 <20160321202810.GD32071@sigill.intra.peff.net> <CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
 <20160321205043.GA436@sigill.intra.peff.net> <CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
 <20160321211834.GA1068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:23:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai7IG-0005p3-2l
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 22:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114AbcCUVXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 17:23:09 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37292 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953AbcCUVXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 17:23:06 -0400
Received: by mail-wm0-f44.google.com with SMTP id p65so138485111wmp.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xRBU2xtzSZ5B94XEw8wbA9juXg9pqXyZYH9pb0GZ9Bk=;
        b=Dg7yYf7OP6kozuBmzFsoQzZlW2yDf0kfwtUVLXyC1HcEoU370GmQ/8hiv04b/5nGIX
         TXlhQKXfg+pkCiZgdBKthA/wx3Im/ED6RBjk0dPE4V0bczE6pcYXs0CKJ5mHbl/hiYu4
         M/1GB9U88qIXT5NBZagXJOJbk+aEwC8M27Vrg0Y87tROQZHCN/PLDQRG8kxSA3hgXJrD
         FF+GBYMUM2aMiagHQGFBWOgJa23bq9ZZcAN8ftCQIynIaqJmGdGcjsQKyI5ZFVBzGOvK
         ihMnV6/nFP28bQA9mrJiq9mIDHLfnsVNNI6PWvRDgFvEGrKskOW6v0LC6cIiG4ol07bT
         +oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xRBU2xtzSZ5B94XEw8wbA9juXg9pqXyZYH9pb0GZ9Bk=;
        b=hYPNUiLIuWqIDtgGdc63BxgN6ITHg2qtFM9/PtQLS7Zt6+HjXuIJjGgPDzTjYdGgUZ
         zLfXNQ4tBXvCQ5vipLadxB/BIaFd42rRXBfWieateoOMtOhHUVKQ4FHGfHiWvKa4hrdB
         ZwQOPJ0WeueMshRvIWThOahZ9iukVpAYNoWkwskScTaZm2fGaqCofQnBWkayCSHE3aZB
         rUYMX/AIzz8+sVCZSWPVdwB1zHodt+bS/x1m3wP5nYZ/dwqtmhUcVgza/I+4Dr/OVWSM
         K2qJoYdc2kyy55ViRga+98uNJPc69WocFJsNlN2j2iu4PQLS7a+SCj8uzf3rxFKUoEJc
         NKtA==
X-Gm-Message-State: AD7BkJLMbCuVV6QlidX9cpz00SSpGlyUyFX3BRGqluuIU/enKlhMpReOyORBhgg3sJtnHxBDJ7w3w9QX+DGzug==
X-Received: by 10.194.58.169 with SMTP id s9mr32980073wjq.52.1458595385075;
 Mon, 21 Mar 2016 14:23:05 -0700 (PDT)
Received: by 10.194.110.168 with HTTP; Mon, 21 Mar 2016 14:22:50 -0700 (PDT)
In-Reply-To: <20160321211834.GA1068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289464>

On 21 March 2016 at 21:18, Jeff King <peff@peff.net> wrote:
> Again, just my opinion, but that looks awfully clunky. And it doesn't
> address the other messages (you might be behind origin/branch-X by N
> commits, or ahead by N, but only as of that particular date). Do we want
> to annotate every message whose value was computed based on a tracking
> branch?

Hmm.  I would hope not.  I'll wait for others to make a call on this,
but it's about all I can suggest without significantly bloating the
message which isn't desirable either.

>> No one's suggesting that this message is removed, I'm not sure where
>> you got that from?
>
> You said earlier:
>
>> [...]it's more a case of whether even printing that message is useful?
>
> I didn't know quite what you had in mind, which is why I asked. If we
> all agree that removing it is a bad idea, then good, we don't have to
> bother discussing that option. :)

Ah, oops!  I was meaning more, whether to print the message in the
case where the branch was uptodate, but now I appreciate it's cached.
Apologies for the confusion.

-- Thomas Adam
