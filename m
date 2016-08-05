Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809F11F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbcHFUq7 (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:46:59 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36435 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbcHFUqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:46:51 -0400
Received: by mail-io0-f171.google.com with SMTP id b62so328125315iod.3
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:46:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eno9D1ew6B7o1gl5FllFl+quNOvUCYGBlyoOLN7Pkc4=;
        b=f2UoS0nJqwXeIHP0Pe6bYUKzidscopObNMF+V3MRVZnCaURaFJbvh0d3suS+60Qp5N
         o4X165+U/JDYa1yFfPyzBfYtsRYUSQk6VARr5+BmfRPNUKXi+GR73v+WYVBxT5qPn/iI
         oot6NpdpTQbHyPW778mSafLvbdI26HUatPde3ypQTEuI2dRD6IcB2HdBmweMs65YVxVf
         uW0joBBe4wqgJ5Wfh/ROPwZA+kHKZ0WAfrjLH3xJhqp3sA8WLGTjwcRXrvvy8JqpO+t8
         e5aMChacMEXZE390naLcRWZ58Z6ZlV2duORjz8sEwT6Ca2UcFC2m6ZptKUNBlOH9sS77
         j5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eno9D1ew6B7o1gl5FllFl+quNOvUCYGBlyoOLN7Pkc4=;
        b=dejelrCF81nBvWANIU/628nnq6q5zmH4FL7XT601BJpLXt0NXV9ur3z9+fhBWPdBvw
         StyFB6F6Y2BmTWSS1l0mHy/tX/2hOMETtO2DifT91Kqwx6JeX2vk71dwvdlxEQ4rVGIf
         /+Dmic8SSRAxvvo13ekHDp+tDWVZ/wbTR2NpiQDbGi6ZMf6ozkPi+oOorkUYaiijEC7G
         Wjs5BbL5VGZUSgEomhk7DYy6SrIl9z2y76nKrskqvZKotuz6t07NrN7Rdo6BBcrpY5ik
         Qdx2G2gkwTufHK9VDHFm/l7qnc/NslF1QvJHGZQOKpBkkn+nny7VUsDmdS4UZFFs+GfG
         NpHg==
X-Gm-Message-State: AEkoouvTeM8ADWOoGKO2RwohtUsFgcmi4crrB4o+l4BR5fcZWELYAEG6F/Nx7UysGdvjhQaTuMKrR7umSKsSPrGO
X-Received: by 10.107.144.10 with SMTP id s10mr79403189iod.165.1470437113527;
 Fri, 05 Aug 2016 15:45:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 5 Aug 2016 15:45:13 -0700 (PDT)
In-Reply-To: <xmqqeg63vtar.fsf@gitster.mtv.corp.google.com>
References: <20160804195159.7788-1-sbeller@google.com> <20160804195159.7788-3-sbeller@google.com>
 <xmqqeg63vtar.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 5 Aug 2016 15:45:13 -0700
Message-ID: <CAGZ79kZChXebtSJeTPGoZgnoKySDrWnD11NX7fyze+rOU=Jwvg@mail.gmail.com>
Subject: Re: [PATCH 2/6] t7408: merge short tests, factor out testing method
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>, mst@redhat.com,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Tests consisting of one line each can be consolidated to have fewer tests
>> to run as well as fewer lines of code.
>>
>> When having just a few git commands, do not create a new shell but
>> use the -C flag in Git to execute in the correct directory.
>
> Good motivations.
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  t/t7408-submodule-reference.sh | 50 +++++++++++++++---------------------------
>>  1 file changed, 18 insertions(+), 32 deletions(-)
>>
>> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
>> index afcc629..1416cbd 100755
>> --- a/t/t7408-submodule-reference.sh
>> +++ b/t/t7408-submodule-reference.sh
>> @@ -10,6 +10,16 @@ base_dir=$(pwd)
>>
>>  U=$base_dir/UPLOAD_LOG
>
> Is this line needed anywhere?
>
> We (perhaps unfortunately) still need $base_dir because we want to
> give an absolute file:/// URL to "submodule add", but I do not think
> we use $U, so let's get rid of it.
>
>> +test_alternate_usage()
>> +{
>
> According to Documentation/CodingGuidelines, this should be:
>
>     test_alternate_usage () {
>
> Somehow the helper name sounds as if it is testing if an alternate
> is used correctly (i.e. the machinery may attempt to use alternate
> but not in a correct way), not testing if an alternate is correctly
> used (i.e. the machinery incorrectly forgets to use an alternate at
> all), but maybe it is just me.
>
>> +     alternates_file=$1
>> +     working_dir=$2
>
> These are good (they can be on a single line), but you would
> want &&-chain just as other lines.
>
>> +     test_line_count = 1 $alternates_file &&
>
> This needs to quote "$alternates_file" especially in a helper
> function you have no control over future callers of.
>
> I wonder if we want to check the actual contents of the alternate;
> it may force us to worry about the infamous "should we expect
> $(pwd)/something or $PWD/something" if we did so, so it is not a
> strong suggestion.
>
>> +     echo "0 objects, 0 kilobytes" >expect &&
>> +     git -C $working_dir count-objects >current &&
>> +     diff expect current
>
> It is more customary to name two "expect" vs "actual", and compare
> them using "test_cmp" not "diff".
>
>> +}
>> +
>>  test_expect_success 'preparing first repository' '
>>       test_create_repo A &&
>>       (
>> @@ -42,44 +52,20 @@ test_expect_success 'preparing superproject' '
>>       )
>>  '
>>
>> -test_expect_success 'submodule add --reference' '
>> +test_expect_success 'submodule add --reference uses alternates' '
>>       (
>>               cd super &&
>>               git submodule add --reference ../B "file://$base_dir/A" sub &&
>>               git commit -m B-super-added
>> -     )
>> -'
>> -
>> -test_expect_success 'after add: existence of info/alternates' '
>> -     test_line_count = 1 super/.git/modules/sub/objects/info/alternates
>> -'
>> -
>> -test_expect_success 'that reference gets used with add' '
>> -     (
>> -             cd super/sub &&
>> -             echo "0 objects, 0 kilobytes" > expected &&
>> -             git count-objects > current &&
>> -             diff expected current

This is where the "diff" and "current" above came from.

>> -     )
>> -'
>
> Completely unrelated tangent, but after seeing the "how would we
> make a more intelligent choice of the diff boundary" topic, I
> wondered if we can notice that at this point there is a logical
> boundary and do something intelligent about it.  All the removed
> lines above have become "test_alternate" we see below, while all the
> removed lines below upto "test_alternate" correspond to the updated
> test at the end.

I guess that would require even more knowledge of the underlying
content that we track in Git.

Originally I started the diff boundary topic, as I assumed that the
new line detection is not doing harm. What Michael came up with
is impressive though I fear there might be a selection bias in the corpus,
i.e. we are missing some projects that get worse by it and these projects
would have had a great influence on the selection of the tuning parameters.
I guess we'll just wait until someone speaks up and points at worse
examples there.

What you're asking here is a complete new ballpark IMHO
as it takes diff to a whole new (syntactical) level. As of now
the world agrees that '\n' seems to be a good character to
put in text documents, so we use it as a splitting token
in our underlying diff driver, i.e. the diffs are primarily by line,
no matter how many characters change in that line. Sometimes
there is a "secondary" aspect such as coloring and pointing out
the characters that changed in a line[1].

[1] random example:
https://gerrit-review.googlesource.com/#/c/79354/3/project.py
Visually we focus on the changed characters, but the underlying
diff is still "by line".

We could write another "diff driver" that would not segment the
text by '\n' as a primary method and then showing the changed
hunks with +/-, but it would try to find rearrangements in the
underlying text:

As an example, this patch with such a diff driver could read partially as:
----8<----
***diff-driver: moved-text line 42 -> 14, length:7, post-operations: 1
 test_expect_success 'that reference gets used with add' '
      (
              cd super/sub &&
*             echo "0 objects, 0 kilobytes" > expected &&
*             git count-objects > current &&
*             diff expected current
      )
***diff-driver:post-operation 1:
*** modify moved text with:

+test_alternate_usage() {
+        alternates_file="$1" &&
+        working_dir="$2" &&
*             echo "0 objects, 0 kilobytes" > expected &&
*             git count-objects > current &&
*             diff expected current
+ }

***diff-driver: deletion 40,50

 -     )
 -'
 -
 -test_expect_success 'after add: existence of info/alternates' '
 -     test_line_count = 1 super/.git/modules/sub/objects/info/alternates
 -'
 -
----8<----

Thinking about this further, this would not require knowledge of
the underlying content, it is actually "just" an intra-file-rename
detection.

We have a rename detection from one blob to another, so we
could also have a similar thing to deduplicate within one blob,
which would track moving code around.


>
>> -test_expect_success 'cloning superproject' '
>> -     git clone super super-clone
>> -'
>> -
>> -test_expect_success 'update with reference' '
>> -     cd super-clone && git submodule update --init --reference ../B
>> -'
>> -
>> -test_expect_success 'after update: existence of info/alternates' '
>> -     test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates
>> +     ) &&
>> +     test_alternate_usage super/.git/modules/sub/objects/info/alternates super/sub
>>  '
>>
>> -test_expect_success 'that reference gets used with update' '
>> -     cd super-clone/sub &&
>> -     echo "0 objects, 0 kilobytes" > expected &&
>> -     git count-objects > current &&
>> -     diff expected current
>> +test_expect_success 'updating superproject keeps alternates' '
>> +     test_when_finished "rm -rf super-clone" &&
>
> This one is new; we do not remove A, B or super.  Does it matter if
> we leave super-clone behind?  Is super-clone so special?

"We need it in a later test."

It comes down to philosophy of how to write tests.

I spent some time in 740* and this is a surprising short test.
Compare to 7404 and 7400 for example. These are very long,
so when you want to add another test (no matter if testing for a
fixed regression or a new feature), you have lots of repos like

    super, super2, super3, sub, sub1, sumodule, anothersub,

and none of the names make sense. (Can I reuse them?
do they have some weird corner case configuration
that I need to undo? etc)

To stop that from happening again I want to have a clean slate,
i.e. all clones are deleted shortly after using, so it is obvious what
to use for testing.

>
>> +     git clone super super-clone &&
>> +     git -C super-clone submodule update --init --reference ../B &&
>> +     test_alternate_usage super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
>>  '
>>
>>  test_done
