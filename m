From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [RFC/PATCH 1/2] log: add "log.showsignature" configuration variable
Date: Fri, 27 May 2016 11:34:34 +0530
Message-ID: <CA+DCAeTtKcCJOmDykErE_6JSJF+9FEdKs=qVQkP8DGCYKOyh_Q@mail.gmail.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
	<20160526130647.27001-2-mehul.jain2029@gmail.com>
	<20160526165946.GA18383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Austin English <austinenglish@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 08:04:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6At0-00022b-30
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 08:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbcE0GEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 02:04:37 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36446 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246AbcE0GEf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 02:04:35 -0400
Received: by mail-qk0-f194.google.com with SMTP id l68so11760510qkf.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 23:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=AR5dnGsQh6YZHaUUQ+ks2kVU5rFCwrjIm/x5pM3W94c=;
        b=HVgNa/ipmdNb2Wg6TjM+BTFs8MrG306tY7VFuRl/vNrB3eXUxTBsSWSxj91c95fEuh
         HEeiEd/uTudPzanto9uK2i/pkL+AjpsN6SbJWb4J3iMhY1oaqDaTqHT4Zeb8C6lvfPtr
         FlqsPp1v9IHYLs8nHK7d5ZQzlN7J0qvqYsNuMJNaKj0HX0QSNMevJxobf/dXo8ZDbMZA
         qSVsYIMNYAGEVIg8lgeH4SDwEHwykb1R9wFtjGHxR380+LJtEEv80tKUker+gf6AZ21o
         QBX/pu/uuLJ+6mrtRHm/4y9z0f1CsSxWL2y/RL/B7DsvwO9L/8zW7As6pJFy+ix23y4x
         CUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=AR5dnGsQh6YZHaUUQ+ks2kVU5rFCwrjIm/x5pM3W94c=;
        b=cj02+FpROfwcGaHcT/4sf8ChtEKMjcVDYMgv6PTUkrOhLhQUNMoBlAo+kjvNSCGEpg
         dtQch6Ao1/R91A7YSvIsqfXXRxQ1yxcYu1hHzumXrp4egTXtyaWP8d+a65JIhuy6Jx+2
         KT9/SB9KfnsPpi9fx32uaD20czRDXIDfQfvGk/sMimD8RLdnfvIdm4AoHA8Fq2VR4DI7
         lxqf+XIjLrIKH0bFwK6mr1t0ma4AVdOgRk7TyeZf7gfeqF4KO/ezDoLCa39KrNDm5X01
         a6u8RmKlydtfQR03VfhBX4jxPHFjrzNYY09nrDz0nRnM/DD/SD9miJPNZnW6TjAwW1N+
         jvKA==
X-Gm-Message-State: ALyK8tJxBaSWtDR0yF5ADVrIoJ5iIdL1b92XVpbrequTAJ1YzjDVQajTKk0ARffsnSvhKxi9Q08gqQMjdutlag==
X-Received: by 10.55.66.66 with SMTP id p63mr12102141qka.137.1464329074880;
 Thu, 26 May 2016 23:04:34 -0700 (PDT)
Received: by 10.55.51.212 with HTTP; Thu, 26 May 2016 23:04:34 -0700 (PDT)
In-Reply-To: <20160526165946.GA18383@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295733>

On Thu, May 26, 2016 at 10:29 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 26, 2016 at 06:36:46PM +0530, Mehul Jain wrote:
> The documentation here mentions "log" and "show". But I think this will
> affect other programs, too, including "whatchanged" and "reflog". Those
> ones are probably good, but the documentation is a little misleading (I
> think other options just say "git-log and related commands" or
> something).

Yes, the documentation is misleading. As you have mentioned, this
config variable will affect git-log, git-show, git-whatchanged and git-reflog.
I will mention them in the documentation.

>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 128ba93..36be9a1 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -890,6 +890,25 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
>>       grep "^| | gpg: Good signature" actual
>>  '
>>
>> +test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
>> +     git checkout -b test_sign master &&
>> +     echo foo >foo &&
>> +     git add foo &&
>> +     git commit -S -m signed_commit &&
>> +     test_config log.showsignature true &&
>> +     git log -1 signed >actual &&
>> +     test_i18ngrep "gpg: Signature made" actual &&
>> +     test_i18ngrep "gpg: Good signature" actual
>> +'
>
> You can see in the context that we do not use test_i18ngrep for finding
> gpg output in existing tests. I'm not sure if the new tests should be
> consistent, or if they should be changed to use test_i18ngrep. I don't
> think it's actually doing anything here, though. It's used with a
> git-specific GETTEXT_POISON flag that tweaks the output generated by
> git, but not by sub-programs like gpg.

There was no real motivation behind usage of test_i18ngrep. Certainly,
usage of grep will fit in the context.

>> +test_expect_success GPG '--show-signature overrides log.showsignature=false' '
>> +     test_when_finished "git reset --hard && git checkout master" &&
>> +     git config log.showsignature false &&
>
> Should this be test_config?

Noted.

Thanks,
Mehul
