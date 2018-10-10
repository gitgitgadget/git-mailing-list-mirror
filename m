Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A79E1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeJKEr3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:47:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35408 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeJKEr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:47:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id y19-v6so6302148edd.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qOMN9JohOVCRpE+c4KAQdMfEmoGrCWLwwYdD7Jvvhww=;
        b=mUAo/glHeBUbxxlpV7Sq3xUWddPSF5PLQBIBTZFPLTmeLUKKPnDQFdJygENhAZuTTr
         aCoE9z7F05Yg0kFIDWB008PbdrhNgf0/Us65GUsl8ZI74G7Pkz0J80G7MINsG/7d/CRu
         xwMPmoai4rWr+jbKu8EWvAh/og3ztSXdr8PIjrwpFK2xPImI+HyOtXgXXZRqyb/qy3TA
         Bdxl04XCPD9CsoVrdYCBwpEDwuvh+OAXYR+GVSkFHIDacljvDwQeiHSFiF+jiRgXMNf1
         +WE9tPPVdpwi6NIlkIIwoTdcBZp5cXwj6xsYWLIkwcxXrrvC+P4wEOK8MTdftAb7dEnw
         rMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qOMN9JohOVCRpE+c4KAQdMfEmoGrCWLwwYdD7Jvvhww=;
        b=t7wslyAy5f+l7uWlctuuY9GqQ6iPgWbpmZRXHjwWNm2JcvpRL8nmOtI8NCO2tJ3TZq
         CoO81jOtPgRL8SNGuVd+QDgOUxugW2KePEOa4W3BRAC5DGnlFYv3/8qCk+Bg+uPu5egU
         rdsk3ooGHcJkow4mVphIRXkT/DbmO1VEUNlsdi7ALy3NDOjK0p2OcMBDza0al/y3P3uK
         l1SgOZClTUgmltBk2JZh0o97v9BxL6qv1cHdkUR73/MGybKG4mBizppa7uc7l1tsP4u0
         HYAMQB3130AtVXFG1uTKBXrLgoHjNQop7kD3NYxa4WoOpJdmTOzbiVwlNrFrDsHWkhBu
         eecg==
X-Gm-Message-State: ABuFfohL97G1idvzZcbfnDsB51TtyEDibhi9+y/L8XsQtScigcoxFlUc
        SrUarhNsxZnQCXZjtCW6cLk=
X-Google-Smtp-Source: ACcGV61hx2e/eABxs5nYmBuHGhgimx+nQ9I3U/Sm+JvRY7TeiIDxmTD75nRkm5Cvmi5A5Net7KRBSg==
X-Received: by 2002:a17:906:76d1:: with SMTP id q17-v6mr35035905ejn.150.1539206607089;
        Wed, 10 Oct 2018 14:23:27 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id c11-v6sm1696453ejr.6.2018.10.10.14.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:23:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: add an advice on unqualified <dst> push
References: <20181010104145.25610-1-avarab@gmail.com> <20181010104145.25610-3-avarab@gmail.com> <20181010205505.GB12949@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010205505.GB12949@sigill.intra.peff.net>
Date:   Wed, 10 Oct 2018 23:23:25 +0200
Message-ID: <87r2gxebsi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Jeff King wrote:

