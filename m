From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] create a skeleton for the command git rebase --status
Date: Fri, 29 May 2015 08:44:08 -0700
Message-ID: <xmqqoal3e6d3.fsf@gitster.dls.corp.google.com>
References: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<CACRoPnRa1wrOJr=wGnR4NayZfe2yJ4F7Abv_sjqRpgQnicxm1g@mail.gmail.com>
	<1141577560.115469.1432827789020.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqiobcy9yt.fsf@anie.imag.fr>
	<xmqqtwuwh8fv.fsf@gitster.dls.corp.google.com>
	<vpqlhg8pk1o.fsf@anie.imag.fr>
	<xmqq382gh465.fsf@gitster.dls.corp.google.com>
	<12496325.145058.1432896023146.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq4mmvv37f.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 17:44:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMSG-0002Xx-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 17:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbbE2PoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 11:44:12 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38630 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbE2PoK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 11:44:10 -0400
Received: by igbjd9 with SMTP id jd9so17387852igb.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pwD+Y8ZFSZRB8+t7iqiQcMlqTGADz0g6QdpO7LAkqnE=;
        b=ZdFRiY3/cvfpbGRx/DpFfkTKkMAlKAiiu0ljcRyLJJY1M+6wBLGnFqFOTCyafCvINo
         zzNi0uBWgjSxtBafRhp0/2cQ840yMZ4WkzvsCvDrHnS0sLM7U2VEnFpB9DYKZw1bD71V
         gMq1XH3EO4pC131lkb/iNNsMA+O6pc/oeOW6ozQ6A0yq0QrLthToMREXBUiqi+vaz8c6
         lof82q2nMb1JguK0Mv/6OtrmlU4P+AqWeatjW5GHj4FkM+nXbCTeKo1nMdzZkZDxrrQf
         1afzdXWiBiDitGQn8H5l/s15luBmP4OOklHDwwjvTYLiyJdGpoxnxsXgy9guuW6gEvjn
         UNIA==
X-Received: by 10.50.78.170 with SMTP id c10mr627848igx.0.1432914250423;
        Fri, 29 May 2015 08:44:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id l1sm4416176ioe.32.2015.05.29.08.44.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 08:44:09 -0700 (PDT)
In-Reply-To: <vpq4mmvv37f.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	29 May 2015 17:00:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270246>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr> writes:
> ...
>> And during an interactive rebase:
>>
>> rebase in progress;
>
> This could even become "interactive rebase in progress".
>
> Most of the time, you're supposed to remember whether you ran "git
> rebase" with -i, but a typical use-case is when a newbie requests help
> like "I don't know what I did, but can you fix it?", and then any
> information can be valuable.

Yeah, I like that.

> Not sure the blank lines are meant to be there, but I wouldn't put them
> in the actual output. I'd format it as
>
> Last commands done (5 commands done) :
>   pick 62609785 commit message1
>   (see more at .git/rebase-merge/done)
>
> (lower-case "see" to be consistant with other hints)

Nice.

>> Is it a good practice to send the user find information in the .git
>> directory?
>
> We usually avoid doing that and provide commands to do this (e.g. "git
> rebase --edit-todo" instead of asking the user to do $EDITOR
> .git/rebase-merge/git-rebase-todo), but the ones you show seem OK to me.

Yeah, I think it is OK to suggest peeking into (not writing) files
like this.  We may update the internal implementation but then the
suggestion can and should be updated when that happens.
