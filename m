From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state stack machinery
Date: Thu, 20 Aug 2015 19:19:35 +0200
Message-ID: <vpqmvxlubbs.fsf@anie.imag.fr>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-4-git-send-email-Karthik.188@gmail.com>
	<vpqvbcb2uoi.fsf@anie.imag.fr>
	<CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com>
	<vpqa8tn2sgy.fsf@anie.imag.fr>
	<CAOLa=ZSzXyQZJksNqyroU6Td+LG7ZRTF_WNNryusAGZxTYTmDg@mail.gmail.com>
	<CAOLa=ZRBTrWa5EEOxa-Rf+J+8DWP7gSGGEYaG75EsR=A1DofRA@mail.gmail.com>
	<vpq7foq1kpe.fsf@anie.imag.fr>
	<xmqqvbc97vpn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 19:19:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSTVF-0006lU-CD
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 19:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbbHTRTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 13:19:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47674 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbbHTRTn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 13:19:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7KHJXg3018179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 20 Aug 2015 19:19:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7KHJZ4C007393;
	Thu, 20 Aug 2015 19:19:35 +0200
In-Reply-To: <xmqqvbc97vpn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 20 Aug 2015 09:47:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 20 Aug 2015 19:19:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7KHJXg3018179
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440695976.13367@Wt6hBGBxMt/NspYCCwibUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276254>

Junio C Hamano <gitster@pobox.com> writes:

> So I think 'quote' should apply only to the top-level atoms in the
> nested %(magic)...%(end) world.

This is true in most cases, but I think there would also be use-cases
where you would want the opposite, like:

--format '
    %(if:whatever)
    echo %(refname)
    %(end)
'

I'm not sure what's best, but if both can make sense, perhaps we should
just keep the simplest to implement, i.e. the current behavior.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
