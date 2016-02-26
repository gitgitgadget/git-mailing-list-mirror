From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Feb 2016, #08; Fri, 26)
Date: Fri, 26 Feb 2016 15:57:15 -0800
Message-ID: <CAGZ79ka_3wr7uCLRjA6DqzSUOF8V+SVH_89WxPsx=jjucaWmMg@mail.gmail.com>
References: <xmqqfuwfhwey.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 00:57:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZSGC-00069C-U2
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbcBZX5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 18:57:18 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37646 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820AbcBZX5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 18:57:16 -0500
Received: by mail-ig0-f178.google.com with SMTP id z8so46088822ige.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 15:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=15ITov40sTdkS+ilVzB2ZHapFt2RVE12CBFFPElzL9o=;
        b=ZypZ4xbn7ZsmrKPL2ksSBK9DIKeY6WhAdiSjnE7hlqxdlqPsPnPConpYJEDwjAGcNe
         OzN1957I20vQGIiCxlYtGVdLbDGvCdoBY267qFdXZIxpeLBYAEzE+fdE+htS61ID9LM3
         JJm372ok+FMU6q2l5F/lHdjBqgYDRcTeC9pfTTMt/rLYZ04BwhBcSznVNBO6Zs2EuZzh
         7eACbXLGG8aTqi0Em/WMK8/II76CeX4Ctm+cMU5MnlER033P+qw6Q7lMnGuA3nQ8SlA+
         Me17elJlnACcGGCQjeNFCcfouaCVWi93qBiWfHpW5QnP9VTSAVGHq/7qsVFedMTEOLi6
         6ciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=15ITov40sTdkS+ilVzB2ZHapFt2RVE12CBFFPElzL9o=;
        b=M44IDEWY/D6PObLMpD70qcLllo8oNdoWNO2ykAtWGhCAOAd3f8CAZGLi5oVubVJmEf
         miHQP2Mkr+sqo3rZog1XfzSkHIy86mk+jmSB2yVB0gdCFVjsJk1gCSuJJoomumS0p5zk
         mYVf1AwUuN2jRoAFp/sPVw9p/TavExWs9qkqOxb2q1baLeGZ9LIcz+4l3Ko2zkWBKt+R
         9do93cShj4ZZPS09IInScE3im6XIR5cxV0JO1ilG8MTlWd0UQ4Vp80zsiyOTNu4MprgP
         +7ngr5ZcmESN7xw6bztymnUNqG+AVEWUHWorWvQcymB1JBPwPAv6lSoaeGVwNHu0w2Vc
         2Jqw==
X-Gm-Message-State: AD7BkJKGXsSHBaasQJq0XKn4u6Cod8sdzK6u2Vw5ynwew0BbwwTHsn2aZN/lJaiIkbdKITH9n88b3/N3xYqE6rC5
X-Received: by 10.50.28.105 with SMTP id a9mr554820igh.94.1456531035150; Fri,
 26 Feb 2016 15:57:15 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Fri, 26 Feb 2016 15:57:15 -0800 (PST)
In-Reply-To: <xmqqfuwfhwey.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287643>

On Fri, Feb 26, 2016 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * sb/submodule-parallel-update (2016-02-25) 11 commits
>  - clone: allow an explicit argument for parallel submodule clones
>  - submodule update: expose parallelism to the user
>  - git submodule update: have a dedicated helper for cloning
>  - run_processes_parallel: correctly terminate callbacks with an LF
>  - run_processes_parallel: rename parameters for the callbacks
>  - run-command: expose default_{start_failure, task_finished}
>  - run_processes_parallel: treat output of children as byte array
>  - submodule update: direct error message to stderr
>  - fetching submodules: respect `submodule.fetchJobs` config option
>  - submodule-config: drop check against NULL
>  - submodule-config: keep update strategy around
>  (this branch is used by dt/refs-backend-lmdb and sb/submodule-init.)
>
>  A major part of "git submodule update" has been ported to C to take
>  advantage of the recently added framework to run download tasks in
>  parallel.
>
>  Seems to break tests when merged to the tip of 'pu'.

There was a version (v17[1]) which broke tests,
v18 seemed fine by Jonathan except for a small nit (the prefix handling[2])
v19 reverted that nit to an earlier version, which Jonathan seemed fine with.
IIUC, v19[3] is reviewed by Jonathan, no complaints found.

Please pick that latest version.

Thanks,
Stefan


[1] http://thread.gmane.org/gmane.comp.version-control.git/287319/focus=287447
[2] http://thread.gmane.org/gmane.comp.version-control.git/287319/focus=287489
[3] http://thread.gmane.org/gmane.comp.version-control.git/287500
