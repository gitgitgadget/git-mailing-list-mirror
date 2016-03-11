From: Stefan Beller <sbeller@google.com>
Subject: Re: Ability to remember last known good build
Date: Fri, 11 Mar 2016 10:17:40 -0800
Message-ID: <CAGZ79kZS7vnw5EskQHty9Cathv6FdE3L8wLstFwaWpMFHamSEw@mail.gmail.com>
References: <CEDF59214E9E6A4CB418120F4FD7A0056E86A214@US-MBX2.ingrnet.com>
	<xmqq60wsc2gh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Pedroso, Osiris" <osiris.pedroso@intergraph.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 19:27:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeRjX-0000BC-3I
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 19:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbcCKSRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 13:17:42 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35525 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbcCKSRl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 13:17:41 -0500
Received: by mail-ig0-f178.google.com with SMTP id vf5so16757400igb.0
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 10:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=RIgF4zkhNuCKP6qi5tTKFBNwSY+L/ApNX4vJKOb6PGk=;
        b=UblFrV8P6lv00d/Ky3ICxarEY81jSemVLkBAJZCtUvr6LTaGcJTpUReKlKXTErYEJE
         s55Ehqbv8aJIAFS7wfeagrh31XyN0+myQtW+SVUse3TOblVDHdhILD7j8z7VqyuMB/84
         uMGceyzZOiImhupiAiErccAIA7uaNLnGYdb9yAndgh+1AWJgKd9pL5sDiy0ywoZ+ATgD
         Q3in93O4WMHm5hDQA2DooknJL4MAgaZ9w5JtGmAA/JEU89VQT0MMixAPgrCJnjF+Tp+c
         rXncD76PucLpw0gXC54OhsMPJrX+pEqRE1p5DS1NOtpxDNjxEOwQ/Fe8UujTTsLECEIz
         dGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RIgF4zkhNuCKP6qi5tTKFBNwSY+L/ApNX4vJKOb6PGk=;
        b=f7h4hDmMDmj782JS6JOg1AtKjDE9EmcXPn4lhgHEsZA6mhpXe7QijZJI9o+FwZB7Q6
         oQ8xABaOqZhbMQw4ZZG7xXWpk8r+bJm28Qk+udwCOQIiKjmwAWLAARygqrzMTfzqix16
         HUSoyi1f2Ii52MbUIMu6FfHRjEVBQA2hMcl4ncpoNCUTliyolGu8mE5g3nkbq7VWFToU
         z28xl1BeXlUAHnQ9WniyNvRWpGoOhmzlq7t0q8fSg1hTZZuSc5GISZh5Ap9g9ykBKMnB
         2hLzqyWPLND+f3JlHTaTIcaXED6Qfu15UMUKFJiiOQ51q9ZoqesaAedsTsZRKgoJ5kwD
         gruQ==
X-Gm-Message-State: AD7BkJKyEVrJfnr+f0M5vBjtw86CaHBUjNs6ckc/3xpXaUnZmC+JHnTvVra4Dx3Kh2l4w2Uhr6ePHO2dX77RpVof
X-Received: by 10.50.43.226 with SMTP id z2mr5605745igl.94.1457720260536; Fri,
 11 Mar 2016 10:17:40 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Fri, 11 Mar 2016 10:17:40 -0800 (PST)
In-Reply-To: <xmqq60wsc2gh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288695>

On Fri, Mar 11, 2016 at 10:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Pedroso, Osiris" <osiris.pedroso@intergraph.com> writes:
>
>> I participate in an open source project that any pull merge is accepted, no matter what.
>>
>> This makes for lots of broken builds, even though we do have Travis-CI enabled on the project, because people will merge a request before even the build is complete.
>>
>> Therefore, I would like to remember the id of the commit of the last successful build. This would be updated by the Travis-CI script itself upon a successful build.
>>
>> I imagine best option would be to merge master to a certain branch named "Last_known_Linux_build" or "Last_known_Windows_build" or even "Last_known_build_all_tests_passing".
>>
>> I am new to git, but some other experienced co-volunteers tell me that it may not be possible due to authentication issues.
>>
>> Any better way of accomplishing this?
>
> "test && git branch -f last-good"?

Travis-CI enabled, tells me they're using Github and are distributed,
so one contributor would want to know the last known good state of
a remote, that others push to, without testing all commits locally.

So maybe the question is better rephrased as: "How do we keep track of
the last good state using the distributed nature of Git?"

I would rather ask the more fundamental question of the workflow
of having everything merged despite tests failing. Also accepting
pull requests no matter what, sounds suspicious to me. (Can I sneak
in security issues or delete all files and it still is pulled?)

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
