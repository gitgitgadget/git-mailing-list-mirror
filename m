Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18DB61F453
	for <e@80x24.org>; Mon, 28 Jan 2019 16:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389982AbfA1Qhx convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 28 Jan 2019 11:37:53 -0500
Received: from elephants.elehost.com ([216.66.27.132]:42893 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389827AbfA1Qhx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 11:37:53 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x0SGbDGu065304
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Jan 2019 11:37:13 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'COLLOMB Joris -EXT'" <joris.collomb-ext@alstomgroup.com>,
        <git@vger.kernel.org>
References: <HE1PR01MB3722DCA42B6E16CB9DEEC29EA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com> <000201d4b713$7edcd3d0$7c967b70$@nexbridge.com> <HE1PR01MB3722D90668E75E4BCDBA71F2A9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com> <000701d4b71c$f3ba57f0$db2f07d0$@nexbridge.com> <HE1PR01MB3722F2B99E14165C952055BCA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
In-Reply-To: <HE1PR01MB3722F2B99E14165C952055BCA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
Subject: RE: Git checkout multiple options issue
Date:   Mon, 28 Jan 2019 11:37:08 -0500
Message-ID: <000e01d4b727$b928e6a0$2b7ab3e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF2nyvm1/JdLDX7iJPWJ1IP6XDHBgIVuxTJAgByOnoBhe/s3QGjz4c8pkcNTxA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 28, 2019 11:03, COLLOMB Joris wrote:
>> -----Message d'origine-----
>> De : Randall S. Becker <rsbecker@nexbridge.com> Envoyé : lundi 28 janvier
>> 2019 16:20 À : COLLOMB Joris -EXT <joris.collomb-ext@alstomgroup.com>;
>> git@vger.kernel.org Objet : RE: Git checkout multiple options issue
>> 
>> On January 28, 2019 9:25, COLLOMB Joris wrote:
>> > -----Message d'origine-----
>> >> De : Randall S. Becker <rsbecker@nexbridge.com> Envoyé : lundi 28
>> >> janvier
>> >> 2019 15:12 À : COLLOMB Joris -EXT
>> >> <joris.collomb-ext@alstomgroup.com>;
>> >> git@vger.kernel.org Objet : RE: Git checkout multiple options issue
>> >>
>> >> On January 28, 2019 8:25, COLLOMB Joris wrote:
>> >> > git checkout -fb "branch_name"
>> >> > (force branch creation and checkout it)
>> >> >
>> >> > doesn't work (even if option a separated).
>> >> >
>> >> > I don't know if this is consider as an issue, but here it is.
>> >>.
>> >> I think you might mean (which works on every platform I have):
>> >>
>> >> git checkout -f -b "branch_name"
>> >>
>> >> There is no provision for aggregating options into one. -fb (invalid)
>> >> is
>> not the
>> >> same as -f -b (valid).
>> 
>> > git checkout -f -b "branch_name"
>> > gives me " Fatal: A branch named 'branch_name' already exists."
>> 
>> Once the branch is created, you can't force its creation, because it is already
>> created. Just
>> 
>> git checkout "branch_name"
>> 
>> is sufficient at this point. git is correct to complain that you are trying to
>> create a branch that already exists.
>> 
>> git log --decorate --oneline --graph --all
>> 
>> will show you where your branch points in history at any given moment in
>> time in a convenient form.
> 
>> > I understand that here the checkout is force, but not the branch creation.
>> > The opposite option order doesn't work:
>> >
>> > git checkout -b -f "branch_name"
>> > gives me "Fatal:  '-f' is not a valid branch name."
>> 
>> In this case, you are asking git to create a branch named -f (the -b branch
>> option). Then "branch_name" becomes the reference that would be used to
>> find the commit that -f would have pointed to. However, -f is not a valid
>> name because it is an option and git is correct to reject it.
>> 
>> git checkout options are described here:
>> https://git-scm.com/docs/git-checkout

>> > Once the branch is created, you can't force its creation, because it is
>> already created.

> Sorry to not be agree, in the man page of git branch:
> 
>        -f, --force
>            Reset <branchname> to <startpoint> if <branchname> exists already.
> Without -f git branch refuses to change an existing branch. In combination
> with -d (or --delete), allow
>            deleting the branch irrespective of its merged status. In combination
> with -m (or --move), allow renaming the branch even if the new branch name
> already exists.
> 
> The behavior I was expecting with
> git checkout -b -f "branch_name"
> is a checkout on a forced branch creation at <startpoint>.
> 
> So the only solution for me is :
> git branch -f "branch_name" && git checkout "branch_name"
> 
> So to resume:
> - This is not an issue, just a divergence between my logic and git
> implementation.
> - The message "Fatal:  '-f' is not a valid branch name." is maybe not optimal,
> and it may better be " Fatal:  you trying to force the creation of a branch.
> Please do "git branch -f" if you know what you're doing"

A few things:

1. Please put your responses at the end, by convention, for this distribution list so that I don't have to reformat the message each time 😉
2. You cannot assume that a flag in one command is going to do the same thing in another command. -f in checkout means one thing. -f in branch means something different. It is dangerous to conflate the meaning of flags between commands.
3. git branch -f is used to force a branch move on a branch that you do not have checked out, so mixing these is semantically incorrect. git branch -f will deliberately fail if you try to use it on the branch that is checked out. This is correct behaviour.
4. git checkout -f means to do the checkout even if the HEAD and working index do not match and has nothing to do with branch creation. These are entirely different meanings and must not be "blended" into one concept.
5. Your expectation of the functionality is different from what git is providing.

git checkout -b name creates a branch. The -f flag, which deals with index vs. HEAD, really has no usefulness with what you are trying to do. Perhaps we should throw an error saying -f and -b make no sense when used together, but I suspect there is a subtle reason for keeping that capability. It is NOT what you are intending.

git checkout -b -f is a SYNTAX error on part of the operator error, and git is correct to issue a Fatal error message about it. At best, git checkout -b "branch" -f is correct, but not meaningful.

If you are trying to script a situation where git checkout will work regardless of whether the branch exists or not, use git show-ref. Then your script can use git checkout -b "branch" if the branch does not exist, and git checkout -f "branch" if it does. You might get unpredictable results using -f anyway in this case because of the mismatch above.


