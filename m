From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v6 0/6] Add Travis CI support
Date: Fri, 20 Nov 2015 12:56:04 +0000
Message-ID: <CAE5ih7-q9JpiAW3pU6XWk+z0sGY8ej+UKEaR0bGuBnR0D9+P5A@mail.gmail.com>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
	<20151119141409.GB9353@sigill.intra.peff.net>
	<46C55D27-0B59-41AA-84AD-FED095EBDEE4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 13:56:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzlEn-0005j1-Jk
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 13:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162720AbbKTM4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 07:56:16 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35723 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760165AbbKTM4E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 07:56:04 -0500
Received: by obbnk6 with SMTP id nk6so85386198obb.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 04:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kc9uBz6r8U7TZZZTKr4lgYaPco/N04qprB9XnICAAcw=;
        b=f9DEv/otSOFnHcqS+S6dg2qCVfgdLuiQPjZmGOcuXgA8qHp5wxuFKThUKa2qFIf8CQ
         8fXasXO4lN+NApfGtGpkUXqcLh6wkNPmbW4OHHmelRCGh2gbAmNYfp2+tba7TY2GViET
         bWfT1sihVlMqx0nYZHlNzDS7Y+1NFy5IyHflU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kc9uBz6r8U7TZZZTKr4lgYaPco/N04qprB9XnICAAcw=;
        b=gtDs5hT+zQi2c/Ytge6eHifnwFcrmCzYJPtPnKI9fvCzavrwXJ0wK+i8Sv/g+q2eUO
         oJS36e26Xl1Cmp3ATerdNCJVembp5QDCiHf5i/VfKD2N1O/CQt/rYlDIBfGXBAhP6oo6
         Q9zs1MUZ2xbcbTEVpRUvAtTbsV0wSj90QrPiTz8uE8uUbd+dflO7YAW4HHt/Mz+8fZ0y
         W6rQOBRFodJpftvSJxhRU5EfUcbul8ZecksCqB+1YD4Ll4Kg9e76NeyRIlOf4sAN8z6N
         QBLr2LeO9ZoX6/cB8kJlamWRdDPH+NxfxS/HfqENW37qHKdMueeCY3Y/x1Ri1xnL+tFx
         Lydg==
X-Gm-Message-State: ALoCoQlGkyZyHxZ/X7rEz2VeaiOavpE9m1r8MYhleVwo7BQREmttJDVeewJA3WarnKZBa1HZ2PwD
X-Received: by 10.60.97.105 with SMTP id dz9mr8383636oeb.40.1448024164262;
 Fri, 20 Nov 2015 04:56:04 -0800 (PST)
Received: by 10.60.141.40 with HTTP; Fri, 20 Nov 2015 04:56:04 -0800 (PST)
In-Reply-To: <46C55D27-0B59-41AA-84AD-FED095EBDEE4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281517>

On 20 November 2015 at 08:46, Lars Schneider <larsxschneider@gmail.com> wrote:
>
> On 19 Nov 2015, at 15:14, Jeff King <peff@peff.net> wrote:
>
>
>>
>>>  git-p4: retry kill/cleanup operations in tests with timeout
>>>  git-p4: add p4d timeout in tests
>>>  git-p4: add trap to kill p4d on test exit
>>
>> These are all fairly gross, and I don't have p4d to test with myself.
>> But if we assume they're all necessary, I suppose it's the best we can
>> do.
>
> Unfortunately I think they are necessary. However, if someone finds a better way for stable p4d tests then I would be happy to see them go away, again.

I think that's just how p4d is I'm afraid. It doesn't like being
stopped and started quickly (I guess it's not a normal use-case for
most p4 users). I've made various unsuccessful attempts in the past to
make these tests work reliably, and Lars' changes are far better than
anything I ever managed.

Luke
