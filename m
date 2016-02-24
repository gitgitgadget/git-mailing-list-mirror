From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 15:50:09 -0800
Message-ID: <CA+P7+xp=EOUHbn5hp0YijAW6sfmZeiD2yp72jVero4_WB-skkg@mail.gmail.com>
References: <1456344559-2822-1-git-send-email-jacob.e.keller@intel.com> <CAGZ79kbSd4TRdgdcj2NUrc+pL7ATrGQNcfTYd57TuJtyZ5QBwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:51:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjDU-00076Y-5C
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbcBXXua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:50:30 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33598 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcBXXu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 18:50:29 -0500
Received: by mail-io0-f182.google.com with SMTP id z135so71829632iof.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DMdOYcfH18hdn/veK0bL0WrfukoiqxyOS7X/S/ZobDY=;
        b=xQKuu28SgZ46Pg2pyntALp6wA/9kXk2w3Lh+4qvDI5o6VX4jrI2R6QBmd9zqLWTSkU
         Roh7aZidprmhC/lnsGSNrdgzEN/Toa+fwiWBcUYQ0tgYIywkCPjObY8sYeRyeE9jaIdI
         gZHPVX7bNeEcXmoph38gsECcp7CSjGSvb6aFQf0e2ungLrgGafHc00XrZKzs4NbVQgwi
         ZlLnROzq8CK7JuSn6dzyac9U1TgPuEaHcG+ZNx3dWQBoNHiToHP378GHrIIfn64FwpRL
         S1HVErsrAOgy6c1xVpBppzK3HgHHcbPtMv3h0y65WAXH1aX3Kc3sAo5ScqzVz9fR8iGK
         uQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DMdOYcfH18hdn/veK0bL0WrfukoiqxyOS7X/S/ZobDY=;
        b=ML3ReW+eJb0zEBzA4OVVf4HZXmB4Dm/z1MO8lO8QrZXJGcewMI9Er7++KnR4NuzX7O
         hpQvZah8LwgVHVZRiu+0nvaXlZEuPjkJ3vHwiiBeqYKcY+UKDYmvCErbeUiXXTAcbs/O
         ZWn02v3lafme/c6D6EGrwrMrP3OCCNPfxLDX8kl8Cl6NdjEulki2UNSeYhclPi8jFQnQ
         +RyleAxFlr0Dzzd3JaShWfezM9yO5OKcuEryN2NqvBQJ0KXpVwthIJT9lfvh8jVM0FpT
         SuQXKfwF8sHRjbfnXYuaMHPuuvBQk/rC+41i/F6C4pBZ/rWtSt10ookk8DUUIgxsMcYY
         pqrA==
X-Gm-Message-State: AG10YOQj55H63OxM5SmKgEdCtuxkiq+VOG5eM54qTRv4c4JdxMsofzd7LcRPCHOaZK4+U4kP1VZk8aflmcr8+g==
X-Received: by 10.107.170.79 with SMTP id t76mr265575ioe.71.1456357828605;
 Wed, 24 Feb 2016 15:50:28 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 24 Feb 2016 15:50:09 -0800 (PST)
In-Reply-To: <CAGZ79kbSd4TRdgdcj2NUrc+pL7ATrGQNcfTYd57TuJtyZ5QBwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287284>

Hi,

On Wed, Feb 24, 2016 at 3:27 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Feb 24, 2016 at 12:09 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>> Add a git submodule--helper function which can be used to sanitize the
>> GIT_CONFIG_PARAMETERS value to only allow certain settings. For now,
>> restrict this to only credential.* settings.
>
> I guess for now that subset is fine and will be expanded over time?
>

Yes, I figured that we would expand it as there became a reason to use
it.. If we instead blacklist things we may introduce many more issues
in the future.

>>
>> Replace all the calls to clear_local_git_env with a wrapped function
>> that filters GIT_CONFIG_PARAMETERS using the new helper and then
>> restores it to the filtered subset after clearing the rest of the
>> environment.
>
> The patch looks good to me, we should have introduced the submodule--helper
> test file earlier. I may migrate the test for the fix I send earlier
> today to that
> file eventually.
>

Ya, I didn't see any other tests for submodule--helper in master
branch yet, so I just added one.

>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index f4c3eff179b5..8194d3b3d1d5 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -255,6 +255,56 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>>         return 0;
>>  }
>>
>
> Probably this will cause easy to resolve merge conflicts with
> origin/sb/submodule-parallel-update
>

Yea I figured there would be some conflicts, but I based it on master
so it should be relatively easy to fix things up.

>> @@ -264,6 +314,7 @@ static struct cmd_struct commands[] = {
>>         {"list", module_list},
>>         {"name", module_name},
>>         {"clone", module_clone},
>> +       {"sanitize-config", module_sanitize_config},
>
> same here.
>
>> diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
>> new file mode 100755
>> index 000000000000..376f58afe967
>> --- /dev/null
>> +++ b/t/t7412-submodule--helper.sh
>
> Thanks for introducing such a file. I did not do it as I though it was
> "too small"
> and would not be enough to test to justify its own file.
>

I think that it makes more sense, since none of the other files really
fit the submodule--helper. In addition, I figure that "eventually" it
would go away after all of git-submodule.sh was re-written in C, and
git-submodule--helper is obsolete. That meant that having only a
single location for these tests would be easier to isolate and remove
them when we need to.

>> +
>> +test_expect_success 'sanitize-config clears configuration' '
>> +       git -c user.name="Some User" submodule--helper sanitize-config >actual &&
>> +       test_must_be_empty actual
>
> I usually keep my user.name in the global config, so no need to pass
> it around like that,
> but for testing purposes this looks good.

I just picked a simple key. This could really be anything, but I
figured that user.name is unlikely to be ever allowed to pass through
to submodules though it is probably harmless to do so. I don't believe
this is necessarily a valid case but rather just a way to make sure
that all configuration was not passed through.

Thanks,
Jake
