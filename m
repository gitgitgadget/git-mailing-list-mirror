From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Forcing git to pack objects
Date: Sun, 20 Dec 2015 03:25:20 +0100
Message-ID: <CAHYJk3Tzx29A+ZuOhXcxZThwZ98WmKC4aiwX32T=KA-7PTqs7g@mail.gmail.com>
References: <CAOc6etZePL=yvy=fVt9e=RmwdStJy6Kf621icYbYOER-NyMvXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 03:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aATgb-0003TU-UQ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 03:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbbLTCZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 21:25:22 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36522 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbLTCZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 21:25:21 -0500
Received: by mail-qk0-f176.google.com with SMTP id t125so125927872qkh.3
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 18:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YdePk6ADWXWsf6w8LYitDFg0FVycLlikX4qYAYXGKvo=;
        b=vbgatlfz/LGyQGGpiGqFpn1UBmwx3clJxmbsMBg+SarGkDCenucqc+W48qdFvu/0zN
         bl05hYaqUMDpMeVRtZtG3pwjOQgWwSAZKrQBdo1tWttx9vPbktwhQdep8OWnY7hdnE55
         DREC03P3xj9kbxoxEiwquEuBevzTqK6S9UJd8VZNm8QMvGBr3FD+Cht2XAORX3dLy06h
         en0mB9DHROMwSia1fmCwEVFs2x9Kjm8s5Dv7uY3Q7RGSQVohIxVbpCJDXFX2+ms3AnNu
         hxgrXGwOPFyOv4A6Cb1ZXZv1esOHIGijgn5+fYnLMrPBgiWE0TKjdbAtUtREFYgqPXLl
         08sg==
X-Received: by 10.55.75.77 with SMTP id y74mr15783637qka.19.1450578320563;
 Sat, 19 Dec 2015 18:25:20 -0800 (PST)
Received: by 10.55.38.202 with HTTP; Sat, 19 Dec 2015 18:25:20 -0800 (PST)
In-Reply-To: <CAOc6etZePL=yvy=fVt9e=RmwdStJy6Kf621icYbYOER-NyMvXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282756>

On Sat, Dec 19, 2015 at 2:03 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Hi!
>
> Recently I was running manually a git gc --prune command (wanted to
> shrink my 2.8G .git directory by getting rid of loose objects) and I
> ended up running out of space on my HD. After freaking out a little
> bit (didn't know if the repo would end up in a 'stable' state), I
> ended up freeing up some space and I again have a working repo...
> _but_ I noticed that basically _all_ objects on my repo are laying
> around in directories .git/objects/00 to ff (and taking a whole lot of
> space... like the .git directory is now like 5 GBs). After running git
> gc manually again it ended up taking a lot of time and the objects are
> still there. Also git svn sometimes gcs after fetching and it took to
> run cause of the gc execution (ended up killing it) and the files are
> still there. Is it possible to ask git to put all those objects in
> .pack files? Or did I mess something on my repo?
>
> Just in case, that's a repo I use at work that's working on a windows
> box (git for windows 2.6.3).
>
> Thanks in advance.

git repack -d should do it.

-- 
Mikael Magnusson
