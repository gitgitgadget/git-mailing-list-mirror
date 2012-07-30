From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 14:16:30 -0400
Message-ID: <CACPiFCKxYdF8G33myfjOXU31cDWrfrtedve8m89tH_tfOCZ4ng@mail.gmail.com>
References: <jv5tln$96e$1@dough.gmane.org> <alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
 <7vipd5s161.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jan Engelhardt <jengelh@inai.de>,
	Thomas Badie <thomas.badie@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 20:16:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvuWX-0005XE-4s
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 20:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab2G3SQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 14:16:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59230 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab2G3SQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 14:16:51 -0400
Received: by yenl2 with SMTP id l2so5138134yen.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WZcsgrc71IEEFSzDeCVP3QKt1LrFLWvMml2kwgNxTTs=;
        b=SYBs5jOZ65CzL2IHv58Yzxzy6RjBzX4rrKfXM27VM9uYRYBHWqdnB9k8spgqSOL3rZ
         cJ9on9FRBH0ySIwtbk5i73UcCWysLvHdXAMzoqpeS+FcfgZCnS7hMAVynfdwJrXCO6wk
         Ir7cXqeTP+8HeMv8efFiRV9CWhkDSKnVP7njgQ0TrlA2z/PHofNMVPZZt393W02ROj8B
         A5ioKo5Kg2+hwruBf0tOKzfgfmm6ua/JxUIMLzKgXC9LTVQ7dBu06a/bR41lRAHAHG/r
         x3j3arOEryX3iD3VhQ+Fz4TJeH0s4Z7qik5Ki+rtLj8MHMP0lHiWxvz1/1r9SiL6xS8S
         xwHQ==
Received: by 10.66.83.39 with SMTP id n7mr26263490pay.82.1343672211015; Mon,
 30 Jul 2012 11:16:51 -0700 (PDT)
Received: by 10.66.249.232 with HTTP; Mon, 30 Jul 2012 11:16:30 -0700 (PDT)
In-Reply-To: <7vipd5s161.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202601>

On Mon, Jul 30, 2012 at 11:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>         git show -s ':/^t1100-.*: Fix an interm'

That doesn't work for me (git 1.7.10.4 as per Fedora 18 rpms) in
git.git. But the idea is sound -- git can give you the sha1 trivially.
You don't need additional glue.

But any ref definition can be turned into a sha1 with this snippet:

    git show --pretty=format:%H HEAD

If you want to get the last 10 sha1s, use the same "pretty" with git log

   git log --pretty=format:%H HEAD | head

This is all predicated on passing the info to something else. For git
commands, you can always use the rich ref notation git supports.

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
