From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 02/16] list-objects: limit traversing within the given 
	subtree if core.subtree is set
Date: Mon, 2 Aug 2010 09:11:33 +1000
Message-ID: <AANLkTimSY4kv_i0HnBMCAwODkeFO3sV0tdxopcQwOfK8@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<1280593105-22015-3-git-send-email-pclouds@gmail.com>
	<AANLkTinXhfSzVtcjHVzpdV_GUK+mbpVEezGY2aDXRk1-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 01:11:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofhgy-0006gP-Ms
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 01:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882Ab0HAXLf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 19:11:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61324 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab0HAXLe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Aug 2010 19:11:34 -0400
Received: by wwj40 with SMTP id 40so3281775wwj.1
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 16:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LtqcML0d5b3/Bs7G5PAzPFVXKsCpNeK0LPiLh9Jr3Jw=;
        b=kdr8Y4r3SJ07Ibv9k2atoO/34CuyoGfZEd8/F1iETdo6sK2Fl1dTs+R40CDD3W3SKX
         K+gcCWUwODlSe6JBgoQsnouFmMbIQFGfD1JIKFNw8Ykg+PCIM9S2pT2MBZebFu7MaTh+
         9wDv8PDkxXVlzzaR26ReuE7bu3eg1ehVlWFiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pcafXHTkT0jRwt307bjmdmxciVlg7EKM+XlaSnlCckiX1zkkTZlCdpxF3RASTnjUYi
         qcOoGG5bftERal3I+9eGAzQQLonPSGOfumsbpsYEdn0z07Fi9M9t0dF4jN4lzXMHlHAZ
         lG/44tCJYWLnsFoxWyqbjuHAK3FvqIHakstbI=
Received: by 10.216.30.207 with SMTP id k57mr4179000wea.88.1280704293351; Sun, 
	01 Aug 2010 16:11:33 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Sun, 1 Aug 2010 16:11:33 -0700 (PDT)
In-Reply-To: <AANLkTinXhfSzVtcjHVzpdV_GUK+mbpVEezGY2aDXRk1-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152385>

2010/8/1 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
>> + =C2=A0 =C2=A0 =C2=A0 int subtree_len;
>
> Shouldn't that be size_t? strlen returns size_t, and strncmp expects
> size_t, not int.
>

Hmm.. yeah. The compiler didn't warn me. Anyway subtree_len should be
small enough (i.e. < PATH_MAX) that type does not really matters.
--=20
Duy
