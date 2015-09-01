From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Tue, 01 Sep 2015 15:11:42 +0200
Message-ID: <vpqk2sa1dyp.fsf@anie.imag.fr>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
	<CAOLa=ZTHtps2gJb9asSzG_4NOwx_xiA7OuCzjW=BTTFfkaYoQg@mail.gmail.com>
	<CAPig+cQF=1FPFP_7Bn2m2J+ay5ZupG25USWc9LT9SqO1=VDZvg@mail.gmail.com>
	<CAOLa=ZS53BNNvnYv2TU6xQbEihi1GiKBaEEZ=KT6p_gDBR9Y9Q@mail.gmail.com>
	<CAPig+cRAYeF0ZDn5FsHioZr1g4pH3Ay69_3KDb8ZF1USZxzcEg@mail.gmail.com>
	<vpqpp235pvg.fsf@anie.imag.fr>
	<CAPig+cRig+zk=D1SDF7wBHuQgcQqb-4cHkmeVgLs5BaWzk9WRg@mail.gmail.com>
	<CAOLa=ZQV63ZETPswEPYjSMrXcZAK+W-Jek+Psq7wtmSsQHtb3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 15:12:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWlMA-0001Lm-HU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 15:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbbIANMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 09:12:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56231 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792AbbIANME (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 09:12:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t81DBe0m002424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 1 Sep 2015 15:11:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t81DBgd5006147;
	Tue, 1 Sep 2015 15:11:42 +0200
In-Reply-To: <CAOLa=ZQV63ZETPswEPYjSMrXcZAK+W-Jek+Psq7wtmSsQHtb3g@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2015 18:35:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Sep 2015 15:11:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t81DBe0m002424
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441717904.84032@2kcp7GyGC1B7mh1rfNX1Sg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276978>

Karthik Nayak <karthik.188@gmail.com> writes:

> Like this:
>
>  else if (skip_prefix(name, "align", &valp)) {
>             struct align *align = &v->u.align;
>             struct strbuf **s;
>
>             if (valp[0] != ':')
>                 die(_("format: usage %%(align:<width>,<position>)"));
>             else
>                 valp++;
>             ......
>             ........
> }

Checking the string's correctness as you read it seems good to me, yes.

But as you say, you should make this a bit more generic, for example by
putting your "if/else" in a helper function, that other atoms could use.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
