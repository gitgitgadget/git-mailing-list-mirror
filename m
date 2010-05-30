From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] Add API for string-specific memory pool
Date: Sun, 30 May 2010 05:09:30 -0500
Message-ID: <20100530100929.GB6242@progeny.tock>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-6-git-send-email-artagnon@gmail.com>
 <20100529113800.GA7925@progeny.tock>
 <AANLkTil6dK82ydjjBqKlHEuDMHbgOlVAUXNQZGHZzCYM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 12:09:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIfS7-0005pY-SO
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 12:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab0E3KIy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 06:08:54 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32891 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab0E3KIx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 06:08:53 -0400
Received: by gwaa12 with SMTP id a12so2034306gwa.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NF1qyM8dDrgYUY2iXWAKSKbKT20+me3rZq69k5qjvrQ=;
        b=MKns/MjV79WX7nn2/DyZaguru1vUPhasCv64pD6Q6vyxtdCgwc9Qi1a1lmTEs7W7PT
         ZavO5+JY9IvTr+mOEZALoainzYzMt7CdXbozAJ5mZoR9PCLsjMANyNzo3+SRVCJhiUXD
         98ODUSMNrgTyGSo86hX+12MHm6CWVLV9Od03g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=V4t5l/rO4by/ykwO6SFFLjjwook02c6vFpQn5P6QfQpTLcJ2HKD6DYQpIlZXh+nV+9
         pm/hSPz/o054IElaIHIAMPeKeW6Ue3S0AxMKab56xwd5Ey6Am//VY++Zh/mmuwTEu1vC
         46Onqttk06xhjDgTB+4slUoMwYtpR7V7PLMiA=
Received: by 10.231.186.161 with SMTP id cs33mr3741340ibb.65.1275214132843;
        Sun, 30 May 2010 03:08:52 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm20469923ibf.7.2010.05.30.03.08.51
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 03:08:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTil6dK82ydjjBqKlHEuDMHbgOlVAUXNQZGHZzCYM@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147997>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> style nitpick: should use space instead of tab
>=20
> Quick doubt: Does running whitespace-cleanup (Emacs) on all the files
> before generating patches suffice?

No idea.  Documentation/CodingStyle in linux-2.6 has some emacs tips.

>> some platforms git supports still don=E2=80=99t have stdint.h iirc.
>
> Oh. What do we do about stdint.h then?

Luckily, the systems without stdint.h have inttypes.h (and vice
versa[1]), so git-compat-util.h takes care of it.

Jonathan

[1] inttypes.h is the older standard, and almost all systems support
it, but Interix has stdint.h but not inttypes.h.  So it goes.
