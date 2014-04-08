From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] Remove the close_ref function.
Date: Tue, 8 Apr 2014 15:23:47 -0700
Message-ID: <CAL=YDWk3CkLG5P18GFhUKKQ9bEqOeJayNxKCiTMRtg-d4K_smw@mail.gmail.com>
References: <1396991830-20938-1-git-send-email-sahlberg@google.com>
	<1396991830-20938-2-git-send-email-sahlberg@google.com>
	<xmqqeh173301.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 00:23:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXeQv-0006zG-19
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 00:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929AbaDHWXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 18:23:53 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:43203 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246AbaDHWXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 18:23:48 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz11so1359386veb.5
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AKGid808ZDCbXCDkfkSjzTzlHR/cFRXI7OG6i0P738E=;
        b=c7dqziXbTP+jUibkF1NTJ1lkW8Mmeyj7kQ87lkSZAZfI/ZNHD9H26Nbvr5o469VGvQ
         bUtP9E+ooYiplNUb8vKEIHpSSUKaNTD8JnArpBBLuOIkUh5ky2RiuFy29Pzt8VWobT0c
         D5ODgb5aW8cf9tFFD9ktFILSkg5zl158eg/9aOJXBqKW63DoYt4H5U17Zxj5SpjllG+h
         gmZbfxy5rUaOMWvSpyxj0oIzMjbmue5oNYWmvgMYwiAPlLpBnQuPsnyyWLCGUwY9/oWD
         TP0Z0hh0T9litX9rkNdJm4GIzyW9RytSeVKWoZjsno4b5FQoGQPGUoQI79YEP+iWzdMh
         KfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AKGid808ZDCbXCDkfkSjzTzlHR/cFRXI7OG6i0P738E=;
        b=eaHF9DWbUCknXK9MqGwRtcRutNKkoT/oVNXGLsksRNLdwUDF2hWCOPbkWlYCzKqEI1
         YTEi+4A9g7AdNBNaiXNKmrMvQEAB0voNIDSfOuArQVZD1iE/cjHSAFy726Vc+p8JoleB
         dBItYx1upcd94h5B3e8Bv2PoZM2vffKcAqpMkCds36gVWcDfquej7jgRl1S2qWWtkV2R
         ffGzEl0Ix7BrLtJHw2xPbWckpqTb6hz8PAYRhZI7bUOk+YphdZxo+3B3x8V2RzkQte9+
         mrGFWzUxkNbH3nDVXgohqIjKaY9IR1PCgnkeqri33BnDJvMKgsHIyTRowaCSm7TazKxM
         UzZw==
X-Gm-Message-State: ALoCoQnxqtRbi+nXMRzFf5/zLH4QV8VDvB1AIGD0pnbsLl/99/Oyp1L21k2bhjeTj7+A8c68ZESKntAlo05z3jTzLfxKOtw+sSygiFimvr25T0Djjevsc2De9rrMWW9PBN4wxi4ihUpWJgkApPpjJIeNwFL3rOyTSXftTeJcPHozdovCuNN2nBlqCS/50lThIO/BZdK4tAef
X-Received: by 10.58.107.65 with SMTP id ha1mr5422268veb.1.1396995827623; Tue,
 08 Apr 2014 15:23:47 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 8 Apr 2014 15:23:47 -0700 (PDT)
In-Reply-To: <xmqqeh173301.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245963>

On Tue, Apr 8, 2014 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> @@ -2824,8 +2816,7 @@ int write_ref_sha1(struct ref_lock *lock,
>>               return -1;
>>       }
>>       if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
>> -         write_in_full(lock->lock_fd, &term, 1) != 1
>> -             || close_ref(lock) < 0) {
>> +         write_in_full(lock->lock_fd, &term, 1) != 1) {
>
> In the original code, we try to write the new object name and the
> line terminator, and also try to make sure that the file descriptor
> is successfully closed here.  Only when all of that is done
> successfully we go update the reflog and then after that, we commit
> the lockfile by renaming.
>
> With the updated code, these two write(2)s may succeed, but we would
> not know if the close(2) would succeed, until commit_lock_file() is
> called much later in this codepath.
>
> We would end up updating the reflog even when the close(2) of the
> ref fails.
>
> To be really paranoid, we should probably be doing an fsync(2)
> to make sure that the bytes written hit the disk platter, not just
> close(2), and such a change may be a good step in the direction to
> make the code more robust; in that light, the patch goes in the
> opposite direction "what it does is not robust enough anyway, so
> let's loosen it further".
>
> Hmm...
>

Good point. Thanks.
Please consider this patch abandoned.
