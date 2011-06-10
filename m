From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 10 Jun 2011 13:12:12 -0700 (PDT)
Message-ID: <m3vcwdcuqm.fsf@localhost.localdomain>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
	<BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
	<BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
	<4DF0EC32.40001@gmail.com>
	<BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
	<4DF1CAC1.7060705@op5.se>
	<BANLkTi=4zfO5jKKzbncJk7ihcoHX7Rst4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV845-0004GK-30
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758055Ab1FJUMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:12:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59425 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006Ab1FJUMP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:12:15 -0400
Received: by bwz15 with SMTP id 15so2470060bwz.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=/loboqJDskyHv+mW/zOlgeHq322Uy9OV+6JNmTB1OWU=;
        b=YIZJZF6Tps94oSe3rKHkJ6ZjUc02sJ/AgYmMy261er4H01+SQSLmvrHHLIe+VwW5pI
         nqay9NzuIYVeCXhm5z2iruGuKDk+nO3MMSGVhQe5zQETLZ4zQhCzZpW6ZLMvtEZzqn4L
         HFuUjPCQ1S9Lc3clMeMYVCU7tZXv6N72FdX+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=shJjvP8Fs1zWQ1OtFlls3Y1XUEXjqqrgQ4O9KvTL8lPwtK0raG+jtHhLRslC9jOJgX
         BkppGTTyl/3kgP1VvPuL8vMGqDvEu4iC7wYYItgW5ASqbW+6B32eMwgtRXk+e4N4bIqj
         VP6nM6zclmWqsl1upNXsH8TPC3CLIDCz08CyU=
Received: by 10.204.7.4 with SMTP id b4mr1177949bkb.39.1307736733455;
        Fri, 10 Jun 2011 13:12:13 -0700 (PDT)
Received: from localhost.localdomain (abvz126.neoplus.adsl.tpnet.pl [83.8.223.126])
        by mx.google.com with ESMTPS id af13sm1353726bkc.19.2011.06.10.13.12.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 13:12:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5AKBZBF023454;
	Fri, 10 Jun 2011 22:11:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5AKBDgm023448;
	Fri, 10 Jun 2011 22:11:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTi=4zfO5jKKzbncJk7ihcoHX7Rst4Q@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175617>

Shawn Pearce <spearce@spearce.org> writes:
> On Fri, Jun 10, 2011 at 00:41, Andreas Ericsson <ae@op5.se> wrote:
>> On 06/09/2011 05:56 PM, Shawn Pearce wrote:
>>>
>>> A lot of operations toss every commit that a reference points at into
>>> the revision walker's LRU queue. If you have a tag pointing to every
>>> commit, then the entire project history enters the LRU queue at once,
>>> up front. That queue is managed with O(N^2) insertion time. And the
>>> entire queue has to be filled before anything can be output.
>>
>> Hmm. Since we're using pre-hashed data with an obvious lookup method
>> we should be able to do much, much better than O(n^2) for insertion
>> and better than O(n) for worst-case lookups. I'm thinking a 1-byte
>> trie, resulting in a depth, lookup and insertion complexity of 20. It
>> would waste some memory but it might be worth it for fixed asymptotic
>> complexity for both insertion and lookup.
> 
> Not really.
> 
> The queue isn't sorting by SHA-1. Its sorting by commit timestamp,
> descending. Those aren't pre-hashed. The O(N^2) insertion is because
> the code is trying to find where this commit belongs in the list of
> commits as sorted by commit timestamp.
> 
> There are some priority queue datastructures designed for this sort of
> work, e.g. a calendar queue might help. But its not as simple as a 1
> byte trie.

In the case of Subversion numbers (revision number to hash mapping)
sorted by name (in version order at least) means sorted by date.  I
wonder if there is data structure for which this is optimum insertion
order (like for insertion sort almost sorted data is best case).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
