Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F821C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 21:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333A860F14
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 21:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhJKVyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 17:54:23 -0400
Received: from sender4-pp-o93.zoho.com ([136.143.188.93]:25380 "EHLO
        sender4-pp-o93.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhJKVyX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 17:54:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1633989141; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TfL4b3KINRAqkhhWVXSE91CALEyNpDtY5WgZDBOcY3KMNI0bFO4kbdPZwMt/31sCWs9JzqusdC8NISeTLRTkRxN7lTTXfG+9uIcvyEbm9e6gXgMJ5b1F8QXM7S7cZYScNW4gqO6uzpx5F/8aJIZAu0uOey/YM8RPBlzh98iGQXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1633989141; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8OElKgwpAenWygDGJXehIifl3hq+4uhBHkwcoqo6mCI=; 
        b=Ev+2n2v9Xo1GBbX/dxZhOa+uYC/X5HeAFIVZQCz7I7nrwXzNgUSzECfsHCrehP9vhr7WBCX2uVAW+GBCw5TtGZhmbRaFs/QepcEt2p70XCKPiUQQVpTdxS82YqLclJDskPL7wfytT60ZrPnqT0avxhBjKw8fqEh4/o2Crzu08Bo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=ToddAndMargo@zoho.com;
        dmarc=pass header.from=<ToddAndMargo@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:cc:references:from:in-reply-to:content-type; 
  b=Z6uQcWfA9ysYDx10ik3QUjjnZbzSF4V4k9Te9vW2AFKuflphswQ0iRof27l/3m3BEVjZ58gh0doZ
    yA0sCwWuJAde3SjqjHh+r+C+7e8DyA9gWr9ezcPlmvbaeRqobs6n  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633989141;
        s=zm2020; d=zoho.com; i=ToddAndMargo@zoho.com;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=8OElKgwpAenWygDGJXehIifl3hq+4uhBHkwcoqo6mCI=;
        b=ilxhtJ8oCNcP+Qmf1e71gAvXGT2TzDJl0ftSiqzrmWjTZq3/jcc837GrbHbEhlwQ
        EBRTV4RNVBvyZbAJI1KWWIB900+P24uVqEP/Lbtq2/UNopzcl1t/WB6rYaNLyX5qCRw
        F8iEUV1ApMNbwbkVURSKzmC/j4exd8wlSzmF04Rc=
Received: from [192.168.250.117] (50-37-29-217.grdv.nv.frontiernet.net [50.37.29.217]) by mx.zohomail.com
        with SMTPS id 1633989126984676.5726661748249; Mon, 11 Oct 2021 14:52:06 -0700 (PDT)
Message-ID: <64c7dd07-495d-7efe-f4aa-7ea91830c783@zoho.com>
Date:   Mon, 11 Oct 2021 14:51:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: I just want the revision
Content-Language: en-DE
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
 <CAP8UFD1_2g84epP+qjP2QW2g2bzdWcepPE60rY2vdKpTZFdEDg@mail.gmail.com>
 <a12adb98-d8c1-cd36-1760-343360a9ba85@zoho.com>
 <afd8890e-0042-8fc6-523d-f69aa6ed7af3@zoho.com>
 <CAP8UFD0TBOkNU2g_OqpMiQyopBfae95nBwJQJ8F04+C1FcBRYQ@mail.gmail.com>
From:   ToddAndMargo <ToddAndMargo@zoho.com>
In-Reply-To: <CAP8UFD0TBOkNU2g_OqpMiQyopBfae95nBwJQJ8F04+C1FcBRYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/21 06:13, Christian Couder wrote:
> On Mon, Oct 11, 2021 at 12:24 PM ToddAndMargo <ToddAndMargo@zoho.com> wrote:
>>
>> On 10/11/21 03:09, ToddAndMargo wrote:
>>> On 10/11/21 02:45, Christian Couder wrote:
>>>> Hi,
>>>>
>>>> On Mon, Oct 11, 2021 at 4:57 AM ToddAndMargo <ToddAndMargo@zoho.com>
>>>> wrote:
>>>>>
>>>>> Hi All,
>>>>>
>>>>> I am trying to write a script to tell me the latest revision
>>>>> showing on
>>>>>
>>>>> https://gitlab.freedesktop.org/spice/win32/spice-nsis/-/tree/master
>>>>>
>>>>> which is 'virtio-win: rebase on 0.164", but I can only see this
>>>>> from a web browser, as the page is dynamic.
>>>>>
>>>>> I do have access to the git link on that page:
>>>>>
>>>>> https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
>>>>>
>>>>> Does git (or some other) have a way of telling me
>>>>> JUST the revision without having to download the turkey?
>>>>
>>>> If you just want the commit ID, you can use for example:
>>>>
>>>> $ git ls-remote
>>>> https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
>>>> refs/heads/master
>>>> f6ad44f35f5caeec51b7002169977272d85701a3        refs/heads/master
>>>>
>>>>> If I could get something that contained
>>>>>           virtio-win: rebase on 0.164
>>>>> I could dig out the revision
>>>>
>>>> You might also want to take a look at the GitLab API docs, for example:
>>>>
>>>> https://docs.gitlab.com/ee/api/commits.html
>>>>
>>>> Best,
>>>> Christian.
>>>>
>>>
>>> Hi Christian,
>>>
>>> I do not mean to be dense, but how do I get
>>> "virtio-win: rebase on 0.164" out of:
>>> " f6ad44f35f5caeec51b7002169977272d85701a3  refs/heads/master"?
>>>
>>> Perplexed,
>>> -T
>>
>>
>> Found something that worked:
>>
>> $ curl --silent
>> 'https://gitlab.freedesktop.org/spice/win32/spice-nsis/-/commits/master'
>> | grep  rebase
>>
>> <a class="commit-row-message item-title js-onboarding-commit-item "
>> href="/spice/win32/spice-nsis/-/commit/f6ad44f35f5caeec51b7002169977272d85701a3">virtio-win:
>> rebase on 0.164</a>
>>
>> <a class="commit-row-message item-title js-onboarding-commit-item "
>> href="/spice/win32/spice-nsis/-/commit/d6836f79ba8deeef5b7719fd94cc208b81eb70df">virtio-win:
>> rebase on 0.164</a>
> 
> If I needed more information than just the commit ID, I would use the
> GitLab API, especially:
> 
> https://docs.gitlab.com/ee/api/commits.html#get-a-single-commit
> 
> So you might want to customize this example command:
> 
> $ curl --header "PRIVATE-TOKEN: <your_access_token>"
> "https://gitlab.example.com/api/v4/projects/5/repository/commits/master"
> 

no idea what the " <your_access_token>" is.

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Computers are like air conditioners.
They malfunction when you open windows
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
