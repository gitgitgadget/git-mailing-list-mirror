Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB7320899
	for <e@80x24.org>; Tue, 22 Aug 2017 09:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbdHVJgT (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 05:36:19 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57680 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbdHVJgS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 05:36:18 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LsNui-1dYqFp3PAm-011yIs; Tue, 22 Aug 2017 11:36:13 +0200
Subject: Re: [PATCH v2 3/3] merge: save merge state earlier
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, hIpPy <hippy2981@gmail.com>
References: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
 <cover.1503319519.git.git@grubix.eu>
 <407f205e2b824d56c652411256eea3c0047576ef.1503319519.git.git@grubix.eu>
 <xmqqk21w4et2.fsf@gitster.mtv.corp.google.com>
From:   Michael J Gruber <michael@grubix.eu>
Message-ID: <36bea69b-010a-9542-ec87-38b00d2bb009@grubix.eu>
Date:   Tue, 22 Aug 2017 11:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqk21w4et2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ZU25f07QsB7fnHrEscstM5ecvQPrQsxidP2teAQh8POlDYsHrCO
 0xa2ErFBGmRLZmJwUPad4KqqGgXH/dmfQGyO5gsC32yLfUZfgjORjqO6qvO9r0HArlZNjgB
 L+hCONlI9gvPTETbimY85yBQlUqgiAe39XYA0FSqgdjk2gc8pcXpmQrozpqrzmxAT6HKXqK
 qA3R6oiLwWUHsGVy73bEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e5WzFBR9BjA=:vpiUAHmiRy3LgD2OpdmY2m
 OW8xveiD29/qgZXUEkxZ/T/0u+O9Z9OTiqwZoAJogYCKNWj+r2wOpJIB/TATc5Ab5JpUwayvX
 ClS2i0u78LdFNlWtB1MuZ/QdLBu5blQ74rtnq2OupFbPlON8NtQs0sdBu055smxhQgiAojRyr
 C1OaiEvL+7+T0NbPLdvRVJct/RBiEnY3ijqO3rgF1EF52eAfT5NSkqwIDKEQ8X4FKiVS+uXBd
 mwzVBRXstNWT8wHmqRf9g/JCREQtN72PwEpIcxhMEMpSokzKqRPQa0yMu9NbcZAcbbk5DKLmZ
 g2eSmQE4/A/MBp1u2XXkVOmYt7urv8ChYqeMbFng8Sp1kqc3KX3V1x+BX5TUrYuiZadnnfL8D
 4hKWhHYJXN17E8dvpxbgR0VqMAi3mZOPYsj7wf9phN9mK660dDu+mUyWDK8mNGBaFeBBxffCW
 RXAfNFlA6v5bjkGUwsq1Vzsbk7dC8uiIZHEOZ4dgoGcLw2HUWdWPpb9HjlZ08pU86en+Vd6Zf
 sIb361ABBbcOE345iIV6dhOto2DOMmXGVS/VOtw8/Hjp5i+V72XzAc/3iqiyOpJPl/cv3K4/z
 tUSDX3lUZHGN36rhKqg07mCkPNx5CxzCqyleLj+qo/CaRaF5FujYGBkrdDnh0YOazDmVZE3wY
 EdzpEq3Mc7ygBPfcgdYmKYGNQbaVbAFUZDKRolmAzojoIhpvh9WhXKEoJa7AphSK+fIOLe0t3
 1Vt+9YGfVu2IggJtbfMIQ0ykVS4BQPNGKo+xzRTFd3PiCHRRvfIu6AYT2ps=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 22.08.2017 02:38:
> Michael J Gruber <git@grubix.eu> writes:
> 
>>  static void prepare_to_commit(struct commit_list *remoteheads)
>>  {
>>  	struct strbuf msg = STRBUF_INIT;
>> @@ -767,6 +768,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>>  		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
>>  	if (signoff)
>>  		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
>> +	if (!squash)
>> +		write_merge_heads(remoteheads);
>>  	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
>>  	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
>>  			    git_path_merge_msg(), "merge", NULL))
> 
> I can understand that you would never want to write out MERGE_HEAD
> while squashing, but I somehow think it would be a bug in the caller
> to call prepare_to_commit(), whose point is to prepare the merge
> message to be recorded in the resulting merge commit, when the user
> gave us the "--squash" option, which is an explicit instruction that
> the user does not want the merge commit the message is used.

That sounds reasonable. I vaguely remember a failing test for an earlier
version that I tried, but that was before the "split".

> Can squash ever be true in this function?
> 
> This function has two callsites: merge_trivial() and
> finish_automerge().
> 
> I think merge_trivial() will not be called under "--squash", which
> turns option_commit off and the only callsite of it is inside an
> else-if clause that requres option_commit to be true.  You can do a
> similar deduction around the "automerge_was_ok" variable to see if
> finish_automerge() can be called when "--squash" is given; I suspect
> the answer may be no.

I'll go without the if, after more testing.

>> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
>> index 2ebda509ac..80194b79f9 100755
>> --- a/t/t7600-merge.sh
>> +++ b/t/t7600-merge.sh
>> @@ -774,4 +774,19 @@ test_expect_success 'merge can be completed with --continue' '
>>  	verify_parents $c0 $c1
>>  '
>>  
>> +write_script .git/FAKE_EDITOR <<EOF
>> +# kill -TERM command added below.
>> +EOF
>> +
>> +test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue' '
>> +	git reset --hard c0 &&
>> +	! "$SHELL_PATH" -c '\''
>> +	  echo kill -TERM $$ >> .git/FAKE_EDITOR
>> +	  GIT_EDITOR=.git/FAKE_EDITOR
>> +	  export GIT_EDITOR
>> +	  exec git merge --no-ff --edit c1'\'' &&
> 
> This is a tricky construct.  You "reserve" a process ID by using a
> shell, arrange it to be killed and then using "exec" to make it the
> "git merge" program to be killed.  I kind of like the convolutedness.

That is from t7502. Sorry for hiding that note in the cover letter, I
should put it into 3/3's message or a test comment.

When testing, I simply used "git merge... &" and "ps" or "jobs" to know
which process to kill. Apparantly, the above is the most portable way to
script that. t7502 went through a few iterations to ensure this.

>> +	git merge --continue &&
>> +	verify_parents $c0 $c1
>> +'
>> +
>>  test_done
