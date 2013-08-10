From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Sat, 10 Aug 2013 17:15:07 +0200
Message-ID: <CALWbr2x6BH8oKSBt2xYWgEzrML2EqO=iEn4WTq7Lq=0U9C0C5A@mail.gmail.com>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	<CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
	<7v7gfu4ikb.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Ky2AkEt-XS_nAo=_RrPXSVAL=8cGiMuJabw0=BRU0Dw@mail.gmail.com>
	<7vmwoq304o.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Q2x9uz5Ajr=BgVjSjO88XD5UYzVSEqgMeK5_YAYSa5A@mail.gmail.com>
	<7vioze2kev.fsf@alter.siamese.dyndns.org>
	<CAMP44s3ULMBg6BJr6m4zkqHyD70rHSwLcuG5ph+ABr6KME8T=w@mail.gmail.com>
	<7v38qi2g63.fsf@alter.siamese.dyndns.org>
	<CAMP44s1NE-ac_tWej9EhMWJLRm7aq1WKOm17fZm5y_aA4ppq5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 17:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8At9-0007xW-5E
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 17:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770Ab3HJPPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 11:15:09 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:41217 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934153Ab3HJPPI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 11:15:08 -0400
Received: by mail-qc0-f175.google.com with SMTP id s11so2678636qcv.6
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PLTMbgpVnQsU2h8xPsEHYcZaCSyTJD2W8iy3gsUzqTs=;
        b=Ir99ziIV/EqE/ol7MBDuLeiwxyIa65UpnISuDrkXOz0X69/3729e42xXd0QejXneIx
         uFU6gc9yNufCDWSVrE1ktMgHtPvAo6qpONga2RhMCUZ/b8gkDtl634t80PvdoKJu/VcF
         TdJfEdPylcFc31CK3JacB2QTYMtOVftJZRWpBvGGADZBR6uyl+EZJsMMSyQ9Se9eWM7B
         qOkXKnzFC0hgc7rfQccOU1M2Amp0Fb7VwoEUhxrsz+3hkdCw5Osa7XfJ87JMSdgpszsp
         FeRD+LkrLIKuAdN1y1Wh+U8MqrZzXs/wqNS1+wBJUuCELM1VTGO4eycrx19BKLv26FkX
         Cd/A==
X-Received: by 10.224.76.71 with SMTP id b7mr16511626qak.48.1376147707129;
 Sat, 10 Aug 2013 08:15:07 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Sat, 10 Aug 2013 08:15:07 -0700 (PDT)
In-Reply-To: <CAMP44s1NE-ac_tWej9EhMWJLRm7aq1WKOm17fZm5y_aA4ppq5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232099>

On Sat, Aug 10, 2013 at 9:07 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Aug 10, 2013 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> If I clone ~/git, and then change my username, and move my home
>>> directory, doing a 'git fetch' in ~/git wouldn't work anymore, because
>>> we have expanded the path and fixed it to my old home, if instead we
>>> simply return without fixing, it would still work just fine.
>>
>> Antoine's patch runs expanduser() only to see if the given one gets
>> modified to absolute path, and makes fix_path() return without
>> calling the extra 'git config', so it is my understanding that the
>> above describes exactly what the patch does.  Am I reading the patch
>> incorrectly?
>
> Antoine's *second* patch, which I missed, does that, yeah. That should
> work fine.

OK Cool,
Thank you both,
