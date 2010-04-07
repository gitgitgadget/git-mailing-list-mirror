From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 7 Apr 2010 10:27:57 -0500
Message-ID: <i2sfabb9a1e1004070827m2745f9ccz5976664852eabd3b@mail.gmail.com>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
	 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
	 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
	 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
	 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
	 <20100407031655.GA7156@spearce.org>
	 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
	 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
	 <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
	 <20100407144555.GA23911@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 17:34:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXHM-0004OW-Uc
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 17:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756Ab0DGPev convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 11:34:51 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:55617 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932725Ab0DGPev convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 11:34:51 -0400
Received: by ywh2 with SMTP id 2so623687ywh.33
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CpJ3AkNq46Cbr2qHLnXzfJgEegGD9v7vz0MJysHlLPw=;
        b=CVr9LoiK2Wi7ZEfs65WAoh9kNudP0qghyJC+undFDL2hmLaVARTiaJGlaITT3mEsu5
         wjdBVRtAAl6PLvDPul01BZFPXlzqnpwlg8KIgSgnguvCy0x9mWHSD34O8XizENUawmAD
         0ySuFflBtFFv0SWb+vrlKIo9Pj2aEa7J4pwBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KZowwAYJQa3Gx0VDN6Xeiblyr+AIv8pGr+Rv2oY63kRxqzlBzsrBiMOpiaC+WU07cU
         r5HLxYDAjrE2SKp3CtIVGeMsENZOeSdEXpraSGwKdJBmAIyVjPbS8yBN/F9W9VOUDh++
         QqHGlZDjbeq+xW7VQ2FpRIWDWbQNhBdUmrNy8=
Received: by 10.100.206.13 with HTTP; Wed, 7 Apr 2010 08:27:57 -0700 (PDT)
In-Reply-To: <20100407144555.GA23911@fredrik-laptop>
Received: by 10.101.160.24 with SMTP id m24mr11928210ano.222.1270654079636; 
	Wed, 07 Apr 2010 08:27:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144239>

Heya,

On Wed, Apr 7, 2010 at 09:45, Fredrik Kuivinen <frekui@gmail.com> wrote=
:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("pthread_mutex=
attr_settype failed: %s", strerror(errno));

Can't you just die_errno here?

--=20
Cheers,

Sverre Rabbelier
