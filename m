From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 20:25:08 +1000
Message-ID: <CACsJy8Dxj72U+wiu6MUV3sQYso948Gi6DhTLSO7=ddt6BxdBYQ@mail.gmail.com>
References: <4DF6A8B6.9030301@op5.se> <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
 <201109261539.33437.mfick@codeaurora.org> <201109261552.04946.mfick@codeaurora.org>
 <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk> <CAGdFq_hvR1MPF33YFcjDCzCM0iOO2zpiiePFFS4dBabu84cwTg@mail.gmail.com>
 <22f055b34840e3c64f3339f7b3dc6920@quantumfyre.co.uk> <CAGdFq_j2aa8bwxWuJvEsgA_1zkR4mMzoKjGs9TQVqw+0XYr98A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <davidbarr@google.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 12:26:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8UrP-0007Ko-G3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 12:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab1I0KZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 06:25:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37518 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab1I0KZk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 06:25:40 -0400
Received: by bkbzt4 with SMTP id zt4so6746546bkb.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Mjz8dDqrEq0ntyx4vIUOjJj3ZN+9Au7pJnSV6qUtRDk=;
        b=X515/mmCK5Uq2fiaF3SvX05qb53lRHwfFerw2NUsHNsNvyxHQnke5s/gKekRm4ItWn
         B9TMfsZkxGaHp94X1IolcsawVSWkWZ9orrYC2uZffLo7MarjN9Soxqc0/Ymz1909DimY
         bO/eaX9CQfRFteScigy72WVevtzHX3VIKZEGk=
Received: by 10.204.145.25 with SMTP id b25mr2021128bkv.27.1317119139136; Tue,
 27 Sep 2011 03:25:39 -0700 (PDT)
Received: by 10.205.114.134 with HTTP; Tue, 27 Sep 2011 03:25:08 -0700 (PDT)
In-Reply-To: <CAGdFq_j2aa8bwxWuJvEsgA_1zkR4mMzoKjGs9TQVqw+0XYr98A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182233>

On Tue, Sep 27, 2011 at 8:01 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
> On Tue, Sep 27, 2011 at 11:01, Julian Phillips <julian@quantumfyre.co=
=2Euk> wrote:
>> It has to be hot-cache, otherwise time taken to read the refs from d=
isk will
>> mean that it is always slow. =C2=A0On my Mac it seems to _always_ be=
 slow reading
>> the refs from disk, so even the "fast" case still takes ~17m.
>
> Ah, that seems unfortunate. Not sure how to test it then.

If you care about performance, a perf test suite could be made,
perhaps as a separate project. The output would be charts or
spreadsheets, that interesting parties can look at and point out
regressions. We may start with a set of common used operations.
--=20
Duy
