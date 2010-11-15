From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 002/160] Makefile: Set NO_GETTEXT=YesPlease on Windows & MinGW
Date: Mon, 15 Nov 2010 11:35:15 +0100
Message-ID: <AANLkTin2sMUBtS_WgVX39ngRGrWRLf=Z_+UhGNorP6VH@mail.gmail.com>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com> <1289747245-23263-2-git-send-email-avarab@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 11:35:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwPj-0008Iw-Oe
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab0KOKfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:35:39 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62423 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568Ab0KOKfh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 05:35:37 -0500
Received: by fxm6 with SMTP id 6so1607757fxm.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=CCP4bpoEgWPymqYK4R3Ctb+DTUqG2x0C/h0WX/G/Hfo=;
        b=wRzju80B/lzTR8azHKsv14qDUxwrry9GrVrka/k8EruLtEkyZzXUgjU14rRMVkzlDm
         VUI7ccXeC1qywODyEEivfmu1dR6WxnxDOZpL2GNRyTtRTzYecBvK1+/8DjFnDe3VcDxq
         YDkaJxE4FArsre20izCus2qHA4AC/bqlVqE5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=vB+zL9QNht5kjgq++VFpC6r1BdSUluZzEnoHKqrXJl0pn1mwC04lMooE7nJEvzQiBi
         SrDS35ylE7yzE32NnYG8vZD0AE0Btz31zpYQbeZI49MRxK3JuxFJ630oOdfX++AVO3m1
         QkoZ/OENHWjMxSkkxLZKJTfgXW7Z6o1fY/i+c=
Received: by 10.223.100.4 with SMTP id w4mr4520254fan.26.1289817335746; Mon,
 15 Nov 2010 02:35:35 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Mon, 15 Nov 2010 02:35:15 -0800 (PST)
In-Reply-To: <1289747245-23263-2-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161476>

(msysgit mailing list CC'ed)

On Sun, Nov 14, 2010 at 4:07 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> Change the Windows and MinGW build defaults to not build the gettext
> tools by default. Gettext hasn't yet been ported to the default
> environments on those systems, although Erik Faye-Lund is working on
> MinGW support.
>
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>

I don't think this is exactly what Hannes reported; IIRC he reported
that setting NO_GETTEXT wasn't sufficient to get it to build. Just
unsetting NEEDS_LIBINTL for a platform that doesn't have gettext is
curing the symptoms rather than the decease, shouldn't the build
system and/or the code be fixed so setting NO_GETTEXT is sufficient
instead?

As a side-note, I think it might be time to merge the gettext-branch
into msysGit soon. If no one complains, I'll get it done one of the
next days.
