From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 25 Mar 2016 23:37:54 +0530
Message-ID: <CA+DCAeRbD3S5Ltse3A6vBcvhKwh9t5av=Fnz98fD2ES5pbAN=Q@mail.gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cSdegoGNCMBMcHyEYiE+LUzixvdk-qu0Q-zbFvatX2=KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:08:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajW9Q-0005Ii-Ua
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbcCYSH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:07:56 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:32797 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcCYSHz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:07:55 -0400
Received: by mail-qg0-f51.google.com with SMTP id j35so66030356qge.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=QM7OOqmVKj62ziUyS5MudPJJLWqyxh2Y2AaAeIEOJOg=;
        b=SefWvQ+wqCo/rQjEgaZQR4M/Mvl1SFotSB+a+oC8Y7N4z26vBGngoWlA1R95mcyxQo
         ans9atvXONdPk7K9oEuFgIolq3QFSy5dflGOiDTYPfmjS1O+uiojlUyl9BEocfJ6BUOB
         i210PHxfumhGn7zPO8jBqvUHaCfE+jEH31wVRpb+wauWiUEP2a43F/r4Pr9h5DtLO/6H
         yiNp0W9KDm2nUCJSyRbcKFR5CeIyh0fM0n2dko2pn7JnafF5O7ynNzSsc9nk2B65A4xr
         7j106vPpGif0rGOBu+42OlE/26bHs1aNMzYnWcxxOlOuByWb2u6opQFyTE8x0/u5xbe2
         XeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QM7OOqmVKj62ziUyS5MudPJJLWqyxh2Y2AaAeIEOJOg=;
        b=gc8kWGzL6C4TU8It24TAkFt/u4WdUAkwDSGYxUedbQmDzU1DMkjIZHRUT0Ix1ZFDSl
         JOrxpJDfpFFrDqG1gqzHBoU01HVKSRnZqVHpoA+xrfLEBS3jVt+m396pKCTFryMF9QlL
         +o0IBkhu0Yvy2c+UaMqa4Gf8HCYFLUhMXT/id5Pewde0/mCA6VnPKnErWjp8hi/cm+B2
         JyKcHXxon2bJAO+chbOZsmZhD/01aWBW1DdTnbFokdHXudQBUe9klMEzBFj65awMGVj4
         B1Q6OzpDwqZnjlRSiH5qmSCznUrS3c1p6WvkcYlM5OT0mscRlZWoa1fibKlCFA9sjCga
         6FTA==
X-Gm-Message-State: AD7BkJJuUiZTVZenLAPAVTXqOQi/bg6aV4Pg8Lq0FEjJnzQ6oAEekck+N3KBf397B1t/y8PGp4X9xtZ8kpDurg==
X-Received: by 10.140.20.197 with SMTP id 63mr18790286qgj.18.1458929274423;
 Fri, 25 Mar 2016 11:07:54 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Fri, 25 Mar 2016 11:07:54 -0700 (PDT)
In-Reply-To: <CAPig+cSdegoGNCMBMcHyEYiE+LUzixvdk-qu0Q-zbFvatX2=KA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289924>

On Fri, Mar 25, 2016 at 2:01 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
>
> Nit: Some of the test titles spell this as "rebase.autostash" while
> others use "rebase.autoStash".

That's a mistake. All test titles must spell "rebase.autoStash".

>> +test_expect_success 'pull --rebase: --autostash & rebase.autoStash unset' '
>
> The title says that this is testing with rebase.autoStash unset,
> however, the test itself doesn't take any action to ensure that it is
> indeed unset.

Actually test_config unset the config variable once the test is complete.
Thus I felt that test_unconfig might not be needed.

>As with the two above tests which explicitly set
> rebase.autoStash, this test should explicitly unset rebase.autoStash
> to ensure consistent results even if some future change somehow
> pollutes the configuration globally. Therefore:
>
>     test_unconfig rebase.autostash &&
>

But considering this point, I'm convinced that indeed test_unconfig
should have been used.

