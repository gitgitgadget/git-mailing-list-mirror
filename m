From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make
 them public
Date: Sun, 31 May 2015 21:00:41 +0530
Message-ID: <556B2921.2000407@gmail.com>
References: <5569EF77.4010300@gmail.com> <1433008411-8550-6-git-send-email-karthik.188@gmail.com> <CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com> <CAP8UFD1TTMfruCE-+GT-LzhK5C9LorStPbn64tZ-hhAkC=8Bdw@mail.gmail.com> <556AD1B2.3080502@gmail.com> <CAP8UFD117bJotFQSGjGnSub_0Xq=3wH2o3Du4c49xvmMxAyFDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 17:30:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz5CO-0004yr-Or
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 17:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758466AbbEaPas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 11:30:48 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36754 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976AbbEaPar (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 11:30:47 -0400
Received: by pdjm12 with SMTP id m12so6562255pdj.3
        for <git@vger.kernel.org>; Sun, 31 May 2015 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Wvuz8mf5PBPSOqUQ4oZwq1v0HCEthpfUkLhVRqlg5sc=;
        b=dRLXm2nqZk0FmCCYSlqQUEHZf4FE3sMqTHzEVDsdWMJ8z9ARlCt+dr1z6fdYKg84Sp
         eunG7gdpSs+e0JvsNvrxp/y7uBq43tLwoz8LuM2Cqy31BabQ/EEYovWG+TlN0mxdEUYA
         eDSttefPlRJPFk5vVN0MgZQaWgfQd1EZTZ1bkmTMkuB2PfGnLCGyVv7vz2BaJ9cPzHWq
         qXF+MxSIowJHaLmJS6mNqwg4Ds/B0dps2Kk1zI/jZRSDmpqkgxtx7gvMpNme7kiHNcE0
         W6c5Q9Ze2I1ROafsbJVTxVQvA80rlCZym3NqO7b/mFD+dgWdUW8bedhz5kvsmrcYwjad
         QdoQ==
X-Received: by 10.68.246.1 with SMTP id xs1mr32486699pbc.53.1433086246993;
        Sun, 31 May 2015 08:30:46 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id bx8sm11628032pab.38.2015.05.31.08.30.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 08:30:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAP8UFD117bJotFQSGjGnSub_0Xq=3wH2o3Du4c49xvmMxAyFDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270332>

On 05/31/2015 07:33 PM, Christian Couder wrote:
> On Sun, May 31, 2015 at 11:17 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > On 05/31/2015 01:41 PM, Christian Couder wrote:
> >>
> >> On Sun, May 31, 2015 at 10:04 AM, Christian Couder
> >> <christian.couder@gmail.com> wrote:
> >>>
> >>> On Sat, May 30, 2015 at 7:53 PM, Karthik Nayak <karthik.188@gmail.com>
> >>> wrote:
> >>>>
> >>>>
> >>>> -static void sort_refs(struct ref_sort *sort, struct ref_array *array)
> >>>> +void sort_ref_array(struct ref_sort *sort, struct ref_array *array)
> >>>
> >>>
> >>> It is probably better to call the above function ref_array_sort()...
> >>>
> >>> [...]
> >>>
> >>>> -static struct ref_sort *default_sort(void)
> >>>> +/*  If no sorting option is given, use refname to sort as default */
> >>>> +struct ref_sort *ref_default_sort(void)
> >>>
> >>>
> >>> ... especially since you call the above ref_default_sort()...
> >>>
> >>>> -static int opt_parse_sort(const struct option *opt, const char *arg,
> >>>> int unset)
> >>>> +int opt_parse_ref_sort(const struct option *opt, const char *arg, int
> >>>> unset)
> >>>
> >>>
> >>> ... and the above opt_parse_sort().
> >>
> >>
> >> After saying that I realize that these two other functions are not
> >> doing the same thing.
> >> This might suggest that they are not named very well as well.
> >>
> >
> > What do you mean by "not doing the same thing."
>
> sort_ref_array() is actually sorting a ref_array, while
> ref_default_sort() and opt_parse_ref_sort() are not sorting anything.
>
> Maybe it would all be clearer with a renaming like the following:
>
> sort_refs() -> ref_array_sort()
> struct ref_sort -> struct ref_sort_criteria
> default_sort() -> ref_default_sort_criteria()
> opt_parse_sort() -> opt_parse_ref_sort_criteria()
>
Thanks will follow this, but will change opt_parse_ref_sort_criteria() to
parse_opt_ref_sort_criteria() as this is what is commonly followed.
-- 
Regards,
Karthik
