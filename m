From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 3/4] t5304: Ensure wanted files are not deleted
Date: Mon, 18 Jan 2016 10:54:50 -0600
Message-ID: <CAEtYS8TfcJBbO_QJGH-Z9a3AHLdsO+H+k_fAS2EtJOH8bVwFEg@mail.gmail.com>
References: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
	<cover.1452704305.git.dougk.ff7@gmail.com>
	<670a9d9268beb0d70fb877a7c62d769062babba9.1452704305.git.dougk.ff7@gmail.com>
	<xmqqmvs9mc6h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 17:54:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLD4y-0002Am-CT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 17:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbcARQyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 11:54:53 -0500
Received: from mail-qg0-f68.google.com ([209.85.192.68]:36300 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773AbcARQyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 11:54:51 -0500
Received: by mail-qg0-f68.google.com with SMTP id 6so57999251qgy.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 08:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P9YoALqRfFkjFRQNRrWYXk9URqEEMBs926WuWfWlfRs=;
        b=yWc8wHegVepHCYcxniDgxJoJHZle3Esh6QIGLnHKAXqtEhtsLOUHc/5zkJAgCUspE6
         BtAkSWLSGAaMWpXbNwQS/1vSJ9kENnatClBzd50KAdDjSDwXPfk3ozTbab5zPAaR7Nmt
         1vqOaW+lc3DGArtK44gIS6ZneJrnVRrbzHqkEqM5Vjliq+rp95fqwTk8Xmf2DACI4FdU
         7Vw0BYIZdBJPABJ1gsG5vRMKF+fgC2gv0r8BAxMuXgYffDCplEzCMiMX2ERuUL9mqCsN
         ylV0YxEC4UunjR6iBl+GsB72aDtytkUVD/ey0TsjM3dDca3tXCtcJFdHIznWD6SqX+9r
         dRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=P9YoALqRfFkjFRQNRrWYXk9URqEEMBs926WuWfWlfRs=;
        b=DOOutrdodS0ZqYiliubw4jUrbAVZSvDxjj5+WJLT6TEnX47HGCTLPJ9w6TuQg8vHim
         /djvupya2yJWoEALaD6IbZL/xOZIOU2U0z2YCHgE6jDdABW2ihJvjgIPXcxRpIYmzUIh
         OUpegueslhVhVIbifZrisHOpgClRANcLXd7p3iOzRpIwTZ/dmKb3Vy59AxfOnqeEueT+
         lxEFfhhJopUPHRVEGJhWlufGaCpIlJ5MmlRnTdyot2iwSf4ccRV0Vm1IHVktj1t5axox
         h28cCyXFI5ZEvL3dKu5Ivv6rl9nKrniD1CjhW3bC+de2K8rMPjcwH6SHO8bYIgdXjcqx
         xJug==
X-Gm-Message-State: ALoCoQkfa5Dv3kgRyXL71cTQ7ihhgbN0VzYAkV2EjZ0ihWcRFn87V9Ga0+mYq4ZuXlMnKClhAuWTKHFXJtsCCWzuxX36mJoLsw==
X-Received: by 10.140.42.139 with SMTP id c11mr32747578qga.5.1453136090565;
 Mon, 18 Jan 2016 08:54:50 -0800 (PST)
Received: by 10.55.15.148 with HTTP; Mon, 18 Jan 2016 08:54:50 -0800 (PST)
In-Reply-To: <xmqqmvs9mc6h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284293>

On Wed, Jan 13, 2016 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Doug Kelly <dougk.ff7@gmail.com> writes:
>
>> Subject: Re: [PATCH 3/4] t5304: Ensure wanted files are not deleted
>
> I'd suggest s/wanted/non-garbage/.
>

I'm okay with this.

>> Explicitly test for and ensure files that may be wanted are not
>> deleted during a gc operation.  These include .pack without .idx
>> (which may be in-flight), garbage in the directory, and .keep files
>> the user created.
>
> "garbage in the directory" is not well defined.  "files in the
> directory that clearly are not related to packing" is probably what
> you meant, but the definition of "related to packing" is still
> fuzzy.  Please clarify.

This is probably a good point.  Perhaps a better way to think about it
would be by rewording the paragraph to something like this:

Explicitly test for and ensure files that may either be desired by the user
or are possibly not garbage are not deleted during a gc operation.
These include .pack files missing a corresponding .idx file (possibly due
to it being in-flight), .keep files created by the user, and other
unknown garbage in the pack directory.  These files will still be identified
by "git count-objects -v", but should not be removed automatically by
gc.  Only files we are absolutely sure are unnecessary will be removed
as a part of the gc process.

>
> The following is me thinking aloud about things that you would need
> to think about while attempting to clarify this.
>
> What should the code do if we find
>
>     pack-b0a9d62a7471e58832a575a78d57f8fb26822125.frotz
>
> in $GIT_OBJECT_DIRECTORY/pack/ directory?  Is it a "garbage in the
> directory"?  The filename looks so similar to the usual things with
> know suffixes .pack, .idx, .bitmap, and .keep, that we may want to
> consider that it might be another file related to the packing left
> by a future version of Git and if we do not see corresponding .pack
> we would want to remove it?  Or do we want to do something else?
>
> What should "gc" do if we find
>
>     pack-frotz.idx
>
> without corresponding ".pack"?  Wouldn't it be safer to consider it
> a garbage unrelated to packing (because regular packing would have
> given it with 40-hex name, not "frotz") and leave it undeleted?
>

I think the above paragraph helps explain what we're doing and why.
In your examples, a somewhat valid looking pack file with an unknown
extension may be flagged as "garbage," but should not be deleted
during the gc.  Similarly, we decided that an .idx file with no
corresponding .pack was safe to delete (since the pack is written before
idx, and the initial performance problem was related to scanning a large
number of idx files).

I'm not saying there's nothing to be said for the difference in the base
filename without extension.  Currently, the logic to remove pack garbage
doesn't look at that, though: it only considers the extension, and what
related files are found in the directory.  Whether this is good or bad, I'm
not sure.  It certainly does what I need at fairly low risk, though.

Does this help clarify the situation more?

> Thanks.
>
>> Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
>> ---
>>  t/t5304-prune.sh | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
>> index 4fa6e7a..f7c380c 100755
>> --- a/t/t5304-prune.sh
>> +++ b/t/t5304-prune.sh
>> @@ -285,6 +285,23 @@ EOF
>>       test_cmp expected actual
>>  '
>>
>> +test_expect_success 'ensure unknown garbage kept with gc' '
>> +     test_when_finished "rm -f .git/objects/pack/fake*" &&
>> +     test_when_finished "rm -f .git/objects/pack/foo*" &&
>> +     : >.git/objects/pack/foo.keep &&
>> +     : >.git/objects/pack/fake.pack &&
>> +     : >.git/objects/pack/fake2.foo &&
>> +     git gc &&
>> +     git count-objects -v 2>stderr &&
>> +     grep "^warning:" stderr | sort >actual &&
>> +     cat >expected <<\EOF &&
>> +warning: garbage found: .git/objects/pack/fake2.foo
>> +warning: no corresponding .idx or .pack: .git/objects/pack/foo.keep
>> +warning: no corresponding .idx: .git/objects/pack/fake.pack
>> +EOF
>> +     test_cmp expected actual
>> +'
>> +
>>  test_expect_success 'prune .git/shallow' '
>>       SHA1=`echo hi|git commit-tree HEAD^{tree}` &&
>>       echo $SHA1 >.git/shallow &&
