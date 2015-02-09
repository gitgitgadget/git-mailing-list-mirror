From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/11] Allow reference values to be checked in a transaction
Date: Mon, 9 Feb 2015 12:41:19 -0800
Message-ID: <CAGZ79kZ3ShkW0tu=1uskXw-R93pnkw0faxut-5kA=UrsJiv+Ng@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqtwyvapx7.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZmwk5=ViPdRVd+0ncMyAhGAbid6TJUznvMuK6pQ_VSRw@mail.gmail.com>
	<54D91B24.5050808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 21:41:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKv92-0005ig-V9
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 21:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761005AbbBIUlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 15:41:21 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39416 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759843AbbBIUlU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 15:41:20 -0500
Received: by iecvy18 with SMTP id vy18so244117iec.6
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 12:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W561LmC65pi0tYpCNaySxaghdYZJlQ6nn9DMXKg1cuo=;
        b=kwAVH9YSCtQh8/wyeV9GxrIcD04IzFvVhDQZtM3fOnXLKDzGMdXDn1Q0AipaD8YV1U
         dQNntR+Xy9MAhF4IxlAfkJb/rtQVhA+pj8yrrxUhjKngCHDsflG1rYLbUTTb8g0o8LoY
         gUPwSh8r8nmDqO0Nuiif594eGKsCPcqMe9wQjYOVnChmL/Qz57jwB7+sZipf3vnv5PVa
         arBKT/is3p0oivBcBgIaVnZXLy3c4BL6IgVU5nAMKxnlQk26HIO7NhLrjhoW+Ig2+wAm
         LVIFVKxI04/Bb8X2NXYwgNU7wDmmEF+ZgR52PIF9SFL9JqndJjTgV/q71pQJ77YWBuSR
         3Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=W561LmC65pi0tYpCNaySxaghdYZJlQ6nn9DMXKg1cuo=;
        b=jW+Ef8PMujvWgyuz1P2JhKyrmshOHkgmunU+MGDdD5uMX3p5a8BDgjsi+rJuQ4LicY
         CnPQAknGQZJAUCq8xl3KclTF3J8YsolJayCCDKHvw3jPl9m0cZJh39MITKYyrX2Ji3SG
         z9Kx/zJc/r1eQTUMSB45Zdn3JUZ+bU7crCYGeyryDwcutGNjGm0i4/4GkpCbHR5yECGp
         ROsQHlNO9bChudley74mpsSpXZD7H97dS20+xVtgySCoG0tYUbzSUkewQNPY38F47vCo
         n/GrzNM7SvQMyEagv08DwpY42BmZrlEhyLDREJBhqc65scpLU/cA2LDjLZOeTC4eSbPd
         Y5vw==
X-Gm-Message-State: ALoCoQk/h7Ld7rIfZJVM7aekAJ9oIS0h4Z6n+JauVyI7Idg/uEkHO0y0rXQF9ZaJp5N41DoIAOS4
X-Received: by 10.42.230.67 with SMTP id jl3mr6888665icb.15.1423514479603;
 Mon, 09 Feb 2015 12:41:19 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 12:41:19 -0800 (PST)
In-Reply-To: <54D91B24.5050808@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263593>

On Mon, Feb 9, 2015 at 12:40 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

>
>> I am not sure what advantages this would bring. A better history
>> for bisection? I cannot speak for Michael, but my understanding was
>> to have mh/reflog-expire and sb/atomic-push-fix merged now that 2.3
>> is out and everything else on top is unclear/rerolled/discussed as needed.
>
> Stefan, I think you mean sb/atomic-push, not sb/atomic-push-fix, right?

Of course, sorry for adding more confusion here.
