From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 03:18:43 -0500
Message-ID: <CAMP44s0c-c3pPW8t9p9qabjv46gSeE6y4p6STPeV+kqB77xOJA@mail.gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
	<1366243524-18202-2-git-send-email-felipe.contreras@gmail.com>
	<87li8gxpq2.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 18 10:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USk3U-0004nj-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 10:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628Ab3DRISu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 04:18:50 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:45113 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599Ab3DRISp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 04:18:45 -0400
Received: by mail-la0-f44.google.com with SMTP id fr10so2295598lab.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=NowpPB94xjOnj+0Ok5x6uABrzfFdJ/teqbxto8xT5Cw=;
        b=u23BmUCHgYEpTArGOteflE+P3zXNT1FEXv+BvxIE3vlPJG1sVjMb0sB1IQ7In3fJrX
         Fatx8InEGZbuqxnDIgfJXy47j6zUWIFUYecEG3+29KvPJL/3jABMIhVnhIqwmh4DvXv0
         BdebJWntWSdpSGNuLPVcW6IvPm55Qtjo8WW8xUibGnMcpgt2FsgAYLMbNX86GkUOuwHW
         qEEMkZ/RplKpl/i4dTBGwzqlzVOJSEVWONPKe7abttcJ67NVW6vZ6rmVgJMzYuEgKeGp
         O6INx7SorepcMZlnEIjewPID3h5xFiOYE/Lb+Xq9FT5EELEGA+jXFOSi+OWryzTVlXBq
         E5tQ==
X-Received: by 10.152.120.6 with SMTP id ky6mr5266518lab.19.1366273123810;
 Thu, 18 Apr 2013 01:18:43 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 01:18:43 -0700 (PDT)
In-Reply-To: <87li8gxpq2.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221624>

On Thu, Apr 18, 2013 at 2:28 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The *:* refspec doesn't work, and never has, clarify the code and
>> documentation to reflect that. This in effect reverts commit 9e7673e
>> (gitremote-helpers(1): clarify refspec behaviour).
> [...]
>> -test_expect_success 'pulling with straight refspec' '
>> -     (cd local2 &&
>> -     GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
>> -     compare_refs local2 HEAD server HEAD
>> -'
>> -
>> -test_expect_failure 'pushing with straight refspec' '
>> -     test_when_finished "(cd local2 && git reset --hard origin)" &&
>> -     (cd local2 &&
>> -     echo content >>file &&
>> -     git commit -a -m eleven &&
>> -     GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
>> -     compare_refs local2 HEAD server HEAD
>> -'
>
> So what's wrong with the tests?  Do they fail to test what they claim
> (how?), test something that wasn't reasonable to begin with, or
> something entirely different?

Look at the code comment, and look at the now updated documentation
that assumes that *:* was reasonable. Given the available information,
it would be reasonable to assume that *:* did work, but it didn't
work, and it's not really possible to fix it, even if we wanted to, it
would be a hack. It's better to accept that fact and stop worrying too
much about what would be the best way to do the wrong thing.

-- 
Felipe Contreras
