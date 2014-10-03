From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 19/24] refs.c: allow listing and deleting badly named refs
Date: Fri, 3 Oct 2014 13:25:34 -0700
Message-ID: <CAL=YDW=N1+XS+U=Vs0Sba0UqdN7+HRg5CTdZB28h5Ts3_yusYg@mail.gmail.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com>
	<20141002014817.GS1175@google.com>
	<20141002022819.GL1175@google.com>
	<xmqqa95envxa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 22:25:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9Q4-0008Fe-2a
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbaJCUZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:25:36 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:53782 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaJCUZf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:25:35 -0400
Received: by mail-vc0-f181.google.com with SMTP id le20so1188789vcb.12
        for <git@vger.kernel.org>; Fri, 03 Oct 2014 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fIbAIBUlO7lqy8uk7T1MA+gtxfqm/NvMoslmp2CsJ9M=;
        b=R8h3T6Igus0RfOoS5SScnl7PKxTCzMDfAZl52RcrVDL3+sMtXV86mLXjgVjQ0o5DaP
         Kq04jaYBXpNo5QV6G7+gUlyjWqM0mZu0pFCJUI6bh+4SwBxpUF1t0/6IP2hyYM4ZFWQj
         jM5Ul+zJYfKgV70DVN5OWv1VNl7H2zGaCM+XK87a+ifQ895hZps430xo4Qh+sPPP+3OK
         l6q14MLsM9ENzEsxC+vuqRYYpObe+H32ykoYK5/UPHleSKGq2GYG20vuDDWLltG2fg1P
         Pd1yQiONR8Ms/8UnvQmGBWkFJWbW0SQNGNhrCT3ToDj03UXHKmta/9MX/lQqVb/DOcSO
         TgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fIbAIBUlO7lqy8uk7T1MA+gtxfqm/NvMoslmp2CsJ9M=;
        b=kVwhG0PRLl2PPcm3ysVqisLVRTsoGFV1nZ3TOTmbIJfp2OA5kVeOg8i+ol1seWRDJF
         7C0rOnWiEwbvq/mBv4135IY0Gs+uO7DN1qhVyby5wIHfkcIw9TSAQTW5op/LVJqwtvDG
         EwCFSmErJ06U7+o2Fy7LkacpZb1ISXQJOUEAy6iVtovIhv+ffoZWZoj5oaddsoGAwicm
         HNEKcjNmZSgR4ic14dzrR9GiNSeKUebBwNdbRDBxxm+BbLpSGDzq23idaiL+qcmU5AnY
         X7KTpqxl0xbjRHJRw7RX/Kgy38j0zQLeKvIR9SfrrNCx8YAhk7N3LEpoKTGbJODsXD4h
         N5BQ==
X-Gm-Message-State: ALoCoQnP2A2Ahj5w+YXIFHAXftbEibfG51GJUz81lv+p7jhmy8pMBDDr52LJWix9b5mzH3n5+k8Q
X-Received: by 10.221.44.7 with SMTP id ue7mr5800604vcb.28.1412367934453; Fri,
 03 Oct 2014 13:25:34 -0700 (PDT)
Received: by 10.52.76.167 with HTTP; Fri, 3 Oct 2014 13:25:34 -0700 (PDT)
In-Reply-To: <xmqqa95envxa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257858>

