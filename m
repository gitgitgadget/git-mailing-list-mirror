From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: sporadic git failures on interactive rebase
Date: Wed, 14 Jan 2015 16:11:09 -0500
Message-ID: <CAPig+cT+bG=Pzws0WKpgnZX2mg4+VmAgxTBCwNiOGDmY4AzSKQ@mail.gmail.com>
References: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
	<20150114121915.GB30383@peff.net>
	<20150114123536.GA31530@peff.net>
	<xmqqvbk9b81d.fsf@gitster.dls.corp.google.com>
	<20150114205437.GB1155@peff.net>
	<CAPig+cQ9GpL9r6Rr96jc6G=EvCArodSXC-qMzSBp=e7c7QQbtA@mail.gmail.com>
	<20150114210222.GA5396@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Henning Moll <newsScott@gmx.de>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:11:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBVDf-0003gt-Tp
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbbANVLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:11:11 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:39151 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbbANVLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:11:10 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so5206757ykp.11
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 13:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CkoY516Pq42BzYHR/s/5wcUgNtslGKlSGLO6bNR3+eE=;
        b=wLMBzD1QV6MoF0FPqhff4/kB0GnumvET2OfZqc+rpJcFXAs1NbFQ9mEMERXrCspsqc
         msO8Q9fYmfMO+QmwFDebtr932k/YlFdoM0/gAcQs8mlqmjNoCswVKCrZ5E0xWzz7yC+T
         WhkYiX3LykpGDyN1w97Zsjx5/1FeTJwgNYO/oLpeNnPiJdMEFwtgwjb1unxrmbnd5R4b
         wA20+l2+X734OQASjf/D14GhRkKchCTdYQjYBbB3WcAvCcryVBh5CHH+EPy/JEtUJiKC
         S7PyaQCaXf2sSkgpu8sHN0/I1bICqj1gwmEo+YMSfDXJJ51LmJNEr80hk2jEtfr82C6u
         VJVA==
X-Received: by 10.236.105.210 with SMTP id k58mr3445085yhg.52.1421269869858;
 Wed, 14 Jan 2015 13:11:09 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 14 Jan 2015 13:11:09 -0800 (PST)
In-Reply-To: <20150114210222.GA5396@peff.net>
X-Google-Sender-Auth: RFHzTxrJgnCpF1NgPLq9NJ2xRFk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262431>

On Wed, Jan 14, 2015 at 4:02 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 14, 2015 at 04:00:37PM -0500, Eric Sunshine wrote:
>
>> > So yeah, the most plausible theory to me so far is unluckiness combined
>> > with pre-1.8.4.2. That should be easy to disprove if Henning tells us
>> > his git version.
>>
>> Henning mentioned it at the very top of his original problem report:
>>
>>     "(git version 2.2.0)"
>
> Ah, reading comprehension. It pays off.
>
> I'm stumped, then.

Perhaps some new code been added to git-rebase--interactive.sh since
75c69766 which neglects to invoke expand_todo_ids()?

Or, possibly some older version of git is being invoked somehow during
rebase despite his "front end" use of 2.2.0?
