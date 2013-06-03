From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git daemon --access-hook problem
Date: Sun, 2 Jun 2013 20:33:24 -0400
Message-ID: <CAPZPVFboSH_4ehpu0WMPOz86w1Ak5L5FWOyM8M43fStGqU5sGg@mail.gmail.com>
References: <CAPZPVFZDHHGyHhzBVVK6jS=XhEd2+JpmBT8ofiGOww8vuLUWWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 03 02:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjIiH-0004zv-SV
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 02:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab3FCAd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 20:33:26 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:40130 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab3FCAdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 20:33:25 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so8928885ieb.34
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=FFCPb2rLmGfjlP3gSAUMfY5oMGAm6VoMejakN+kTWAU=;
        b=xrnUI5ceFlgR7A4WvEpheyN7UUInzSmo0pR/yBnKSABH3kKxZ3FzBM9JGxhCQtK0Z4
         +6CP+EJm9IKs/fiFt1w/1Mw1zkA1RhJMN9uA3mm3FlnDKxzCs06zKrqWLofxIe6Zwnuz
         nn7eTPEz1v9LMFq+Q63v+4AdyC2xukTRk37NOD25d6RauGKF0w2GKNl/JH3bajZNvs8l
         Jgfod671qmoxcQVafk1aF9XEau6w+reEGwv7UUmHBhSir3wZ2obzTcl9DxS+Z5c/vwo9
         wm/tMfoxk5CN4ezsxX9KniJo36HqNzlzxblJi/P4fTZ1VJoRveZB8N9eTQ7jEkqgiKfI
         iHBw==
X-Received: by 10.50.106.114 with SMTP id gt18mr6681346igb.7.1370219604707;
 Sun, 02 Jun 2013 17:33:24 -0700 (PDT)
Received: by 10.43.85.7 with HTTP; Sun, 2 Jun 2013 17:33:24 -0700 (PDT)
In-Reply-To: <CAPZPVFZDHHGyHhzBVVK6jS=XhEd2+JpmBT8ofiGOww8vuLUWWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226200>

Anybody? Any ideas?

Thanks in advance!

Eugene

On Fri, May 31, 2013 at 4:22 PM, Eugene Sajine <euguess@gmail.com> wrote:
> Hi,
>
> I'm trying to test this new feature and having problems getting any
> results in the following scenario:
>
> i have a repo in local folder
>
> /home/users/myuser/repos/projectA/.git
>
> i start the daemon with the following:
>
> git daemon --export-all --base-path=/home/users/myuser/repos
> --enable=receive-pack --access-hook=/home/users/myuser/test_hook.bash
>
> test_hook.bash has the following:
>
> #!/bin/bash
> echo $@ >> test_hook_out.txt
> echo $REMOTE_ADDR >> test_hook_out.txt
>
> the hook is set to be executable - otherwise it complains when i do
> anything via git protocol, which proves that it seems to or check the
> hook:
>
> then i did:
>
> cd ~/tmp/
>
> git clone git://myhost/projectA projectA
> cd projectA
>
> and trying to perform some operations like fetch or push. It is cloned
> and fetches and pushes successfully.
> The problem is that the file test_hook_out.txt doesn't have anything
> in it after the execution, So the hook doesn't seem to work.
>
> What might be the issue here?
>
> Thanks,
> Eugene
