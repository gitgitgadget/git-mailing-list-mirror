Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05F71F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbcHOMix (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:38:53 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:20102 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbcHOMiw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:38:52 -0400
Received: from PhilipOakley ([92.22.3.79])
	by smtp.talktalk.net with SMTP
	id ZH93b572wcpskZH93bCOeu; Mon, 15 Aug 2016 13:38:39 +0100
X-Originating-IP: [92.22.3.79]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=LkKjIWfvQdKNf3TZC4q4CQ==:117
 a=LkKjIWfvQdKNf3TZC4q4CQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=IybZy-SpAF9tWSOjtQ8A:9 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=nJcEw6yWrPvoIXZ49MH8:22
Message-ID: <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Duy Nguyen" <pclouds@gmail.com>,
	"Stefan Beller" <sbeller@google.com>
Cc:	"Jacob Keller" <jacob.keller@gmail.com>,
	"Git List" <git@vger.kernel.org>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com> <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com> <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com> <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com> <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com> <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
Date:	Mon, 15 Aug 2016 13:37:33 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfNkuLZI2slmzuCv7elqPNC+hAIPX0VQ8uI504mL0EtJ0ikjyIKvEKnSh8HMSC9cFU47Zykv8tYvOfIcW2HguEfs4mWYV2knnT/tvu1EieyHxUmNR8gbd
 yYbh9kdjqaTcZxeir2uYa4O+CyoBFGx1BGN/NxBFoVae1WBJ0WlWARZ1UDyf7HX3r0VV88cn2hUPT8KtExWWgupJS5F+wsurPa+quTSNKiFWPHiNEGL+U3Ek
 ve+dt8BIg06Xrqk3GjmlHQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Duy Nguyen" <pclouds@gmail.com>
> On Mon, Aug 15, 2016 at 1:28 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Sun, Aug 14, 2016 at 12:15 AM, Jacob Keller <jacob.keller@gmail.com>
>> wrote:
>>> On Sat, Aug 13, 2016 at 1:49 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Tue, Aug 9, 2016 at 12:27 AM, Stefan Beller <sbeller@google.com>
>>>> wrote:
>>>>> is what you want. Maybe we want to see a patch that adds the reverse
>>>>> functionality as well, i.e. git-am will store the the cover letter as
>>>>> the
>>>>> branch description and git-merge will propose the branch description
>>>>> for
>>>>> the merge commit.
>>>>
>>>> I almost suggested the same, but there is a problem with this
>>>> approach: if you're are on a detached head, where does git-am save it?
>>
>> What would the user expect? We can have a range of expectations:
>> 1) reject and error out git-am
>> 2) warn about not saving branch.description and continue with am
>> 3) have a (maybe special) branch.HEAD.description thing, same for
>> FETCH_HEAD etc
>> 4) have a config option to choose between 1 and 2, if unset default to 1
>>
>> I think 3 is a bad choice.
>> 4 seems reasonable to me, though I wonder if some people use git-am in
>> a scripted workflow with a detached head and then create the branch
>> afterwards?
>> So
>>
>> 5) create a branch for them? (such as $(date)-${subject})
>>
>> My gut reaction doesn't like 5 either.
>
> I'm starting to think option 6 (storing cover latter as an empty
> commit at tip then git-merge replaces it with a merge commit in a
> permanent history) may be the way to go. It handles detached heads
> just fine, we have reflog to store older cover letters. Though it will
> not play nice with 'git commit --amend' and 'git reset' for people who
> rewrites history heavily during development, but maybe 'git rebase -i
> --autosquash' would be an ok workflow alternative.
> -- 

[sorry if this is not the right place to 'drop in'..]
I appreciate there has been a lot of discussion, but it mainly appears to be
about an upstream / integration viewpoint.

I'd hate it if there was a one size fits all solution that was only focused
on one important use case, rather than having at least a simple fallback for
simple folk.

Personally I liked the idea that I could start my patch series branch with a
simple 'empty' commit with a commit message that read "cover! <subject of
the series>" and continue with the cover letter. It's essentially the same
as the fixup! and squash! idea (more the latter - it's squash! without a
predecessor). For moderate size series a simple 'git rebase master..' is
sufficient to see the whole series and decide which need editing, rewording,
swapping, checking the fixups, etc.

Format-patch would then be taught to spot that the first commit in the
series is "cover! <subject>" and create the usual 0/N cover letter. Git Gui
may need to be taught to recognise cover! (haven't checked if it recognises
an empty commit squash!). Possibly 'git commit' may want a --cover option to
massage the commit message and add --allow-empty, but that's finesse.

I've no problem with more extensive methods for those preparing very big
patch series, or with those needing to merge together a lot of series and
want to keep the cover letters, but ensuring that a simple flow is possible
should still be there.
--
Philip

