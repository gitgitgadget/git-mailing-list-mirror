From: Stefan Beller <sbeller@google.com>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 18:00:17 -0700
Message-ID: <CAGZ79kZihaftwwmY23mZ_i4H6vv2Z9r=LC68M0MMD1o2h2Z4Sw@mail.gmail.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
	<CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 02:00:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afzp1-0008JJ-GE
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 02:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbcCPBAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 21:00:20 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35629 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbcCPBAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 21:00:18 -0400
Received: by mail-ig0-f180.google.com with SMTP id vf5so102100261igb.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 18:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Ad9OmAf1rgUBr/VT17QjdV/UZiwgMTM+Ox4JXZuU1iA=;
        b=ToBCeIHPx81TlceR3hSCXC2IAy1uHBDKsvHmP1dCNEJPiGyNyROHBSokO3EQ74xLhC
         ZnEVu2HC5I/e/fC5bZ0Styin6ZFCox94dNIlWB0fOt/eXS4kBDRkWZC+9pnubIwChCmM
         ++2EPPO6WomHYbkLP+7b94WcWnHz5HnMbTMpoteeyuZnlXLHXw+yuCOxFNL6b8IK37he
         RTvQqIU4RrOxMQ64tqbb5//Qhyz6x7U3ugD838UUsXm/5Ucyqj00lDW7dDGPqBCNTzD+
         MlUsmdXkVUPKTnULjblxYbRgoMKVQ3f315+hSpHotdAYKVe2tvRtRMGsrdm0VNA0T8/K
         xDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ad9OmAf1rgUBr/VT17QjdV/UZiwgMTM+Ox4JXZuU1iA=;
        b=lp8VEiyd00TZazLMaA2xIaRy4eM7wNhlUo03+fXk7Ol7duwX2AKlI7/2Sm5pInNzXz
         ets86eyEYG7hX+XlwOk91LSDZJkMBgzFR4ecvUfUnY5eyQdhwZkZF9onN9bN6yZYDK7u
         4CmYugX5QXCC99Ij+gx2UjeOnDqNlhg+PsjK36ZAYidp65PTvkN6Soqops/5iiaavl0x
         HyDNcSn2gonN4le/UaeV2DgNIkYW8UUev2QN8xKhteyFwFj9n+6eL9/4iQkvlGzyYSH4
         sMwbsp2v/k6fJRz3ztTLlHFWNSd/OnPtnAhawDXIsYGm/0AtNbT2F1ONvdRriku/VwZ+
         GL2w==
X-Gm-Message-State: AD7BkJIOI5/usfQXGAP8Z0ekEEvmGPUXyowHGu/d95oK6GBc+aFVzmbndi6WNCqY7olxAQ8CGR6nQim1jqOUDuFl
X-Received: by 10.50.43.226 with SMTP id z2mr1742279igl.94.1458090017332; Tue,
 15 Mar 2016 18:00:17 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 15 Mar 2016 18:00:17 -0700 (PDT)
In-Reply-To: <CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288936>

On Tue, Mar 15, 2016 at 5:48 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 15, 2016 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Wouldn't it be nicer to do this kind of thing at the output side?  A
>> stupid way would be to have an option to indent the log text with a
>> tab instead of 4-spaces, but a more sensible way would be to keep
>> the visual 4-space-indent and do the expand-tab for each line of
>> text.
>
> Yes, that would certainly work for me too. It's just the "ascii boxes
> don't line up" that is problematic..

I would also rather side to correct the display side rather than the
applying side. [I still want to send and apply patches with git written in
the white space language ;]

Instead of converting to whitespaces in Git, we could make use of the
set_tabs capability for ttys and setup the terminal for having tabs align
to 12,+8,+8,+8... such that it looks like an indented terminal.
That way we would also preserve the tabs in case you'd want to
copy the message as is.

Thanks,
Stefan

>
> (Also people including example source code etc, where the first tab
> looks wildly different from the second one)
>
>             Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
