From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 05/12] for-each-ref: introduce new structures for better organisation
Date: Thu, 11 Jun 2015 21:13:28 +0200
Message-ID: <vpq4mmeqcrr.fsf@anie.imag.fr>
References: <5579B253.4020804@gmail.com>
	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>
	<1434039003-10928-5-git-send-email-karthik.188@gmail.com>
	<vpqwpzarvl6.fsf@anie.imag.fr> <5579CBE0.3050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 21:13:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z37v0-0005gA-5l
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 21:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbbFKTNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 15:13:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36371 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbbFKTNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 15:13:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5BJDQEg012465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jun 2015 21:13:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5BJDSqK017804;
	Thu, 11 Jun 2015 21:13:28 +0200
In-Reply-To: <5579CBE0.3050301@gmail.com> (Karthik Nayak's message of "Thu, 11
	Jun 2015 23:26:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 11 Jun 2015 21:13:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5BJDQEg012465
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434654807.06808@vvbKqAzaOGkt9MTKmo+oGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271452>

Karthik Nayak <karthik.188@gmail.com> writes:

> On 06/11/2015 11:11 PM, Matthieu Moy wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > +struct ref_filter_cbdata {
>> > +    struct ref_array array;
>> > +    struct ref_filter filter;
>> > +};
>>
>> I didn't notice this at first, but why introduce the structure like this
>> when you are going to turn it into pointers later in PATCH 7:
> Here it is serving to for-each-ref, so I kept it this way so as to ensure
> that currently as per this patch
>
> struct ref_filter_cbdata ref_cbdata;
>
> would be the only declaration needed in for-each-ref.c
> If I made them pointers here I would need to have
>
> struct ref_filter_cbdata ref_cbdata;
> struct ref_filter filter;
> struct ref_array array;
> ref_cbdata.filter = &filter;
> ref_cbdata.array = &array;

... but after PATCH 7, filter and array are passed to ref_filter so you
don't have this overhead anyway. Makes sense.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
