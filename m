Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520BD1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdFSReR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Jun 2017 13:34:17 -0400
Received: from mail.plc2.de ([212.43.91.138]:59799 "EHLO mail.plc2.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbdFSReP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:34:15 -0400
Received: from SBS2011.opfingen.plc2.de ([fe80::48e5:6c6d:d5a9:75eb]) by
 SBS2011.opfingen.plc2.de ([fe80::48e5:6c6d:d5a9:75eb%10]) with mapi id
 14.01.0438.000; Mon, 19 Jun 2017 19:34:14 +0200
From:   Patrick Lehmann <Patrick.Lehmann@plc2.de>
To:     Stefan Beller <sbeller@google.com>
CC:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailinglist <git@vger.kernel.org>
Subject: AW: Restoring detached HEADs after Git operations
Thread-Topic: Restoring detached HEADs after Git operations
Thread-Index: AdLo2JTYy82hS69wTnuiUW9EIL+4M///6qaAgAAkeNWAAFK+gIAAL/wm
Date:   Mon, 19 Jun 2017 17:34:12 +0000
Message-ID: <0092CDD27C5F9D418B0F3E9B5D05BE0801028A86@SBS2011.opfingen.plc2.de>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
 <88AC6179-75D6-416B-9235-C628D6C59CA5@gmail.com>
 <0092CDD27C5F9D418B0F3E9B5D05BE080102887B@SBS2011.opfingen.plc2.de>,<CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com>
In-Reply-To: <CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.42.2.129]
x-g-data-mailsecurity-for-exchange-spamlevel: 0
x-g-data-mailsecurity-for-exchange-state: 0
x-g-data-mailsecurity-for-exchange-error: 0
x-g-data-mailsecurity-for-exchange-sender: 32
x-g-data-mailsecurity-for-exchange-server: 70cd0149-74d1-4df2-bc08-c934d48ac3c3
x-g-data-mailsecurity-for-exchange-guid: AE4BB2F6-5CF9-497C-8C30-2B6E34F0BFCE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm just an advanced Git user, not a Git developer. So I might find some time to improve the suggested script, which I provided with the hints given on the mailing list, but I have no time to do a complete feature release in your patch based Git flow.

I'm currently involved in 8 other open source projects. One can't improve the world alone by supplying patches to any open source project one is using...

I have no experience with other shells then Bash. So if you rely on a Bash with less features, please port the syntax to such a shell system. (I personally do not support legacy programs or out-date programs).

------
We are talking about circa 50 submodules in total with a maximum depth of 4. The platforms are:
- Mint OS with Git in Bash
- Windows 7 with Git-Bash
- Windows 10 with Git-Bash
- Windows 10 with Posh-Git


Kind regards
    Patrick

________________________________________
Von: Stefan Beller [sbeller@google.com]
Gesendet: Montag, 19. Juni 2017 18:37
Bis: Patrick Lehmann
Cc: Lars Schneider; Git Mailinglist
Betreff: Re: Restoring detached HEADs after Git operations

On Mon, Jun 19, 2017 at 2:52 AM, Patrick Lehmann
<Patrick.Lehmann@plc2.de> wrote:
> Hello Lars,
>
> for your questions:
>> If there are multiple branches with the same hash then your script would pick the first one. Can you imagine a situation where this would be a problem?
>
> I can't think of a good solution to resolve it automatically. Maybe a script could print that there are multiple possibilities and it choose the first branch in the list.
>
>
>> Plus, you are looking only at local branches. Wouldn't it make sense to look at remote branches, too?
>
> This is also related to restoring tags. If we go this way, we should have this priority list:
> - local branches
> - remote branches

For remote branches you would create a local branch of the same name
(if such a branch would not exist, possibly setting it up to track that remote
branch)?

> - tags

as said in the other email and similar to remote branches, we'd not want to have
HEAD pointing to them directly but somehow have a local branch.

>> Submodule processing is already quite slow if you have many of them. I wonder how much this approach would affect the performance.
>
> Yes. It takes a few seconds to iterate all the submodules. It could be improved if the processing wouldn't be based on slow Bash scripts spawning lot's of sub-shells to execute multiple Git commands.

How many submodules are we talking about? (Are you on Windows to make
shell even more fun?)
