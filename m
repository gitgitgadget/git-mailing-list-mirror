From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Sat, 7 Dec 2013 14:30:40 -0600
Message-ID: <CAMP44s0sankG67rknVo=g5aOJXS_GZBh+hkr9cyVSiYrEvt83Q@mail.gmail.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
	<52a2f27bfe07_29836d5e98f5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 21:30:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpOWW-0006rE-Fk
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 21:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab3LGUam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 15:30:42 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:40608 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531Ab3LGUam (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 15:30:42 -0500
Received: by mail-la0-f53.google.com with SMTP id mc6so542604lab.40
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=j0pMiU9n2pzdTifxqKi6GnCB0Q5J1ySe4SB2jyKQpE8=;
        b=ppWYHiTG49XPOZVuoz3+Uguiyli6aGgteLmbKuSCdzxuQ2k9PAR6PAkw5DE5QLnvdu
         VTRk0gfo4Eg7YZ/KRm5HxgKduK0C5BePYQPZ0x0UBdLcdEZtqZV0cXOg2fkWB4JXus/7
         CHlj0mF3eWw2bBrSx4WYkqUq3KZjuWNVQJr7fBjVm+qI7HRH2HziVVZeSDEJgaRrRrWn
         kWBeOUj84wO9cLV7iAEpHOL3SZcZPNqbw7jSTJQohKVkEu+U9zAYA0LnhX/47XIPYZpL
         MZhywPOiDX4nHILUok6AycMWTClprrl82TFO09CZkTnRPxbLXW2T6nctGqYAQQzSw6W8
         dQRQ==
X-Received: by 10.152.4.162 with SMTP id l2mr27871lal.75.1386448240644; Sat,
 07 Dec 2013 12:30:40 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Sat, 7 Dec 2013 12:30:40 -0800 (PST)
In-Reply-To: <52a2f27bfe07_29836d5e98f5@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239018>

On Sat, Dec 7, 2013 at 4:03 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Junio C Hamano wrote:
>> * fc/transport-helper-fixes (2013-11-13) 12 commits
>>  - remote-bzr: support the new 'force' option
>>  - transport-helper: add support to delete branches
>>  - fast-export: add support to delete refs
>>  - fast-import: add support to delete refs
>>  - transport-helper: add support for old:new refspec
>>  - fast-export: add new --refspec option
>>  - fast-export: improve argument parsing
>>  - test-hg.sh: tests are now expected to pass
>>  - transport-helper: check for 'forced update' message
>>  - transport-helper: add 'force' to 'export' helpers
>>  - transport-helper: don't update refs in dry-run
>>  - transport-helper: mismerge fix
>>
>>  Updates transport-helper, fast-import and fast-export to allow the
>>  ref mapping and ref deletion in a way similar to the natively
>>  supported transports.
>>
>>  The option name "--refspec" needs to be rethought. It does not mean
>>  what refspec usually means, even though it shares the same syntax
>>  with refspec; calling it --refspec only because it shares the same
>>  syntax is like calling it --asciistring and does not make sense.
>
> Not true. remote.<name>.fetch is a refspec, and doesn't specify what to fetch,
> so does the "refspec" capability in remote helpers, and so does the proposed
> --refspec option.
>
> It is exactly what it already means.

Not to mention that you can apply the first part of the series without
any problems:

>>  - fast-export: improve argument parsing
>>  - test-hg.sh: tests are now expected to pass
>>  - transport-helper: check for 'forced update' message
>>  - transport-helper: add 'force' to 'export' helpers
>>  - transport-helper: don't update refs in dry-run
>>  - transport-helper: mismerge fix

Even:

>>  - remote-bzr: support the new 'force' option

The rest is for old:new :to-delete refspecs.

To take hostage the whole patch series because of the name --refspec
(which is perfectly fine) is just an excuse to not fix the issues
already present.

-- 
Felipe Contreras
