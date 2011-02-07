From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] commit: fix memory-leak
Date: Mon, 7 Feb 2011 20:22:49 +0100
Message-ID: <AANLkTikKZ+2qUMF1T5pP60cUd9Ya3n2mfhTkX6L32zmn@mail.gmail.com>
References: <1297104044-4684-1-git-send-email-kusmabite@gmail.com> <vpqei7jfzq5.fsf@bauges.imag.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, blees@dcon.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 07 20:23:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmWg9-00046t-5z
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 20:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab1BGTXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 14:23:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44730 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab1BGTXL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 14:23:11 -0500
Received: by fxm20 with SMTP id 20so5237589fxm.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6Mgbw10WyvFmlLjeLzAANFytMLN7kYScRwWalDzSPHU=;
        b=o+d2WbO9wC6l5b/SBeBn8kWTrYYnoG5S57sGZEQlhR78tMe/ARQKwwJSfInRV4jcvG
         jJQLF8ae/czQb6fXpx9kb47i/DNYU7cxRjRR89D4ZLVfym7s0g4+z1Fv4OCYJhevRDpN
         iSo3Qer3rQrouGfhj+34uHxWq54ccUf3Cumvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Yer+2tfXjmMM41yBYuW64PkLRG3K6F+RmoGPOYZofQEgWhYT5qfNVtIDU/vY10Vl5M
         VwJJ14G1pg2/ZTMVvOXd0Js+xHdXHGXYyVksighPgXo3xp/gdT7YM9jPhe/EiARn0Fb3
         FViLn0Te+agZIBAIWcMFf8z5aUa7nGfiMj+Ug=
Received: by 10.223.112.1 with SMTP id u1mr4171180fap.109.1297106589911; Mon,
 07 Feb 2011 11:23:09 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Mon, 7 Feb 2011 11:22:49 -0800 (PST)
In-Reply-To: <vpqei7jfzq5.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166271>

On Mon, Feb 7, 2011 at 7:48 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> At the same time, this fixes a problem with strict-POSIX getenv
>> implementations. POSIX says "The return value from getenv() may
>> point to static data which may be overwritten by subsequent calls
>> to getenv()", so duplicating the strings is a potential bug.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 not
> ?

Indeed, thanks.
