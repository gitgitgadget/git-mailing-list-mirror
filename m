Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801521F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdAaWMY (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:12:24 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:36757 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbdAaWMW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:12:22 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so4620335itd.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oVV3Y0ElNcA5I5XvVp6ebuGvv8sQMi32t0oNgN5zGVA=;
        b=b/nGeGchtuke73pSVV0QljNbGwBsT/Zsba+TTu6dyiAR4eslBHTptUtLlbodV4DkaQ
         /Q+lekPp038V65yulq8II80kB8yiUINZ+lCcnHup7wVYIqOnG2TWjce24vagMl9owxEM
         aR2wTkb5445KruBrgCCOzEDIHd3Vfv7O8vQu7R5ORC+1amODM4ZIcNLbk2jvRmxXkzcn
         cErRAcGCWttp5Xvz/j6D4cLogC5DOtu6v4l2femGxWAqXwbaQnva2MsQnYaGN1BhKv50
         QTzFHAj3QCKBgDVB3sXfiTHOrnv/twXFjki9AjdQJF5zTqkEnIip8xK2TuBCElrd9I/B
         zlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oVV3Y0ElNcA5I5XvVp6ebuGvv8sQMi32t0oNgN5zGVA=;
        b=QfiTsRGUXRQj1dwKjWt0mNNjZu7T1BcH6dKJD8ZpfmYbLJwrNao2OVVSAK8Y7zfF+H
         jfeonkxfXcNPa7otxdrLKFg7LVAWzLFMPGUsrmQy3fT2neRVDKQ7fTf0WMA1rs7PPM/t
         raNJW9I0KGMdbhhxewvk3FtRR4HMPbZRbKszc83nhu7Hy5ktvpB6sVhcWzL0KKfHBdM3
         EgnTt6rNTl12mt9OR3ZGNTh66ET6xgcbtk+vSiqDFgPFjYp/YHjgRzT/IVBXHT6jUIVW
         r7OQc3tHrNrUwiklD0EoQ5ewCJHtzxnRV3WI1x0EpuE+hdLcMRWk4B3j+GYJr3U5iFcP
         0icw==
X-Gm-Message-State: AIkVDXJDfMb9ik7DoTVFArJsRZn3rKYw4spgBbX5D44oTH/UGHsCxYOiUyt6DgzhFSJdUgFEDUJT3teY3MTuiI66
X-Received: by 10.36.65.4 with SMTP id x4mr22055133ita.69.1485900290220; Tue,
 31 Jan 2017 14:04:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 31 Jan 2017 14:04:49 -0800 (PST)
In-Reply-To: <b614a44a-fbc6-b5fe-ae40-ccf43dd9fcfb@gmail.com>
References: <0f14df64-1aa2-e671-9785-4e5e0a076ae6@gmail.com>
 <20170130175118.GA35626@google.com> <b614a44a-fbc6-b5fe-ae40-ccf43dd9fcfb@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Jan 2017 14:04:49 -0800
Message-ID: <CAGZ79kbCOHg9Sw01UvFe=Ek5Yf89q9Cw8VvQqVay8i-mVCEkEA@mail.gmail.com>
Subject: Re: gitconfig get out of sync with submodule entries on branch switch
To:     Benjamin Schindler <beschindler@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 30, 2017 at 11:46 PM, Benjamin Schindler
<beschindler@gmail.com> wrote:
> Hi Brandon
>
> I did try your suggestion, so basically:
>
> git checkout branch
> git submodule init
> git submodule update

Eventually this becomes

    git submudule update --init
    git checkout --recurse-submodules $branch


>
> Unfortunately, I still have two entries in my git config this way. It seems
> that git submodule update only considers submodules listed in .gitmodules.

Did you rename the name in the gitmodules file or rename the path on the FS?

>
> The background of my question is this - we have a jenkins farm which needs
> to switch branches continuously in an automated fashion and this needs to
> work even in when submodules are around. I did however, just now, find a
> reliable way to switch a branch, keeping the gitconfig in sync:
> The basic workflow for switching a branch is:
> git submodule deinit .

This will become 'git submodule deinit --all' eventually

> git checkout branch
> git submodule init
> git submodule update

This ought to update all the submodules, sounds fine to me.

>
> Because the .git folder of the submodules are not within the submodule
> directories, this is, while still quite heavy-handed, reasonably fast and
> robust. At least it is better than deleting the entire repository every time
> a branch switch is issued.

In the next version there will be 'git submodule absorbgitdirs'
which moves the git dirs of submodules inside the superproject; would
a reversion of this also be useful?

>
> Regards
>
> Benjamin Schindler
>
>
> On 30.01.2017 18:51, Brandon Williams wrote:
>>
>> On 01/30, Benjamin Schindler wrote:
>>>
>>> Hi
>>>
>>> Consider the following usecase: I have the master branch where I
>>> have a submodule A. I create a branch where I rename the submodule
>>> to be in the directory B. After doing all of this, everything looks
>>> good.
>>> Now, I switch back to master. The first oddity is, that it fails to
>>> remove the folder B because there are still files in there:
>>>
>>> bschindler@metis ~/Projects/submodule_test (testbranch) $ git
>>> checkout master
>>> warning: unable to rmdir other_submodule: Directory not empty
>>> Switched to branch 'master'
>>>
>>> Git submodule deinit on B fails because the submodule is not known
>>> to git anymore (after all, the folder B exists only in the other
>>> branch). I can easily just remove the folder B from disk and
>>> initialize the submodule A again, so all seems good.
>>>
>>> However, what is not good is that the submodule b is still known in
>>> .git/config. This is in particular a problem for us, because I know
>>> a number of tools which use git config to retrieve the submodule
>>> list. Is it therefore a bug that upon branch switch, the submodule
>>> gets deregistered, but its entry in .git/config remains?
>>>
>>> thanks a lot
>>> Benjamin Schindler
>>>
>>> P.s. I did not subscribe to the mailing list, please add me at least
>>> do CC. Thanks
>>
>> submodules and checkout don't really play nicely with each other at the
>> moment.  Stefan (cc'd) is currently working on a patch series to improve
>> the behavior of checkout with submodules.  Currently, if you want to
>> ensure you have a good working state after a checkout you should run
>> `git submodule update` to update all of the submoules.  As far as your
>> submodule still being listed in the config, that should be expected
>> given the scenario you described.
>>
>> If I'm understanding you correctly, A and B are both the same submodule
>> just renamed on a different branch.  The moment you add a submoule to a
>> repository it is given a name which is fixed.  Typically this is the
>> path from the root of the repository.  The thing is, since you are able
>> to freely move a submodule, its path can change.  To account for this
>> there is the .gitmodules file which allows you to do a lookup from
>> submodule name to the path at which it exists (or vice versa).  The
>> submodules that are stored in .git/config are those which are
>> 'initialize' or rather the submodules in which you are interested in and
>> will be updated by `git submodule update`.  So given your scenario you
>> should only have a single submodule in .git/config and the .gitmodules
>> file should have a single entry with a differing path for each branch.
>>
>> Hopefully this gives you a bit more information to work with.  Since
>> Stefan has been working with this more recently than me he may have some
>> more input.
>>
>
