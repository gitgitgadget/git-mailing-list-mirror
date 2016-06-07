From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 7 Jun 2016 10:46:07 +0200
Message-ID: <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com> <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 10:46:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bACeQ-00074f-7R
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 10:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbcFGIqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 04:46:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35711 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbcFGIqK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 04:46:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id k184so15856381wme.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+nKAhB8Q9djnpui1SY7/HhbmtUbBSF4huxY+tZxZY40=;
        b=xGbKxGa2z/mQG0wMjerz18rSXu6lL51bftpJNth943ERi5xvRNcFoZlVTtev2CPYla
         mv5892F/emM4b+zbdhf6+Nt1fQAKTbFuHCdrclNNkNw6JFx9FInr7U2Fh8h6RnGLocTz
         /kbnbvNeT7sosS5ETgkfLUg4XhBn05bN7biE4ySle9w32pbq+YhvirR4brqtVIek4Qk6
         daJcS2LUm83N5kKHnp/UPJe/BqJpGgPIsozz7VaL/X3AC5jPZnXTC6DMo/EQsPTilQTv
         tEUbkZcRwgVu8hF/DteIe/s5flO9gHkSuGygrev3fLjdnrtcV612Kqk3n8Q9xIWjRS2c
         P7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+nKAhB8Q9djnpui1SY7/HhbmtUbBSF4huxY+tZxZY40=;
        b=JBaUMrxyUsnOzx1qUkZDdcdEKBmDIq9S95ias9cd+opqFGLRji+naPjlRA6ZtCc4w1
         XQjjbsEmtSS8kjplE+hvgKdry5FdjVo6Pj56kwxMto+Qq9FXrC02lGk4XnZFJ+5wukyA
         HkRL/fqYOWTjMOOUFNQ9TDH8QevRFLD0Gspi/WZHm95gqb7zNeZj9l28H6eUpDraGuUk
         9WjjoTf4bCa9JtiU3khwc+AhqJZny48g2hkDMnOJo2H1bryXMRpRXGPnEOeZvJ6uIQyF
         NI9nsth4vwvJxaG5SFvmazIW2zU1zW3uODtAVFsn8lh1LJFANe+dexZ87RqjVnOXNGnL
         Vfcw==
X-Gm-Message-State: ALyK8tJIzuMxOsC847Vr/PaKCvv27TJG8ywlyiWhRI7QsvXPJudlumuFNjKAGe9YCWCeyPFVhqq9vKy0sTenXA==
X-Received: by 10.28.94.194 with SMTP id s185mr1545272wmb.62.1465289168166;
 Tue, 07 Jun 2016 01:46:08 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Tue, 7 Jun 2016 01:46:07 -0700 (PDT)
In-Reply-To: <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296617>

On Wed, Jun 1, 2016 at 4:00 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 31, 2016 at 8:18 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>>> [3] http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020
>>>
>>> This points to  https://github.com/peff/git/commits/jk/external-odb
>>> which is dead. Jeff, do you still have it somewhere, or is it not
>>> worth looking at anymore?
>>
>> I have rebased, fixed and improved it a bit. I added write support for
>> blobs. But the result is not very clean right now.
>> I was going to send a RFC patch series after cleaning the result, but
>> as you ask, here are some links to some branches:
>>
>> - https://github.com/chriscool/git/commits/gl-external-odb3 (the
>> updated patches from Peff, plus 2 small patches from me)
>> - https://github.com/chriscool/git/commits/gl-external-odb7 (the same
>> as above, plus a number of WIP patches to add blob write support)
>
> Thanks. I had a super quick look. It would be nice if you could give a
> high level overview on this (if you're going to spend a lot more time on it).

Sorry about the late answer.

Here is a new series after some cleanup:

https://github.com/chriscool/git/commits/gl-external-odb12

The high level overview of the patch series I would like to send
really soon now could go like this:

---
Git can store its objects only in the form of loose objects in
separate files or packed objects in a pack file.
To be able to better handle some kind of objects, for example big
blobs, it would be nice if Git could store its objects in other object
databases (ODB).

To do that, this patch series makes it possible to register commands,
using "odb.<odbname>.command" config variables, to access external
ODBs. Each specified command will then be called the following ways:

  - "<command> have": the command should output the sha1, size and
type of all the objects the external ODB contains, one object per
line.
  - "<command> get <sha1>": the command should then read from the
external ODB the content of the object corresponding to <sha1> and
output it on stdout.
  - "<command> put <sha1> <size> <type>": the command should then read
from stdin an object and store it in the external ODB.

This RFC patch series does not address the following important parts
of a complete solution:

  - There is no way to transfer external ODB content using Git.
  - No real external ODB has been interfaced with Git. The tests use
another git repo in a separate directory for this purpose which is
probably useless in the real world.
---

> One random thought, maybe it's better to have a daemon for external
> odb right from the start (one for all odbs, or one per odb, I don't
> know). It could do fancy stuff like object caching if necessary, and
> it can avoid high cost handshake (e.g. via tls) every time a git
> process runs and gets one object. Reducing process spawn would
> definitely receive a big cheer from Windows crowd.

The caching could be done inside Git and I am not sure it's worth
optimizing this now.
It could also make it more difficult to write support for an external
ODB if we required a daemon.
Maybe later we can add support for "odb.<odbname>.daemon" if we think
that this is worth it.

> Any thought on object streaming support?

No I didn't think about this. In fact I am not sure what this means.

> It could be a big deal (might
> affect some design decisions).

Could you elaborate on this?

> I would also think about how pack v4
> fits in this (e.g. how a tree walker can still walk fast, a big
> promise of pack v4; I suppose if you still maintain "pack" concept
> over external odb then it might work). Not that it really matters.
> Pack v4 is the future, but the future can never be "today" :)

Sorry I haven't really followed pack v4 and I forgot what it is about.

Thanks,
Christian.
