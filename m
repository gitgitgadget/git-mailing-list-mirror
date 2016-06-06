From: Stefan Beller <sbeller@google.com>
Subject: Re: Minor Bug in Renaming Branches
Date: Mon, 6 Jun 2016 11:09:37 -0700
Message-ID: <CAGZ79kZg_ZjBS4gB+P68J+mpzGqkPNW+5NdrRiHmA0uC235RBQ@mail.gmail.com>
References: <CA+wHs3MSax1eo9V_5hnsbEte0k5tX22dAgSUAEzN7aw22rUnhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Samuel Lijin <samuel.lijin@formlabs.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 20:09:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9yy8-0004xJ-Ig
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 20:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbcFFSJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 14:09:40 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35625 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcFFSJj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 14:09:39 -0400
Received: by mail-qg0-f51.google.com with SMTP id 93so46416575qgx.2
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YSLSgNo67MUac0JoloTOypS1JAZG7JVO/fo/yh8ADFU=;
        b=on3ZHT79fQ5GO/bpy83dzpxn7Bs68h+LSqrAHwMLa4XaXthecnShqJMIto5KV4Dxq5
         QJZZ3dqSQgXXRxJ6Qi2qjRBuEqVUlXDzM8py3nKCVAPFMoKUYfLw88A5j3HI864p1gfr
         SeoGwnNCgLw+yqldkg/MdjTgsuecP8FWa99ZAVfAKl1Migk4lEt1rKeou8CHHZlgz1kL
         6Gta3zTQhkhNgRZQnWrb+G9iQOgATGyDjnCJPPYaZZxePeUQkzVp4wAX7lGOv/kbAoIo
         gv9MIlXmIo9PcOQ3Mg4ftKcNU2TcNuOiev1E18vYwL2NB9rSZ0OFKSpgltqjE0myE/cV
         ILIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YSLSgNo67MUac0JoloTOypS1JAZG7JVO/fo/yh8ADFU=;
        b=XS9VIJPI7UOB+yu/Zs/A7brnEF1IjwBcQQTl1UzySePR5jmjP1IXoX635H/Iz5UgeF
         cYn87MjrkYQjyY4coId/ewbSuiP5F7SNcDqg9BRLkot6utJViZ9QP5pnyThOqYAlV/po
         mk82gs0sDIqoM0EaYijcmk7Ii7TB3ok8Ef72H98rDFMbs0RIU1hO2HZSYdn//0hMwGmN
         VpRKcKlkkAi/nPLRAaSwP+mCJrwvCF22cclB4tvu7imph99lnkGt24oSxuI3E40B8Ubx
         69lVOBqznXoFuptNF+ds2zh+wQuSYFarKiRco0ZKzFM9u5O1eYzDLpo6bj0qlyo7e4qQ
         jgdw==
X-Gm-Message-State: ALyK8tJNoDMGmzKHG4LUhqsFDEuqk350C7RcTmpQvPTuWMXnT1juDJIZz3AdyYk002nS1NDx9hr+4LlXFx4GiXrA
X-Received: by 10.140.153.135 with SMTP id 129mr17372725qhz.71.1465236578390;
 Mon, 06 Jun 2016 11:09:38 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Mon, 6 Jun 2016 11:09:37 -0700 (PDT)
In-Reply-To: <CA+wHs3MSax1eo9V_5hnsbEte0k5tX22dAgSUAEzN7aw22rUnhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296546>

On Mon, Jun 6, 2016 at 10:52 AM, Samuel Lijin <samuel.lijin@formlabs.com> wrote:
> user@windows-box MINGW64 ~/sandbox (branch/name)
> $ git branch -m BRANCH/NAME
> fatal: A branch named 'BRANCH/NAME' already exists.

Yeah, branches/refs are treated as if they are files on a file system
(which they are currently). So depending on the file system used
you have problems with case sensitive things.
