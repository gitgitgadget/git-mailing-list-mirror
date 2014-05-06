From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] refs.c: add new functions reflog_exists and delete_reflog
Date: Tue, 6 May 2014 11:21:41 -0700
Message-ID: <CAL=YDW=41PZsMi4S51e_FFd_VVg8EbiMbXFzjd8vhy=bNZ12gQ@mail.gmail.com>
References: <1399330677-17930-1-git-send-email-sahlberg@google.com>
	<1399330677-17930-2-git-send-email-sahlberg@google.com>
	<5369060A.2050400@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 06 21:57:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whjzv-0005Pj-DW
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 20:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbaEFSVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 14:21:43 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:51943 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbaEFSVn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 14:21:43 -0400
Received: by mail-vc0-f173.google.com with SMTP id il7so1251672vcb.4
        for <git@vger.kernel.org>; Tue, 06 May 2014 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EYrVFrkMQ4XhLqf16KBG4hrnikxA6grgZcarK4ubh6U=;
        b=dpRPYyqIe1/jDXzFsIouxqXah/oxQJGD8k+VfTVdGhvWLMHEKa1ooWFOMh6bM6vFgt
         P1R5ooYU5Owh7zkkUIux/o8L8VPIN2EYoAEhFqJJmgF+URPBmYkZEga0CFDJQiOI1yAX
         ttR7FyMMfkZAvPJuX4wDMGxB/mExrtvzI6iG0U9/K5I0Q80kq4f++FtXCOT1Hia4AisC
         h4ESdK+oevcjc6TxIw74UbJdC6MwDuwclwe+e7HQ0H98e1jl9R4ypbZ7Gw6canIfshIK
         M8+nMRtD+BhPe+HBJh2bwXOPNSzm1pgyK0USlBbX0u0LECY2Xws9kBx/04Secfn0tquO
         +eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EYrVFrkMQ4XhLqf16KBG4hrnikxA6grgZcarK4ubh6U=;
        b=lzfds7gJERXiCs3/JJ3L7+Pn/sEGj0sX8EvVUVEIGG3lOba7i31fXzIZ/Zw3ThiVxE
         ATNkES3X3Qe2/aM7EoyziWOXlo0E0i8BcMzyaNFvSvRIWSska9zWppqMWVtOlOKJCuKL
         XYE6NCtkSp30nbEGoQMxe06ERYXcZ7/bs5Idz9ACJExiOvznaZTY01rbCWkfijs8s+4X
         +iRsxT1hvZKgQc2llMlY7csrvU92Pf2manCpvIdjbWU5VJudV6oV3ewO4tG00Dbb2+Bg
         JTEmTSeFAFzRgiFneutBQvS7BFry6dap7is8GihgAX0Eg6GGLvZttgqrZHfxeV2CZgAe
         rtkQ==
X-Gm-Message-State: ALoCoQnf89FSShRN+STCm81n5k6mZyAs2bKZagbdxcAddajBPUXdTG9cs6ZIT98MjYrkCW362H5W
X-Received: by 10.58.243.4 with SMTP id wu4mr1713895vec.67.1399400501979; Tue,
 06 May 2014 11:21:41 -0700 (PDT)
Received: by 10.52.0.139 with HTTP; Tue, 6 May 2014 11:21:41 -0700 (PDT)
In-Reply-To: <5369060A.2050400@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248226>

Thanks.

On Tue, May 6, 2014 at 8:55 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/06/2014 12:57 AM, Ronnie Sahlberg wrote:
>> Add two new functions, reflog_exists and delete_reflog to hide the internal
>
> Need comma after "delete_reflog".

Done. And the other typos too.
>
>> reflog implementation (that they are files under .git/logs/...) from callers.
>> Update checkout.c to use these functions in update_refs_for_switch instead of
>> building pathnames and calling out to file access functions. Update reflog.c
>> to use these too check if the reflog exists. Now there are still many places
>
> s/too/to/
>
>> in reflog.c where we are still leaking the reflog storage implementation but
>> this at least reduces the number of such dependencies by one. Finally
>> change two places in refs.c itself to use the new function to check if a ref
>> exists or not isntead of build-path-and-stat(). Now, this is strictly not all
>
> s/isntead/instead/
>
>> that important since these are in parts of refs that are implementing the
>> actual file storage backend but on the other hand it will not hurt either.
>
> As an aside, I expect long term that reflog handling will be married
> more tightly to reference handling and probably both will become
> pluggable via a single mechanism.
>
>> In config.c we also change to use the existing function ref_exists instead of
>
> s/config.c/checkout.c/
>
>> checking if the loose ref file exist. The previous code made the assumption
>> that the branch we switched from must exist as a loose ref and thus checking
>> the file would be sufficent. I think that assumption is always true in the
>
> s/sufficent/sufficient/
>
>> current code but it is still somewhat fragile since if git would change so that
>> the checkedout branch could exist as a packed ref without a corresponding
>
> s/checkedout/checked-out/
>
>> loose ref then this subtle 'does the lose ref not exist' check would suddenly
>> fail.
>
> I don't understand.  It can *already* be the case that the checked-out
> branch only exists as a packed reference:
>
>     $ git checkout master
>     $ git pack-refs --all
>     $ find .git/refs -type f
>     $
>
> So we already have a bug:
>
>     $ git config core.logallrefupdates true
>     $ git commit -m Initial --allow-empty
>     [master (root-commit) 3a03d51] Initial
>     $ git branch foo
>     $ git pack-refs --all
>     $ find .git/{refs,logs} -type f
>     .git/logs/HEAD
>     .git/logs/refs/heads/foo
>     .git/logs/refs/heads/master
>     $ git checkout foo
>     Switched to branch 'foo'
>     $ find .git/{refs,logs} -type f
>     .git/logs/HEAD
>     .git/logs/refs/heads/foo
>     $ history | tail -10
>
> Note that the reflog for refs/heads/master is incorrectly deleted when
> we run "git checkout foo".
>
> By the way, in case it wasn't clear to you I think the code in question
> is trying to avoid leaving a reflog file behind when leaving an orphan
> branch that hasn't actually been created yet.  So I think your change to
> using ref_exists() will indeed fix the bug (but please test!)

