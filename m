From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Thu, 26 Aug 2010 13:52:05 +1000
Message-ID: <AANLkTi=3tGf=Gw6SnRLOSaURw7JX=qEPtLCzLhZN1D+y@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
	<AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
	<AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
	<AANLkTi=02T+60AjJON8MFt7DSbtA=bx39YKigZHq_b_u@mail.gmail.com>
	<AANLkTinQYfpWYJ8Lr3=VX+x2Xj+eQfYztT1GHh2AQKff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 05:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoTVi-0000LF-9d
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 05:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab0HZDwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 23:52:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39469 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0HZDwH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 23:52:07 -0400
Received: by wwb28 with SMTP id 28so921627wwb.1
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 20:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=05O/3hqW5w9lQzVa32KjLC+vShQ0d7HIHuQNxLmM4oY=;
        b=D+Ykf9ccrO4mcfA96ZZxXbQbikhJP0bCfc6GukvULMmBNRdqwRFDkd/5Ofn10FTytB
         Grl9gEnDGaHIkeklOk//2c5lyI/9u6C4vUv+Jc0cqqyAkCpqAUgfmw/7q7k9QdO1+U8+
         qd5KAm/9DgRNLPq8Hm9+oFL0yrQFaFpiPojII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hbMbqf3ZfoRX1rkyfzoaiS9tN3FGN5OYHFt3tCjtMncoZMuOiV9+EOrJ/P+j+3OGf0
         2j3fpNJiFlDqibkzgMXCRRZyTNA9VMsfSsUX2Rwha8nneyW2d8Hcz5xViy0j9fNDgGqK
         Nq+LC9ecPRioyQUgTku2UqsaxScpsw9EX9ZGo=
Received: by 10.216.159.195 with SMTP id s45mr8256749wek.43.1282794725293;
 Wed, 25 Aug 2010 20:52:05 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 25 Aug 2010 20:52:05 -0700 (PDT)
In-Reply-To: <AANLkTinQYfpWYJ8Lr3=VX+x2Xj+eQfYztT1GHh2AQKff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154505>

On Thu, Aug 26, 2010 at 12:50 PM, Elijah Newren <newren@gmail.com> wrot=
e:
>> The second point (probably not needed if the above assumption is no
>> longer true, but I post anyway in case I forget it again). Without
>> whole trees, it's impossible to determine a trivial merge reliably. =
If
>> "you" adds a file and "upstream" adds another file, predecessor tree=
s
>> will look different but merging them is trivial (at file level). If =
we
>> miss some trees that lead to those new files, the best thing we can =
do
>> is to claim it non-trivial.
>
> I'm not following this one. =C2=A0Could you provide more detail?
>

Let's say in "ancestor" tree, we have

t1/f0
t2/t3/f0

In "you" tree, we have

t1/f0
t2/t3/f0
t2/t3/f1

In "upstream" tree, we have

t1/f0
t2/t3/f0
t2/t3/f2

The narrow tree is t1, so we the trees we have are toplevel tree and
t1. If we have all trees, that should be a trivial merge, which
results in f0, f1 and f2 inside t2/t3. But we don't have t2 and t3
trees in narrow repo. When we traverse toplevel tree of "ancestor",
"you" and "upstream", we can only see that t2 sha-1 is different. If
"t2" is a file, not a tree, then we can conclude non-trivial here. And
because we don't have t2, we can't descend to make better conclusion.
--=20
Duy
