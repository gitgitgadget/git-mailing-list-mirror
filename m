From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc --auto: warn garbage collection happens soon
Date: Thu, 29 Dec 2011 05:09:26 +0700
Message-ID: <CACsJy8BSewZuk-aoorqXRtD=nhPV=TY8YgjFj9uGMivv_GTQSA@mail.gmail.com>
References: <1324993534-16307-1-git-send-email-pclouds@gmail.com>
 <7vpqf94r8c.fsf@alter.siamese.dyndns.org> <20111228184000.GA18780@sigill.intra.peff.net>
 <7vfwg41n3p.fsf@alter.siamese.dyndns.org> <20111228213018.GA22811@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 28 23:10:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg1hi-0003tv-2a
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 23:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab1L1WJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Dec 2011 17:09:59 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51289 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab1L1WJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2011 17:09:58 -0500
Received: by eaad14 with SMTP id d14so5615446eaa.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 14:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pFJjpM2eYmwl/paDC29aqKD0C3NuNLZ3139VFnksuD4=;
        b=b8ILnV5/M3Fe0pfcqzAQ3NIZvo5UUZKoV6rNN39SX5WFJmI0rENRyXj5Y+L5kvHDtt
         8lYa1fP18+25bZlCCUbOHYjRzCrcdDwcepnj47dqP8kFovGOLZNm1HTwGk5GYblcc0CR
         ZKAxdYYjVWwf9JuNbqz7zljMeyD+zP9iibRVg=
Received: by 10.204.48.148 with SMTP id r20mr3640944bkf.116.1325110197220;
 Wed, 28 Dec 2011 14:09:57 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Wed, 28 Dec 2011 14:09:26 -0800 (PST)
In-Reply-To: <20111228213018.GA22811@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187763>

2011/12/29 Jeff King <peff@peff.net>:
> Especially now that prune has learned about progress reporting, it's
> easy to see in "git gc" that the "Counting objects" phase of the repa=
ck
> and the connectivity search in prune are counting the same objects. =C2=
=A0It
> would obviously be easy to just dump the set of sha1s in packed binar=
y
> format, and let git-prune reference that.
>
> But it doesn't work in the general case. Running "git gc" will repack
> everything, and so it looks at all reachable objects. But "git gc
> --auto" will typically do an incremental pack (unless you have too ma=
ny
> packs), which means its counting objects phase only looks at part of
> the graph. =C2=A0So that result can't be used for object reachability=
, since
> many objects won't be marked[1].

Hmm.. I was thinking of sharing this "counting objects" part when
repack is rewritten in C. I guess I can drop the idea now.
--=20
Duy