> On Wed, Oct 10, 2018 at 10:41:45AM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> Improve the error message added in f8aae12034 ("push: allow
>> unqualified dest refspecs to DWIM", 2008-04-23), which before this
>> change looks like this:
>>
>>     $ git push avar v2.19.0^{commit}:newbranch -n
>>     error: unable to push to unqualified destination: newbranch
>>     The destination refspec neither matches an existing ref on the remote nor
>>     begins with refs/, and we are unable to guess a prefix based on the source ref.
>>     error: failed to push some refs to 'git@github.com:avar/git.git'
>
> Thanks for looking into this. Despite being largely responsible for that
> message myself, I always cringe when I see it because it's so opaque.
>
>> This message needed to be read very carefully to spot how to fix the
>> error, i.e. to push to refs/heads/newbranch, and it didn't use the
>> advice system (since initial addition of the error predated it).
>>
>> Fix both of those, now the message will look like this instead:
>>
>>     $ ./git-push avar v2.19.0^{commit}:newbranch -n
>>     error: unable to push to unqualified destination: newbranch
>>     hint: The destination refspec neither matches an existing
>>     hint: ref on the remote nor begins with refs/, and we are
>>     hint: unable to guess a prefix based on the source ref.
>>     hint:
>>     hint: The <src> part of the refspec is a commit object.
>>     hint: Did you mean to create a new branch by pushing to
>>     hint: 'v2.19.0^{commit}:refs/heads/newbranch'?
>>     error: failed to push some refs to 'git@github.com:avar/git.git'
>>
>> When trying to push a tag, tree or a blob we suggest that perhaps the
>> user meant to push them to refs/tags/ instead.
>
> This is much better, and I love the customized behavior based on the
> object type.
>
> I wonder if we could reword the first paragraph to be a little less
> confusing, and spell out what we tried already. E.g., something like:
>
>   The destination you provided is not a full refname (i.e., starting
>   with "ref"). Git tried to guess what you meant by:
>
>     - looking for a matching branch or tag on the remote side
>
>     - looking at the refname of the local source
>
>   but neither worked.
>
>   The <src> part of the refspec is a commit object.
>   Did you mean...

Yeah that makes sense. I was trying to avoid touching the existing
wording to make this more surgical, but you came up with it, and since
you don't like it I'll just change that too.

> I'm not sure about saying "branch or tag" in the first bullet. It's
> friendlier to most users, but less technically correct (if you said
> "notes/foo", I believe we'd match an existing "refs/notes/foo", because
> it's really just using the normal lookup rules).
>
> Also, as an aside, I wonder if we should allow "heads/foo" to work as
> "refs/heads/foo" (even when no such ref already exists). But that is
> totally orthogonal to changing the message.
>
>> The if/else duplication for all of OBJ_{COMMIT,TAG,TREE,BLOB} is
>> unfortunate, but is required to correctly mark the messages for
>> translation.
>
> I think it would probably be OK to put the first paragraph in its own
> variable. I know we try to avoid translation lego, but I'd think
> paragraphs are separate units. Or are you worried about how to get them
> into the same advise() call? I don't know that we need to, but we could
> also plug one into the other with a "%s" (and leave a translator note).

To be honest from being on the code side of a much bigger i18n effort
(the MediaWiki/WikiMedia software) back in the early days of my career I
just do this sort of thing reflexively, because from experience when I
started trying to simplify stuff by making assumptions I was wrong every
time.

Although in that case there were >100+ languages, so maybe we can get
away with this.

In this case one red flag I see is that we make a reference to "the
source ref" in the first paragraph, and then in the second we'll either
talk about "commit", "tag" or "blob" etc. Now imagine a language where
those words have different genders, and where even secondary references
to those things ("the source ref") spill over and need to be changed
too.

You also get languages where a message that stretches multiple
paragraphs flows more naturally if the wording is re-arranged, even
between paragraphs. This is why document translation systems generally
split things by sections at best (not paragraphs), or just by whole
documents.

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 1546833213..fd455e2739 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -320,6 +320,13 @@ advice.*::
>>  		tries to overwrite a remote ref that points at an
>>  		object that is not a commit-ish, or make the remote
>>  		ref point at an object that is not a commit-ish.
>> +	pushAmbigiousRefName::
>> +		Shown when linkgit:git-push[1] gives up trying to
>> +		guess based on the source and destination refs what
>> +		remote ref namespace the source belongs in, but where
>> +		we can still suggest that the user push to either
>> +		refs/heads/* or refs/tags/* based on the type of the
>> +		source object.
>
> I guess you could argue that this is "ambiguous", but usually we'd use
> that term to mean "there were two branches that matched on the other
> side". But here it's actually "no branches matched" (actually, it makes
> me wonder what we'd do pushing "foo" when that name is ambiguous on the
> other side).
>
> So I wonder if this ought to be pushUnqualifiedRefname or something.

Yeah that sounds better. Will change it.

>> @@ -1046,13 +1047,60 @@ static int match_explicit(struct ref *src, struct ref *dst,
>>  		else if ((dst_guess = guess_ref(dst_value, matched_src))) {
>>  			matched_dst = make_linked_ref(dst_guess, dst_tail);
>>  			free(dst_guess);
>> -		} else
>> -			error(_("unable to push to unqualified destination: %s\n"
>> -				"The destination refspec neither matches an "
>> -				"existing ref on the remote nor\n"
>> -				"begins with refs/, and we are unable to "
>> -				"guess a prefix based on the source ref."),
>> -			      dst_value);
>> +		} else {
>> +			struct object_id oid;
>> +			enum object_type type;
>> +
>> +			error("unable to push to unqualified destination: %s", dst_value);
>> +			if (!advice_push_ambiguous_ref_name)
>> +				break;
>
> This break feels funny, because it controls flow much larger than this
> if/else. It does the right thing now, but it must remain in sync with
> what comes at the end of that long string of advise() messages.
>
> Can we just do it as:
>
>   if (advice_push_ambiguous_ref_name) {
> 	struct object_id oid;
> 	enum object_type type;
>
> 	if (get_oid(...))
> 	   etc...
>   }
>
> instead? That pushes your indentation one level in, but I think the
> whole conditional body might be cleaner in a helper function anyway.

I started out with that and found myself really constrained by the 72
char ceiling which I'm already smashing through with these ~95 character
lines (but at least it's under 100!). But sure, we can do with 8 more.
