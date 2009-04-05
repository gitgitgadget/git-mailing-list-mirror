From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 22:30:51 +0300
Message-ID: <94a0d4530904051230x7feae9a9o6a9b81e8673d4fa1@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
	 <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
	 <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com>
	 <87vdpi29a4.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:34:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqY4w-00052p-M5
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbZDETa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 15:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756666AbZDETaz
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:30:55 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49575 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665AbZDETay convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 15:30:54 -0400
Received: by fxm2 with SMTP id 2so1614552fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P8uvnJAAKI5uvvnnH9/Q28/aUhtiNxxrjXP1ouRBAeo=;
        b=Ej62t6GG6KlFLLyVcAcNq/NC5uJ2iJw0yTnCC+AGg5GYysPDaaACeoPRzAJkbSA0ef
         sPTd/RmbgansSREWHMCT5x1/qr+TUumLpf6s8fpmcP/bL48yJDOT6l70cbvjD51YGXRt
         dNDMV1S9FTLzgRqk7bUtQt5yYBHzER+Zeby3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BtssStzjd4cJNocWT/OwINSZhRvenGVJ/zS7N/MriTYNvgnoxo9pu5dfQW7PN1mv9A
         0Bs5wWNFtxIf6cnctslF8Lp8su8h9ZOvaMxrnBFLmH7pYcLjRlIQe5I0NbEp0w4uSVAD
         y2mjwyESQloqOQ+58+LeK64WC/pDKheWFkWQE=
Received: by 10.86.61.13 with SMTP id j13mr2476184fga.68.1238959851950; Sun, 
	05 Apr 2009 12:30:51 -0700 (PDT)
In-Reply-To: <87vdpi29a4.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115687>

On Sun, Apr 5, 2009 at 10:24 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
> On 2009-04-05 22:19 (+0300), Felipe Contreras wrote:
>
>> On Sun, Apr 5, 2009 at 9:59 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> U3ZlcnJlIFJhYmJlbGllciA8c3JhYmJlbGllckBnbWFpbC5jb20+IHdyaXRlczoNCg0=
KPiBPbiBT
> [...]
>> Huh?
>
> Base64 transfer encoding:
>
> =C2=A0 =C2=A0Content-Type: text/plain; charset=3Dutf-8
> =C2=A0 =C2=A0Content-Transfer-Encoding: base64

Yeah, I know, but apparently Gmail doesn't support it.

--=20
=46elipe Contreras
