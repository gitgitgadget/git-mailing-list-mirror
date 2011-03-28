From: Joe Ratterman <jratt0@gmail.com>
Subject: Re: [PATCH] grep: allow -E and -n to be turned on by default via configuration
Date: Mon, 28 Mar 2011 17:41:16 -0500
Message-ID: <AANLkTimpp+dyt8cONp_nK72eTXXgsOfkHuWpPTr90h=u@mail.gmail.com>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
	<7vlj024wal.fsf@alter.siamese.dyndns.org>
	<7vbp0ux5c9.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 00:41:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4L7i-0004it-UP
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 00:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab1C1WlS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 18:41:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59563 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab1C1WlR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 18:41:17 -0400
Received: by iyb14 with SMTP id 14so3610550iyb.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PwlKPxwU/1WXGzA7oKru2fcOYdL9GlpCqpPrve7Nd1U=;
        b=NwmFKDd3skLgyl7YhHxOz68mJwycxarfOnZefX7UB/jvjwSTvaatcBv6CyJ0ATHKos
         T0ipv8WoGGBwtsyuplFNifWnbvjElYOahJsXyK3rG2m9QcyG5vJ7OfzMz6QQVsLh3kvS
         2sIWbuU23dffAKbIP0oz/5ZeMwd/gS2NtnD+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p5i+/DDuExHQnxM+vJOV/iChAj53VRnHdtrETSWFwtc0aPpw6mN+W4Lgd/F6eYIrtE
         v3/nOORv0hMQhGALZjYG8PLXwsDBRVuUlQ92Lg2ilzLEHbZQVwx7UDlNl2ujxpGBdwog
         r33K7VsoH2XZ3KjtG//QK0pL8GWKPtUx56WjQ=
Received: by 10.42.147.134 with SMTP id n6mr7199134icv.216.1301352076527; Mon,
 28 Mar 2011 15:41:16 -0700 (PDT)
Received: by 10.42.218.1 with HTTP; Mon, 28 Mar 2011 15:41:16 -0700 (PDT)
In-Reply-To: <7vbp0ux5c9.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170196>

On Mon, Mar 28, 2011 at 5:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> +grep.lineNumbers::
> + =C2=A0 =C2=A0 =C2=A0 If set to true, enable '-n' option by default.
> +
> +grep.extendedRegexp::
> + =C2=A0 =C2=A0 =C2=A0 If set to true, enable '--extended-regexp' opt=
ion by default.
> +

I know my original patch was plural, but I since noticed that the GNU
grep --line-number option is singular.  I used the same thing in my
patch to add that option to git grep.  Should this one be singular?


> +grep.lineNumbers::
> + =C2=A0 =C2=A0 =C2=A0 If set to true, enable '-n' option by default.
> +
> +grep.extendedRegexp::
> + =C2=A0 =C2=A0 =C2=A0 If set to true, enable '--extended-regexp' opt=
ion by default.
> +
> +
=2E..
> + =C2=A0 =C2=A0 =C2=A0 if (!strcmp(var, "grep.extendedregexp")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opt->regflags |=3D=
 git_config_bool(var, value) ? REG_EXTENDED : 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!strcmp(var, "grep.linenumbers")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opt->linenum =3D g=
it_config_bool(var, value);

We need to match the case between the docs and the code or use
strcasecmp().  Most config options I could find used all lower-case.



Joe
