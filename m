From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Mon, 10 Aug 2015 10:03:16 -0700
Message-ID: <CAGZ79kaKdzvyU0D9XectR+3BQE+7FZ+x=X=HUYuNcLvoHDdZKA@mail.gmail.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
	<xmqqpp2ywwj1.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaGe59=z4Eeuno8DRuWWRD12OyLETi7NA+utfoLsJ4+=A@mail.gmail.com>
	<xmqqlhdmwrxx.fsf@gitster.dls.corp.google.com>
	<xmqq4mkawbc8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:03:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOqTz-00056Q-Ee
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbbHJRDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 13:03:18 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36393 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbbHJRDR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:03:17 -0400
Received: by ykeo23 with SMTP id o23so144401185yke.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZmIR3m4Pha3AFI5fwLRituREpBphXBSo19kqMY8wj/o=;
        b=IUScx53AcF+KsHBZ83M69B4igiM0z2f32O+ZbWqaenNKkl3HP2/NfPVPtb1DxD3Bid
         5x1ZIaDxLVY5lcP8dxEU7+SozTrJUV5XuaXBVXrOGWvSU22p9aojzNc8sbyXtw7Qoo1s
         ogjtJm1P5IQjPWfplOhQya49iBD72BabjuEViKRf38S/Kezr82AkSTs0HsFDn6MvD6zj
         dKSFxM3Orj1xtn8Vv/W3pokGJd+W7V+sJZyNC5zIYEi5/WuXvDKCmDvoAHJ1eSn5zxQj
         Ntw9IuuJuWxXsq9CZEmWUBvmdUS5aJ49YGH2mKnngFLQ56pEhZ1a9DSNkc1uR7kdEUk8
         KNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZmIR3m4Pha3AFI5fwLRituREpBphXBSo19kqMY8wj/o=;
        b=le13U/m9vqNhdphMIO3T4Y4y3Bf+0Sd+K2hTbVLUs3hXqKhXRPa5pZakSBRZTHG22r
         fu6D62qcIF5ClZIasZXc5+UuRcyPlvYRl5tIChVPZEZbg5Zto1FOGPsTYAtcLSKwWDPv
         nesCUhundYCjS7UpruyLjWQHe+01twXf4UGKUiQ6w3dlaez2dYYlnGbo3uStrwQ2tmDr
         wrl6scHKfjgWFMHskXuwG9lqIlb8zOvuEu+tiBUxveRPmQ4Ex2dmhe5ddMreXUrQZPWK
         1zGiKOOF14/nvl2tQpxBjPajF8k7b28+5UrHnou8+CxLgJihGPa1uK2YtEJ//1yKLTh1
         ifeg==
X-Gm-Message-State: ALoCoQmpI11fa9KvncwCJLhxs/8UzEJg57asDbVh7KMEX10/HFYNDshw6YRqrEtEM8qQI1MFH8fQ
X-Received: by 10.13.247.3 with SMTP id h3mr22670478ywf.142.1439226196828;
 Mon, 10 Aug 2015 10:03:16 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 10 Aug 2015 10:03:16 -0700 (PDT)
In-Reply-To: <xmqq4mkawbc8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275634>

On Fri, Aug 7, 2015 at 11:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>> ... if
>>>> you really want to go the "thread" route, the first thing to try
>>>> would be to see if a few places we already use threads for
>>>> parallelism (namely, "grep", "pack-objects", "preload-index" and
>>>> "index-pack") can be factored out and model your new API around the
>>>> commonality among them.
>>
>> And obviously, doing your pool API around threads will allow you to
>> throw future per-thread function that do not involve run_command()
>> at all at your API, and it will make it easy to adapt the current
>> threaded parts of the system to the API.
>
> Just a few random thoughts before going to bed and going offline for
> the weekend...
>
> Eventually, we would want to do "submodule update" of a top-level
> project that has 500 submodules underneath, but obviously we would
> not want to blindly spawn 500 threads, each of which runs "fetch",
> all at the same time.  We'd want to limit the parallelism to a sane
> limit (say, 16 or 32), stuff 500 work units to a queue, from which
> that many number of worker bees grab work unit one by one to process
> and then come back to ask for more work.

This is exactly what is currently implemented and works in patch
"[RFC PATCH 2/4] Add a workdispatcher to get work done in parallel"

>
> And we would eventually want to be able to do this even when these
> 500 submodules are spread across multiple levels of nested
> submodules (e.g. top-level may have 8 submodules, and they have 16
> nested subsubmodules each on average, each of which may have 4
> nested subsubsubmodules on average).  Specifying -j16 at the top
> level and apportioning the parallelism to recursive invoation of
> "submodule update" in such a way that the overall process is
> efficient and without waste would be a bit tricky.
>
> In such a nested submodule case, we may want to instead try to
> enumerate these 500 submodules upfront with unbounded parallelism

The problem here is we need to have finished cloning at least one top level
submodule before we can add any further sub-submodules into the work
queue. So if there are only 4 top level submodules we'd have a slow start.

If we have only one top level work queue, the deeper nesting levels
will not explode unbound, but eventually we will reach the 16 threads
and keep working with them, and once git submodule is ported to C
we don't need to have process invocations, but can rely on the just the
threading done right. And then we it should be rather easy to only use
one top level task queue.

> (e.g. the top-level will ask 4 worker bees to process immediate 8
> submodules, and they each spawn 4 worker bees to process their
> immediate 16 submodules, and so on---it is unbounded because we do
> not know upfront how deep the nesting is).
>
> Let's call that a recursive module_list.  You would want out of a
> recursive module_list:
>
>  - the path to the submodule (or "." for the top-level) to indicate
>    where in the nested hierarchy the information came from;
>
>  - the information the flat module_list gives for that location.

I only see value in this recursive module_list approach for updating
the work tree (fetch --recurse-submodules=yes, instead of cloning)
as you already have most of the submodules there (there may be new
submodules after fetching).

Also collecting 500 submodule information is in the order of reading
500 files. But then we need to do 500 fetches. And doing a fetch takes
some orders of magnitude longer than reading a file, so I am not convinced
a parallel collection of work to be done is a good first step?

>
> Since you already have module_list() function natively callable from
> C and also it is available via "git submodule--helper module_list",
> implementing a recursive module_list would be a good first proof of
> concept exercise for your "thread pool" engine.  You can employ the
> "dual implementation" trick to call
>
>  - a version that tells the thread to run the native C version of
>    module_list(),
>
>  - another version that tells the thread to run_command()
>    "submodule--helper module_list" in the top-level and nested
>    submodules.
>
> and collect and compare their results and performance.
>
> That will not just be a good proof of concept for the pool
> implementation.
>
> Once you have such a recursive module_list, you can use it as a way
> to easily obtain such a "unified view" list of all submodules.  That
> can be used to stuff a flat work unit queue to implement reasonably
> bounded parallelism.
>
> Your recursive "submoule update" implementation could be
>
>  - Run recursive module_list to stuff the work queue with these 500
>    submodules (possibly spread across in top-level and in nested
>    submodules, or all 500 in the flat top-level);
>
>  - Start N worker bees, and tell them to pick from that work queue,
>    each element of which tells them to process which submodule that
>    resides in where (either in the top-level project or in a
>    submodule).
>
> And each work element would essentially be to run "git fetch" in
> that submodule directory.

As said before the 500 fetches are many orders of magnitude slower than
collecting the information what to do.

>
> Hmm...
>
>
