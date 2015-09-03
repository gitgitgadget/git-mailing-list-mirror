From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Thu, 03 Sep 2015 09:23:53 -0700
Message-ID: <xmqqtwrblbdy.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRfYow-wBvorX44E4ROH=nvQdS=3zBaEVVbQZf86JFELw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:24:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXIs-00076o-NK
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522AbbICQX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:23:58 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34538 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757516AbbICQX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:23:56 -0400
Received: by padfa1 with SMTP id fa1so8833519pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4EoquLIzzk4z1UhqV6XoXSERdrLg7YeWgz/gc2Yv9PA=;
        b=DHWBEzKb5VQCP85UWEuxxvx9biO6lgzxPr/FPlpIzobl0H0KB2NpQbCcGNLQlC76k2
         Su1A//o3IEIGzzgSd2V/qaToQJ/BQGlVmtUyTb0M4E/MnuRl6uU5viPhDd+43WWFAFfu
         +o8esLFWk2g0WkzsSy1eXipxa81+HfwgMTMgpZLf8uwWJ8/WxwwJ5cu8IgKfRE+0Xjll
         L08ss28N2kTbfpO0ASzXXs1KdnNVVqxNYQWA5SD+xCrWUk3OTyHRdE8upem7K4peoKH2
         Fog+BHRdwFEvvcUNppbwXo76VvHcXUa4SHYeoFv0Bd30bJ2ZjIOGiFbOLOCua1YtqdsL
         RGSg==
X-Received: by 10.66.163.161 with SMTP id yj1mr67262081pab.34.1441297435591;
        Thu, 03 Sep 2015 09:23:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id kp7sm17153504pdb.49.2015.09.03.09.23.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 09:23:54 -0700 (PDT)
In-Reply-To: <CAPig+cRfYow-wBvorX44E4ROH=nvQdS=3zBaEVVbQZf86JFELw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 3 Sep 2015 10:12:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277220>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Sep 1, 2015 at 2:26 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Implement an `align` atom which left-, middle-, or right-aligns the
>> content between %(align:..) and %(end).
>
> Spell this either %(align:) or %(align:...) with three dots, not two.
> I, personally, think %(align:) is sufficient.

I agree with you that double-dot does not signal "some things are
ellided here" to a usual reader.

I actually think consistent use of %(align:...) is needed, simply
because my knee-jerk reaction to "%(align:)" was "huh?  where does
the need for the trailing colon come from?", not "ah, you try to
imply that there must be something more by having just a colon
there".
