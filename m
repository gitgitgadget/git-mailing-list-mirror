From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Sat, 23 May 2015 19:00:46 +0200
Message-ID: <vpqr3q7cjpd.fsf@anie.imag.fr>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>
	<vpqr3qagvv6.fsf@anie.imag.fr> <555E1CE7.8090507@gmail.com>
	<vpqbnhd157k.fsf@anie.imag.fr> <555F252C.2060601@gmail.com>
	<vpq8ucffj8h.fsf@anie.imag.fr>
	<CAP8UFD0CPLcTGYTo1Oh_QFxVkORBZF2SmwRYu0O8do66qmakPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: karthik nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 19:00:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwCn9-0002N6-CV
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 19:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbbEWRAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 13:00:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57650 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758034AbbEWRAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 13:00:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4NH0iE6019188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 May 2015 19:00:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4NH0kGM013684;
	Sat, 23 May 2015 19:00:46 +0200
In-Reply-To: <CAP8UFD0CPLcTGYTo1Oh_QFxVkORBZF2SmwRYu0O8do66qmakPw@mail.gmail.com>
	(Christian Couder's message of "Sat, 23 May 2015 18:04:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 23 May 2015 19:00:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4NH0iE6019188
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433005244.83875@zMm0VOMBy0iC9e1dfyndLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269808>

Christian Couder <christian.couder@gmail.com> writes:

>> struct ref_list {
>>         int count, alloc;
>>         struct ref_filter_item **items;
>>         const char **name_patterns;
>> };
>
> Matthieu, I think you forgot to remove "const char **name_patterns;"
> in the above struct, as you put it in the "ref_filter" struct below:

Yes, indeed. Too quick cut-and-paste.

> I agree that it might be clearer to separate both. In this case
> instead of "ref_list" the struct might be called "ref_filter_array" as
> we already have "argv_array" in argv-array.h and "sha1_array" in
> "sha1-array.h".

I'd drop the "filter" part and make it ref_array then. There's no reason
we could not use it it places other than filter.

But we also have string_list which is an array underneath, so I think
both names (_array and _list) are fine.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
