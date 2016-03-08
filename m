From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 08/15] ref-filter: make "%(symref)" atom work with the
 ':short' modifier
Date: Tue, 8 Mar 2016 11:51:11 +0530
Message-ID: <CAOLa=ZSSz7F_-fFm70=uyYsu6eGdUT+-SgbphWd8CKXnZqdCtg@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
 <1457265902-7949-9-git-send-email-Karthik.188@gmail.com> <xmqqtwkhnaxg.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xqqA=aZ5Nr7YuMnLKAc2E3F4Y31oOb06aAcvunqw+gH4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 07:21:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adB1n-0000JZ-V9
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 07:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbcCHGVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 01:21:44 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33347 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbcCHGVm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 01:21:42 -0500
Received: by mail-vk0-f68.google.com with SMTP id c3so515425vkb.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 22:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FPX635XyxImLjUjs4/8hkwEjoHx3FCnxiFl9nTv6lnQ=;
        b=KHLNAaHhsbjWZ3qm/1chUInRZ+n7hrTsYLk1XaSobhsjUyfNy2JAxQELZX6lfH1H3a
         xgEznxyfEb5G/1B+62XAHaQXt9hd9WAb4ErpBJJyyIg8zC3TvLr8gDSstMtB9Zhptekl
         GIFsqsNw2LtCGWnUa3Fe3Vo9FPqD05Q+RDtOmBJzSYy8Ga1HaeHuXlnWLXa7eNMVnnUF
         orfFFHUZI0ERg7RBqdDC37BRhU9csFweOZT0rR6HLofor0qcEm9CV7nebtbKGjy2hmsM
         jIAjlYblOkhcbJkvtrrI72SpPJ3ovlyyupVgBRdhhQpn1pOpFUAu0OzCEPIiY74xt5Tx
         OT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FPX635XyxImLjUjs4/8hkwEjoHx3FCnxiFl9nTv6lnQ=;
        b=ZMzWOEYuU/oxeRpjd658hiwA4t74oJHWUoDjLgybY79xlWmXnqfXabzGGWhWpwzWlr
         EfZl1gxifrX42kdTKYRK/0NypQsewwUg9+dKU93VKX5OAcsLbyoJeMZ7hx6a4A8nRXqH
         NLd5nPGvI7QCxibxXA2qrT7oOf/CER5whMROE12PP4xbv0W0YD+KoEmElelkA594HiPS
         w0jimLsFW59JkvxH4t+/eMgZ4fdPBSOnfgqv1HUJYmz/NMKQyF6pZmEXrL9Q2gpsLo0l
         1u9rRfrS7pqmo05FCmg+tmR968K1YQRbgMnHyQ+pC/PDE6GdbERGy+i8R/xzSJjB9NwV
         WkAw==
X-Gm-Message-State: AD7BkJI7yTHVVOg46DBWZ+pDifaBpZ3dqWqmY54Rw5cWxWyuQ2kZQd7ddrebvbeFxn1QrU/PfBOhsnoGWC5uVg==
X-Received: by 10.31.16.40 with SMTP id g40mr18013297vki.97.1457418101278;
 Mon, 07 Mar 2016 22:21:41 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Mon, 7 Mar 2016 22:21:11 -0800 (PST)
In-Reply-To: <CA+P7+xqqA=aZ5Nr7YuMnLKAc2E3F4Y31oOb06aAcvunqw+gH4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288422>

On Tue, Mar 8, 2016 at 7:26 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Mar 7, 2016 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> The "%(symref)" atom doesn't work when used with the ':short' modifier
>>> because we strictly match only 'symref' for setting the 'need_symref'
>>> indicator. Fix this by using 'starts_with()' rather than 'strcmp()'.
>>
>> Does that mean you also accept %(symrefgarbage) without complaining?
>>
>>
>
> Looks like patch 9 fixes this by introducing symref_atom_parser.
>

There are two ways this kinda errors can occur:
1. %(symrefgarbage) : This is handled by parse_ref_filter_atom() which would
print a "fatal: unknown field name: symrefgarbage".
2. %(symref:garbage): This is handled by populate_value() which would print
a "fatal: unknown symref: format garbage".

Either ways we do not need to worry about this as existing code would handle
it. Also like Jacob mentioned Patch 09 would ensure this error checking would
happen within symref_atom_parser().

-- 
Regards,
Karthik Nayak
