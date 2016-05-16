From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/12] attr.c: update a stale comment on "struct match_attr"
Date: Mon, 16 May 2016 16:39:52 -0700
Message-ID: <CAPc5daU248vqPwWiNzJf3gKJnO=SqngUSpT-BEdT2t91ScbBCg@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com> <20160516210545.6591-4-gitster@pobox.com>
 <CAGZ79kZW6GRC8As5oX6CXbTarcU86x_+e8=ksABQubXJGkVhiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 01:40:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2S7Y-0005fJ-RB
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 01:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbcEPXkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 19:40:13 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34954 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbcEPXkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 19:40:12 -0400
Received: by mail-yw0-f177.google.com with SMTP id g133so177843559ywb.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 16:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dxQJUMky6WId1Cd2GmICwAeOeIGTDOV7G9bE5c22umA=;
        b=KtNnb7Xu/nwBwSo3XuqI7+RwN7pbTDj9ekC3Fim8z0BZA3043F4IUf6UY2rjt2WdPj
         YwR00pADMDtZJxbz8By/U0R/yWHv43EDt8l96pe7z/7dRXKezfI2Zp++tKcczbtaukW/
         6a+xeFegMc7Ru8woKq0lHfKUHdhl1mK0eS8+sNpRD6XcFoIuWy52NyKMszXcsjT/7KmO
         54+q/fVzJ1n595lk0/nfsly2cEWsNgxavZEwtXJEKQo6vcIuA6gnKETwZmD2/63MPwyf
         lXzynP0jRzRfsIm+Xxe+m3M1xkgX6KskTRoMPM9BoplbZ1T6ShUN+7cSmiKqvTG0NWya
         Yhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dxQJUMky6WId1Cd2GmICwAeOeIGTDOV7G9bE5c22umA=;
        b=jPX8Qbi0UjCfLtguUakJrRc85LZnnFFCqERrtqaJBPrrVry0TymtN1yylAkzu25V3R
         UCIf518JIvmJEaQQII2Z+S73f7VDByAUd8mapuXgclPr1GEG8unP1p0wz3giEAFkcMjk
         L17lqMKyrp+cT3QuFFQur1nciTufoaxSu0iiipTa3Sp2Lly2IUUofN7vUatUQ5QwT58l
         Dmxibe1Ic6uRUG9ZNBkgmeE8OBX6tuTMW++lKkj9VMdseFLHZjM5iic3y0h1pzvmnj+Q
         OR6gACTJCYXhfek/I0sE/NcPFqoYHu43aH28YsRhblwM7Ld07ojn4uUPoWwcw0s3UKID
         aq5A==
X-Gm-Message-State: AOPr4FW9gdmTpxUymVZAoCscDdk+jNagKtd+SHgEd7Q9r4xEE2O/IAvrqbbhz5nJ+3Ml05KmO60f2T7E/up9dQ==
X-Received: by 10.13.215.75 with SMTP id z72mr17221665ywd.278.1463442011373;
 Mon, 16 May 2016 16:40:11 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Mon, 16 May 2016 16:39:52 -0700 (PDT)
In-Reply-To: <CAGZ79kZW6GRC8As5oX6CXbTarcU86x_+e8=ksABQubXJGkVhiQ@mail.gmail.com>
X-Google-Sender-Auth: 6OiCCVEr_BVRlU2esHiDIxgsWYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294818>

On Mon, May 16, 2016 at 4:34 PM, Stefan Beller <sbeller@google.com> wrote:
>> - * If is_macro is false, then u.pattern points at the filename pattern
>> - * to which the rule applies.  (The memory pointed to is part of the
>> - * memory block allocated for the match_attr instance.)
>> + * If is_macro is false, then u.pat is the filename pattern to which the
>> + * rule applies.
>
> and we don't need to talk about memory ownership here as that
> is clear for 'struct pattern' documented elsewhere?

It is embedded in the structure which you cannot lose independently, no?
