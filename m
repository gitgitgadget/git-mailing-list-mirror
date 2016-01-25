From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Tue, 26 Jan 2016 00:59:50 +0530
Message-ID: <CAOLa=ZQmX6QMTz+dki+q07F+pHjUETLRdjJR5=nw8meYfoyEeQ@mail.gmail.com>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
 <20160124071234.GA24084@sigill.intra.peff.net> <20160124071815.GB24084@sigill.intra.peff.net>
 <xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com> <20160124222736.GA29115@sigill.intra.peff.net>
 <xmqqsi1m9yxh.fsf@gitster.mtv.corp.google.com> <20160125100141.GC24452@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Pete Harlan <pgit@tento.net>,
	Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 20:30:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNmqa-0000OE-5T
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 20:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523AbcAYTa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 14:30:26 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35953 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758511AbcAYTaV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 14:30:21 -0500
Received: by mail-vk0-f50.google.com with SMTP id n1so79519467vkb.3
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W14HhMWqy2WTaMNb4GOW0hjrFyWQvCSCHwzQ5+dh7WA=;
        b=gspepvYz/tE4oHadvU/Edsc882Is6Y9fgqD03jVibWkKUSvcTVJ8B7Bv3pjd+6KOei
         LFfONreBVAvPJYQtbtJB9UgaPzbyTWcHUYI0piLVO4tn3BTDW7GQiEPK811in6dAIIlu
         Y0i6k5y8GGhpceGi5GbdJdgrad4dnyLEzOQdNWTd2V1J8OpN1OBBcPp6vDipcvX27c0V
         4H9eUWTx3UAPKvGoxHTCxGNE9v1rL/XKFuPqceGdtalJiqAVg9etj4zl1X1jHDRKiYQh
         fBTorg8w0bujOHa6ioz9DBSvXx5+HZj/CNMXN+04iJpL7TR2L5yexPF/lUNntPQ1M5uk
         eUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=W14HhMWqy2WTaMNb4GOW0hjrFyWQvCSCHwzQ5+dh7WA=;
        b=kILW6227v5lCHPDVLVuVVRL2Pj+Xh3N/3bX+VzhsjzVHQ4tF2VdbhaEYakHKAAd712
         k1jwO8BJMRgEQVV+HC9HQEEVYMTxMHRDYTmuKO1cWd1q+OI/0miLjz5KZywsqE/OwYYX
         xF2s4ZANdKJGPe6MbmlNbwhNrrxngIGNnRIWHJc9ScGkIps/1h2ZZ17dGRSKdnkrBEjq
         WK5qtzc9gbbJJcPkv1uffYvkNEs588Jal0qPloZmkL5IOoazhCVtwf0aJrVVK/Ckbtvw
         Mqh/o/1pMxZ6Z7m+8DBQdoh0z+Hn81KRy9RoxaYFqaEh4dTXmq/hsPuuVWD2v+JnkI6P
         luTg==
X-Gm-Message-State: AG10YOQtLK9Qkmsg601semzztRM95Mvo7QosZgWZ5e0qegciamWjhnRbbgpgU+XubrzunE/CCWpnj0FdpVH7Pw==
X-Received: by 10.31.16.140 with SMTP id 12mr10815862vkq.106.1453750220193;
 Mon, 25 Jan 2016 11:30:20 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Mon, 25 Jan 2016 11:29:50 -0800 (PST)
In-Reply-To: <20160125100141.GC24452@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284750>

On Mon, Jan 25, 2016 at 3:31 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jan 24, 2016 at 06:26:50PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > Yeah, "strip=2" would also get the job done, and extends more naturally
>> > to the branch case.
>> >
>> > To be honest, I cannot imagine anybody using anything _but_ strip=2...
>>
>> I 100% agree, and I do consider this to be internal implementation
>> detail for the listing modes of "tag" (and "branch"), which may be
>> exposed to the user (by documenting that %(refname:X) is used by
>> default), so perhaps even the flexibility of strip=2 is unwanted.
>>
>> I know what "remove-standard-prefix" is way too long for the value
>> of X above, but then we can say "the command will error out if you
>> allow your for-each-ref invocation to step outside of the area that
>> has standard prefix to be removed." without having to worry about
>> "what is the sensible thing to do when the prefixes are not what we
>> expect (too short for strip=2 or no match for short=refs/tags/)".
>
> I'm not sure "remove-standard-prefix" doesn't open its own questions.
> Like "what are the standard prefixes?".
>
> If we are going to go with "remove a prefix", I really don't think
> "remove if present" is too complicated a set of semantics (as opposed to
> "error out" you mentioned above).
>
> I do like "strip=<n>" for its simplicity (it's easy to explain), and the
> fact that it will probably handle the git-branch case for us. The only
> open question is what to do if there are fewer components, but I really
> think any of the 4 behaviors I gave earlier would be fine.

This seems ideal, it's also quite useful like your mentioned example.
And would provide common ground for the upcoming git-branch patches
as you said.

What about a scenario wherein we have
refs/branches/abc/foo
refs/branches/xyz

should --format="%(refname:strip=3)" give us
    foo
    xyz (here stripping till 2 '/', which is the maximum)

or
    foo
    refs/branches/xyz (no stripping done at all)

I prefer the former, cause that would allow us to give a maximum value for
stripping and have everything below that maximum value stripped as well.

-- 
Regards,
Karthik Nayak
