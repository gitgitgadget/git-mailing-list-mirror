From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Wed, 16 Mar 2016 21:50:11 +0700
Message-ID: <CACsJy8B08c5ydNL0e8fvaG7_4UEFqsCR4a0beuvDmYEmPDr78Q@mail.gmail.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
 <xmqq4mc76yji.fsf@gitster.mtv.corp.google.com> <CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
 <CAGZ79kZihaftwwmY23mZ_i4H6vv2Z9r=LC68M0MMD1o2h2Z4Sw@mail.gmail.com>
 <CAGZ79kZtAm1M=9CGDGxPdecXEuNEQcbpQb3FNj9=Py0VE2UrKQ@mail.gmail.com> <56E96D61.6060007@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:50:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agCmg-0004d2-Fs
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 15:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966801AbcCPOup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 10:50:45 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33315 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966783AbcCPOuo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 10:50:44 -0400
Received: by mail-lf0-f44.google.com with SMTP id h198so21050162lfh.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7/b2MxhnugQ3fdJauCmjaSnhqK1uaR11PkhBuKIQXOU=;
        b=zCvZvMtON1g7K++Mcjr/Z4RbL26N5YcVE5QeGC3R0ao95gdo8CFK3e3EHkEt7d38Eg
         gdckvJ+XwI+eLvPKHoGjyhXkXnyqo+3gaG05uYLakoXZD0vZi2W94GgjRW7y+rHBeoSQ
         XdNsbZQfLztJu45Yb3YbB9mkSnUFsKmtGUf35Gk00b0UlBKGq39ODPN14DFNVRjDwHV2
         Sfks/EanMJr4wOZMV15OSBegxZoHbSOcyy03L7nbEksurj1teuKFgccjd/j2YGzva7wV
         SpZ2S+dIea7c1ZjRW6IiCQfGglUdHhFu1m2J0pQiM64VTqwjws6cCQTXoKhRS0w0gP3v
         N8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7/b2MxhnugQ3fdJauCmjaSnhqK1uaR11PkhBuKIQXOU=;
        b=jzZV3KuIXxXPPhgyEmndftGAwKS+Vfspe0RjmkZ2ncNsBc9jmqfqWZsov8Dlip6BmT
         Yh5bshTYTp93+R/+Uio6fa5hnalCPndNy+u4in08BJXR6yUH6bbzxaVfRsLH66uX21gm
         3Uin0Mmp3mHDn20qAIyMEM3WoAcm2eU5xImzLEv2asWyL13qP4oSlyqoGQpjOcqBOvnf
         fu03ScbB+MTm37S100757Q9M1zUxpvqdNed4HEPTpsl0T00x+8zkA75izxRheaNU4QlF
         THhapJ2HwZRwioa9QoVj3ytogO58XIBnGDOwIiCtZG7Yh3CuIHo+gT8FcUexh4+F6hDQ
         LFeg==
X-Gm-Message-State: AD7BkJJLEhoZ7wqTq1BFfmaYOthf9BxU9VRyBJjhRvKvbQ80XYgV1zTlHPluwQYtQLv0WE5170PwwXOx3xEGOA==
X-Received: by 10.25.160.79 with SMTP id j76mr1588430lfe.83.1458139841409;
 Wed, 16 Mar 2016 07:50:41 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 16 Mar 2016 07:50:11 -0700 (PDT)
In-Reply-To: <56E96D61.6060007@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288979>

On Wed, Mar 16, 2016 at 9:27 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> On 16-03-15 09:02 PM, Stefan Beller wrote:
>> On Tue, Mar 15, 2016 at 6:00 PM, Stefan Beller <sbeller@google.com> wrote:
>>>
>>> Instead of converting to whitespaces in Git, we could make use of the
>>> set_tabs capability for ttys and setup the terminal for having tabs align
>>> to 12,+8,+8,+8...
>>
>> Or rather read in the existing tabs configuration and shift it by a constant.
>
> Could this also help with diff output, where the leading + or - mars the
> indentation in a similar way?

Yes, please! Even if we only activate this when stdout is tty. Much
better output.

> That opens a bit of a deeper problem, because not all the files in a single
> repo necessarily use the same tab size.

Maybe we can pass --tab-width=xx to git?
-- 
Duy
