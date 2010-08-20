From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/17] Documentation/technical: avoid stray backslash in
 parse-options API docs
Date: Fri, 20 Aug 2010 05:32:36 -0500
Message-ID: <20100820103236.GI10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:34:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOvX-0003g4-Hj
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab0HTKeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:34:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61295 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0HTKeR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:34:17 -0400
Received: by iwn5 with SMTP id 5so686766iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3q0/qFVrdGQnwrGZC1IB9GyscIby2T+6/lYVfF1NOyU=;
        b=JsZxEhdJ2le/n+KqVZOuKzI84ZamXv7rOk3AwK1DQQXckJyecbSiV8MIOG10mYsKzp
         fw5eH3cJvc5C85ogxvu40QznTivIsz1umDItTc6920TLOaBA6efHXq+weo2fVfgwPMg4
         pI6hJegWliDxr1Dx2crFYa8vpbE1iHdF0/Fxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DsizAmhjXunCS4qhrd6YsjwoyS4XoZfP8P5ZsmsJC4aFTvx+dW6Y5NyxT1PawxFMaZ
         R9CtD/rRrfBNE2AjX48s/X2KhcnoT4DP9WNygB2m6uoAa8tInW7+XZpsg3agz1/MqrrK
         GBGVfDGqsDozShOIQBhLUKkR0w1zm5PPynAbE=
Received: by 10.231.166.9 with SMTP id k9mr1401701iby.127.1282300457118;
        Fri, 20 Aug 2010 03:34:17 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm2495941ibe.17.2010.08.20.03.34.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:34:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154004>

Due to some unpleasant interaction between the `quote', 'italics',
and `monospace` rules, a certain paragraph ends up rendered like so:

	=E2=80=98short` is a character for the short option
	  (e.g. <tt>'e\=E2=80=99</tt> for <tt>-e</tt>, use <tt>0</tt> to omit)=
,

Use the {apostrophe} to avoid this.

While at it, escape "->" strings: they are meant as a literal
two-character C operator, not a right-pointing arrow.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/technical/api-parse-options.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentat=
ion/technical/api-parse-options.txt
index 312e3b2..c5d141c 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -201,7 +201,7 @@ The last element of the array must be `OPT_END()`.
 If not stated otherwise, interpret the arguments as follows:
=20
 * `short` is a character for the short option
-  (e.g. `\'e\'` for `-e`, use `0` to omit),
+  (e.g. `{apostrophe}e{apostrophe}` for `-e`, use `0` to omit),
=20
 * `long` is a string for the long option
   (e.g. `"example"` for `\--example`, use `NULL` to omit),
@@ -228,10 +228,10 @@ The function must be defined in this form:
 The callback mechanism is as follows:
=20
 * Inside `func`, the only interesting member of the structure
-  given by `opt` is the void pointer `opt->value`.
-  `\*opt->value` will be the value that is saved into `var`, if you
+  given by `opt` is the void pointer `opt\->value`.
+  `\*opt\->value` will be the value that is saved into `var`, if you
   use `OPT_CALLBACK()`.
-  For example, do `*(unsigned long *)opt->value =3D 42;` to get 42
+  For example, do `*(unsigned long *)opt\->value =3D 42;` to get 42
   into an `unsigned long` variable.
=20
 * Return value `0` indicates success and non-zero return
--=20
1.7.2.2.536.g42dab.dirty
