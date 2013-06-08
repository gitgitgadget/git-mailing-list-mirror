From: =?UTF-8?B?Q8OpbGVzdGluIFBlcmR1?= <tohwiq@gmail.com>
Subject: Re: [PATCH v2 02/22] git-remote-mediawiki: Use the Readonly module
 instead of the constant pragma
Date: Sat, 08 Jun 2013 15:01:03 +0200
Message-ID: <51B32B0F.1030400@gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr> <1370641344-4253-3-git-send-email-celestin.matte@ensimag.fr> <20130608032324.GA20226@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 08 15:01:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlIls-0005JE-SM
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 15:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab3FHNBU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 09:01:20 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:53158 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab3FHNBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 09:01:07 -0400
Received: by mail-we0-f180.google.com with SMTP id w56so3668093wes.25
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VmcM9wOgCGyIueEwNwPfUkJ+fUgC2ZlivHTP2kJ1PN0=;
        b=J/m0I+G3GVLOdF6FAcF/D/5shmxCE5a1PqgkhMKxOhzXovkGW9Jx7LvqDqgTy4mn3B
         ZajNPx3PQuxnpLf1j1FwO9fHl53AdkmPXAaaMP2pVNs4vPB4ofUUEhkqUSt9d9xnO56p
         I8pNWBnmpHh+8RyH/t0ExtPvGqkT28x2oyVcfLN4mPa7VF9JxUW88TI8zuzOdC+VcpSK
         gPvENkJ/q57sbuuN/lzyNwM+e8/ChetleYicmO1ppzbJD9crtxa5QwCQFJDPxPP3aITS
         rXNVOf9NIKgseWVSEhcd/+E02FRtQbgEpHX9DW01MMu16q0F7/yOvezo5r9H/HoP0R2F
         Zmsg==
X-Received: by 10.194.120.7 with SMTP id ky7mr1481175wjb.89.1370696466173;
        Sat, 08 Jun 2013 06:01:06 -0700 (PDT)
Received: from [192.168.1.2] (89-156-204-68.rev.numericable.fr. [89.156.204.68])
        by mx.google.com with ESMTPSA id cw8sm2198251wib.7.2013.06.08.06.01.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 06:01:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130608032324.GA20226@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226814>

Le 08/06/2013 05:23, Jeff King a =C3=A9crit :
> What does this series apply on top of? The existing version in "maste=
r"
> does not have "use Readonly" in it at all. The first version of your
> series introduced that line, but here it is shown as an existing line=
=2E
> Did you miss a commit when putting your patches together?

Oh yes, part of this commit went into the previous one, which was not
formated as an email when I did my git-format-patch. I should check my
patches more carefully before sending them. Sorry for this.

> What advantage does this have over "use constant"? I do not mind
> following guidelines from perlcritic if they are a matter of style, b=
ut
> in this case there is a cost: we now depend on the "Readonly" module,
> which is not part of the standard distribution. I.e., users now have =
to
> deal with installing an extra dependency. Is it worth it?

Like Benoit said, the problem is that they sometimes don't interpolate.
I don't know if we should keep this commit or not.
