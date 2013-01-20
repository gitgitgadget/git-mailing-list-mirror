From: Eric James Michael Ritz <lobbyjones@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Sun, 20 Jan 2013 14:21:53 -0500
Message-ID: <50FC43D1.6080701@gmail.com>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin> <vpq622s9jk1.fsf@grenoble-inp.fr> <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx0TH-0002vq-EV
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 20:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445Ab3ATTWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2013 14:22:00 -0500
Received: from mail-gh0-f173.google.com ([209.85.160.173]:58606 "EHLO
	mail-gh0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab3ATTV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 14:21:59 -0500
X-Greylist: delayed 76856 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Jan 2013 14:21:59 EST
Received: by mail-gh0-f173.google.com with SMTP id g2so831228ghb.4
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 11:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MCWsiAjh0KAN0rLNUj0kTL1txeBi1CB8u++jpmzBExM=;
        b=iaR+KX/lPiVuPk2Dlsc98EoAQh2wasNzj4fBgmNoIg+r/Dc0PlzfjNVbWvzYTF4e0C
         8Txyo+NYyMf9YuYRyxFvgP/pCdMlAXspM97QoEB3xKQsY3MRLd0Gu+hFjft60fj120QM
         MZmpCvuNKz2U0HDTlDItur9hYpTH4sUSl7fE4Py3bJEC8U/gkbtkczoFpM2PGrL13SQ1
         UiDOUd/poXiQAs/BGwaq81Fd0rNiCef2FJsaD5cQNNNzhWV13RLw2+3j2Z7REl3ifh9N
         3YxJqiNsZRVc8TNkDr9MJEPzb5wf4Bd3EnzhM425/l7BKhP5RppwfqNjQ9hJ3RK7lTUU
         dKmQ==
X-Received: by 10.236.135.140 with SMTP id u12mr17638006yhi.123.1358709718827;
        Sun, 20 Jan 2013 11:21:58 -0800 (PST)
Received: from [192.168.1.102] (97-81-212-183.dhcp.hckr.nc.charter.com. [97.81.212.183])
        by mx.google.com with ESMTPS id x41sm11058178yhg.9.2013.01.20.11.21.55
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 11:21:57 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214037>

On 01/20/2013 01:53 PM, Junio C Hamano wrote:
 > Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
 >
 >> Implementing "git rm -u" as a tree-wide command would create a
 >> discrepancy with "git add -u". Implementing it as a "current
 >> directory" command would make the migration harder if we eventually
 >> try to change "git add -u". Perhaps "git rm -u" should be forbidden
 >> from a subdirectory (with an error message pointing to "git rm -u
 >> :/" and "git rm -u ."), waiting for a possible "git add -u" change.
 >
 > Yeah, that sounds sensible.  Start with a "'git rm -u' is forbidden
 > without arguments", give advise to use either "." or ":/".  And stop
 > there.

I was unaware of any plan to change `git add -u`, but the above makes
sense to me.  I will use those suggestions as guidelines for the
initial implementation of `git rm -u`.  In particular, it will require
an argument like `.` or `:/`.  It sounds like the future direction of
`git add -u` will play a role in how `git rm -u` should behave so that
there is consistency between the two, so I will try to take a
conservative approach in my implementation.  Thank you both for the
advice and insight.

--
ejmr
=E5=8D=97=E7=84=A1=E5=A6=99=E6=B3=95=E8=93=AE=E8=8F=AF=E7=B6=93