>> +       git reset --hard before-rebase &&
>> +       echo dirty >new_file &&
>> +       git add new_file &&
>> +       git pull --rebase --autostash . copy &&
>> +       test_cmp_rev HEAD^ copy &&
>> +       test "$(cat new_file)" = dirty &&
>> +       test "$(cat file)" = "modified again"
>> +'
>
> With the addition of these three new tests, aside from the
> introductory 'test_{un}config', this exact sequence of commands is now
> repeated four times in the script. Such repetition suggests that the
> common code should be moved to a function. For instance:
>
>     test_rebase_autostash () {
>         git reset --hard before-rebase &&
>         echo dirty >new_file &&
>         git add new_file &&
>         git pull --rebase . copy &&
>         test_cmp_rev HEAD^ copy &&
>         test "$(cat new_file)" = dirty &&
>         test "$(cat file)" = "modified again"
>     }
>
> And, a caller would look like this:
>
>     test_expect_success 'pull ... rebase.autostash=true' '
>         test_config rebase.autostash true &&
>         test_rebase_autostash
>     '
>
> Of course, you'd also update the original test, from which this code
> was copied, to also call the new function. Factoring out the common
> code into a function should probably be done as a separate preparatory
> patch.
>
> This suggestion isn't mandatory and doesn't demand a re-roll, but, if
> you're feeling ambitious, it would make the code easier to digest and
> review.

Nice. This will increase fluency of the code and also lead to significant
reduction in number of new lines introduced by this patch.

>> +test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
>> +       test_config rebase.autostash true &&
>> +       git reset --hard before-rebase &&
>> +       echo dirty >new_file &&
>> +       git add new_file &&
>> +       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
>> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
>
> I don't care strongly, but many tests consider test_must_fail() alone
> sufficient to verify proper behavior and don't bother being more exact
> by checking the precise error message (since error messages sometimes
> get refined, thus requiring adjustments to the tests). If you do

Main reason to use test_i18ngrep here and check for this specific
error is that in future if some developer make changes which might
trigger git-pull not to die at die_on_unclean_work_tree() check (if
work tree is dirty) but leads git-pull to die somewhere else then
basically he/she will not understand the bug introduced by him/her as
test "pull --rebase --no-autostash & rebase.autostash=true" might pass.
test_i18ngrep will make sure that this does not happen.

> retain the error message check, it's often sufficient to check for
> just a fragment of the error string rather than the full message. For
> instance, it might be fine to grep merely for "uncommitted changes".

Yes, that will work too as no other error messages for git-pull contain these
words.

>> +'
>> +
>> +test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
>> +       test_config rebase.autostash false &&
>> +       git reset --hard before-rebase &&
>> +       echo dirty >new_file &&
>> +       git add new_file &&
>> +       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
>> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
>> +'
>> +
>> +test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
>
> Same comment as above:
>
>     test_unconfig rebase.autostash &&
>
>> +       git reset --hard before-rebase &&
>> +       echo dirty >new_file &&
>> +       git add new_file &&
>> +       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
>> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
>> +'
>
> Same comment as above about the common code shared by these three new
> test: moving it to a function is suggested.
>
>> +test_expect_success 'pull --autostash (without --rebase) should error out' '
>> +       test_must_fail git pull --autostash . copy 2>actual &&
>> +       echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
>> +       test_i18ncmp actual expect
>
> Same comment as above about checking the exact error message (vs. just
> trusting test_must_fail).
>
> Also, you mentioned in your cover letter that you couldn't use
> test_i18ngrep because grep was mistaking "--[no-]autostash" in the
> above expression as a command-line option. If you were using the exact
> string as above as an argument to test_i18ngrep, then it is more
> likely that the problem was that grep was seeing "[no-]" as a
> character class rather than as a literal pattern to match. You could
> get around this either by escaping the [ and ] with a backslash (\) or
> by passing -F to test_i18ngrep.
>
> Alternately, as mentioned above, just grep for a fragment of the error
> message, such as "only valid with --rebase", rather than the full
> diagnostic.
>
>> +'
>> +
>> +test_expect_success 'pull --no-autostash (without --rebase) should error out' '
>> +       test_must_fail git pull --no-autostash . copy 2>actual &&
>> +       echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
>> +       test_i18ncmp actual expect
>> +'
>
> Same comment as above about code common to these two tests. However,
> in this case, it might be easier simply to use a 'for' loop rather
> than a function:
>
>     for i in --autostash --no-autostash
>     do
>         test_expect_success "pull $i (without --rebase) is illegal" "
>            test_must_fail git pull $i . copy 2>actual &&
>            test_i18ngrep 'only valid with --rebase' actual
>         "
>     done
>
> Take special note of how use of double (") and single (') quotes
> differ in this case from other tests since $i needs to be interpolated
> into the test body.

I agree with all of these comments. I will introduce two new function to
reduce the code and the above mention loop. Also the work on Matthieu's
comment.

I feel that most of your comments are necessary and should be there in
the next patch. But I have a doubt regarding the next patch. As Junio has
merged v10 of current series in next branch (as noticed from his mail),
sending a new patch should be based on the current patch (i.e. on next
branch) or master branch (i.e. continuing with this series)?

Thanks,
Mehul
