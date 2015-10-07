From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 8/9] branch: use ref-filter printing APIs
Date: Wed, 07 Oct 2015 19:58:03 +0200
Message-ID: <vpqmvvu4l3o.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-9-git-send-email-Karthik.188@gmail.com>
	<vpqvbao86pj.fsf@grenoble-inp.fr>
	<CAOLa=ZSk8-6nkfEd+Kz1srOJxPLj6+zLEU9DnLgW3rW1O6kZGg@mail.gmail.com>
	<vpq7fn1qhp2.fsf@grenoble-inp.fr>
	<CAOLa=ZS5x=ksfnBt1kLp5bJJHmqeBztR7Zn7U5VKZN-56T-_5A@mail.gmail.com>
	<vpqmvvvhl9m.fsf@grenoble-inp.fr>
	<CAOLa=ZS4xVfsQ+F+KGD8Gz9NHzvJtuVvW16RSLV08ZiEv8DhKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 19:58:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjsyw-0007iQ-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 19:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbbJGR6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 13:58:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39532 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755321AbbJGR6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 13:58:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t97Hw1M6015468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 7 Oct 2015 19:58:01 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t97Hw3kk018637;
	Wed, 7 Oct 2015 19:58:03 +0200
In-Reply-To: <CAOLa=ZS4xVfsQ+F+KGD8Gz9NHzvJtuVvW16RSLV08ZiEv8DhKw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 7 Oct 2015 22:17:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 07 Oct 2015 19:58:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t97Hw1M6015468
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444845483.26045@B9Ls/55Gk40st4q5C7CP5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279190>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Oct 7, 2015 at 12:33 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> To go a bit further, you can pre-build a string or strbuf aligned_short
>> with value like "%%(align:20,left)%%(refname:short)%%(end)" and use it
>> where needed (it's not a constant because you have to introduce maxwidth
>> into the string, so it's not a candidate for #define).
>>
>
> Again, the remote has a remote prefix here, so we can't really factor
> it out much.

Ah, OK, there's a %s containing the remote prefix in "remote" that is
not there in "local", and in the last version you sent it's already
factored for verbose > 1 and verbose == 1. Indeed, there's nothing more
to gain here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
