Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A69C433EF
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 08:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiAII0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jan 2022 03:26:07 -0500
Received: from mail-oln040092065018.outbound.protection.outlook.com ([40.92.65.18]:65024
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229867AbiAII0F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jan 2022 03:26:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUCXhDwpsOkXPH9OVjhxTC7ATLv8eU3rajbQWIYQxebqXeiGvjHbQWF18QSvR9s5HxAqyMkUJDiA8CHTM7PaEmhrhiOVYAqoiOzbLYDjQHDSiSr4Z6V6Fw5cUMTyNN5g3LsCg3cWdj5HfUtfYW2c7YbDSN39/D+ViLiHK7RnBMHO77qiQuLLbuhDr3kNVaTcyVxMst72TXeGuRaSXNT9qM99296g7UyKE92MK4AgdXQn6w7FpHbbzBk2LfuoUP11LuNoAZ/gvXbR1qJiYVBthaCp+S+8YatqsOsqiPkuvBnh1/Au47qtUc1iP/6Cd8pUS5QNGPNWBpHVcg2gRL5m+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBgMNdHfreARpgxk36660LQ6NnFzjnCSM3HKEm6Ig2M=;
 b=TZMXAtAu9nRo6V6kDLmmE6B+bd52nntp0bH1GaEGmQ0fCthSgwrfj2ArkujvE37NLvCcumWR2iPUUUmD3pphQ9IajVMB2X3RQC4Owu1x3rLreGxVsKkTD+/6+lQB0QzgAiemqsYQzd9Hukt87HJr8deFqXH1qCsdclrCLCHJ7JeS5UkF4FmIjmN7agBy0qIwe/RPXHpkB09+H63gt7OGhF8AamD3ni3VzlctQ11xEvkhM5FbP65PlelZ8L0nYePBkV7UMpUslqosh/iKhzUA086yirteuXPWv4c8hcY/w0mQzUmmgVNBx3zd89VbA+av6ktiFVyWKNkFsVPTQDaHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com (2603:10a6:208:141::13)
 by AM0PR04MB4708.eurprd04.prod.outlook.com (2603:10a6:208:cc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Sun, 9 Jan
 2022 08:26:02 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::6c90:6dad:e65d:784b]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::6c90:6dad:e65d:784b%6]) with mapi id 15.20.4867.011; Sun, 9 Jan 2022
 08:26:02 +0000
Date:   Sun, 9 Jan 2022 09:26:00 +0100 (CET)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        steadmon@google.com, chooglen@google.com, calvinwan@google.com,
        konstantin@linuxfoundation.org, stefanha@redhat.com,
        avarab@gmail.com, gitster@pobox.com, fs@gigacodes.de,
        broonie@kernel.org, christian.couder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        JoaoVictorBonfim+Git-Mail-List@protonmail.com,
        rsbecker@nexbridge.com
Subject: Re: Review process improvements
In-Reply-To: <YdTqQDnHLY7oUTja@google.com>
Message-ID: <AM0PR04MB60198B9F4E77A80526463F6AA54F9@AM0PR04MB6019.eurprd04.prod.outlook.com>
References: <YbvBvch8JcHED+A9@google.com> <YdTqQDnHLY7oUTja@google.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN:  [wb8WrDNLYoZSuHxig/7iXS+Z1V3nLVhAzqnLdUaACfBapXK6K31Vf7qfDr9waUvi]
X-ClientProxiedBy: AM5PR0301CA0032.eurprd03.prod.outlook.com
 (2603:10a6:206:14::45) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <282f95c5-7d65-916f-8184-a3d6b3b0ccee@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 148fe263-bdba-43a5-2784-08d9d349ab4f
