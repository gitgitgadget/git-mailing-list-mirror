Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6AF20954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbdKVQUq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:20:46 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:39587 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdKVQUp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:20:45 -0500
Received: by mail-pf0-f176.google.com with SMTP id l24so12283181pfj.6
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neulinger-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JX6RrXG2M/6Vdwd5C/kgtMLcT0BzLK7ctEHexBh8laE=;
        b=PyG9lxXZ2APUdzdLkpTqtE1ktbHHnSF9dwYUgO/Exayb8G93BgQ4gri9+r+odjkHQn
         QAvm96cSXCExTUEQuS1qQpprN0H4e8fBgvyrutCCue5Dq8HGmPqz5j4W7rrs4D+dra6U
         +hJf0fJDOK+jIXdJWI3zor2dVElr9Opb3HvdR0OJ8CkTssmuCGgqnKbw1+PomYktaRW+
         DPnrUdC/xtcCiXUzDgciXhDHUxgmv7GmuQmCr3h8Pmh1sstYqiA2R8jvOBkN2NcJRcKk
         KvBWSOIZWRNHmGt5CFmrToBLekvyfk4EEnZrKp3mOH4AJ4bo5t6k9VHPQ0o5FOEUX40s
         crQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JX6RrXG2M/6Vdwd5C/kgtMLcT0BzLK7ctEHexBh8laE=;
        b=C7b7T4ARDpganP2xkcZTRAqc10YjLwTSpM9KSl6iejD8JxG9zzVpFyji1xsk/l5ODV
         /4pY3UFOVTUpjr3A9g+EjsI6W4kq4PF1HNLQAm+h3gVvYLUEpUn583sJRfWbZbrimlmc
         3r/wzRl+w+jdlCUYUkP8C1ZZgRha0RFkwBv/wpcQRE+GmXWdUxhHHgtYJAVRVf2yBHzx
         XLd9lpynal/Vsxt+3eUhWKlU7VYPJRM9AG1OR2VcTSUXhGpRVQJCxNESZ1+LQhAt5UDo
         iMzUo6E66WPBkZD2fBOkRfm0rjSI1xg9riWsYP1tG1KkYiApKLg5pmqYF6KqvsyleQ40
         3dPQ==
X-Gm-Message-State: AJaThX5RX0umd7Rs6cOYpP56pGH3qZb4jooXkkxB+mI7ZelBvn9Z2qN1
        Y86Njzmam7M4hvXp9YL9bhWAZDMs
X-Google-Smtp-Source: AGs4zMbkdZL1eizZhZRiQ4znOc3Pp8kzg4iLyslzNIPR3tFs2+gZi3XXyJHOzvDgmfr45vUnlIMqgA==
X-Received: by 10.98.196.77 with SMTP id y74mr19983597pff.186.1511367645042;
        Wed, 22 Nov 2017 08:20:45 -0800 (PST)
Received: from infinity.srv.mst.edu (infinity.srv.mst.edu. [131.151.93.93])
        by smtp.gmail.com with ESMTPSA id y5sm26042279pfl.52.2017.11.22.08.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 08:20:44 -0800 (PST)
Subject: Re: git status always modifies index?
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
From:   Nathan Neulinger <nneul@neulinger.org>
Organization: Neulinger Consulting
Message-ID: <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
Date:   Wed, 22 Nov 2017 10:20:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just got an answer to my stackoverflow question on this, apparently it's already implemented:

https://stackoverflow.com/questions/47436939/how-to-run-git-status-without-modifying-git-index-such-as-in-a-prompt-command

There is a "--no-optional-locks" command in 2.15 that looks like it does exactly what I need.

-- Nathan

On 11/22/17 10:10 AM, Santiago Torres wrote:
> On Wed, Nov 22, 2017 at 09:37:09AM -0600, Nathan Neulinger wrote:
>> What I'm meaning is - why does it need to write the index back out to disk?
>>
>>  From looking at the code in builtin/commit.c it looks like it takes a lock
>> on the index, collects the status, and then unconditionally rewrites the
>> index file.
>>
> Hmm, I just took a look at those lines and I see what you mean. From
> what I understand, this is to cache the result of the index computation
> for ensuing git calls.
> 
>> I'm proposing that the update_index_if_able call not actually be issued if
>> it would result in a ownership change on the underlying file - such as a
>> simple case of root user or other privileged account issuing 'git status' in
>> a directory.
> 
> I don't think this would be a desire-able default behavior. I'd wager
> that running git status using different accounts is not a great idea ---
> specially interacting with a user repository as root.
> 
>> I understand completely that it would be expected to be altered if the
>> privileged user did a commit/add or any other operation that was inherently
>> a 'write' operation, but doesn't seem like status should be one of those
>> cases.
> 
> I think it's because of the reasons above. That being said, I don't know
> what the rest of the community would think of something akin to a
> --no-update-index type flag.
> 
> Cheers!
> -Santiago.
> 

-- 
------------------------------------------------------------
Nathan Neulinger                       nneul@neulinger.org
Neulinger Consulting                   (573) 612-1412
