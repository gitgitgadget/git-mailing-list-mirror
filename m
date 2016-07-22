Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3967F203E3
	for <e@80x24.org>; Fri, 22 Jul 2016 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbcGVRJd (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:09:33 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33019 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbcGVRJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2016 13:09:32 -0400
Received: by mail-it0-f66.google.com with SMTP id d65so3453760ith.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 10:09:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1zsDuTuhrvhWSQ5n9tYjRkeHBAJhCzvBB6Qv8R4OowY=;
        b=iVregYL4p7jiYoXpy5YhNm/V6nbOLgeCWH9EE/3HblsI2VWEIbkcJLhATtsBgeYmGo
         pxWvfTzDscA3XEpB71wst2hvHrFDxIzNlghdBVB08FD4iSDWFzvY8KQ7fQzXxswp/++1
         ZRKZG2rB0FTdr4aSYYDGL8CSWtg/A70l6DwZq8XZZQ1gxdRdXnsd9KOGjlxGcFNPALdX
         fJd9alnJ8QS6Sw3xG+3m7aXZvNvrfiagV41WCCgheXQ4D1P86fc/SHE4QfUOsZpcPo/G
         v7Tsv3Yh7ofqtxme0ygOxi0ihneoWEAIUDDakQlEQdcADBrySt2SA214NDC2wIBiCWcP
         P2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1zsDuTuhrvhWSQ5n9tYjRkeHBAJhCzvBB6Qv8R4OowY=;
        b=lC4Dx+oSly9h6c7eBDx2OhJFZAmT6xuaxCLlZRr3hPXo94nBxFD2etd1YOBQLEIGG9
         SBIHLVHILl7dwxuNAr3818CRuqb8R6qAIMlCCTcHytDAKV8eeaPW5qhTW571Ky5hG5us
         Yc9LXoyi5h7nsw2n14Ac9XAa2FsVQlhMIUngfEsibb51rpJfEV1k6QpEZInLaajCtDvX
         Iv3ponWn3gIqzCBz6R7icSGUH4klUCmKpTK7i4w9PtlXbmpivSCCWjh0EZx1VLt3xgSj
         HuX2EFgCiReCYnvdYu76w4gehYpXSIujzbpCH724QRiQgkZepPirkL0cJLewfqLjVAqS
         xUng==
X-Gm-Message-State: ALyK8tLQzT5uNrTuCZ57Bz7lAm2Ccm6KKurDIZg3VSOIApsShYujAyG9sVQhj0d9a6gvZVOIbkohyMUPLlzm6w==
X-Received: by 10.36.33.197 with SMTP id e188mr56626094ita.42.1469207371354;
 Fri, 22 Jul 2016 10:09:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 22 Jul 2016 10:09:01 -0700 (PDT)
In-Reply-To: <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 22 Jul 2016 19:09:01 +0200
Message-ID: <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	Stefan Beller <sbeller@google.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 21, 2016 at 1:22 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Jul 20, 2016 at 10:24 AM, Nguyễn Thái Ngọc Duy
> <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  Documentation/git-worktree.txt | 8 ++++++++
>>  git-submodule.sh               | 8 ++++----
>>  2 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
>> index 41350db..2a5661d 100644
>> --- a/Documentation/git-worktree.txt
>> +++ b/Documentation/git-worktree.txt
>> @@ -142,6 +142,14 @@ to share to all working directories:
>>     you are sure you always use sparse checkout for all working
>>     directories.
>>
>> + - `submodule.*` in current state should not be shared because the
>> +   information is tied to a particular version of .gitmodules in a
>> +   working directory.
>
> While the submodule.* settings are copied from the .gitmodules file initially,
> they can be changed in the config later. (That was actually the whole
> point of it,
> so you can change the submodule remotes URL without having to change history.)
>
> And I would think that most submodule related settings (such as remote URL,
> name, path, even depth recommendation) should be the same for all worktrees,
> and a different value for one worktree is a carefully crafted
> exception by the user.
>
> So while the .gitmodules file can diverge in the work trees I do not
> think that the
> actual remotes for the submodules in the different worktrees differ
> though. The change
> of the .gitmodule files may be because you checked out an old commit, that
> has outdated information on where to get the submodule from.

I just quickly glanced through the rest of this mail because, as a
submodule ignorant, it's just mumbo jumbo to me. But what I see here
is, there may be problems if we choose to share some submodule info,
but I haven't seen any good thing from sharing any submodule info at
all.

I can imagine long term you may want to just clone a submodule repo
once and share it across worktrees that use it, so maybe it's just me
not seeing things and this may be a step towards that.

Anyway, I assume some people will be working on the submodule side.
And because I have not heard any bad thing about the new config
design, I'm going to drop submodule patches from this series and focus
on polishing config stuff.
-- 
Duy
