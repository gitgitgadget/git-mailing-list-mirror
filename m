From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 1/2] parse-options: add PARSE_OPT_LITERAL_ARGHELP for 
	complicated argh's
Date: Thu, 21 May 2009 12:03:23 -0700
Message-ID: <780e0a6b0905211203g3223fe3fp5eed27ebf244394a@mail.gmail.com>
References: <1242557224-8411-1-git-send-email-bebarino@gmail.com> 
	<fbaa26d941f496efefc30e298f5534f8194ee716.1242891030.git.bebarino@gmail.com> 
	<7v3aaybewo.fsf@alter.siamese.dyndns.org> <4A1586A7.9000909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 21 21:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7DYX-0000Ck-9x
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 21:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbZEUTDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 15:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbZEUTDo
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 15:03:44 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:10800 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbZEUTDn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 15:03:43 -0400
Received: by an-out-0708.google.com with SMTP id d40so2750892and.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 12:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VoU0nIglYMi61v/NrjgH31/NHGLy+NRZTFpgHMfxgG0=;
        b=VxvvvQlhh0jnmerCKsKkU041Ycig92vDAAsfWLF9Iu4PtjnxASiIbcEhQNMKMm1+xR
         gDa/DVK0sozRbMIOYEeZBHvlBRJKXcXpmrMjgt6iXL8RNdMX80G/w87QcO4bovUFrJ2n
         CcFYMYBF+OcQ4KwZD9fauPUtbSTzjhD7lvzfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XpKkScBdOWLy9RDpIaddxbwk3PdTJvhS+W+uyuzv0sBzc0pdfSafR3VOWqUsk066i0
         qtOL2N4Ku65V+dC6IE6mv7EvOMXPKF7luedh30QeEyVQic/Xac2t6A2y6ZKFkm+Mxvqj
         oWL2pw8KteJCdmkn9E5c7uCTz9LtmLAb2dmvQ=
Received: by 10.100.58.19 with SMTP id g19mr5419695ana.150.1242932623330; Thu, 
	21 May 2009 12:03:43 -0700 (PDT)
In-Reply-To: <4A1586A7.9000909@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119701>

On Thu, May 21, 2009 at 9:51 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Junio C Hamano schrieb:
>> Hmmm, why does this break t0040 (I am queuing this on top of 5acb3e5=
)?
>
> Probably because it changes this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pos +=3D fprintf(...);
>
> into this (simplified, usage_argh() expanded):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pos +=3D pos + fprintf(...);
>
> usage_argh() doesn't need the parameter pos.
>
> Ren=C3=A9
>

Woops. I thought I ran the tests but I guess I didn't. This is the
correct fix, thanks.
