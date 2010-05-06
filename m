From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Thu, 6 May 2010 19:54:30 -0400
Message-ID: <z2k32541b131005061654je98055aanac16e790d412684e@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <g2m32541b131005061638o8a5e3490x8a5b1c3eb8c73c70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, torvalds@linux-foundation.org,
	prohaska@zib.de, gitster@pobox.com
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 01:55:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAAuK-0004ML-FD
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 01:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab0EFXy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 19:54:58 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:55207 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab0EFXyw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 19:54:52 -0400
Received: by yxe29 with SMTP id 29so333429yxe.4
        for <git@vger.kernel.org>; Thu, 06 May 2010 16:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q+WdG2LE6h+rxrBnvPygMRkgH5BYMPXy4cO0Gnxl5E0=;
        b=xFajVtQr1J27ei9F82LPwsk27d0A3109zZRjl+6hSRwKIYYfc5m3sVPfB1yPsCPfyE
         8JuhFzjbbq3g32TlQ++jtjwkk+RNagZelTakJ10/jy/VkW1o9MU5BUW6YHK9Ji80CyIT
         +vUP1XE3nUrD3CFlPwPnp3YDNlTiO2B2hux10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qHehTxSne4LxmQvSaXcEm5z1Hmv7U/HdwmEEIycKelH+tKxY+CH+lL10Bw4N8yWlnc
         cDlEI2ksnYV5UQS76weC9Wdm+egkynjEBiNswAWWr4dP+ybDIzt4BT/rxFpUUNTxiNVp
         yuzWzKSDMQdYneNTNbuKb0kRh5wpQJC1+rYa4=
Received: by 10.150.237.9 with SMTP id k9mr2729126ybh.155.1273190090745; Thu, 
	06 May 2010 16:54:50 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Thu, 6 May 2010 16:54:30 -0700 (PDT)
In-Reply-To: <g2m32541b131005061638o8a5e3490x8a5b1c3eb8c73c70@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146513>

On Thu, May 6, 2010 at 7:38 PM, Avery Pennarun <apenwarr@gmail.com> wro=
te:
> I definitely like this. =A0The existing core.autocrlf setting does ca=
use
> a lot of confusion for precisely the reason you stated: people often
> forget to set it until *after* they've checked out the repo, at which
> time all the files are already checked out wrong and total confusion
> ensues.

Oh, just to clarify the rationale a bit more:

Whether a developer wants autocrlf or not actually is
project-dependent, not user-dependent or "all Windows users want
autocrlf."  For example, if I'm running Cygwin and I checkout a copy
of the git source code to build with Cygwin gcc, I definitely don't
want autocrlf.  (Actually, almost always, for C source code I don't
want autocrlf, or I want autocrlf=3Dinput.)

If I'm checking out a copy of our Delphi project on Windows, though, I
need autocrlf or the IDE goes bananas.  And our team would be happy to
put the right magic incantation in a .gitattributes file in our Delphi
project if it would make this work out automatically.

Setting core.autocrlf on one of our Windows developers' systems can't
cover both of those cases automatically, whereas the settings Eyvind
has proposed would solve our problem.

Have fun,

Avery
