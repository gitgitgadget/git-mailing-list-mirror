From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: wishlist; unify behavior while cloning non-bare repos over http
 to be in line with ssh/local
Date: Tue, 10 May 2016 13:33:40 -0700
Message-ID: <CA+P7+xoCmMV01=11GRVsuOSoTPgzSFT-VAeqa1SCcLnzpGcb0Q@mail.gmail.com>
References: <20160506131855.GD7907@onerussian.com> <20160510190652.GI7907@onerussian.com>
 <xmqqfutpoepz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yaroslav Halchenko <yoh@onerussian.com>,
	Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Michael Hanke <michael.hanke@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:34:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EM8-0005ZJ-AC
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbcEJUeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 16:34:04 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36048 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbcEJUeB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 16:34:01 -0400
Received: by mail-oi0-f43.google.com with SMTP id x201so35687553oif.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4rOtz62KsRhK2OXgmhUjq6IsFiRA01j9khXRapMXYmM=;
        b=UZ6CUZWHKXhhjXfHsKqpD0OYCoPUq2zPUvQNneAZwDuMCaCsV3KFUWFsdmE1suxPAL
         KO8oR63uoeOJamgU/QHD5InPW9cw+IWpJEXuveqE2zx8ZSgJ0BXiiYoFrQuDWjerTkbE
         JS9cmOM/fo3CRuXA3SxoWGAgrnNRhBuvYtXhQBxCSJfIiVCk/U/VlluK64WKiDCAQYKr
         IEWYHGGVYOBbu8MmxiSWujtFpT4531SGrvOMNpsJ5ETJ0jHd9Mvf5S4mrXHmXsVS3fWV
         dOywNgLr3h7PUVjzLNDDrRfdM1w+TEtfazDVP+ygkzKkl12q0S/xI60HpVfglsqZjb00
         NT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4rOtz62KsRhK2OXgmhUjq6IsFiRA01j9khXRapMXYmM=;
        b=a0Lum2+CZZLt5bLuddBhErAbCITxGduS4r6TfIN4PJvfHkAqXM9bm6gRhEAQ9QmJqo
         DXjyySas83PylOfHXqK4Y/GntHW+jhGnSjtnFGb+bhhqeZbTZ/3S35XbsEqu5egHEXte
         0h7MkESWrVjqTELPKEo6O5qXJr8kB5JozxdhWS76QcIAWywI1o/hBeUvtFOrwi2LC5ZE
         n+VSgMyJ+gIkPN0dVeu7jebic/NoiVNobxl9J7NxOB2DMjTCCefWWGIx+TiaSy2MHw3i
         B/ooQHrX4wGkINQk6z6RWIb7tJ1nGhjGtkOHQfvr76YVCgro+Ia7jhHBBKvQWtza3Y0n
         BS0A==
X-Gm-Message-State: AOPr4FWBKy49mdZf3NkY88EAv3TjF/6DyoinEDsxLKQrzlJTL8Mm64i94mI2Epre9rDS2Xo+NkEZkoGgYNk0Dw==
X-Received: by 10.157.36.135 with SMTP id z7mr3638931ota.69.1462912440207;
 Tue, 10 May 2016 13:34:00 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Tue, 10 May 2016 13:33:40 -0700 (PDT)
In-Reply-To: <xmqqfutpoepz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294187>

On Tue, May 10, 2016 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Yaroslav Halchenko <yoh@onerussian.com> writes:
>
>> On Fri, 06 May 2016, Yaroslav Halchenko wrote:
>>
>>> Dear Git Folks,
>>
>>> Originally this issue was mentioned in previous thread [1], and I have decided
>>> to bring it into a separate thread.  ATM there is a dichotomy in git behavior
>>> between cloning non-bare repos:  if I clone over ssh or just locally by
>>> providing url without trailing /.git, git senses for /.git and works just fine
>>> with ssh or local repositories, but fails for "dummy" http ones, the demo
>>> script is here [2] which produces output listed below.  From which you can see
>>> that  cloning using http URL to the repository without /.git fails (git version
>>> 2.8.1, Debian).  As it was noted in [1], concern could have been to not
>>> traverse website since could lead to dangerous places.  But .git is under
>>> originating url directory, as well as info/ or HEAD or any other object
>>> accessed by git, so IMHO this concern is not a concern.
>
> I am afraid that the reason why you saw no response is primarily
> because nobody is interested in extending dumb commit-walker HTTP
> transport after the world has largely moved on and abandoned it.
>
> The necessary update to the client might as simple as using
> $GIVEN_URL/.git/ and attempting the request again after seeing the
> probe for $GIVEN_URL/info/refs fails.
> --

I know at least Jenkin's Git plugin has a workaround to solve this
issue that is quite similar.

Thanks,
Jake
