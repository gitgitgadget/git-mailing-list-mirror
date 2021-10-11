Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D8DC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 10:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947AF60F21
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 10:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhJKKLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 06:11:47 -0400
Received: from sender4-pp-o93.zoho.com ([136.143.188.93]:25325 "EHLO
        sender4-pp-o93.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbhJKKLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 06:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1633946985; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jopSWjtJSCu0g6B+9zQGa5uusoniKWHSSCenF5wYYoEtIfeVWbQdOE1/M4MOXkElzt99sCUGtMI23QmdiWcMyQpiw3r4EIcoTm+wvcnAosulRkcag+p0xg3fBl5XCACPcKLs6/vxgQ1SodP2pyxvcVbKfqIpW9OcEzDfDdfTl/k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1633946985; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oFVsPnbqwief1gEGk/7lZmrZ7XQ8FWALMcd+O4Ui52s=; 
        b=SXRWqLqonnY8K6GOnoZ1j9bV3Id/T3Fjstu2MkR0ljXe6OAf5TOsfxMan6Xoy4gdzq5BauTKqO10bF8s0qIcFo2KBx32hb24qbSGxkzgPXs2aDTCLRLoCV2VfDy5WHGtTgAoCDPd2bsU25ziwPjqzz2qDp2XJYMUGY6FtyVTQCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=ToddAndMargo@zoho.com;
        dmarc=pass header.from=<ToddAndMargo@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=message-id:date:mime-version:user-agent:subject:to:cc:references:from:in-reply-to:content-type; 
  b=dnPZHP+2rFHJgw1iy6KEQeGftnnImyl0cQ7ctDiymJ6eLKg2uB3y4aRDi30kTNExxjLi5ByzNulG
    sQ2mq8TWoOExZPrqG02FZv78RLfB2auojnAss6doZ0gvt3Uyc/m2  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633946985;
        s=zm2020; d=zoho.com; i=ToddAndMargo@zoho.com;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=oFVsPnbqwief1gEGk/7lZmrZ7XQ8FWALMcd+O4Ui52s=;
        b=Fa18dRpU5+7M7bqkMFTQmdklR2ddAOJIdfB1JIn8EcqHL9zjssPlyA1fu7EdWP48
        cseMtTACY2YIp2kxCxK1ezFXksOrZKGomyyQ++Cmut/y3oIijzEPjKktyTCd9L5JVlJ
        SwojGY2pk2dr30jlDHWVXqGj2xLm8jU+f9y9k37w=
Received: from [192.168.250.117] (50-37-29-217.grdv.nv.frontiernet.net [50.37.29.217]) by mx.zohomail.com
        with SMTPS id 1633946981275115.77595987989935; Mon, 11 Oct 2021 03:09:41 -0700 (PDT)
Message-ID: <a12adb98-d8c1-cd36-1760-343360a9ba85@zoho.com>
Date:   Mon, 11 Oct 2021 03:09:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: I just want the revision
Content-Language: en-DE
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
References: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
 <CAP8UFD1_2g84epP+qjP2QW2g2bzdWcepPE60rY2vdKpTZFdEDg@mail.gmail.com>
From:   ToddAndMargo <ToddAndMargo@zoho.com>
In-Reply-To: <CAP8UFD1_2g84epP+qjP2QW2g2bzdWcepPE60rY2vdKpTZFdEDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/21 02:45, Christian Couder wrote:
> Hi,
> 
> On Mon, Oct 11, 2021 at 4:57 AM ToddAndMargo <ToddAndMargo@zoho.com> wrote:
>>
>> Hi All,
>>
>> I am trying to write a script to tell me the latest revision
>> showing on
>>
>> https://gitlab.freedesktop.org/spice/win32/spice-nsis/-/tree/master
>>
>> which is 'virtio-win: rebase on 0.164", but I can only see this
>> from a web browser, as the page is dynamic.
>>
>> I do have access to the git link on that page:
>>
>> https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
>>
>> Does git (or some other) have a way of telling me
>> JUST the revision without having to download the turkey?
> 
> If you just want the commit ID, you can use for example:
> 
> $ git ls-remote
> https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
> refs/heads/master
> f6ad44f35f5caeec51b7002169977272d85701a3        refs/heads/master
> 
>> If I could get something that contained
>>          virtio-win: rebase on 0.164
>> I could dig out the revision
> 
> You might also want to take a look at the GitLab API docs, for example:
> 
> https://docs.gitlab.com/ee/api/commits.html
> 
> Best,
> Christian.
> 

Hi Christian,

I do not mean to be dense, but how do I get
"virtio-win: rebase on 0.164" out of:
" f6ad44f35f5caeec51b7002169977272d85701a3  refs/heads/master"?

Perplexed,
-T
