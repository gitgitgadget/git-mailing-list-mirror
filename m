From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v2 08/29] Added more test cases for "guilt new": empty patches.
Date: Wed, 14 May 2014 22:38:08 +0200
Message-ID: <CAP=KgsRoi0P0zYYPD+aZX0FYi7eXL6cY5w-Y+rVJfjBhrhd+Ww@mail.gmail.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
	<1400013065-27919-9-git-send-email-cederp@opera.com>
	<20140514171040.GF1582@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 14 22:38:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkfwQ-0004H1-3u
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 22:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbaENUiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 16:38:10 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34398 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaENUiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 16:38:09 -0400
Received: by mail-ie0-f174.google.com with SMTP id at1so109860iec.33
        for <git@vger.kernel.org>; Wed, 14 May 2014 13:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OgEtsmy2+t6HhCsGUZ8NBgeLF+r6NzksxpmkSiFXgAY=;
        b=FbSgGwf4bfsVBSZKbPbwO3An0Ih+lUDdpTSkm/h0EQ8TRVaJZt44qOpycGVYRblATz
         6dYmZpRKDWQJAwoOxYkzsLDTnzp+vup5UiD5Qz0/hDo1m4AqVlwk63pIDmYkV9S9/cEf
         ciJsnn8o3lK1w4FCf1ItSbiBqqtiI4QATbDg3o0epstXm2iqURyDUfjc0JzPLBOt06QN
         OQYjDaHJHSiGXvQT+ZH4+2WjHho5MvvqwCCMbAb54ealRojAYPHzkQn05iq51JmNUq9e
         SVS5Ch1UQyZu8IwIFnsLzQm1zakoVzT6X+vODtvZti9DASE4bWaJnPRExS0VqRgQDydm
         wP1A==
X-Gm-Message-State: ALoCoQkkg1Z4WKjzdcz0zwvAoO6JGinLqKCTYeuYFf6cQw0W3l9vJkqVlIB21T6Nl4b1+Y9Ykyze
X-Received: by 10.50.147.9 with SMTP id tg9mr69847646igb.31.1400099888617;
 Wed, 14 May 2014 13:38:08 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Wed, 14 May 2014 13:38:08 -0700 (PDT)
In-Reply-To: <20140514171040.GF1582@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248949>

On Wed, May 14, 2014 at 7:10 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Tue, May 13, 2014 at 10:30:44PM +0200, Per Cederqvist wrote:
>> Test that empty patches are handled correctly, both with and without
>> the guilt.diffstat configuration option.
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  regression/t-020.out | 250 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  regression/t-020.sh  |  60 +++++++++++++
>>  2 files changed, 310 insertions(+)
>>
>> diff --git a/regression/t-020.out b/regression/t-020.out
>> index af45734..7e07efa 100644
>> --- a/regression/t-020.out
>> +++ b/regression/t-020.out
>> @@ -1128,3 +1128,253 @@ f 9c18cc7abe6b87f18503714a80a677b4094eb457  .git/patches/master/add
> ...
>> +% git log -p
>> +commit c7a139f532a43c3c8b0e068cac04f8f6af0f94e1
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    patch empty.patch
>> +
>> +commit d4850419ccc1146c7169f500725ce504b9774ed0
>> +Author: Author Name <author@email>
>> +Date:   Mon Jan 1 00:00:00 2007 +0000
>> +
>> +    initial
>> +
>> +    Signed-off-by: Commiter Name <commiter@email>
>> +
>> +diff --git a/def b/def
>> +new file mode 100644
>> +index 0000000..8baef1b
>> +--- /dev/null
>> ++++ b/def
>> +@@ -0,0 +1 @@
>> ++abc
>> +% git config guilt.diffstat false
>> +---
>> +
>
> I'm a bit confused about the above.  It looks like contents of an empty
> patch with an empty diffstat.  But the only time I see a cat in the .sh file
> is when you rewrite... oh I got it.  I'll comment about it by the 'cat'.
>
> ...
>> diff --git a/regression/t-020.sh b/regression/t-020.sh
>> index cdd08ba..906aec6 100755
>> --- a/regression/t-020.sh
>> +++ b/regression/t-020.sh
>> @@ -5,6 +5,13 @@
>>
>>  source "$REG_DIR/scaffold"
>>
>> +function fixup_time_info
>> +{
>> +     cmd guilt pop
>> +     touch -a -m -t "$TOUCH_DATE" ".git/patches/master/$1"
>> +     cmd guilt push
>> +}
>> +
>>  cmd setup_repo
>>
>>  #
>> @@ -69,6 +76,59 @@ done
>>
>>  cmd list_files
>>
>> +# push an empty patch with no commit message
>> +cmd guilt new empty.patch
>> +fixup_time_info empty.patch
>> +cmd list_files
>> +cmd git log -p
>> +
>> +# Ensure we can push the empty patch even when guilt.diffstat is true.
>> +cmd git config guilt.diffstat true
>> +cmd guilt refresh
>> +fixup_time_info empty.patch
>> +cmd list_files
>> +cmd git log -p
>> +cmd git config guilt.diffstat false
>> +
>> +# Let the patch have a commit message, but no data.
>> +cat .git/patches/master/empty.patch <<EOF
>
> cat > .git/.../empty.patch <<EOF
> ...
> EOF
>
> Otherwise, you'll just cat the existing patch and that's it.

Yes. The intent was to modify empty.patch.  This is a bit
embarrassing, since it should have been obvious from
the output of "git log -p" that the modification didn't work
as I intended. :-)

I'll fix in the v3 series.

    /ceder

>> +Fix a bug.
>> +
>> +From: Per Cederqvist <ceder@lysator.liu.se>
>> +
>> +This commit fixes a serious bug.
>> +
>> +FIXME:
>> +    - add a test case
>> +    - track down the bug
>> +    - actually fix it
>> +EOF
>> +
>> +fixup_time_info empty.patch
>> +cmd list_files
>> +cmd git log -p
>> +
>> +# And once more, with an empty diffstat.
>> +
>> +cmd git config guilt.diffstat true
>> +cmd guilt refresh
>> +fixup_time_info empty.patch
>> +cmd list_files
>> +cmd git log -p
>> +
>> +# Restore the diffstat setting and remove the empty patch.
>> +cmd git config guilt.diffstat false
>> +cmd guilt refresh
>> +fixup_time_info empty.patch
>> +cmd list_files
>> +cmd git log -p
>> +# (Cannot delete an applied patch)
>> +shouldfail guilt delete empty.patch
>> +cmd guilt pop -a
>> +cmd guilt delete -f empty.patch
>> +cmd list_files
>> +cmd git log -p
>> +
>>  # FIXME:
>>  #   --all
>>  #   -a
>> --
>> 1.8.3.1
>>
>
> --
> Fact: 23.6% of all statistics are generated randomly.
