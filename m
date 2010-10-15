From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Thu, 14 Oct 2010 19:07:49 -0500
Message-ID: <20101015000749.GD29494@burratino>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
 <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
 <20101014200027.GA18813@burratino>
 <AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
 <20101014205413.GD28958@burratino>
 <AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 02:11:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6XtQ-0008M4-NX
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 02:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab0JOALQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 20:11:16 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42901 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab0JOALP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 20:11:15 -0400
Received: by yxm8 with SMTP id 8so103155yxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TRgnHN5Tcb6trAxAQj/3A74rKkH7/7dAmw91LWQCiqI=;
        b=GcVKBISEFPkIrjqPOEi7BK3G2uS1trlxbOTQ5swK6tkVyf4UGU+qd/PaHeBhdMj66j
         /tdJVINhydrEy7AGNJSJFOnY2YP3AyYyf/4bUG9EMw6J7t1IlGHH8j3Zy1z7LIVtTK8N
         aX8CCXas8/QslIdfexPaqmFIp01hTKq4jR+Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MP/8khKCEUUSOow7EyboK4fE4W70LR7dK8c56lVwBUqFhyWWvMq2QyhtRuog2XWzok
         eASL9xHec0fZH0WlAiFP63NBtTArPUQ6Stsw/iFcHHlpjn0RoKSk38oIIIwfHSUhrGPP
         umOcv4y5LPWBnqfO0dUkgmZdIJDaoA83ljshU=
Received: by 10.90.82.8 with SMTP id f8mr5338683agb.30.1287101474838;
        Thu, 14 Oct 2010 17:11:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id x21sm8741842yhc.35.2010.10.14.17.11.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 17:11:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159087>

Hi again,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> While that's not a perfect solution I think it's the best we're going
> to get for the time being. I'm pretty convinced that if I tried to
> make git itself LC_CTYPE-safe as part of this already huge series it'=
d
> never get merged. Having messages with question marks from strerror()
> on certain platforms is an OK compromise in my opinion.

The question marks[1] are what I was referring to.  Consider this from
the point of view of someone working on the Debian package: would
users consider that an appropriate or positive change for squeeze+1?
(Hint: not if it doesn't come with some benefit in their locale, no.)

I suspect making git work with other LC_CTYPE would not actually be
too hard[2].  Such fixes are useful for futureproofing and increased
sanity anyway --- they do not have to be part of the l10n branch imho.

[1] fatal: unable to stat 'foo.c': Op?ration non permise
[2] except that annoying printf bug.
