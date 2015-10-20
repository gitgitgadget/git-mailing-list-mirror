From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] test-run-command: Increase test coverage
Date: Tue, 20 Oct 2015 12:05:01 -0700
Message-ID: <CAGZ79kYAv6uVmTZEcstu7a5LjOuUvWiOgJh-UfPZyLAi_v4ojA@mail.gmail.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
	<1445279086-31066-6-git-send-email-sbeller@google.com>
	<xmqq1tcp8j82.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:05:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZocDk-0001Um-CW
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 21:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbbJTTFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 15:05:06 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33281 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbbJTTFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 15:05:03 -0400
Received: by yknn9 with SMTP id n9so26560718ykn.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=plvYdnO8zI9bx5EfjoCb1/kdc10E6cAMIKNBfoCPi8U=;
        b=ZG6CTyqfSKNQpy0On8XZvHlpHT/Ml+YEVb/TU1UlfwPXa8aomYb9Nzt7Jadd/rsV/k
         hn1bQ0koQ/8vsg8GEc2+uP0a5+ZIN9V3wZ5aX0Yt63Mm1rH8qEksll2TAuryw6Ia8tLX
         RI7Ua5a1oEOf2SCQ7SIPV71+zuNc4KSF/EYVlyhwVnmn/U9/9GP40Y4IrBx2EyUxmQNh
         pkaqS0KWGcV75TnZ3P25LijVdovy8FZX3ona4xV52Tp/xsAjUB0Obl5aPPhfew2sWrLQ
         Zm6RMtRXT+cgl33ZKkgwLyBbFUJW5Iy313Q1DkUuCgd9A6Hblb4zvEQjWOYN86I8uZCN
         TPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=plvYdnO8zI9bx5EfjoCb1/kdc10E6cAMIKNBfoCPi8U=;
        b=LfNJUpmKkyFFZUX85AyXM/82cwrq7E9yZmDodearlxAQ9PuPs8601jFX62wH6prhjP
         diHc04nljLXIKn04uZ7dUYzGkFrWfDJsqUKnRCx7M8rfPZC4xL2Z8DnYiMWNgnvnEPdp
         DD2hDXXfnhNgsyDHdgsvEAiwvrFNR57U8hwCbXWONnxFcxnnQXo3Easz9CXvct4O1yRX
         gYKv6GX9Z0fsQPd5pJK72X8y01EVrf05WquBmwgRLt9VpG1WL6OSrNptbx0WkOmysHVa
         EXMzgyuA6QsOeJnAL6yMRdcAdal2acOYW/efAEMp9Wkj0YYsViwmOsvDZUf/iZFW9Vf8
         84wg==
X-Gm-Message-State: ALoCoQlibSJj3LrwPajY0Oqze7FBe0icczlX2Z45fvFMGI4jyx7Hr/ZQLNlMKjNOhguhruPxJI3N
X-Received: by 10.129.40.18 with SMTP id o18mr3538067ywo.199.1445367901753;
 Tue, 20 Oct 2015 12:05:01 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 20 Oct 2015 12:05:01 -0700 (PDT)
In-Reply-To: <xmqq1tcp8j82.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279934>

On Tue, Oct 20, 2015 at 11:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>         proc.argv = (const char **)argv + 3;
>
> or
>
>         proc.argv = (const char **)&argv[3];

ok, will fix

>
> Given the line immediately before refers to argv[2], the latter
> might be easier on the eyes to follow.
>
> In what way does this "Increase" test coverage?  By allowing the
> caller to specify arbitrarily higher parallelism?

Currently we have exact 4 jobs to be run with at most 4 parallel
processes. This sounds as if we're testing only one special case,
but in reality we want to have any number of tasks be processed
successfully, so the test I came up with is 3 cases
* more tasks than max jobs (implying reused slots)
* equal number of jobs and max jobs
* less tasks than max jobs (implying unused slots)

>
>> +
>> +     if (!strcmp(argv[1], "run-command-parallel"))
>> +             exit(run_processes_parallel(jobs, parallel_next,
>>                                           NULL, NULL, &proc));
>>
>> -     if (!strcmp(argv[1], "run-command-abort-3"))
>> -             exit(run_processes_parallel(3, parallel_next,
>> +     if (!strcmp(argv[1], "run-command-abort"))
>> +             exit(run_processes_parallel(jobs, parallel_next,
>>                                           NULL, task_finished, &proc));
>>
>>       fprintf(stderr, "check usage\n");
