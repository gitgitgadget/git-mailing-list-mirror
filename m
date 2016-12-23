Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FD01FF40
	for <e@80x24.org>; Fri, 23 Dec 2016 08:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbcLWIcp (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 03:32:45 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34648 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbcLWIcn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 03:32:43 -0500
Received: by mail-yw0-f172.google.com with SMTP id t125so126674351ywc.1
        for <git@vger.kernel.org>; Fri, 23 Dec 2016 00:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k1wIoBNbblybJkIzhhTbACMDqn0YlRAGTLtLcYJ+290=;
        b=qeM8t4vm4JgKfdiKIFikSn8JUOqUeRubpcN/oj1R0YJVkxZ2PZ944LUose6+ujFy2t
         aRN21LDkDLI2ex5JY6BjB6OwsAjgImL63C8N5ECnCxOhdegnvqxd6AeHidHmXDxqLC8h
         E9WtIfe5L9Z70pysaQVnhvDs0PvCf/9TRUVskL4KhZdQk1pS+s5NqAUvQV36B3nqIbD3
         dOTwOdh+vEs4fiXl/uZmHo4qJGCHidybBIz5TFt44+/iUJQAfqaWqZlQ3JVV2igHin5u
         q+svfJGaHp1/Lc+Ejcj+jIb3LIKcTDWivG+LWY0FDDrTlirYXXUTsnVNVK6xPjgnKPFH
         9xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k1wIoBNbblybJkIzhhTbACMDqn0YlRAGTLtLcYJ+290=;
        b=exhQ6ULGcj7Gv/mjDqChlWGNmf3zR3uDdvw+kT8OtE2h5L82tz2oNEfCpLzBInp1Od
         C9Qdlv7xcVbnhpunqZ4sjzMaLX0dlnqnAJCqbQMDDr2AkKSNx1rxFa+4b+ITpD6e+Qh4
         xrDK/519I+ElQWMih3AHIpIUsTPCs2FiWwdJcfTi9x3d2kN0idehCNPMNQ8oFK1Ix5mR
         WG3CXWt5CGBfsKMIJU5mNoOboaJxVg7eXG4hICSV6E5g+sGlKiJ4FRHURKk00gIfll09
         s93XejZFJAeK462bStI08KxqSHBuX6rj0gafbUv+O++G/cducNjTZ+00AoIJE2Scdu5t
         BzwA==
X-Gm-Message-State: AIkVDXJdF83EIV+tR9L+7+IsvPc+JWTcbbCqCxt/vpvYUVt9OBvcKRDalj0dlrUoItQ+wAU0vYIWMd+fSe7rnw==
X-Received: by 10.13.234.19 with SMTP id t19mr11736939ywe.204.1482481962821;
 Fri, 23 Dec 2016 00:32:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.177.158 with HTTP; Fri, 23 Dec 2016 00:32:22 -0800 (PST)
In-Reply-To: <xmqqtw9vegjr.fsf@gitster.mtv.corp.google.com>
References: <20161222185609.21139-1-sbeller@google.com> <xmqqtw9vegjr.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 23 Dec 2016 00:32:22 -0800
Message-ID: <CA+P7+xr_itve2q=Kr5hrZBWoF2wkVeuqtQP7DLckeOtrdu2S5A@mail.gmail.com>
Subject: Re: [RFC/PATCH] add diffstat information to rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2016 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>     $ git rebase -i HEAD^^
>>
>>     pick 2eaa3f532c Third batch for 2.12
>>     # Documentation/RelNotes/2.12.0.txt | 40 +++++++++++++++++++++++++++++++++++++++
>>     # 1 file changed, 40 insertions(+)
>>     pick 3170a3a57b add information to rebase
>>     # git-rebase--interactive.sh | 2 ++
>>     # 1 file changed, 2 insertions(+)
>>
>>     # Rebase 2eaa3f532c..3170a3a57b onto 2eaa3f532c (1 command)
>>     #
>>     # Commands:
>>     # p, pick = use commit
>>     # r, reword = use commit, but edit the commit message
>>     # e, edit = use commit, but stop for amending
>>
>> I am not completely satisfied with the result, as I initially wished these
>> information would just appear in line after the commit subject, but this
>> comes close. Maybe the last line also needs to be dropped.
>
> This is an interesting and thought-provoking idea ;-).
>
> In practice, you would probably be touching the same file over and
> over again in the series you are rebasing, when you are doing "many
> miniscule commits recording experiments and dead ends, with an
> intention to clean it up later", and by definition, your subject
> lines are useless series of "oops", "fix", etc.  The subject and
> list of filenames would probably not make a good "summary" of the
> changes for each commit.
>
> Stepping back a bit, right now, when the user asks "git commit" to
> supply material to help writing a good commit message, we punt on
> mechanically generating a good summary and instead just show output
> of "diff --cached".  If we can come up with a way to mechanically
> generate a concise summary for the purpose of annotating "rebase -i"
> instruction, we probably can reuse that and append it at the end of
> the log editor "git commit" spawns when it is run without "-v".
>

I really like this idea, though I'm not sure exactly what a good
heuristic would be? A short summary of all diff "function headers"
could be valuable, as could file names. It would obviously be a
heuristic of some kind.

> Also, this makes me wonder if the ideal endgame might be to depend
> on the current "rebase -i" UI as little as possible.
>

I think this type of short summary could be valuable in lots of places yes.

> "rebase -i" is "interactive" only to the extent that you can
> interact in your text editor the order and the fashion in which the
> changes are applied.  If we instead teach either gitk or tig to
> easily allow you to "tick" each commit you see in their UI and
> generate the instruction used by the sequencer, and feed that and
> actually drive the sequencer to execute it (perhaps inside a
> temporary/throwaway working tree) while you are still in gitk or tig
> and reload the UI dynamically to let you view the result, the
> overall user experience would become a lot more "interactive".
>

Thanks,
Jake
