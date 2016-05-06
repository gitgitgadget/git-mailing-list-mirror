From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] test-parse-options: --expect=<string> option to
 simplify tests
Date: Thu, 5 May 2016 21:27:47 -0400
Message-ID: <CAPig+cQO_N=AM+YniXMKHOzvGy4JU=Sqxn+dGWuuqmc62s-qyA@mail.gmail.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<20160505215056.28224-1-gitster@pobox.com>
	<20160505215056.28224-4-gitster@pobox.com>
	<CAGZ79kY+9BUjcbpSA8sAqd=qZ5niZ2CDsPeGuXhK+yqZY4hL9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 03:27:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayUYb-0000Ft-J1
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 03:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbcEFB1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 21:27:49 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35516 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbcEFB1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 21:27:48 -0400
Received: by mail-ig0-f194.google.com with SMTP id jn6so3680130igb.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 18:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=8es5LBBJtgc+D3kcRy7GrE0hVPfcXT3xFwmubUKLrGM=;
        b=E14PuZ4GFg6yfMEpXqgcicJSgD9y008S3IP+V4h6ydC9/ckp5voPl1bGAWLZL9GFtl
         d7+Pt2xP8c/MgsC7Pj6giGo+aALkwM7VABBYY8SrI49OVjw/1GyXjZv5Z0mkukyYzD/w
         EQCN7eqeoxq9Mt2pqXDI3xSsSgAnnvb7DUV2tpl7HN2FaEyq5qFr7GpAOiC/q+lO60+i
         8Du1AjXrkGXRwlg0zZfMCnW+ZvsJYKZyCMkGRJ9WZEQuxW5uLML5JuduDwdadcmSiXmk
         i5Owl/gd8iqTMI2+UTJpDNM5Cht92Xlr9GDDho/cX060HdW3YyTlVfoiPRQKwfRGTfYZ
         uclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8es5LBBJtgc+D3kcRy7GrE0hVPfcXT3xFwmubUKLrGM=;
        b=cpV0wkJXe0x8PFcJzJllrwC/gfLw2JUiUNDwKuPHu55Lh/vjgWRo8VnMGVgD+5uZLT
         KxQ06LKIpcvNFbghdmwnhfpwPkTTn0idhfJEAtxyTAyNHpSLlSG8N5xPIIT3peg+8Dbs
         /xLm2MTrl6K4yUt5eXJWzKjPRLHnSdaFR9QIud3r+KvD7due2FRSvx7Cc0HaEt0FdTfM
         3VVbeWt+Zsk79+vKvmH5k8PiYPAMCxjTxTPZLcR/U/dqgsBbn+ZF7xi6AXzA3Lh2aHn9
         Ps7aESDa/Hejn8JednFvo64T3qziHRjaSsI9IouLmIqGGCOg7hzWHZp12osbrgrZ/JFn
         rmTw==
X-Gm-Message-State: AOPr4FXvlhqVRBcuUSaUlZOVFlnlNQSrlOtnvEaJs0DDj12SyJEhmbE3oKSXuuu7O2fs6+RbdPFS+UN8brfGBw==
X-Received: by 10.50.36.9 with SMTP id m9mr7550392igj.91.1462498067483; Thu,
 05 May 2016 18:27:47 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Thu, 5 May 2016 18:27:47 -0700 (PDT)
In-Reply-To: <CAGZ79kY+9BUjcbpSA8sAqd=qZ5niZ2CDsPeGuXhK+yqZY4hL9Q@mail.gmail.com>
X-Google-Sender-Auth: 5vmlSZnTju3VbSaQQli0Aoie7nM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293734>

On Thu, May 5, 2016 at 8:41 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, May 5, 2016 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> [...]
>> But the only thing this test cares about is if "quiet: 3" is in the
>> output.  We should be able to write the above 18 lines with just
>> four lines, like this:
>>
>>         test_expect_success 'multiple quiet levels' '
>>                 test-parse-options --expect="quiet: 3" -q -q -q
>>         '
>>
>> Teach the new --expect=<string> option to test-parse-options helper.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
>> +/*
>> + * See if expect->string ("label: value") has a line in output that
>> + * begins with "label:", and if the line in output matches it.
>> + */
>> +static int match_line(struct string_list_item *expect, struct strbuf *output)
>> +{
>> +       [...]
>> +       const char *scan = output->buf;
>> +       [...]
>> +       while (scan < output->buf + output->len) {
>> +               const char *next;
>> +               scan = memmem(scan, output->buf + output->len - scan,
>> +                             label, label_len);
>> +               if (!scan)
>> +                       return 0;
>> +               if (scan == output->buf || scan[-1] == '\n')
>
> Does scan[-1] work for the first line?

Take note of the short-circuiting '||' operator.

> On a philosophical level this patch series is adding a
> trailing "|grep $X" for the test-parse-options.
> I think such a grep pattern is a good thing because it is
> cheap to implement in unix like environments.
>
> This however is a lot of C code for finding specific subsets
> in the output, so it is not quite cheap. Then we could also go
> the non-wasteful way and instead check what to add to the strbuf
> instead of filtering afterwards, i.e. each strbuf_add is guarded by
> an
>
>      if (is_interesting_output(...))
>         strbuf_add(...)

I agree that this is adds far more complexity than I had expected upon
reading Junio's suggestion about simplifying the t0040 tests. Patch 1
aside (which seems a desirable change), rather than patches 2 and 3, I
had expected to see only introduction of a minor helper function in
t0040; perhaps something like this:

    options_expect () {
        expect="$1" &&
        shift &&
        test-parse-options "$@" >actual &&
        grep "$expect" actual
    }

and tests updated like this:

    options_expect "quiet: 3" -q -q -q
