From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 4/6] zlib: wrap deflate side of the API
Date: Fri, 10 Jun 2011 19:23:47 -0300
Message-ID: <BANLkTinz9VAL_j9hZeF=kuAPwU1+0yEyRw@mail.gmail.com>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
	<1307736948-16956-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 00:23:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVA7N-0000In-AE
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 00:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167Ab1FJWXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 18:23:48 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50999 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096Ab1FJWXr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2011 18:23:47 -0400
Received: by yia27 with SMTP id 27so132961yia.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2n6gjz0r1YMitbv00lCKXyZ1k3wjQmNf8OCM/wqwUDc=;
        b=loO28Q5n1Zu1LVKE5rMvUzEiRIkzGGyDzeNC2UrPgYLbM3gSSO7hTeUqhqVcL5k1JL
         N6WRT1dIvmtpxaCAhqYElmFG98u5N6Sn3DrxmnCiCEMBE5HB/DFMvv0PGeHc7GEi10Tz
         06uWBxbOMv3aB2Y9NXEReeKt3NpAONANUxA0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P5AvwzOg+GdZZaynnDuVoS4IOgfW7v9xQ1L0jHTurmwX+3uXHFUXWxvaIlhRz8Vx8N
         psFI7xRLqOmWGFXfLIK6vF4b4PXIEyAXFJ+yGPbeZRhq5dEyEWDzJLcdVm+oBYeHLiHg
         Q7INyXMnU/taI3qagZkNsNulQvDXbaxL8xJqk=
Received: by 10.151.122.11 with SMTP id z11mr3617626ybm.278.1307744627063;
 Fri, 10 Jun 2011 15:23:47 -0700 (PDT)
Received: by 10.151.78.8 with HTTP; Fri, 10 Jun 2011 15:23:47 -0700 (PDT)
In-Reply-To: <1307736948-16956-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175631>

On Fri, Jun 10, 2011 at 5:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> +void git_deflate_init_gzip(z_streamp strm, int level)
> +{
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Use default 15 bits, +16 is to generat=
e gzip header/trailer
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* instead of the zlib wrapper.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 const int windowBits =3D 15 + 16;
Was this style intentional?
