From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 20:12:10 +0200
Message-ID: <1496b663-6b6c-45a2-95d1-cbe634b0d160@email.android.com>
References: <5236FBEA.80909@gmx.de> <CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com> <vpqvc1z6eoo.fsf@anie.imag.fr> <CAP8UFD1u9hPFcbftpacDFdp27Jmp0YLGbpHPP12uEtjzEmnPQA@mail.gmail.com> <CACsJy8AEoUUat-1smJ1BmDuDBLseWf8oZ+EJyuadSLncb1UMSw@mail.gmail.com> <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 20:12:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLzlG-000191-MH
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 20:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393Ab3IQSM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 14:12:26 -0400
Received: from mail-bk0-f54.google.com ([209.85.214.54]:55190 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab3IQSMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 14:12:25 -0400
Received: by mail-bk0-f54.google.com with SMTP id mz12so2434391bkb.27
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=dvFOz8gdTImD1SlN3n1hN1wVnw73d+ykHuxKwlMTolY=;
        b=Lm+wQkLj2IoLvqQTp5hGQ7+BY3opAjoAEvie3SsSi51chJ6+KNyguQE4gn+1V1zv1D
         0qV798jzaVVudgLWuG/zh/OT4dwzoaEiWgGejYkkyFDYT9MxGU/PIi5Nc3+PEyzEPa1i
         GE7l3am2BpQsSsQy3RRT7WkYgx6o8q4ZvUAQaww61GrXsE969/BmSJKIpCqclVQ+35ee
         KZQj2Bc8AhAU4Wc+UG+2sq9Mv5JAzn4hqZSPTdjM8JuDK0FRs0cBSaZkpLG8eoADnRWa
         f6k69MNlZgpOmircfZD41Z2XYPTteRGU8Dr6Hp68S0J0M52EHRNku9lcfI+ssukFAprc
         iKeA==
X-Received: by 10.204.69.202 with SMTP id a10mr2030440bkj.36.1379441544561;
        Tue, 17 Sep 2013 11:12:24 -0700 (PDT)
Received: from [100.72.156.212] ([5.172.252.212])
        by mx.google.com with ESMTPSA id on10sm10879304bkb.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 11:12:24 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234899>

Junio C Hamano <gitster@pobox.com> napisa=C5=82:
>Yeah, it is easy to say that
>
>	git log -- A ':(exclude)A/B' A/B/C
>
>has two positive (A, A/B/C) and one negative (A/B), and then the
>most specific one A/B/C matches a path A/B/C/D and hence A/B/C/D is
>included.
>
>But to actually _design_ it, there are ambiguities that makes
>understanding and explaining the semantics, especially given
>pathspecs can have wildcards, icase matches, etc.  For example, is
>":(exclude,icase)A/B/?"  more specific than "A/?/C" or less?

 What about simply iterating over options in order in which they are sp=
ecified and the last option that matches specifies the result?=20

--=20
Piotr Krukowiecki=20
