From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Wed, 29 Jul 2015 23:30:28 +0200
Message-ID: <vpqtwsmd53f.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cTb3U2AHjr4wmQGezqHOED3zyYHPG54BjdCZObt=7Mu3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder\@gmail.com" <christian.couder@gmail.com>,
	"gitster\@pobox.com" <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 23:30:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKYvy-00008B-Nh
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 23:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbbG2Vai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 17:30:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59803 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbbG2Vah (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 17:30:37 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6TLUQZ6009865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 23:30:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TLUSDI024084;
	Wed, 29 Jul 2015 23:30:28 +0200
In-Reply-To: <CAPig+cTb3U2AHjr4wmQGezqHOED3zyYHPG54BjdCZObt=7Mu3w@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 29 Jul 2015 16:10:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 29 Jul 2015 23:30:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TLUQZ6009865
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438810229.58041@h5qwCNj3L3NmTH34qyIVPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274957>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Also, please explain here and in the commit message why this highly
> specialized colorizer ('colornext'), is needed even though a more
> general purpose one ('color') is already available.

It is needed in the current form to allow
%(colornext:blue)%(ifexists:[%s]) to color only the replacement of %s
and not the [].

But I now think that this would be more elegantly solved by Junio's
%(if) %(endif) idea:

  %(if:atom) [ %(color:blue)%(atom)%(color:reset) ] %(endif)

(I added spaces for clarity)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
