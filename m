From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 10/10] revert: report fine-grained error messages from
 insn parser
Date: Fri, 16 Dec 2011 04:48:35 +0530
Message-ID: <CALkWK0k6Vf51nk3jLs3z1LvzRnCb46obVDZh8h5byzTzCBctJw@mail.gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com> <1323881677-11117-11-git-send-email-artagnon@gmail.com>
 <7vsjklmsvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 00:24:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbKfU-0005Uy-0L
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 00:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759654Ab1LOXYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Dec 2011 18:24:47 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32979 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759633Ab1LOXYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2011 18:24:46 -0500
Received: by wgbdr13 with SMTP id dr13so4897035wgb.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 15:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XExrC5qU0Cu7Xeooyb/wCzz+syY4eD3m9ux/3HLN/tc=;
        b=M3cpoD0XUrzNicI3um4iB2/1o53Z3Y8jjxiC1XSIfp9sCuZHgWO6QPRWdc4Euh9T6m
         agm0Y0B/SykqwcTCZfevHY9vOg7Fo5Xm85iHGksgsr6TblBVQInV/wrhkbhxPrVSH07/
         Lo6wc9il2NG13vmfIWqMp6YeLsHIUncUCNAJA=
Received: by 10.180.88.66 with SMTP id be2mr8678769wib.54.1323991136237; Thu,
 15 Dec 2011 15:18:56 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Thu, 15 Dec 2011 15:18:35 -0800 (PST)
In-Reply-To: <7vsjklmsvt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187256>

Hi Junio,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Three kinds of errors can arise from parsing '.git/sequencer/todo':
>> 1. Unrecognized action
>> 2. Missing space after valid action prefix
>
> I think these two are the same and shouldn't result in different erro=
r
> messages, i.e. the first one in this sequence is still an "Unrecogniz=
ed
> action" error and does not have anything to do with "pick" action.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pickle rr/cherry-pick~4
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick rr/cherry-pick~3

Good point.  I'll change the parser to check for "pick " || "pick\t"
and "revert " || "revert\t" explicitly in the re-roll.

Thanks.

-- Ram
