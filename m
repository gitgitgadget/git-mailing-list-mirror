From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4] clone: simplify string handling in guess_dir_name()
Date: Thu, 9 Jul 2015 23:23:01 +0200
Message-ID: <CAHGBnuO+Anxc_ftxTMFiYXoxu+9tfiR-zaRSzjTTA7PUwzTWKQ@mail.gmail.com>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
	<0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
	<xmqqfv4xuiwh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 23:23:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDJHg-0006PQ-P3
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 23:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbbGIVXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 17:23:05 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37436 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbbGIVXD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 17:23:03 -0400
Received: by igpy18 with SMTP id y18so6099109igp.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zC2P7yD159JznjIPQj2pMDbv7ZMA4yuRhZ3qWxidgcg=;
        b=NadKXCO+Awg/v60iJ5PQZSOFwgVJTCfh+bnD94lrk6hiT+SXDEClZcKKdR6+ZISySh
         +WUlROu7VbH5SaQFB5bEZe0Gtd0xCDBTRcj8cMYba0MbEeXPhsWDY9Z5l4f5sTBLTZAo
         TaLAj7DWEo+nxZkJoyhX1ih332U+/omJx8qiS7wrs/8hMRoE/A4H9TAfMYhXRZ8gMYIy
         MimE1jB9ZgyjLJl2mkgjV72shgk5K1QjjkgMhtXzz0oxAfggNR0gyTjkXqnZiO0qI9fU
         XXHFSGUnzLQNYF9mdumEJS+HrAolEH39EFTWOHO0MsVg6P3NKue+gNgPNuKhRqj9q4mI
         oVBQ==
X-Received: by 10.50.49.46 with SMTP id r14mr78627785ign.45.1436476981652;
 Thu, 09 Jul 2015 14:23:01 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Thu, 9 Jul 2015 14:23:01 -0700 (PDT)
In-Reply-To: <xmqqfv4xuiwh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273779>

On Thu, Jul 9, 2015 at 11:21 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> -     if (is_bare) {
>> -             struct strbuf result = STRBUF_INIT;
>> -             strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
>> -             dir = strbuf_detach(&result, NULL);
>> -     } else
>> +     if (is_bare)
>> +             dir = xstrfmt("%.*s.git", (int)len, start);
>> +     else
>>               dir = xstrndup(start, end - start);
>
> The last one needs to be adjusted with s/end - start/len/.  The
> last-minute rewrite without testing shows; your first two patches
> correctly used "len" ;-)

Doh, you're right, sorry for that.

> No need to resend.  Will locally tweak before queuing.

Thanks!

-- 
Sebastian Schuberth
