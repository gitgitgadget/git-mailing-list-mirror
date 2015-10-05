From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git interactive rebase bug?
Date: Mon, 05 Oct 2015 16:03:34 -0700
Message-ID: <xmqqsi5ox6ih.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqMFFtVPnZ7Pw9B9oYXHe5N=Ectyd-M+_aGb2NKjRvLAg@mail.gmail.com>
	<CA+P7+xomv59bevbAMV=NYwo+UtY29OqVog3nDFUG8Jp1YbLYpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 01:03:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjEnF-0001Kk-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 01:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbbJEXDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 19:03:38 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35068 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbJEXDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 19:03:35 -0400
Received: by pacfv12 with SMTP id fv12so193309987pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ClvW2G7lsLtwxu+0SX3b16YSPNpfnCX/+IXDMZflxCg=;
        b=rjHUsno0R9d//gB2VsypQEidduATvPYqu+5S3bo7vRzi4UW1V88wIc42zSbKpekHW/
         jowbraBuP2v73rOUoZvj9nIjY3bs+ntOrbo5eB0T56BSdR3IcJ+TIG9baJFzjXQA51D4
         9CNhB0ghkJRIgLjLsMsZu5vu76OcRFvaVIAQ7nytoY1GTyoszjlTqOnNsN6q6Q+EDWAK
         GVr+RGotiwYC8ImEMQ3dYkycUkRPzsiqLcEPSX0EO5kiQU/lj4XObDlu+PODA0b5ss7u
         qrqIhYyuSk0ctiPU98Q3YMNp+Quwjrj1CNzzCzJn6RUrm+jfvUpvPfXtUN9tzlemdKO0
         42ZA==
X-Received: by 10.68.135.136 with SMTP id ps8mr42665070pbb.123.1444086215507;
        Mon, 05 Oct 2015 16:03:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a14c:f96c:97d2:eee0])
        by smtp.gmail.com with ESMTPSA id tb9sm29749329pab.13.2015.10.05.16.03.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 16:03:34 -0700 (PDT)
In-Reply-To: <CA+P7+xomv59bevbAMV=NYwo+UtY29OqVog3nDFUG8Jp1YbLYpw@mail.gmail.com>
	(Jacob Keller's message of "Mon, 5 Oct 2015 15:40:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279105>

Jacob Keller <jacob.keller@gmail.com> writes:

>> I've been experiencing a very annoying bug when performing interactive
>> rebases. The rebase process will stall after I close the editor, and I
>> have to kill the process and then restart the rebase using "git rebase
>> --continue"
>>
>> I am not sure how to debug this further. Suggestions are welcome. It
>> is an intermittent issue, so it doesn't always happen but it seems to
>> happen fairly often (at least every other attempt).
>>
>> It appears to only occur after an interactive rebase, with an editor is closed.
>>
>> Regards,
>> Jake
>
> Note, I have this problem when using the latest of next branch,
> haven't had it in the past when using the latest released version, so
> I think it's a rather recent regression.

Platform, editor, terminal emulator, specifics?

I have been on Ubuntu, coming over ssh, running "screen" as the
terminal enumlator, displaying on Gnome terminal, and my editor is
"emacsclient -c" to an instance of Emacs in the screen session.  I
primarily run a version that is a bit ahead of 'next' (unless it is
very close to the feature release, in which case I tend to run
'master') and haven't noticed anything new that is strange.