I tested with the sequence above and it does indeed fix the issue.
I will put this change in a separate patch and create a test for it.

>
> Given that this is a real bug, I suggest breaking this change out into a
> separate patch with a corresponding addition to the test suite.

Will do.

>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/checkout.c |  8 ++------
>>  builtin/reflog.c   |  2 +-
>>  refs.c             | 20 ++++++++++++++------
>>  refs.h             |  6 ++++++
>>  4 files changed, 23 insertions(+), 13 deletions(-)
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index ff44921..f1dc56e 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -651,12 +651,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>>                       }
>>               }
>>               if (old->path && old->name) {
>> -                     char log_file[PATH_MAX], ref_file[PATH_MAX];
>> -
>> -                     git_snpath(log_file, sizeof(log_file), "logs/%s", old->path);
>> -                     git_snpath(ref_file, sizeof(ref_file), "%s", old->path);
>> -                     if (!file_exists(ref_file) && file_exists(log_file))
>> -                             remove_path(log_file);
>> +                     if (!ref_exists(old->path) && reflog_exists(old->path))
>> +                             delete_reflog(old->path);
>>               }
>>       }
>>       remove_branch_state();
>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>> index c12a9784..0e7ea74 100644
>> --- a/builtin/reflog.c
>> +++ b/builtin/reflog.c
>> @@ -369,7 +369,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
>>       if (!lock)
>>               return error("cannot lock ref '%s'", ref);
>>       log_file = git_pathdup("logs/%s", ref);
>> -     if (!file_exists(log_file))
>> +     if (!ref_exists(ref))
>
> Shouldn't this be reflog_exists()?

Yes, fixed.

>
>>               goto finish;
>>       if (!cmd->dry_run) {
>>               newlog_path = git_pathdup("logs/%s.lock", ref);
>> diff --git a/refs.c b/refs.c
>> index e59bc18..7d12ac7 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2013,7 +2013,6 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
>>
>>       *log = NULL;
>>       for (p = ref_rev_parse_rules; *p; p++) {
>> -             struct stat st;
>>               unsigned char hash[20];
>>               char path[PATH_MAX];
>>               const char *ref, *it;
>> @@ -2022,12 +2021,9 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
>>               ref = resolve_ref_unsafe(path, hash, 1, NULL);
>>               if (!ref)
>>                       continue;
>> -             if (!stat(git_path("logs/%s", path), &st) &&
>> -                 S_ISREG(st.st_mode))
>> +             if (reflog_exists(path))
>>                       it = path;
>> -             else if (strcmp(ref, path) &&
>> -                      !stat(git_path("logs/%s", ref), &st) &&
>> -                      S_ISREG(st.st_mode))
>> +             else if (strcmp(ref, path) && reflog_exists(ref))
>>                       it = ref;
>>               else
>>                       continue;
>> @@ -3030,6 +3026,18 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
>>       return 1;
>>  }
>>
>> +int reflog_exists(const char *ref)
>
> We try to use the variable name "refname" for variables that hold the
> full names of references (the same comment applies to delete_reflog()).

Ok. Changed.

>
>> +{
>> +     struct stat st;
>> +
>> +     return !lstat(git_path("logs/%s", ref), &st) && S_ISREG(st.st_mode);
>> +}
>> +
>> +int delete_reflog(const char *ref)
>> +{
>> +     return remove_path(git_path("logs/%s", ref));
>> +}
>> +
>>  static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
>>  {
>>       unsigned char osha1[20], nsha1[20];
>> diff --git a/refs.h b/refs.h
>> index 71e39b9..5a93f27 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -159,6 +159,12 @@ extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
>>                      unsigned char *sha1, char **msg,
>>                      unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
>>
>> +/** Check if a particular ref log exists */
>> +extern int reflog_exists(const char *);
>
> We usually spell s/ref log/reflog/.  The same thing below.

Ok. Changed.

>
> My preference is that you give a name "refname" to the parameter in this
> function signature.  That makes it clear at a glance what is expected.
> (Though I admit that this practice is far from universally practiced in
> the Git project so maybe other people disagree.)

Ok. Changed.

>
>> +
>> +/** Delete a ref log */
>> +extern int delete_reflog(const char *);
>> +
>>  /* iterate over reflog entries */
>>  typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
>>  int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
>>
>
> Thanks!
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
