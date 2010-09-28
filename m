From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/6] tree_entry_interesting(): remove dependency on struct diff_options
Date: Wed, 29 Sep 2010 08:00:46 +1000
Message-ID: <AANLkTikso2O5M_ZBr1pvr8jqg=h7jhd+U+fBGossdU0W@mail.gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
	<1284938514-16663-6-git-send-email-pclouds@gmail.com>
	<7vtylavnfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:01:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0iEv-0001MI-D4
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0I1WBQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 18:01:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63828 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887Ab0I1WBP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 18:01:15 -0400
Received: by wwd20 with SMTP id 20so23873wwd.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YErBJkuTCahay6Rzugo8yTk+4hxhFMe0b6FXfAUU05c=;
        b=SiWVf1bjAG9reamYTdidPz6s7m39luLF2ijb+26DWbAZJRf/acJf5cib/AEF1cuI2E
         l43hShSsHRgBLTKmy0bL6OAV8ld8cSNhl/bZHapU4OCCfIDMEyADYcexD/SAa4IE8Zdu
         mVskKXdwk5/IJZuytAoSq9LzmUPHgo66GYmhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k37DBFFA2oj6nPK77XKqw0UC7lm7glnBjCergCZoJwCqCORI8c4RqOeH2la2Z1ozEu
         Y9jxY0qsFBidr46//LtkdZ/62iZNt45mjqENyQuBbzt+w8bQuXhw4vEi1AWWe4R3zL2h
         kxvro5wXrPvxsJXeWJYYWUoR3FKmApLk4GsPI=
Received: by 10.216.30.21 with SMTP id j21mr1681454wea.37.1285711247132; Tue,
 28 Sep 2010 15:00:47 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Tue, 28 Sep 2010 15:00:46 -0700 (PDT)
In-Reply-To: <7vtylavnfx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157482>

On Tue, Sep 28, 2010 at 8:20 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> This function can be potentially used in more places than just
>> tree-diff.c. "struct diff_options" does not make much sense outside
>> diff_tree_sha1().
>
> This does a bit more than that; it does not call tree_entry_extract()
> anymore, and instead uses the knowledge of its underlying implementat=
ion.
> The mode of the entry that is passed to S_ISDIR() check is not cleans=
ed
> with canon_mode() anymore.

Hmm.. missed that. Thanks for catching.
--=20
Duy
