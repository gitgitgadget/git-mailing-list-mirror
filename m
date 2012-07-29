From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Bug: Recursive submodules fail when the repo path contains spaces
Date: Sun, 29 Jul 2012 17:10:51 -0400
Message-ID: <CABURp0oHchc8KuwE+AxwzygLSi30+qiyqX=tfj9_rQrjBgO5AA@mail.gmail.com>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com> <500F00C7.4040209@web.de>
 <7va9yogb37.fsf@alter.siamese.dyndns.org> <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com>
 <CABURp0rM_zkA0Hb=kkJcEeqWBX0qgRqH-zviW8ofp-qQqkW6uw@mail.gmail.com> <FE466454ECCE48A19472B85D1C92E9E2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 23:11:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svam3-0002qW-ON
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 23:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab2G2VLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 17:11:12 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34133 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab2G2VLM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 17:11:12 -0400
Received: by qcro28 with SMTP id o28so2611718qcr.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UAVpK7OHgp1LZnSMPADxs7GzYuZpnttsCQcAjsZfK0A=;
        b=mEqYybKxkyjuTGrPCyhtNzAd9JvsU6glGHis7cA52A6nyEF0EgrTQv0VA955372fjQ
         zNShiIrhGaogMRo7MMpAtbo6087myeJ+fOdS1mQ3OSv+jl+Q5CYllf14t8V+vMRDBMou
         fvqkLbe8BSCAh6tL92KjyeKkcdc9oFzZESwBgM2N7G5fTioYdB35SkFO8roL01/gwLt8
         JmpDGzxEhXkZwrSxzNVf6Y80DJOIrb0xSBgpifqebwNjUAJhfwrEnZjGrmkf4npCKJ10
         4MHWy8kEZwOw/uBhQ5KRkffgOCuDIDhgUkWwdBC88+LcBgoM42A78mTU9/asXGosF8xT
         X6wQ==
Received: by 10.224.187.136 with SMTP id cw8mr20091212qab.70.1343596271468;
 Sun, 29 Jul 2012 14:11:11 -0700 (PDT)
Received: by 10.229.165.201 with HTTP; Sun, 29 Jul 2012 14:10:51 -0700 (PDT)
In-Reply-To: <FE466454ECCE48A19472B85D1C92E9E2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202496>

On Sun, Jul 29, 2012 at 3:30 PM, Justin Spahr-Summers
<justin.spahrsummers@gmail.com> wrote:
> Hmm, you're right. After further investigation, this actually looks like a weird issue with soft links. Here's some exact output (with spacing only for clarity), using a public test repository at https://github.com/jspahrsummers/recursive-submodules-test:

I can reproduce the problem now on 1.7.10.3.  However the problem goes
away in 1.7.12 since it was fixed in

6eafa6d096ce6b0ae20e4c0fbb248958559daf64
Author: Jens Lehmann <Jens.Lehmann@web.de>
Date:   Thu Jul 12 19:45:32 2012 +0200
Subject: submodules: don't stumble over symbolic links when cloning recursively

Regards,
Phil
