From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Tue, 02 Jun 2015 10:17:26 -0700
Message-ID: <xmqqfv6a3u8p.fsf@gitster.dls.corp.google.com>
References: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<vpq7frmy5nl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stephen Kelly <steveire@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 19:17:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzpoj-0002h2-ND
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759743AbbFBRRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 13:17:30 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34909 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759324AbbFBRR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 13:17:28 -0400
Received: by iesa3 with SMTP id a3so138261530ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=0KfTZMiAE1/K3n/UhLibt5kXkuCyqCRJgtT3NVZhNp4=;
        b=Aahx3x20TutHRniTLGAq1QEiVunsFeo64pKbVEZ4BoMAxJVoNjfJH+LEtX5rAmSkfp
         JYpsaxW6SP70VmfB+TPYwjVedrZrfVA98ZDuHQhcfBE3XojhU0bnRNraUA/6C0Pf9Ibj
         9CekLLfUhCCWZIN3RC05TSMnosN7BZzcv20BAzONBa53J4ROfzuM3b0/+2XEH3a7on1y
         HfbKlxIptfRTqIk6lRtmHOZPD5pyeFawNm/lP+A52IOxQo2CnsPL1SNAdKu8/Aols42P
         Z4icbvlaxcrDFa4/RqMPE5m5fWMhQiI+n1/aJJ1PNSojr8WCakSlmRb6eB+N4wpXqd/a
         WXgw==
X-Received: by 10.107.168.164 with SMTP id e36mr34203545ioj.87.1433265448017;
        Tue, 02 Jun 2015 10:17:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id rr5sm10348698igb.7.2015.06.02.10.17.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 10:17:27 -0700 (PDT)
In-Reply-To: <vpq7frmy5nl.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	02 Jun 2015 08:40:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270565>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>
>> Check if commits were removed (i.e. a line was deleted) and print
>> warnings or abort git rebase according to the value of the
>> configuration variable rebase.checkLevel.
>
> checkLevel does not seem to be a good name, because it doesn't say
> _what_ is checked. I don't have really good proposal in mind, but may=
be
>
> rebase.todoListCheckLevel
> rebase.missinLinesCheckLevel

Yeah, with s/sin/sing/, but the above makes more sense.  It may be
that we probably do not even need "Level" there in the name.
