From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Mon, 27 Jul 2015 20:47:32 +0200
Message-ID: <vpqwpxl30aj.fsf@anie.imag.fr>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
	<vpq3809aho9.fsf@anie.imag.fr>
	<xmqqr3ntioyh.fsf@gitster.dls.corp.google.com>
	<vpqk2tl4mvx.fsf@anie.imag.fr>
	<CAOLa=ZRVMnqxb-E29f_53igzJDTWNU0yjVACSq1CK8TCbaM-9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:47:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJnRI-0000ID-D2
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 20:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbbG0Srs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 14:47:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59152 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbbG0Srr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 14:47:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RIlUFT013130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 20:47:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RIlWtK017763;
	Mon, 27 Jul 2015 20:47:32 +0200
In-Reply-To: <CAOLa=ZRVMnqxb-E29f_53igzJDTWNU0yjVACSq1CK8TCbaM-9w@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 28 Jul 2015 00:12:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 27 Jul 2015 20:47:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6RIlUFT013130
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438627654.91467@VyAuAbbTkO3M4cXDjz1wXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274697>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Jul 27, 2015 at 9:24 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Yes, but on the other hand we already have:
>>
>>   git log --format='%<|(50)A very long irrevlevancy|%an|'
>>
>> that pads/truncate %an. So, consistancy would dictate that Karthik's
>> version is the right one.
>
> Sorry but I didn't understand what you're trying to say here, Matthieu.

The "git log" equivalent of %(padright:N) is %<|(N), and it behaves the
same way as your current implementation of %(padright) (except for the
missing reset in your v5).

So, if we want to be consistant with "git log", we should keep the
"apply to next atom, even if it's far away in the format string"
semantics.

Note that consistancy is not the only criterion for choice, so I'm not
saying we should absolutely do this, just that there's an argument in
favor of it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
