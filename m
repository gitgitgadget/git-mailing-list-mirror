From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: failed submodule update re-run results in no checked out files?
Date: Wed, 17 Feb 2016 16:26:19 -0800
Message-ID: <CA+P7+xqj2i7EFpOhsecRPniHL68sEcmnaCB+m6VuO4U3dfnwog@mail.gmail.com>
References: <CA+P7+xoF1Rz_43-v3NzGk1Hxp=yhF3toh1nFNQFMRVWr5q8STg@mail.gmail.com>
 <CAGZ79kaM5JREvfCmNMn8FQm1mutmDB3e8DYmtxMEzmUO5mqccw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 01:26:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWCQe-0000SJ-5y
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 01:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161975AbcBRA0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 19:26:40 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33847 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161199AbcBRA0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 19:26:39 -0500
Received: by mail-io0-f181.google.com with SMTP id 9so55410852iom.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 16:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6i1jKdN1+LPvWzJoBWoh7FjS5l99TNOT+KWeRWTepgo=;
        b=RU+3uDatbz7kzXcPArHY89DEoE6b8NHnHfHnYkrvnMD1bm4AC29yYnrIXeBgG1KIH2
         rC8L4w7+Aogvz5n4aldEwEwU0pWVIG/lliUUn2BJHkBnybYB1weBRg9eB5W9CZRv2QQL
         SWCsE2B2TBu+amn8fN6ZRf1JkZq4UCAMXZt33xgjn51YDvnpW/5yRluFlcSCnecOij1H
         LgBNWNHJ+TYyA2YZsIr68jbmMcGqDCNTUY32TeNj0z8bYRHKmx2MpfqJJwRFXauTmrKB
         ivSCmpm1cboH1nGjfQKiYNEAHW17DDiWVpfnfb1vR7zZSPTonuen5GeeH6GYdGHHHUX0
         Y84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6i1jKdN1+LPvWzJoBWoh7FjS5l99TNOT+KWeRWTepgo=;
        b=dibvuQdf3m+sXCLsAd/+EtQw2pO8YllG825nWEVFO+oCtu/3maid7DcGu6SpzuoJFB
         +S4n3InBiPMQEHaQPo9RycvRH00bP4CWIS2nGBPc8LC7kiooYOdhmTOsACaIHo8nHWuE
         fU/vXQNC84An0q/tWbAIUhiSnD1ZSygHVJMj4/CA2FUe+voz9nUClhfxKA7qryF4QjQ3
         5cXHaxtvvgy9ltyX6l1BR9dN/n8XM1BqRXQkTXaBacw+Hxbg5MkuP/3PnzlM2U38XO27
         kT4+CAMslLnLAUUbHnONqd5ZZ75mUvu7ijul4FyEBo/9qAZgQg0IMea52rFaZ4klwbrG
         ySZA==
X-Gm-Message-State: AG10YOT/rY9zaKZEALQqcz8UQobSirjrJ8oSWf+7xL1dYI8eedy78JoxbvMSIA+gSfAuVmERq1Ed4TqoAfAr6g==
X-Received: by 10.107.166.195 with SMTP id p186mr6309789ioe.146.1455755198800;
 Wed, 17 Feb 2016 16:26:38 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 17 Feb 2016 16:26:19 -0800 (PST)
In-Reply-To: <CAGZ79kaM5JREvfCmNMn8FQm1mutmDB3e8DYmtxMEzmUO5mqccw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286568>

On Wed, Feb 17, 2016 at 4:15 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Feb 17, 2016 at 3:54 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Hi,
>>
>> I am having an issue currently when using Git with a remote server
>> which has a limited number of ssh connections.
>>
>> The ssh server sometimes closes connections due to too many concurrent
>> connections. I will get the following output from git in this case
>> when performing a submodule update of a submodule which is not yet
>> currently cloned/checked out.
>>
>> stdout: Cloning into 'src/SHARED'...
>
> Which version of Git are you using?
> (does it include origin/sb/submodule-parallel-update, which rewrites
> lots of the relevant code? Also it introduces parallelism, which may not be
> anticipated by the server admin)
>

I am not 100% sure, but multiple versions. I have multiple virtual
machines that run automated tests, and I have not kept all the VMs up
to date.

>>
>> stderr: Total 10288 (delta 7577), reused 10190 (delta 7577)
>
> Seeing both stdout and stderr, I assume you're on master or even behind that,
> which doesn't include the rewrite.
>

I think I am using 2.4.x right now.

>> Received disconnect from 10.96.8.71: 7: Too many concurrent connections
>> fatal: Could not read from remote repository.
>>
>> Please make sure you have the correct access rights
>> and the repository exists.
>> Unable to fetch in submodule path 'src/SHARED'
>>
>> The submodule is not cloned successfully, and this occurs somewhere in
>> the middle of the process.
>
> I wonder if the client should retry each submodule at least once, in case of
> transient errors such as this ssh config having too many connections.
>

Well, in my case it wouldn't be "transient" and my process already
does an automatic re-run when it fails. (Technically I am using the
Java wrapper around CLI Git for Jenkins, which does this re-wrapping).
It is possible something is wrong in the java wrapper, but I
determined that it boils down to this sequence. I have yet to be able
to reproduce a failure locally though without the Java wrapper (due to
being difficult to generate enough simultaneous connections to cause
the failure).

>>
>> If I run the command a 2nd time,
>>
>> git submodule update --remote src/SHARED,
>>
>> I get a successful run, but the files are not actually checked out.
>
> The submodules are cloned via clone --no-checkout.
> This is because you may have a custom update strategy configured,
> (or a preset such as "none" which would clone but do nothing further)
>

I see.

>> I
>> believe this is because the clone that failed did succeed in getting
>> the repository into a state where all the files are "removed" so a
>> further submodule update will do nothing since it's "already" checked
>> out at the correct commit.
>
> you can pass --force into "git submodule update" which passes that
> flag along to the checkout.
>

Right, this is what worked as a workaround for me.

>>
>> Am I right in my understanding? Is this a bug? I believe I can fix
>> this using --force.
>>
>> Note that i don't yet currently have a reliable reproduction of this
>> for various reasons, not least of which is that simulating network
>> error is difficult.
>
> I have a similar problem which I am debugging currently with the
> new code. (~1000 submodules which may fail randomly; This is
> why I wonder about either automated retries or ignoring the errors)
>
>>
>> Any thoughts on this? Should I just have my script that runs my
>> continuous integration builds add a check to ensure files are checked
>> out? Is "--force" enough to get the submodule to be re-checked out
>> even if it's already checked out at the location?
>
> I believe so.
>
> Stefan
>

Ok, sounds like for now I need to extend my setup to use --force
instead, which will resolve the issue for me. I like the idea of
having git itself perform some retries incase of transient failures
though.

>>
>> Thanks,
>> Jake
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
