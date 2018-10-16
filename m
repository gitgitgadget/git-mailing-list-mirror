Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16521F453
	for <e@80x24.org>; Tue, 16 Oct 2018 20:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeJQE2s (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 00:28:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44233 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbeJQE2s (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 00:28:48 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6D0E82079B
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 16 Oct 2018 16:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=to
        :from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=DTIcOlpv8ZZ1YaXnuV9msKOvqy
        8SQaxQ4PDS2BJvAuQ=; b=Vf85T1Il73iwDf/WT0YL0yCst7yi/rZpK9VWkuSbw2
        jCHX8xbyp/m6P14jN4JonjjFOarGKmKyEWJrM+XUsDb5dmrLc9GY8c7MOql/2mJD
        xSFyf2iEBIzr5U18wU7/SbB4pxJyMWOcUMh4Y2NRF0gUOt9aaf8h9StudSKfmK2F
        5GnDIONDRBC3+ifJ3XyoCiJiK7U4aBRB0geWXqRuJe8Fpk14gX3qpRBQzDNzhR9q
        H698wqJkS11OBqmLwofW9ntipXeA6PW8nxAUB8kKlOmWWsSSRLqZxYDpAoHat3gG
        EADo6FWU24g9Ev3+p3D3X84TDbknsc/hncBeSfwTweGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DTIcOl
        pv8ZZ1YaXnuV9msKOvqy8SQaxQ4PDS2BJvAuQ=; b=WfkwKIN3y1O9UiUQO2sPmY
        YicYjjLaLVJp0wlHSOSaxW+6x/kUoXdCoyuo1OfsBLDIFArQTRca0PIBgzhKCtQH
        AhjKBUcXSTMqc9EDphsH8WseeCqAhYQBQcrW54nfdphSHxqU5mYO0+77ZWu/4NXn
        D6zvrok30vmESJMrlElW+wkRosChvlzqUVgqVzqZqnbO+Avsdu9A9faSZ9u81BxX
        3KK2S0bjaTpErjku4DfsKYNU81clWNWtQf3fqLr2oHhi28rUH7Xi7yVvKZ6kZBO/
        XQ3XOpXd/kX0baBkhyLj4QBSxsUR0LcZ5qZMPSSTyQqLWPT7ZzA6t5PD61QZsPGQ
        ==
X-ME-Sender: <xms:10vGW3n-tRaUoWwkR_aaiKLN9cf8EsK8jhUiNNY2SqssLkROtcFKcA>
X-ME-Proxy: <xmx:10vGW7lTQuYh5I8pZAmbKbmUn4B41mlrEXy64JJmhrWhdgmdHF2abA>
    <xmx:10vGW_epd10kYxHASy4zycRRaDSesmkbwibRw5QExsdzARz2_sEUHA>
    <xmx:10vGW143xpG4ADdmSwBG1HFPrPXL-qMNpZjRhdDml2bZ6egyV6Bq0Q>
    <xmx:10vGWw9iY12UoL6O-VNhyPvNixsLU22f5yrW0WVcYLT-6SKmQMMzWw>
    <xmx:10vGWzDLxuMiT055VGV8yiQOre1CYzE-etF8SoVlcToK7Yl2UwpUqw>
    <xmx:10vGW7Eq6vM2RaOkt_4ld2RqHZ5EmwplhplVERbEL1BAzawRsXluMA>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id CF6DCE447F
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:38 -0400 (EDT)
To:     git@vger.kernel.org
From:   Stas Bekman <stas@stason.org>
Subject: problem with not being able to enforce git content filters
Organization: Hope, Humanized
Message-ID: <5d4966c8-8171-9a0a-5120-f7c151c2b81f@stason.org>
Date:   Tue, 16 Oct 2018 13:36:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

TL;DR

Our open source project dev team has a continuous problem with git
content filters, because developers don't always have them configured.

We need a way for git to support content filters w/o using user's
.gitconfig. Otherwise it leads to an inconsistent behavior and messed up
git checkouts.

=================================================

Full story:

We use a version of the nbstripout content filter
(https://github.com/kynan/nbstripout), which removes user-specific
information from the jupyter notebooks during commit. But the problem
would be the same with any one way clean filter.

First the setup:
https://github.com/kynan/nbstripout#manual-filter-installation

=================================================
Set up a git filter using nbstripout as follows:

git config filter.nbstripout.clean '/path/to/nbstripout'
git config filter.nbstripout.smudge cat
git config filter.nbstripout.required true

Create a file .gitattributes or .git/info/attributes with:

*.ipynb filter=nbstripout

Apply the filter for git diff of *.ipynb files:

git config diff.ipynb.textconv '/path/to/nbstripout -t'

In file .gitattributes or .git/info/attributes add:

*.ipynb diff=ipynb

=================================================

The problem is that it can't be enforced.

When it's not enforced, we end up with some devs using it and others
don't, or more often is the same dev sometimes doesn't have it configured.

When a person has a stripped out notebook checked out, when another
person commits un-stripped out notebook, it leads to: invalid `git
status` reports, `git pull` breaks, `git stash` doesn't work, since it
tries to stash using the filters, and `git pull' can never succeed
because it thinks that it'll overwrite the local changes, but `git diff`
returns no changes.

So the only solution when this happens is to disable the filters, clean
up the mess, re-enable the filters. Many people just make a new clone -
ouch!

And the biggest problem is that it affects all users who may have the
filters enabled, e.g. because they worked on a PR, and not just devs -
i.e. the repercussions are much bigger than just a few devs affected.

We can't use server-side hooks to enforce this because the project is on
github.

And the devs honestly try to do their best to remember to configure the
filters, but for some reason they disappear for them, don't ask me why,
I don't know. This is an open source project team, not a work place.

You can see some related complaints here:
https://github.com/kynan/nbstripout/issues/65#issuecomment-430346894
https://stackoverflow.com/questions/51883227/git-pull-stash-conflicts-with-a-git-filter
and I can find you a whole bunch more if you need more evidence.

==================================================

Proposed solution:

There needs to be a way for a project to define content filters w/o
going via user's .gitconfig configuration, since due to git's security
it can't be distributed to all users and must be enabled manually by
each user, which is just not the right solution in this case.

Of course, I'm open to other suggestions that may help this issue.

"Tell your developers they must configure the filters" is not it - I
tried it for a long time and in vain. If you look at our install
instructions: https://github.com/fastai/fastai#developer-install

  git clone https://github.com/fastai/fastai
  cd fastai
  tools/run-after-git-clone

It already includes an instruction to run a script which enables the
filters, but this doesn't seem to help (and no, it's not a problem with
the script). The devs report that the configuration is there for a
while, and then suddenly it is not there, I don't know why. Perhaps they
make a new clone and forget to re-enable the filters, perhaps they
disable them to clean up and forget to reenable them, I can't tell.

The bottom line it sucks and I hope that you can help with offering a
programmatic solution, rather than recommending creating a police
department.

Thank you for listening.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
