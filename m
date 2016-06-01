From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Wed, 1 Jun 2016 21:00:25 +0700
Message-ID: <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com> <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 16:01:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b86hh-0002zg-Cb
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 16:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbcFAOA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 10:00:56 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38038 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbcFAOA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 10:00:56 -0400
Received: by mail-it0-f44.google.com with SMTP id i127so20240892ita.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G90nZ+/IOZwDucrhstx+WPOmf/fJfE5PmUvsILZ8NCk=;
        b=sQM59nsnpeniDqChLHNBt3Bqk/ro1Kk2yGFrNDmckx2/hdD0jIqWow4dJ3lKJ2vQhe
         q9Q9jKK6sSiHqNuVD+yZumFzUy/FCYwpWJItdVXLI6odcoDInYUUZk8vAixPA3YgIWlX
         0dqIGNH2wTIYoqTOs4IlnqneygUGP/KzjolbIrYyik7WzooGs5MqaMSdEOWiiorYaV+L
         6bVjXkCIHuwCxcHvgRjQ7I1cKaNFuMl5cbUtYvJKmR1IGC2yB4Co+xys+m+BJRr11S8d
         81NmdCRAOb7jPvhJ9T+zMCZBKPwcigfM65NVEbNsfFBkl35+PUWTfFxE0iW7h3NyMQuk
         /wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G90nZ+/IOZwDucrhstx+WPOmf/fJfE5PmUvsILZ8NCk=;
        b=LvjeldpX20qq5JN+Nrv0Bs3H9Scb/VrQ9TyF5gqaRXOYZ81AxkgKPPiRiP+SIu1/NH
         1LQNtfPACJqkKbC3IXdcEJCm/m+2w2ZH9IczjpUmZKssr8m3PkUz2niQCi0TsffNisfd
         2sV6NoGry+ZAcM6PBKfsRbPydzXPq+x8T91/livbVcOXAspVU7OvXFdv0ZiAYTqXjLfs
         Hjwv5mKRjLSF88BA0aCJDJjTspp2TRDxMGPJvYRBT6xjNzT1EpyagBjsB8JoTMbM8ysA
         LEwXZYvdz9J3FsQxqd6rhK/m0otxGcEQPR1Tc0cIphSVJlwWLQ/VWalaCdkgMVxuMxHr
         YWLw==
X-Gm-Message-State: ALyK8tLZIjNzQqiDZCQcBH/KsBdct0U/NWzxPNIlRrFt+/T8zgR4ybT+nbtjmPthVGBGC8eTLLeTmVjXJ43VUA==
X-Received: by 10.36.239.197 with SMTP id i188mr5456300ith.57.1464789655023;
 Wed, 01 Jun 2016 07:00:55 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 1 Jun 2016 07:00:25 -0700 (PDT)
In-Reply-To: <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296086>

On Tue, May 31, 2016 at 8:18 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>>> [3] http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020
>>
>> This points to  https://github.com/peff/git/commits/jk/external-odb
>> which is dead. Jeff, do you still have it somewhere, or is it not
>> worth looking at anymore?
>
> I have rebased, fixed and improved it a bit. I added write support for
> blobs. But the result is not very clean right now.
> I was going to send a RFC patch series after cleaning the result, but
> as you ask, here are some links to some branches:
>
> - https://github.com/chriscool/git/commits/gl-external-odb3 (the
> updated patches from Peff, plus 2 small patches from me)
> - https://github.com/chriscool/git/commits/gl-external-odb7 (the same
> as above, plus a number of WIP patches to add blob write support)

Thanks. I had a super quick look. It would be nice if you could give a
high level overview on this (if you're going to spend a lot more time on it).

One random thought, maybe it's better to have a daemon for external
odb right from the start (one for all odbs, or one per odb, I don't
know). It could do fancy stuff like object caching if necessary, and
it can avoid high cost handshake (e.g. via tls) every time a git
process runs and gets one object. Reducing process spawn would
definitely receive a big cheer from Windows crowd.

Any thought on object streaming support? It could be a big deal (might
affect some design decisions). I would also think about how pack v4
fits in this (e.g. how a tree walker can still walk fast, a big
promise of pack v4; I suppose if you still maintain "pack" concept
over external odb then it might work). Not that it really matters.
Pack v4 is the future, but the future can never be "today" :)
-- 
Duy