On Thu, Oct 2, 2014 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> From: Ronnie Sahlberg <sahlberg@google.com>
>> ...
>> In resolving functions, refuse to resolve refs that don't pass the
>> check-ref-format(1) check unless the new RESOLVE_REF_ALLOW_BAD_NAME
>> flag is passed.  Even with RESOLVE_REF_ALLOW_BAD_NAME, refuse to
>> resolve refs that escape the refs/ directory and do not match the
>> pattern [A-Z_]* (think "HEAD" and "MERGE_HEAD").
>>
>> In locking functions, refuse to act on badly named refs unless they
>> are being deleted and either are in the refs/ directory or match [A-Z_]*.
>>
>> Just like other invalid refs, flag resolved, badly named refs with the
>> REF_ISBROKEN flag, treat them as resolving to null_sha1, and skip them
>> in all iteration functions except for for_each_rawref.
>>
>> Flag badly named refs with a REF_BAD_NAME flag to make it easier for
>> future callers to notice and handle them specially.
>>
>> In the transaction API, refuse to create or update badly named refs,
>> but allow deleting them (unless they escape refs/ and don't match
>> [A-Z_]*).
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.  We originally threw all the different kind of breakages
> into ISBROKEN, but a ref can have a malformed name or can contain a
> bad/non value and allowing us to tell them apart is a good direction
> to go.
>
>> diff --git a/cache.h b/cache.h
>> index 5ca7f2b..0c0ac60 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -978,16 +978,26 @@ extern int read_ref(const char *refname, unsigned char *sha1);
>>   * If flags is non-NULL, set the value that it points to the
>>   * combination of REF_ISPACKED (if the reference was found among the
>>   * packed references), REF_ISSYMREF (if the initial reference was a
>> - * symbolic reference) and REF_ISBROKEN (if the ref is malformed).
>> + * symbolic reference), REF_BAD_NAME (if the reference name is ill
>> + * formed --- see RESOLVE_REF_ALLOW_BAD_NAME below), and REF_ISBROKEN
>> + * (if the ref is malformed).
>
> You want to define "is malformed" here.
>
> The original defines REF_ISBROKEN as "malformed" because
>
>  (1) resolve_ref_unsafe() uses get_sha1_hex() and read_loose_refs()
>      uses read_ref_full(), both to catch "malformed values" stored;
>
>  (2) resolve_ref_unsafe() uses check_refname_format() and catches
>      "malformed names" stored as a symref target.
>
> I _think_ you are introducing ALLOW_BAD_NAME to allow add the third
> class ".git/refs/remotes/origin/mal..formed..name".  I do not know
> if they should be the same class as a symref with a good name
> ".git/refs/remotes/origin/HEAD" that points at a bad name
> "mal..formed..name", which is (2) above).  Perhaps not.  (2) is
> still above what is stored in the ref, and the ref in question may
> or may not have a well-formed name, which is orthogonal.
>
> So probably you left only the "value stored in the ref is malformed"
> (in other words, "we expected to find 40-hex object name but didn't
> find one") case for REF_ISBROKEN?

I updated cache.h to try to clarify it better.
The intention here is to expand the use of REF_ISBROKEN.

For all cases  REF_ISBROKEN will be set. This includes both "the sha1
value is bad" as well as "a name is bad".

For those cases where a name is bad then REF_BAD_NAME is also set. Bad
names are when either the ref itself has a bad name or when a bad name
is encountered while resolving a chain of symbilic refs.


I.e.  REF_BAD_NAME is a special case of broken ref. All REF_BAD_NAME
refs are also REF_ISBROKEN but not the reverse.


>
> Do we want to separate "value is not 40-hex" and "a symref points at
> a malformed refname" as separate "malformed value" errors?
>
>> + * RESOLVE_REF_ALLOW_BAD_NAME allows resolving refs even when their
>> + * name is invalid according to git-check-ref-format(1).  If the name
>> + * is bad then the value stored in sha1 will be null_sha1 and the
>> + * REF_ISBROKEN and REF_BAD_NAME flags will be set.
>
> Viewed with that light, I am not sure if a badly named ref should
> yield null_sha1[] (REF_ISBROKEN, which I am assuming is about a
> value that is badly formatted and cannot be read, should keep
> yielding it as before).  Wouldn't it make it harder for the user if
> you give null_sha1[] back to somebody who is trying to recover by
> reading "refs/heads/mal..formed", creating "refs/heads/sensible" to
> point at the same value and then removing the former?
>
> Note that I am not saying we should give back the parsed value at
> this step in the series.  Perhaps there are some existing callers
> that do not check for ISBROKEN flag and instead says "null_sha1[]
> ref is to be rejected/ignored", in which case they may need to be
> corrected before that happens.  Or there may be some reason I
> overlooked that makes it not so useful if we returned the object
> name stored in a ref whose name is malformed.  Just wondering.

The reason for these malformed refs resolving to null_sha1 is exactly
that. There may be callers that do not check ISBROKEN, so all those
callers need to be carefully audited before we start returning
potentially valid non null_sha1 here.
Right now I only want to do the minimal changes needed to open up only
those few paths I need to in order to allow the refs to be deleted.
For the delete case, returning the null_sha1 is sufficient.


Now, IF we add support to "rename a bad-ref-name to a good-ref-name",
then for that case we would need to start allowing resolve_ref_unsafe
to actually return the sha1 for the ref.
And that would require that we do those changes and audits. Given how
rare this should be, I am not convinced we need "rename bad to good"
at this point and would thus prefer to hold off adding that.

Thus, returning the object name is not so useful for the problem I try
to solve at this stage, namely "make delete work".


>
>> @@ -272,6 +272,37 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
>>       return dir;
>>  }
>>
>> +static int escapes_cwd(const char *path) {
>> +     char *buf;
>> +     int result;
>> +
>> +     if (is_absolute_path(path))
>> +             return 1;
>> +     buf = xmalloc(strlen(path) + 1);
>> +     result = !!normalize_path_copy(buf, path);
>> +     free(buf);
>> +     return result;
>> +}
>
> I think this function is misnamed for two reasons.
>
>  - It does not have anything to do with cwd; it does not make any
>    difference to the outcome of this function given the same input,
>    if 'pwd' says "/u/jc/git" or "/u/jc/git/Documentation", no?
>
>  - Even if this had something to do with cwd, I would expect a
>    function whose name is escapes_cwd("/u/jc/git/Documentation") to
>    yield false when 'pwd' says "/u/jc/git", but the implementation
>    unconditionally rejects absolute path.  In the context of the
>    (sole) caller of this function, which deals with a refname "refs/...",
>    it makes no sense to see an absolute path, but that does not have
>    anything to do with "does this path escape cwd?", no?
>

Agree.
I removed this function completely and just inline the !normalize_path_copy()
checks to make sure that refs/* paths remain within refs/.


>> +/*
>> + * Check if a refname is safe.
>> + * For refs that start with "refs/" we consider it safe as long as the rest
>> + * of the path components does not allow it to escape from this directory.
>> + * For all other refs we only consider them safe iff they only contain
>> + * upper case characters and '_'.
>> + */
>
> I presume that the exception is to accomodate for "HEAD", "ORIG_HEAD",
> "MERGE_HEAD" and friends, but you probably do not want the readers to
> guess.
>

I updated the commend to highlight that this is for "HEAD" and friends.

>> +static int refname_is_safe(const char *refname)
>> +{
>> +     if (starts_with(refname, "refs/"))
>> +             return !escapes_cwd(refname + strlen("refs/"));
>> +     while (*refname) {
>> +             if (!isupper(*refname) && *refname != '_')
>> +                     return 0;
>> +             refname++;
>> +     }
>> +     return 1;
>> +}
