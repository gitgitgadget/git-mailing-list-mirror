From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] get_sha1: support ref^{/regex} syntax
Date: Wed, 15 Dec 2010 08:58:11 +0700
Message-ID: <AANLkTikgXAg9+0TXzpFH7LT1yD2sV5Dp=025GbudnY5S@mail.gmail.com>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 <1292209275-17451-3-git-send-email-pclouds@gmail.com> <7vaak7rh9k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 02:58:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSgdm-0007yX-Q8
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 02:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab0LOB6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 20:58:43 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52176 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab0LOB6m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 20:58:42 -0500
Received: by wwa36 with SMTP id 36so1139895wwa.1
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 17:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=m2RIyE2xmPl2GHddcmBuT/LTvk22kFSyv7SVxKO+Rag=;
        b=k8NQImYRKHJS/DW9PR+ixY5NsQipTYiKQvD1YfWOdW0T6mdzqGbvHRFSVMYDpvkxMw
         QAqFNKTuqEXj4e+xPMnujfLsbIoA8po83+ZFBD2aTukGNTMXwyVpvUAiYwxwCCgy8ZnU
         udBzs49CIQbsCLSVMloGSSpPr2lPT9h9LXvVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fui6Ypv66rG1APQtxQHYKGElwjv3PHTOvxzywbXkISK+9J5ype6PEikAxJUGo9Rv/9
         CgaA9RONMaj96Yxt7ve8uaHQJ1Vhi6F/NstucACtfnh3n+SN61HC3me1vYwoeQNGzDG1
         7p+RPqd8nnBs+qVPQMO+YLu4fAZd1FghG0MvI=
Received: by 10.216.142.101 with SMTP id h79mr2786937wej.49.1292378321424;
 Tue, 14 Dec 2010 17:58:41 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 14 Dec 2010 17:58:11 -0800 (PST)
In-Reply-To: <7vaak7rh9k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163728>

2010/12/15 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> +test_expect_success 'ref^{/}' '
>> + =C2=A0 =C2=A0 git rev-parse master >expected &&
>> + =C2=A0 =C2=A0 git rev-parse master^{/} >actual &&
>> + =C2=A0 =C2=A0 test_cmp expected actual
>> +'
>
> This test fails on FBSD 8, which refuses to regcomp("")
> saying "empty (sub)expression", which is somewhat bogus.
>
> I'd change it to "/." for now ;-).

Perhaps we should just reject this case. No sane body would ever use it=
=2E
--=20
Duy
