Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77CC720285
	for <e@80x24.org>; Thu, 24 Aug 2017 13:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbdHXNZM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 09:25:12 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:63632 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753058AbdHXNZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 09:25:09 -0400
Received: from [192.168.2.201] ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id ks8AdLYx1Ap17ks8AdYR51; Thu, 24 Aug 2017 14:25:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1503581107; bh=7edGyQbrBXI9uJ6+uCUfh0epdRTf8kWIo1gZgLuwNac=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NSB+UoM+DNWQkm1Hhw9SFf7yn1mHX3PnbAw8dU7yTHxkZieFTn0oco2b/WjOWiTFc
         8ohuOrwVNjW1W/ye2v2Ae4kS0XdyqAKQ3Uggg4yU8HmwCARhnCb635rsrgL0lte3DT
         NxdYWqeNOkEvWhcPbtF0KCS1fZlLV5mtwNiGs2IA=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=Mdh7YchmD2lePnj318EA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a
 rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
 <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
 <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
 <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
 <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
 <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net>
 <xmqqpocloqcp.fsf@gitster.mtv.corp.google.com>
 <a3b7af29-8b3a-5253-21da-957920212a6e@talktalk.net>
 <xmqqinhg5ysf.fsf@gitster.mtv.corp.google.com>
 <d1eaed1c-5e62-0a93-f65d-06be43812617@talktalk.net>
 <xmqqefs34mz4.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <5dcd588d-b6ce-713d-dc28-25853d5bb4b3@talktalk.net>
Date:   Thu, 24 Aug 2017 14:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqefs34mz4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPjOv/cBpMg9DsuSVKE4Y3Ks50iCmgpgmQWdmOKFILynR2jSTCQWnsns0jWRrdCf9f4qFGLEstUuJE3dp0wWWeyBPnBCsILGyh8niCUS9ZJXgGPD2jFl
 yxD90KQAVY378qGbN7egrLLRg6X+XL0Z1EVr4RgwK2ZrzRm5g6CPaAWJLl8Os9dMns35COtb8yFbQ7p5inj45BBLfkObcCGN8fkou4DxE+nOcMgcErUFKpSZ
 /lJaYxkI0ck3GTop2+HhJRghlN9skmyb0lvg0+CDNbk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/17 16:54, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>>> In other words, instead of
>>>
>>> 	git add -u && git rebase --continue
>>>
>>> you would want a quicker way to say
>>>
>>> 	git rebase --continue $something_here 
>>
>> Exactly
>> ...
>> rebase --continue -a
>>
>> behaves like commit -a in that it commits all updated tracked files and
>> does not take pathspecs.
> 
> Hmph, but what 'a' in "commit -a" wants to convey is "all", and in
> the context of "rebase" we want to avoid saying "all".  A user can
> be confused into thinking "all" refers to "all subsequent commits" 
> not "all paths conflicted".
> 
> Besides, with the $something_here option, the user is explicitly
> telling us that the user finisished the resolution of conflicts left
> in the working tree.  There is nothing "auto" about it.
> 
>> Did you have any further thoughts on what checks if any this new option
>> should make to avoid staging obviously unresolved files?
> 
> The more I think about this, the more I am convinced that it is a
> very bad idea to give such a $something_here option only to "rebase".
> 
> The standard flow for any operation that could stop in the middle
> because the command needs help from the user with conflicts that
> cannot be mechanically resolved is
> 
>  (1) write out conflicted state in the working tree, and mark these
>      paths in the index by leaving them in higher stages
>      (i.e. "ls-files -u" would list them);
> 
>  (2) the user edits them and marks the ones that are now resolved;
> 
>  (3) the user tells us to "continue".
> 
> and this is not limited to "rebase".  "cherry-pick", "am", and
> "revert" all share the above, and even "merge" (which is a single
> commit operation to which "continue" in its original meaning---to
> tell us the user is done with this step and wants us to go on
> processing further commits or patches---does not quite apply) does.
> 
> And "rebase" is an oddball in that it is the only command that we
> could deduce which files in the working tree should be "add"ed, i.e.
> "all the files that are different from HEAD".  All others allow
> users to begin in a dirty working tree (they only require the index
> to be clean), 

Are you sure about that, the second sentence of the cherry-pick man page
is "This requires your working tree to be clean (no modifications from
the HEAD commit).". If you pass '--no-commit' then this is relaxed so
that the index can differ from HEAD but it is not clear from the man
page if the working tree can differ from the index (potentially that
could give different conflicts in the index and working tree). I'm not
sure what a rebase that does not commit changes would look like.

> so your 
> 
> 	git [cherry-pick|am|revert] --continue $something_here
> 
> cannot be "git add -u && git [that command] --continue".  Blindly
> taking any and all files that have modifications from HEAD will
> produce a wrong result.
> 
> You cannot even sanely solve that by first recording the paths that
> are conflicted before giving control back to the user and limit the
> "add" to them, i.e. doing "git add" only for paths that appear in
> "git ls-files -u" output would not catch additional changes the was
> needed in files that did not initially conflict (i.e. "evil merge"
> will have to modify a file that was not involved in the mechanical
> part of the conflict), because out of the files that are dirty in
> the working tree, some are evil merge resolutions and others are
> ones that were dirty from the beginning.

I wonder if git could record the state of the working tree in a
temporary index just before it exits with conflicts. Then when the user
has resolved the conflicts

git [cherry-pick|am|revert] --continue $something_here

could do something like

{ GIT_INDEX_FILE=$TMP_INDEX git diff-files --name-only &&
    git ls-files -u } | git update-index --remove --stdin

to stage the files that the user has edited. This would not catch the
case where a new untracked file has been created that should be added to
the conflict resolution, but I think it is reasonable to expect the user
to manually add new files in this case. It would also not add an
unchanged file whose changes should be part of the conflict resolution
but I can't think of a sensible case where the user might want that at
the moment.

> 
> The only reason "git rebase" can get away without having to worry
> about all of the above is because it insists that the working tree
> is clean before it begins.  In the ideal world, however, we would
> want to lift that and allow it to start in a working tree that has
> an unfinished local modification that does not interfere with the
> rebase, just like all other operations that could stop upon a
> conflict. 

It could be expensive to check that the local modifications will not
interfere with the rebase - wouldn't it have to look at all the files
touched by each commit before starting? What do cherry-pick and am do
here when picking several commits?

 And when that happens, your $something_here option to
> "git rebase --continue" will have to worry about it, too.
> So...
> 

