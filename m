From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Tue, 29 Dec 2015 01:13:32 +0100
Organization: Opera Software
Message-ID: <5681D02C.1040609@opera.com>
References: <cover.1451298323.git.mostynb@opera.com>
 <xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 01:13:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDhv2-0004ZJ-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 01:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbbL2ANh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 19:13:37 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35435 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbL2ANf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 19:13:35 -0500
Received: by mail-wm0-f53.google.com with SMTP id l126so276834264wml.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 16:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=HBG1EIgsBam/pbFKJLpzHYIXC+/7UKUMs9nYBI/itCk=;
        b=jfAAUHGXt0DuYE2JSx+8j976U8zPYXXJEj5KjaSgodPYmaotQHZ0JPifmLYER71I5X
         W+/PIsIQRlpiV34jRRd/c7loaiB8GfeeVHnk+4Y75SThfAsLrMFhswXCZGqQXd5wjQj0
         dTqa9NqNy7KEdZ7UIylGBv59E2PUAsigYwThuJEtVz9NsrdoXM4s44xuf0UMZhzTKSfs
         TNKiVipejK1Y/4oH4zcsGP/+8L+S64d3Z+z9eHmDTpQLfPTxfV0DVsqhgRPQ8BLL7oCx
         /Y2DCMTI1qcI9eGcYrZXx+++WKjKdMyP8nQ8ZAnfF3Dsz3KG2qoagS+geIdDN5D/q7H7
         V7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=HBG1EIgsBam/pbFKJLpzHYIXC+/7UKUMs9nYBI/itCk=;
        b=JeIIRcuqLlQl/IxukvAevD9s+tGuaq+vJZIvbOBxPgSAOLaeei4PUGZeQwXYbTIMaU
         ksK3ztQVRHglVmtaG10hTP1tU3ybc+oWzDcZkOC9FuotAVryX20oRh/Cw2OWPD6Ifi/e
         A1CnbU8+j7fQC72uOpW73l81jYimYA7rfl+lLv9ArYYhBRHudVSJDaqGY6HDlatK8QgQ
         69QWOsWvJ0Q6Vm7WE3R3W3EuNQX1addYwz+Jl6uIRVvjFMHbigP+nNyHOec0wibPFjWL
         DXw8LbwdNSltIOQeRXnfCTy07HaKBEt/NeANfGuqBjgMSKzpuILXWcEgf2BdHUVrQDu3
         s/GQ==
X-Gm-Message-State: ALoCoQnbxH9CiKMzLxN/LiqXOqtcLqMMTxtjv4ZbPQAr42Fs+3xNWrPYd8Wwu1jvq5TOINvFGPU9YzDFCHrtqlnh3SvqRqmqow==
X-Received: by 10.28.72.2 with SMTP id v2mr64577524wma.84.1451348014494;
        Mon, 28 Dec 2015 16:13:34 -0800 (PST)
Received: from [10.0.0.50] (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id uw6sm58786413wjc.42.2015.12.28.16.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2015 16:13:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283059>

On 12/28/2015 09:30 PM, Junio C Hamano wrote:
> Mostyn Bramley-Moore <mostynb@opera.com> writes:
>
>> git describe currently only supports glob matching with the --matches flag.
>> It would be useful to support regular expressions.
>>
>> For consistency, this uses the same regex flags as those used by git-grep.
>>
>> Some old discussion of this as a candidate feature is here, though nobody put
>> together a patch as far as I can see:
>> http://comments.gmane.org/gmane.comp.version-control.git/173873
>
> Thanks.
>
> I do not think it is wrong per-se to add an option to use regular
> expressions instead of globs, but if we are to do so, the endgame we
> aim for MUST be that we do so consistently to all the other commands
> that iterate over refs and limit their output to the ones that match
> given pattern (or a set of patterns), not just 'describe'.

There is one important distinction between 'git describe' and the other 
commands that iterate through refs- it applies an internal search 
strategy and outputs at most one match.  This makes it difficult to 
search for the closest matching tag that matches any item in a set of 
patterns without some messy scripting (ie run multiple 'git describe' 
commands, for each pattern, then figure out which result is the one you 
want).

> Even if we are not adding such an option to these other commands
> right now (yet), we at least need to know what these commands are
> (e.g. "git tag -l" and "git for-each-ref" immediately come to mind,
> but there may be others), and make sure that the option names you
> choose here can be used sensibly in their context.  I think "tag"
> and "for-each-ref" do no pattern matching against anything other
> than the refnames, so it would be clear what a new --perl-regexp
> option does in their contexts.

The commands that you mention produce a list of results, which can 
easily be processed by an external util (eg grep itself), and might not 
need similar arguments to be added.

Adding regex pattern matching to 'git describe' is just one reasonable 
(IMO) solution, but there are a couple of alternatives that might suffice:
1) Add an option to print all tags, in a well-defined/useful order. 
Then the results would be easy to process by an external command too.
2) Add support for multiple patterns, and print the first found item 
that matches any of them.

> Unlike "grep" whose sole point is to perform pattern matching, the
> filtering of refs these commands do is merely a very small tweak in
> the overall picture (e.g. "git tag --contains $commit -l $pattern"
> does filter by matching $pattern against the refname, but that is a
> small detail compared to the filtering done by the reachability with
> the $commit), so I am not sure if short -E/-G/-F/-P should be given
> to these commands like "grep" does, though.  These commands may have
> better uses for these shorter option names.

Besides 'git grep', the only regex type flag that is given a short 
option seems to be -E for 'git log' and 'git rev-list'.  I have no 
objection to dropping the short options, or leaving only -E.


-Mostyn.
-- 
Mostyn Bramley-Moore
TV and Connected Devices
Opera Software ASA
mostynb@opera.com
