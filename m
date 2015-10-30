From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 1/8] run_processes_parallel: Add output to tracing messages
Date: Fri, 30 Oct 2015 10:32:55 -0700
Message-ID: <CAGZ79kbmkwiQYSqtvn0kTCqh6XfkkcfxN1exTXzr8FOz4pWDQw@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-2-git-send-email-sbeller@google.com>
	<CAPig+cToAFAPhhFhOd_MF+EUcvRUjWOooeZH4uDy3-d9GEq73g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:33:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsDY5-0003oL-AC
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 18:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbbJ3RdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 13:33:03 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35560 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759944AbbJ3Rc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 13:32:57 -0400
Received: by ykek133 with SMTP id k133so83352895yke.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0LkQCQG43izu0G17e4dnQCa4AU1MfM1bWaTvkM0YeBI=;
        b=ZLPkuQcnT74FfL+/so7GBZMfPdAEuL1kFdy+5te9IpaaQ5/jPUKh3CqpxRV5sOnX/w
         SS7CXGXyVSYXYf/Xe5TVnTIlrxLaTnOAVo9bxQ8qpbM/JKmzFBbl76Br4bMhuH7oQDRX
         +kfMu0NKj1Md+tQJbWpK1lwGIq2sp9Qo6hVqhQqPzCkR8D5Mfz1MPqQWy2qKw0BAvLrG
         clXX3tXV/DZ1/Jom0jVae+OBV7rA8unZb64Q4vl6l+N1uycj3I+ldC+6L0umZCvA6CwO
         jKtve9X08f4b0CkVDDQ5RXtU7+M8Y2ZM67Wph2h5jk0c+17K0da2yAm3HSpmtQCD9PtE
         7u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0LkQCQG43izu0G17e4dnQCa4AU1MfM1bWaTvkM0YeBI=;
        b=O4oPMVvd+7KH1TILAJ4MyxDsFk2zie0TcBF5ZGTb62bkMm3S6J1vPxZMz6IiF1vkGG
         W3rT1xpdRD9WOzlPNCWwB2iaGpKhFmpLWc/LL1cYn/3CEdkjF4d4AlQIqEm1HM2z7/4T
         RLHnMW0NuYTRN2ZtaZP2lc6795vzB9uKGQ0VPMNk+/uSKMIF3v2eMPN8SzOjUtHO7Gkp
         C3NIjbNVwDUyae0kz1erWSWU3PGTl7mexIvlLNUF/4sQXn9MnhzLW4xlHz63k2/0i7nV
         C5EA4TNPxF47b0G4f7FAzvymwR1uRy8kyBIEG0ZG7ybxAOrAS6cjt2qDA0tB0L/4qI6H
         ZJBw==
X-Gm-Message-State: ALoCoQnYfXD++G/2TxOYDmfr85v7cSHD0yhMkmmFqJDGCIyP1rhvmXaFjDmMz40sRcsE2kW39PsV
X-Received: by 10.13.251.2 with SMTP id l2mr7215057ywf.44.1446226375265; Fri,
 30 Oct 2015 10:32:55 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 30 Oct 2015 10:32:55 -0700 (PDT)
In-Reply-To: <CAPig+cToAFAPhhFhOd_MF+EUcvRUjWOooeZH4uDy3-d9GEq73g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280498>

On Thu, Oct 29, 2015 at 6:10 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
> On Wed, Oct 28, 2015 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
>> run_processes_parallel: Add output to tracing messages
>
> This doesn't really say much. I guess you mean that the intention is
> to delimit a section in which output from various tasks may be
> intermixed.

My original intention is to have it there for testing in later patches,
so I am not so much interested in the delimiting but the raw number
%d here.

>     run_processes_parallel: delimit intermixed task output

Sounds good to me, better than my subject.

> s/children/tasks/ maybe?
>
> Minor: Perhaps drop "in parallel" since the parallelism is already
> implied by the "run_processes_parallel" prefix.

done

>> +       trace_printf("run_processes_parallel: parallel processing done");
>
> Minor: Likewise, perhaps just "done" rather than "parallel processing
> done" since the "run_processes_parallel" prefix already implies
> parallelism.

done