X-MS-TrafficTypeDiagnostic: AM0PR04MB4708:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytCfcE9MxFCNSPhyfWploK3KHAaCaaxwUyYdscarCEYFLsfGX/5UW32qOMw/ilROhkulQdIj1Xkb04M4aboj4FpCaeMGbykJlO6rmk5DHEiZX4wvgE0MpX10ZdXHJ5UXAT8XMq7LTmvXlimbt7FlEPCDK+ZosMn9GMqREH8d5umE8QnW7CxaVTs0hecznqmqEogyth7rhqamaIcunksYMHQF/JbbJmfaA8sMQi0nlY84Dwydiif+jexJ/BaiXjBTMtK0pYT7WirqqRDOU3xrI9nY+kSHF8dGyUAci3Q2yQ6NHrceI2hMGNYd4UupYJsnNX9sRCTCh5njzV2Da98gZlz21566KMQogcI9MVrT34YSwwqCsTRTsWG4jalRoNEh1MBfv3LUqRrHmh1ARihMpgQYo8IEmXNHYV0e8BkHcRftMWlbRlPkBVi3WOcIRvG5x8o2oLn/a5BmxGzr3j3i2of+kCjwvv1apW1lE7k7z/VWc4UhAGstBv2+GO3+zx5SP2uF4UcL+sqQV8U5SIn0n6oyWMDEj+4jSoDV2K68oMBUDiYund7ePBq03xX4Wr9FQlycvsjvtzEyzSH33+pSifp6y0Ujz6geFEfZ1khokbzZjLW4EL5RBYFAbkVFILXp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8n5nUuTXuUR7IjtiFfND4Px8eSPevz9ViTQ66gLxK4JwOtJShLiwepa8b5?=
 =?iso-8859-1?Q?N0CF9tNpzcHdlUobYYfnOsDlQcUVQdpyhOoA0sY9FQe68EDHZL46aeY3I5?=
 =?iso-8859-1?Q?gMq/NkBRF0LmwRnSVI9JhlhSz0HaEDWsW5hEQkrRFqIL2dPHWQgh9vgAyK?=
 =?iso-8859-1?Q?9cwTy+J9eSRiky+BDPX2FPDSGsrqco8TkTFVGSl94kUqjLc8RxmeK5RNH/?=
 =?iso-8859-1?Q?8RStgh0Sgp7WB+UzW0h2yrs+GuVwZpZy41PwtqSZyN+uSHNkkNJdqTBZXa?=
 =?iso-8859-1?Q?ISLmrfI4PNiw08pxJ9LTrkB0aujCvdK66UtYx6Pj+gsJpv2wk1clvE5OD1?=
 =?iso-8859-1?Q?0pRt5F/aQ+u/7DhJyd0CeedxvkS2BxoFFAUoJwpoU+Ahh3VGHy3mvhbKxf?=
 =?iso-8859-1?Q?iQ/kvGafZ5StENhc1uBCvWFHlzihJwQSHHlOIBW9Biss+XCKe7eTaPA4ss?=
 =?iso-8859-1?Q?k0VNt3UUj/kndBq62BJHcfpTDtIFfUACq4WmPjxx9lDFOctaaaJ2NkPhGi?=
 =?iso-8859-1?Q?PqW8/8zrVzMlKgBGZsY/QZltuVdpXOpfgEW+3+mxwFpqLUYmbVbf1mUHRi?=
 =?iso-8859-1?Q?NNybn4UEbYlKARAXtNqwB2JZcP4pc3bUS48lVhGbfW9DrNL0I7Zg/oJQuB?=
 =?iso-8859-1?Q?NRAyUfObfZxLdEL+Y5rk0rwyaUh2Tk5Gtu1g+pbwtYUvYhiApfZhvGVhIy?=
 =?iso-8859-1?Q?4hEM2VoknHpslIadHMTu0PD2GyPsK7fkzAiZBTUc/qsR5UfD+GUZ0PA/gF?=
 =?iso-8859-1?Q?nrbsEsIQwgGrWoFWXN11jd1Q5xgr+qF+doHnUS0Q0a2FkbV0ONBaF1hu7v?=
 =?iso-8859-1?Q?u9pAST51LLOHECKvNizJ7ITcfEIhKASvLXEAeVZVP9PAQOPMWiidlBQJMs?=
 =?iso-8859-1?Q?p5W+W7Jf1qhg7CFFHSrrxSRdbiE/9Pr+E4isKwnML3+IuOCFklxw8NcEPz?=
 =?iso-8859-1?Q?rAHqIiJAqM5Smkp4JJbTNqzf6spAOOhrA6kyMEgqHgDQrCfVXmQSM69Bgy?=
 =?iso-8859-1?Q?EGNe3fbdEa1g1MVqNIMnLVfg1ChxzW4X5DutvEVfAkky6tP+t/heJX6Ylq?=
 =?iso-8859-1?Q?WQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-03a34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 148fe263-bdba-43a5-2784-08d9d349ab4f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2022 08:26:01.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4708
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Tue, 4 Jan 2022, Emily Shaffer wrote:

