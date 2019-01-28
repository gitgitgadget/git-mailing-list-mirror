Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068C31F453
	for <e@80x24.org>; Mon, 28 Jan 2019 15:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfA1PUv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 28 Jan 2019 10:20:51 -0500
Received: from elephants.elehost.com ([216.66.27.132]:20710 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfA1PUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 10:20:50 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x0SFK7m2062204
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Jan 2019 10:20:07 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'COLLOMB Joris -EXT'" <joris.collomb-ext@alstomgroup.com>,
        <git@vger.kernel.org>
References: <HE1PR01MB3722DCA42B6E16CB9DEEC29EA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com> <000201d4b713$7edcd3d0$7c967b70$@nexbridge.com> <HE1PR01MB3722D90668E75E4BCDBA71F2A9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
In-Reply-To: <HE1PR01MB3722D90668E75E4BCDBA71F2A9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
Subject: RE: Git checkout multiple options issue
Date:   Mon, 28 Jan 2019 10:20:02 -0500
Message-ID: <000701d4b71c$f3ba57f0$db2f07d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF2nyvm1/JdLDX7iJPWJ1IP6XDHBgIVuxTJAgByOnqmYEf0UA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 28, 2019 9:25, COLLOMB Joris wrote:
> -----Message d'origine-----
>> De : Randall S. Becker <rsbecker@nexbridge.com> Envoyé : lundi 28 janvier
>> 2019 15:12 À : COLLOMB Joris -EXT <joris.collomb-ext@alstomgroup.com>;
>> git@vger.kernel.org Objet : RE: Git checkout multiple options issue
>> 
>> On January 28, 2019 8:25, COLLOMB Joris wrote:
>> > git checkout -fb "branch_name"
>> > (force branch creation and checkout it)
>> >
>> > doesn't work (even if option a separated).
>> >
>> > I don't know if this is consider as an issue, but here it is.
>> 
>> I think you might mean (which works on every platform I have):
>> 
>> git checkout -f -b "branch_name"
>> 
>> There is no provision for aggregating options into one. -fb (invalid) is
not the
>> same as -f -b (valid).

> git checkout -f -b "branch_name"
> gives me " Fatal: A branch named 'branch_name' already exists."

Once the branch is created, you can't force its creation, because it is
already created. Just

git checkout "branch_name"

is sufficient at this point. git is correct to complain that you are trying
to create a branch that already exists.

git log --decorate --oneline --graph --all

will show you where your branch points in history at any given moment in
time in a convenient form.

> I understand that here the checkout is force, but not the branch creation.
> The opposite option order doesn't work:
> 
> git checkout -b -f "branch_name"
> gives me "Fatal:  '-f' is not a valid branch name."

In this case, you are asking git to create a branch named -f (the -b branch
option). Then "branch_name" becomes the reference that would be used to find
the commit that -f would have pointed to. However, -f is not a valid name
because it is an option and git is correct to reject it.

git checkout options are described here:
https://git-scm.com/docs/git-checkout

Regards,
Randall

