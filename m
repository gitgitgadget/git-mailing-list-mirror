From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 01/72] gettext.h: add no-op _() and N_() wrappers
Date: Sun, 20 Feb 2011 11:13:52 +0100
Message-ID: <AANLkTikkTUD=ih_KHxZ-F2gm_rNTfJ0E3Z6WXSLHBCnd@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-2-git-send-email-avarab@gmail.com> <20110220020130.GA17225@elie>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 11:14:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr6J0-000578-FZ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 11:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab1BTKOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 05:14:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56567 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab1BTKON convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 05:14:13 -0500
Received: by fxm17 with SMTP id 17so601949fxm.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 02:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V/jGtY+tbwk1ZaCytZpEjU5iavIdsFWG3qG+pHaXd5Y=;
        b=G/NoukTs1FXFzdGteHe1uOKLeyGX256mLZ6rNbGyJG06eC9qizNj3gF8uplCjCL7ZU
         PSSFp0goXdu0iT2mDXD0MAnhiSMAXFt28XI/PeKehWV7ajBdrPceReY7bAS9NIB0pL1R
         qBl6RDlvVWH/M60ZjHy4u96wLVyqsSt7pml+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ATQ/j0XERU0mFVChCwsMV+3FRIJDrCRroXZPB4TrR6t3JqJRum/o0k4YfvaCEFOx5p
         JGOE9JY2ctKYmKP4LtQb1sXgWHJ++buyOeXRdHD1Cw0Er4YqoQ1oB0NP3MOgtG4A2Xlb
         aJpUj38XaTDixLRNqUDV+3o9Sacuk2gaW0cP4=
Received: by 10.223.71.200 with SMTP id i8mr266814faj.142.1298196852083; Sun,
 20 Feb 2011 02:14:12 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Sun, 20 Feb 2011 02:13:52 -0800 (PST)
In-Reply-To: <20110220020130.GA17225@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167414>

On Sun, Feb 20, 2011 at 3:01 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> =C6var Arnfj=F6r=F0 Bjarmason wrote:
>> +#define N_(s) (s)
>
> Might be nice to make this an inline function, for type safety.
>
>> +#define _(s) (s)
>
> This one can't be a function, though, since it needs to transform
> literals to literals.
>
=2E..
> -#define N_(s) (s)
> -#define _(s) (s)
> +
> +static inline const char *_(const char *msgid)
> +{
> + =A0 =A0 =A0 return msgid;
> +}
> +
> +/* Mark msgid for translation but do not translate it. */
> +#define N_(msgid) (msgid)

Isn't this the opposite of what you suggested above?