> On Thu, Dec 16, 2021 at 02:46:21PM -0800, Emily Shaffer wrote:
>
> Reshuffling context....
>
>> As it's reaching the end of the year and the holiday season, I'm
>> planning to spend the rest of the year with family and away from my work
>> email as much as possible. Some other Googler Gitters will be working on
>> and off and may chime in. But I am expecting to be able to engage more
>> with this mail in the first week of January.
>
> Having had a very restful couple of weeks off, I've now read through all
> the replies to this mail - thank you! - and will summarize as much as I
> can.
>
>> 1. Draft a MAINTAINERS file
>> One recurring theme from the conversations I had with the Google Git
>> team was that selecting a topic to review in the first place can
>> actually be pretty time-consuming. Choosing from the series subject line
>> or the "What's cooking" mail isn't always straightforward - it can be
>> hard to tell whether the series is working on a goal you are interested
>> in or in a part of the codebase you care about. It's not feasible for
>> someone wanting to get involved to review every single series that comes
>> across the list - but it might be feasible for someone to review every
>> series in a particular subsystem or topic.
>>
>> In the first half of January, I'd like to have a review out to the list
>> adding a kernel-style MAINTAINERS file with a few areas of interest. To
>> that file, I'd like to add "R:" ("CC me!") lines to subsystem mailing
>> lists and interested individuals. My hope is that that will make it easy
>> for someone to either add themselves as an "R:" or to subscribe to the
>> subsystem list, and then be able to filter their mail based on "stuff
>> I'm CC'd to" or "stuff sent to git-partial-clone@linux.dev" - and then
>> be able to review every patch in that list. I'd like to create lists on
>> topics where it makes sense, too.
>
> Summary: Everybody pretty much hated this idea. ;) I count at least five
> replies saying "please let's not, it's too cumbersome".
>
> That makes sense to me. As Ævar mentioned - just because he and I are
> working on config a lot right now, doesn't mean we will still care in
> 2023. And remembering to remove yourself from the MAINTAINERS file is a
> pain.
>
> Ævar suggested leaning in harder to improving the tooling around "who do
> I CC?"
> (https://lore.kernel.org/git/211220.86fsqnwkzs.gmgdl%40evledraar.gmail.com)
> and I think that's a reasonable approach, if we pair it with updating
> SubmittingPatches and MyFirstContribution to include recommending
> running the "who do I CC?" script.
>
>> Since the Git codebase isn't modularized into subsystems as plainly as
>> the kernel is, I don't think that the MAINTAINERS list needs to be
>> machine-parseable yet, although it would be a nice goal. Maybe over time
>> we will decide we'd rather organize the codebase differently and
>> implement a machine-parseable MAINTAINERS list to incorporate into a
>> sendemail-validate hook, or something. So I envision lines looking
>> something like this (just examples, sorry for directly calling people
>> out ;) ):
>>
>>   Submodules
>>   submodule.[ch], git-submodule.sh, builtin/submodule.c,
>>     Documentation/git-submodule.txt, anything else adding a feature involving
>>     submodules
>>   R: git-submodules@example.com
>>   R: emilyshaffer@google.com
>>
>>   Config improvements
>>   Documentation/config/*, config.[ch], builtin/config.c, changes which add new
>>     config options
>>   R: emilyshaffer@google.com
>>   R: avarab@gmail.com
>>
>> It would be extremely useful to hear other suggestions from the mailing
>> list about subsystems which deserve a MAINTAINERS line and possibly a
>> subsystem mailing list.
>
> Randall suggested using a prefix/tagging approach to make it easy for
> reviewers to filter by topic. I think that's a pretty good idea! But I
> also think for it to be useful as a filtering tool we'd want to
> formalize "this topic goes to this tag" - which brings us back along to
> the cumbersome-ness of the MAINTAINERS file.
>
> I see a couple options:
>
> 1) Eat the maintenance overhead of having a checked-in file mapping
> filespec/topic to subject line tag, like the sample Randall gave
> (https://lore.kernel.org/git/00b901d7f2d3%24c0d2ca20%2442785e60%24%40nexbridge.com)
> but minus the "Reviewers:" section:
>
> Submodules:
>  Prefix: SUBM
>  Files:
>    submodule.[ch], git-submodule.sh, builtin/submodule.c,
>    Documentation/git-submodule.txt
> Platform:
>  Linux:
>    Prefix: LINUX
>  NonStop:
>    Prefix: NS
>
> Having these mails all still delivered to git@vger.kernel.org means that
> it's not such a big deal if the prefix becomes obsolete, and not
> including an individual CC list means that nobody needs to remove
> themselves from CC list after they stop caring about some part of the
> codebase.
>
> An alternative to subject lines like "Subject: SUBM: share config
> between blah blah" might be possible. Some providers (at least Gmail,
> and based on João's reply-to address, protonmail as well) allow mails
> addressed to e.g. "my-name+from-git-list@example.com" to be delivered to
> "my-name@example.com" regardless of what follows the +; if vger allows
> this kind of thing, we could save some visual space by adopting the
> convention that e.g. submodule topics should go to
> "git-subm@vger.kernel.org" and allow folks to write their mail filters
> accordingly. (I took a poke through IETF RFC5322 to see if this +
> comment/tag/whatever-it-is is standardized and didn't see anything
> promising, so maybe this alternative is a bad idea. Or maybe I didn't
> Google well enough.)
>

The IETF calls it subaddressing. It's not strictly speaking standardised.
There is one RFC about how to handle subaddressing, RFC5233 [1] and one 
old draft to standardise it [2], but no real standard for it.

There's a lot more mail providers and MTAs that support it in some way,
but some use different separators and RFC5233 even mentions puting the 
detail part before the user part e.g. "from-git-list+my-name@example.com".

Other providers include Yahoo, iCloud, Outlook.com and Pobox [3] and MTAs 
include sendmail [4], postfix [3] and MS Exchange [5] (though apparently 
currently only Exchange Online and 365 instances), from a cursory search.

[1] https://datatracker.ietf.org/doc/html/rfc5233
[2] https://tools.ietf.org/id/draft-newman-email-subaddr-01.html
[3] https://en.wikipedia.org/wiki/Email_address#subaddressing
[4] https://people.cs.rutgers.edu/~watrous/plus-signs-in-email-addresses.html
[5] https://docs.microsoft.com/en-us/exchange/recipients-in-exchange-online/plus-addressing-in-exchange-online

> 2) Put that kind of mapping into an easier-to-modify place, like a wiki. The
> downside is that, as far as I'm aware, we don't have or maintain an
> existing git.git wiki, so it'd probably end up going unused as people
> don't want to start looking at yet another discussion area.

From my understanding we have a wiki on kernel.org [6] that's pretty 
official, but isn't very active.

Best regards

Matthias

[6] https://git.wiki.kernel.org/index.php/Main_Page

>
> Either way, "Check this file/page and determine what additional tag to
> add to your outgoing patches" would need to be called out in
> documentation like SubmittingPatches//MyFirstContribution - and modeled
> by veteran prolific contributors in their own patches.
>
> If we're generally happy with the idea of tagging rather than additional
> lists, then I think there's nothing in the way of beginning to draft
> changes to either of those docs in order to agree on the standard we
> want to adopt. But I'd like to make sure that we are in agreement first.
> Maybe the best way to find that agreement is via the doc patches
> themselves?
>
>> 2. Draft a ReviewingPatches doc
>> Another theme we discussed was the general ambiguity around the act of
>> performing code review. How detailed should the review be? Who should be
>> examining interoperability with the rest of the codebase? Is it OK to
>> reply with only "I don't know what you're trying to do, rewrite your
>> commit message please"?
>>
>> Sometime in January I'd like to have a review out with an outline with
>> agreement on the content and organization for a ReviewingPatches doc.
>> I'm hoping that it can give some structure to review by including:
>>   - How to give different types of review (maintainer vs. individual vs.
>>     drive-by nits)
>>   - Review best practices (Sage Sharp's article on stages of review[4],
>>     CCing experts/lists from MAINTAINERS file above, short-circuiting by
>>     sending comments early instead of reviewing a patch in-depth when
>>     the idea seems so-so or unclear)
>>   - Checklists for new contributors to use or to help make in-depth
>>     review more thorough
>>
>> Since this is intended to be checked into Git's codebase, I expect that
>> we'll want to discuss a lot and make sure we all buy into the contents
>> of that doc.
>
> This idea seemed generally well-received. I noticed that João was
> curious to hear more about Google's review process; I'll state that
> there is less magic than you might think, and whatever we do know will
> certainly make it into a draft.
>
> I think there is nothing standing in the way of sending out an outline
> and/or first draft of such a document for us to all discuss and quibble
> over. :)
>
>>
>> 3. Google Git team will review cover letters and commit messages
>>    internally before sending series to the list
>> I often find that when I send a patch to the list, reviewers reply
>> without understanding the point of what I was trying to achieve in the
>> patch. It sounded like this happens to some other Google Gitters as
>> well. Luckily, that's fixable by the patch author.
>>
>> To try and make sure we're sending patches that are easy to understand
>> and decide whether to review, we're adding a step to our process ASAP to
>> require commit messages, cover letters, and "---" notes to be reviewed
>> and approved by at least one other Googler before a topic goes to the
>> mailing list. Those reviews don't need to be formal, but do need to
>> happen for every reroll of a series. We also will intentionally *not*
>> review the diff of changes in this private setting - reviews for code
>> correctness, etc. should continue to happen upstream, in public.
>>
>> I'm mentioning that takeaway in this email to say: if you find you don't
>> understand the purpose of a patch from a Googler, please let us know! It
>> would be really valuable for us to receive a review saying "I think you
>> might be saying X but it's still confusing because you wrote Y"
>> so that we can incorporate the source of your confusion as we continue
>> to review each other's "accompanying context".
>
> It seems that folks liked this idea, and furthermore, that it would be
> worth suggesting such a process - "ask your friend to read your commit
> message!" - in one or both of SubmittingPatches and MyFirstContribution.
>
>>
>> 4. Documentation changes to encourage commit message quality
>
> I think I didn't hear much response to this other than "sure, sounds
> fine" - so I expect that with the changes themselves will come more
> detailed discussion. I also don't think there is anything stopping these
> changes from happening.
>
> ---
>
> In general, I think everybody seems enough on board for us to begin
> sending doc patches. So the next step for me is to work out which of we
> Googlers will handle which, and for us to start sending stuff for
> review. Thank you to everybody who contributed on this thread and thanks
> in advance for reviews on the patches to come.
>
> - Emily
>
