From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] rebase-i: print abbreviated hash when stop for editing
Date: Thu, 24 Mar 2016 22:06:37 +0100
Message-ID: <CAN0XMOJKq7nvyVu57g=Fi3195oG4pDbL7mw3urL33iJDb4Y0cA@mail.gmail.com>
References: <1458844281-13107-1-git-send-email-ralf.thielow@gmail.com>
	<xmqqfuvf8xav.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:06:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajCSq-0005JW-MG
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbcCXVGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:06:39 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34764 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbcCXVGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:06:39 -0400
Received: by mail-wm0-f49.google.com with SMTP id p65so5060275wmp.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rRl81a4Aa2UaN1jsQndpY7GIbtCQOCd4DkuyG9UDHMU=;
        b=ihsqA95c9jWe13B1SXcA4ltL8e0p0DLufvx3jhRwbwQSqvtX/ApVtggEVn5ObrTw92
         h86uX8G32osF7lFTVpLkKcOkjkCoD59z3+GqOX4N4FaBJcWIBLq5PlGghvu19TFFq92T
         xBmOgExPuFkWx4/VbsqVdbK77yorJfOV2GciykWk/HWca9J9L5ZAexREsKtgyo1dF3za
         jzar2wyLXGRBmvw1cgnrOJsYjJ2KpdlWBJVk5AJXVK7mn6+b98hZ4pnFUWwM2EdbVWwV
         wWLPpjxvW+8X02Wp1TVtr174tSozdDQwd3Cm2ieSRVYlCtPX3mWwM9O77S/hmmnYbBTX
         EeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rRl81a4Aa2UaN1jsQndpY7GIbtCQOCd4DkuyG9UDHMU=;
        b=HkZpyzsyAtSkIAEpUjUWe5xLO9AX526/bqLUXe5DBWztWggjGE6dgRVlTbNJgTPo07
         KzjqjQ0jyYe0+GHUg26mhHATL8vY4lKmCzO0/q5p3kxAcJES0/UcaR5Wjww65rdjgGwp
         20H2Ze5xb3EdG3Rnmp3+Kpf+YBzb6r+rKD3eREU6MCgG5+HzLOYuZJjXBfY2jeKCyMiz
         1xQ+YslZbvmSgeq9mEaAvSSUIvZdyPoehJuJrg5BE7oc74fIHP4eH2ew+8mFa7bJp4vl
         JLYb+PFw+fb0t/75Q/m4UKYf57i1QoX7leG+IkyRXWnaHcI8/CXi6HT9WJK6KSXYGb+m
         KqjA==
X-Gm-Message-State: AD7BkJIh9e13wrmuzOjj6oOspQHhryDLD57l7mX/dNi4x9p41wynX2RRArstno2TjiM0Zowo7wC1+0qXjmlz5g==
X-Received: by 10.28.34.69 with SMTP id i66mr35757636wmi.91.1458853597345;
 Thu, 24 Mar 2016 14:06:37 -0700 (PDT)
Received: by 10.28.23.10 with HTTP; Thu, 24 Mar 2016 14:06:37 -0700 (PDT)
In-Reply-To: <xmqqfuvf8xav.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289797>

2016-03-24 20:56 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>
> Hmph, the reason why this is a good thing to do is because an
> overlong $sha1 would push $rest too far to the right (possibly
> making it overflow to the next line)?
>

Yes.  Another solution would have been to remove the "..." at the
end, but I prefer to see a shorter message rather than having
the full sha1 for whatever reason.

>
>>  git-rebase--interactive.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 4cde685..9ea3075 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -548,7 +548,8 @@ do_next () {
>>
>>               mark_action_done
>>               do_pick $sha1 "$rest"
>> -             warn "Stopped at $sha1... $rest"
>> +             sha1_abbrev=$(git rev-parse --short $sha1)
>> +             warn "Stopped at $sha1_abbrev... $rest"
>>               exit_with_patch $sha1 0
>>               ;;
>>       squash|s|fixup|f)
