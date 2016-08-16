Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC591FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 06:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbcHPGph (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 02:45:37 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33729 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbcHPGpg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 02:45:36 -0400
Received: by mail-io0-f173.google.com with SMTP id 38so99421407iol.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 23:45:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DG8BeQaIhMAj+ZxQE0UeuyaoYdzsrsQW6PDIzolzz3Y=;
        b=KrYEqHOOiAx4I9jaRSeCnB678er49Fa6qVFjm7Sv9ogI1mbCr/WRoz4tONyyKynTAR
         m2yJIM8Ysi0OZW0GffsoP5YvY1Rju5Er3CfKMiL3CmDUhRQvtHv6RC+fVsGJfYzBGuWU
         bsesoF63qHJ3/LOXfLbUS6GBIUljseeiDBkoZKqGo2RoqOKBA8R891DgV/c38qkcrSGC
         mCtquWtAzqtm6EWn7WBLj8gJc28jOm3egp9ri+BfIgCbAr0LnyGKdXm3AbH8i7WdVjNk
         /BeL58XgLddGs5V9Xsdx2Z3+TOjnIeIhpR0hZOezhkD5++camWrfCrHblNnPEDFhM7n6
         Q4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DG8BeQaIhMAj+ZxQE0UeuyaoYdzsrsQW6PDIzolzz3Y=;
        b=h+Fxq2GLzN24nVW+oXBZMcKLBVjf+gHkMsChiBznMpUXd/iCJ19jPJMw6D5FwdOqGu
         zXQY9rdl880PZ9qCzSbIZq88jEbUiZYisRH26+K+Ha0Subt6BI/E9JEaj49V1bn1SB7V
         maKXqn1YgIC0zO4rmWETRdchK6BfJbQLRPdt8F3xp76zLuhktFd4C6vSEhynfEKpDFMT
         DuSZv5r+WmA7VhGhRZ8qJABhNV0b4UVvgRdZkKxU3Ct+Kz0v0he+qINwpG7m6PSLk2Pm
         4mVN/JBGa6/eaDcH/1JgfdjyVEvbTCpXLx8SsBfZwtDlwugJM44PxVuj82vyCnuMOAah
         9lbw==
X-Gm-Message-State: AEkoouvySOpUQmSZCx5ME8/d7E6CTA+WZmPFg4ljrZrZbp3pUz5kogDm4Gxez3B+bJRdbG2aoyDuiXh3YpUOBQ==
X-Received: by 10.107.2.78 with SMTP id 75mr38185490ioc.128.1471329935517;
 Mon, 15 Aug 2016 23:45:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 15 Aug 2016 23:45:05 -0700 (PDT)
In-Reply-To: <CA+P7+xr+HonJTj5AcRhAMf5Z059zHKiuOY8Zbd77uu_jAiiZBA@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
 <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com>
 <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley> <CA+P7+xqbmZznxq024fhkejp2FeCVYkOYHTSdR69Di3nkzYJooA@mail.gmail.com>
 <3E80981D72F74A11A41A228901644E1C@PhilipOakley> <CACsJy8CXKcjo6KO8HvBpx+N4Lj7MO5yMH2q4bVWi-x3mbvWsmQ@mail.gmail.com>
 <CA+P7+xr+HonJTj5AcRhAMf5Z059zHKiuOY8Zbd77uu_jAiiZBA@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 16 Aug 2016 13:45:05 +0700
Message-ID: <CACsJy8DJmONcgQO37Xk+2cZb+Svx-bgwjrG1XrZQ4BYipownqw@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 12:26 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> They can just add "squash! cover! <series>" commits for that ;-) Though more
>>> likely the advanced workflow would be used... We'll need both (more than
>>> one) options.
>>
>> Or even better, "git commit --reword $SHA1" brings up the editor with
>> commit message of $SHA1. Modify any way you want and it creates a new
>> empty, "reword!" commit that contains the diff between the old commit
>> message and the new one. "reword!" can be consumed by "rebase -i
>> --autosquash" without bringing up the editor again. I realize making
>> "git commit --reword" run multiple times would be tricky though...
>
> I was just thinking you write text and it gets appended to the text of
> the reworded commit, and when you squash them using rebase you get to
> finalize it like a normal squash?

I think that's what Phillip meant by 'squash! cover!' though I wanted
to go further, I don't want an editor popping up at rebase time,
instead 'rebase' just update cover letter automatically for me.
-- 
Duy
