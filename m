From: Alexander Shopov <ash@kambanaria.org>
Subject: Re: [PATCH] Fixing unclear messages
Date: Mon, 11 Aug 2014 12:13:21 +0300
Message-ID: <CAP6f5MmE4ae81DZu-gbaax4nSh4WMcWCk453wJBfC4mKvmsfxA@mail.gmail.com>
References: <1407683607-4143-1-git-send-email-ash@kambanaria.org>
	<1407683607-4143-2-git-send-email-ash@kambanaria.org>
	<xmqqsil37v4i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Shopov <ash@kambanaria.org>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	jn.avila@free.fr, Xin Jiang <worldhello.net@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>, peter@softwolves.pp.se,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 11:13:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGlfS-0006qi-Re
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 11:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbaHKJNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 05:13:23 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:42537 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbaHKJNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 05:13:22 -0400
Received: by mail-qc0-f172.google.com with SMTP id i8so1356181qcq.17
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 02:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0BioIllkFyZIQ5Gp3Of8RZkYRgPIyS6b0JprtEX+wbM=;
        b=W/G9YQugA6EMkO65cthcuTbHlWHFLVt//0TX51jTG60zWOMJhWSKuvEQ5ye53M4ezZ
         FOwgAmRbP3rpqifzm91AmoEJKjkbMryg0MfHAGA3NEVQIOe6pT0N0pE/skxJzZZerQM3
         ooHuCMV9g7Yx+NlpXOJ45tgcrMRsiEKBifEEYLXGx2TlKfRxasAcsr5Sknbhv5DMivJL
         mpgF7JUvztv0qeecwcJ7jm7BQLSo/aYU9c+R8124CXPuf18vVFKcbEyGT3ztWnurHOaq
         vMWkzGSlcdPuWcEBXZyEGVx/6oFEN7tt9EiaaKsysehpLX2gzGmN922loSQdFpXnbRCb
         PKJA==
X-Gm-Message-State: ALoCoQkKboGC/cRFIymCyMtW8cDeUtUyvqMUrtB8s/80vL0hpoKhS8vEdgegolm/WXttaDKJI8xl
X-Received: by 10.140.97.131 with SMTP id m3mr45483601qge.80.1407748401910;
 Mon, 11 Aug 2014 02:13:21 -0700 (PDT)
Received: by 10.140.93.6 with HTTP; Mon, 11 Aug 2014 02:13:21 -0700 (PDT)
X-Originating-IP: [2001:420:4505:1300:5d6f:98fd:d194:1603]
In-Reply-To: <xmqqsil37v4i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255120>

>> -                     printf_ln(_("Huh (%s)?"), (*ptr)->buf);
>> +                     printf_ln(_("Wrong choice (%s). Choose again."), (*ptr)->buf);
> Why is this an improvement?
Because 'Huh?' without intonation, gesture or a frown provided by a
human being is hard to understand. It does not state that it is the
choice the user provided is wrong and does not prompt the user for the
next action.


>> -             only_include_assumed = _("Clever... amending the last one with dirty index.");
>> +             only_include_assumed = _("You are amending the last commit only. There are additional changes in the index.");
> Why is this an improvement?
...
> Besides, "amending the last commit only."  implies ...
> ... does not convey any extra information ...
> ...It may be time to remove these messages, by the way. ...
You say that my change does not tangibly improve on an initially
unclear and already obsolete message, am I right?
I prefer the messages to be removed then.

>> +             die(_("fatal error in function \"parse_pack_objects\". This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org."));
> It probably should be spelled die("BUG: ...").
>> +                     die(_("fatal error in function \"conclude_pack\". This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org."));
> Likewise.
I have no stand on the issue "fatal error" vs "BUG", if you prefer
"BUG" I can reword.
There was a suggestion to have a separate function that is meant to
echo messages when there are genuine bugs in Git (impossible cases
happening, invariants breaking, etc.) This will allow factoring out
the clause "This is a bug in Git. Please report it to the developers
with an e-mail to git@vger.kernel.org." as a single message and I
prefer that for ease of maintenance.

>> +             die(_("wrong format for the \"in-reply-to\" header: %s"), msg_id);
> Why is s/insane/wrong format/ an improvement?
Because it is more factual and narrows down what is wrong. "Insane"
could mean many different things.

>> -             die(_("Two output directories?"));
>> +             die(_("Maximum one output directory is allowed."));
> Why is it an improvement?
Because the question only implies that the problem is the number of
directories but says nothing how many directories there should be (0,
1, 3... 100?)

>> -     printf(_("Wonderful.\n"));
>> +     printf(_("The first part of the trivial merge finished successfully
> Huh?
I am not sure what you mean or your objection would be, perhaps I am
misreading the source of Git.
The message appears as a part of sequence during merge when the first
stage passes successfully but there still could be a case that makes
the whole merge impossible.
What does "Wonderful" mean in a sequence of steps git is doing for you.

You say "I would buy s/something/BUG: &/;, but I do not think we want
to apply most of the others."
Does this mean the following changes are totally unwelcome or you
(plural, as corresponds to "we) want me to resubmit them and
substantiate changes on a message by message base?

-Nope.\n
+Merge was not successful.\n

- ???
+ unknown state

-no tag message?
+missing tag message

-?? what are you talking about?
+unknown command. Only "start", "good", "bad" and "skip" are possible.

-Unprocessed path??? %s
+The path "%s" was not processed but it had to be. This is a bug in
Git. Please report it to the developers with an e-mail to
git@vger.kernel.org.

Kind regards:
al_shopov
