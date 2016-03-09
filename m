From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 08/15] ref-filter: make "%(symref)" atom work with the
 ':short' modifier
Date: Wed, 9 Mar 2016 16:47:55 +0530
Message-ID: <CAOLa=ZRnVrWxKyYu5soXq27WkevF2tHYSAK04BzGU+yx0JK+rw@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
 <1457265902-7949-9-git-send-email-Karthik.188@gmail.com> <xmqqtwkhnaxg.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xqqA=aZ5Nr7YuMnLKAc2E3F4Y31oOb06aAcvunqw+gH4A@mail.gmail.com>
 <CAOLa=ZSSz7F_-fFm70=uyYsu6eGdUT+-SgbphWd8CKXnZqdCtg@mail.gmail.com> <xmqqwppck9je.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 12:18:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adc8n-0007yV-4e
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 12:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbcCILSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 06:18:32 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36759 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbcCILS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 06:18:26 -0500
Received: by mail-vk0-f44.google.com with SMTP id c3so51418005vkb.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 03:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HaZ7mOTL3JhkEm9BciefDcvmxUQDCjE20Tw3qRgPxgM=;
        b=YFc6y5F2mTjtvgT6jIX+ZDPYt78ZnZE0wMXeTaYIxo8DeyWuTqecEimphw2wdSgDWk
         GQdzHZzI8DnN1Fwxd9EbsGTAt16RHOWsL3YgfMCNncgkpnYUZKvqDp0NycB5N+5f/dbk
         fRUzA+IFdMhLl7Y5U0GZj85E32iFEEifKh668uC/Klq1puj/mktdIQC5NGQBnh7AGeDd
         r/r139rHldVWdnmeviNDRsE1/9mLUKEEAdBIJfdUviSfVPDXZZt/ZIFUTuDtOXMa414r
         YSM5CfW1cuGtud/8HorDyu8XiVgSuvhrZ8cR6OuqJ85XmVW+k5kXFqzPS5GxEqOTSVLK
         CWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HaZ7mOTL3JhkEm9BciefDcvmxUQDCjE20Tw3qRgPxgM=;
        b=WZDrkAiITuGK4BK2uWqiqTT9BY0vPtoJOBhs6g+GyRAz8toQQ+xsd5FI7bf5Pk4DOK
         qM0gGQf2a8+jaW7amdqHMEtJRvi3eROCzdy2LpVLaJsxv2r94lqRI08NeD1CouJyCFIx
         HtxSUI3v41wbZh08ZXtx4wgXKutaayOjCLv+IfO4oGg1QqFHkJNmZw5H0AdJQx3s7Spd
         cE5gFC2PZSOy1kjB71kNWIclgxCm5DaxKjBdQ40jSsJTgpkrGygA0WMIgByWeF0PWj7R
         KNz0rJ9IelthZO1HfPBUhYDs47yzhtZc7Pm7OUcqBIj/3a8/7COH5WB9THHUZcGNBRtD
         UU+w==
X-Gm-Message-State: AD7BkJLIX6jXOr6FZvG8sDCdUniPFpfvmxIKMvJabd2ogXsdQ8oCWnGhObgwkRikmpgBzzVbYT6V50OVQevchQ==
X-Received: by 10.31.142.203 with SMTP id q194mr30141553vkd.95.1457522304643;
 Wed, 09 Mar 2016 03:18:24 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Wed, 9 Mar 2016 03:17:55 -0800 (PST)
In-Reply-To: <xmqqwppck9je.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288480>

On Wed, Mar 9, 2016 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Tue, Mar 8, 2016 at 7:26 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> On Mon, Mar 7, 2016 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>>
>>>>> The "%(symref)" atom doesn't work when used with the ':short' modifier
>>>>> because we strictly match only 'symref' for setting the 'need_symref'
>>>>> indicator. Fix this by using 'starts_with()' rather than 'strcmp()'.
>>>>
>>>> Does that mean you also accept %(symrefgarbage) without complaining?
>>>>
>>>>
>>>
>>> Looks like patch 9 fixes this by introducing symref_atom_parser.
>>>
>>
>> There are two ways this kinda errors can occur:
>> 1. %(symrefgarbage) : This is handled by parse_ref_filter_atom() which would
>> print a "fatal: unknown field name: symrefgarbage".
>> 2. %(symref:garbage): This is handled by populate_value() which would print
>> a "fatal: unknown symref: format garbage".
>>
>> Either ways we do not need to worry about this as existing code would handle
>> it. Also like Jacob mentioned Patch 09 would ensure this error checking would
>> happen within symref_atom_parser().
>
> You forgot to mention that there is 3., which is that you just
> closed the door for a new valid_atom[] that begins with substring
> "symref" which does not need to flip need_symref on, I think.
>
> You can check valid_atom[i].name with strcmp() to achieve what you
> are trying to do here, instead of checking used_atom[at].name, and I
> think that would be a cleaner way to avoid all three problems.

That's actually a very good point, will incorporate that, thanks!

-- 
Regards,
Karthik Nayak
