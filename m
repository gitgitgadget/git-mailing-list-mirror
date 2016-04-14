From: Andrey Hsiao <andreyhsiao@gmail.com>
Subject: Re: Question about git log --merge option
Date: Thu, 14 Apr 2016 10:31:31 +0800
Message-ID: <CAArk4YNKoM9p+FVv+q5Ty4YYoWDcXuF-HjEk96F4Pf-i8QWKDA@mail.gmail.com>
References: <CAArk4YMOkd3dEn-09-LMO7zf=X3iJqXUjCS0YNN5v4h=PjrTLg@mail.gmail.com>
	<xmqqvb3ljldq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 04:31:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqX4G-0005hj-4t
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 04:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbcDNCbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 22:31:34 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36562 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbcDNCbc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 22:31:32 -0400
Received: by mail-vk0-f65.google.com with SMTP id x190so8850885vka.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 19:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=r5zQ4HUSdyPdhICHd0jFsuCn2uQq/FmVqQ01jrOrv6Y=;
        b=CRFYao1U+l4OT1njy515abj/dN7ZlWU2HQM2WvwwYiPuaRkRgkS+ceFO2S/N4G6mP7
         6h4mL4rmrJwYueienQt5mYZfnj9DImIVNTRkQETQMqTFa1sZH9ZE3F1M6jwpVhBE0RLA
         h95bZeICRsmKgaqiYUiN42a5AvJEVEy+0cL+VSRJTOTBvVH0/6/16CNA/VMOTfTbKuyR
         JGDHkhRCh2o4gTxvk1mhgklYpolBDWYMg9Pr47z8zoFbP/ePWEQMjPeI+WCpIAMDRdSv
         1TGOjygtErKflRNL9PjHf4U+vf3g5uWwlZxDWVg2mBPflo/XASf6m3Z5G2gkua0MI6SM
         DxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=r5zQ4HUSdyPdhICHd0jFsuCn2uQq/FmVqQ01jrOrv6Y=;
        b=U49ywMMCMqr7SS56H9OW7NoLmf/vpSQPMn1Q/RFXFXqfNqPCGFgjtly4GVUcpxipIn
         vMJ+21Po41BKEoXG/PRluFXOYwNSdQ0t0zxBhAW+E8bgRCbX0glawDsMm0NeY/yNQo4D
         gpS6HS+MYxAiX9arBYfaxkV/8pcAAc7hxbqD6NsK+HaRyNa4Bi5/rbgW8Aic2TkApJ5M
         dJJCAtzLQONIlFCMAIzxKUyJGYN4u/w+rMymekfoAdJEVA5M0hKxlnEoHL7lB3X/GntL
         UAH/FLk76P6FtdZnDzLj4iQZOc9lcSyEibpaYnXTfbbodMjVlGKIx/i3D2N7rQnP61Ua
         +FBw==
X-Gm-Message-State: AOPr4FXqnl+ksLZAlADectlbT/89pdg9Qb72uqGwHChkkEujph6296upEfLDZCU5mOzZfvdllu3eeXl6fHKLmw==
X-Received: by 10.31.54.207 with SMTP id d198mr6532896vka.119.1460601091252;
 Wed, 13 Apr 2016 19:31:31 -0700 (PDT)
Received: by 10.31.89.70 with HTTP; Wed, 13 Apr 2016 19:31:31 -0700 (PDT)
In-Reply-To: <xmqqvb3ljldq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291512>

Thanks Junio, I understand the option's meaning now :)

On Thu, Apr 14, 2016 at 4:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Andrey Hsiao <andreyhsiao@gmail.com> writes:
>
>> Dear list:
>>
>> Just encountered the --merge option for git log.
>>
>> In the man page, it has the following explanation:
>> - After a failed merge, show refs that touch files having a conflict
>> and don't exist on all heads to merge.
>
>         git log --merge [options] -- $paths
>
> is roughly the same as
>
>         git log [options] HEAD...MERGE_HEAD -- $paths'
>
> where $paths' is $paths limited to those with conflicts.  You can
> further think of that as a rough equivalent of
>
>         git log [options] ^X HEAD MERGE_HEAD -- $paths'
>
> where X is the merge base between the tips of these two branches:
>
>     X---o---o---o---H
>      \
>       o---o---o---M
>
> And the commits among these ('o's, H and M in the picture), the ones
> that change any of the $paths' are shown.  If you further limit the
> output (e.g. with -n<n>, or --since=<time>), you may not see all of
> them, of course.
