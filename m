From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git sideband hook output
Date: Fri, 11 Jun 2010 15:18:14 +0000
Message-ID: <AANLkTikONJoDiyxmcmdG8zZkTCLbqXlXhrASae7rAreN@mail.gmail.com>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
	<20100608214632.GN14847@spearce.org>
	<A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
	<alpine.LFD.2.00.1006090934320.30664@xanadu.home>
	<A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
	<20100610183019.GR14847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 11 17:18:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON5zx-0000tX-TC
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 17:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab0FKPSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 11:18:17 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:58117 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab0FKPSP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 11:18:15 -0400
Received: by mail-yw0-f204.google.com with SMTP id 42so1204456ywh.15
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dpfCpSREy2HpjzaotpwNPqy7e/Z2wXJm5L2i6828Twk=;
        b=pmRI5nBHTSLbkWwKZVYy90LcGqHrYzY8JbGX3sG8rOrfiSNQYGLHEteS5NodXOtZ+6
         /s4wqivlvMgqKjADnRXqMe2Kw3j3KwXIQw9mzuLQBMIr6mTe9i9ZTojJwjSOst9/0xLd
         rCCgcjBJlpprI0EnPn5yxtOCmWkZ8T1OmH088=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gX67q3vDxDMXv4o/e+0OwyII6EEGx9AgdpkaYZqPwos5n5vHDYWmrx2vWWvM7X6wjq
         7BLylsx6L3pvN2imx8TaVaGBAxYyqZ2gAmz1AHw9IM/jCj6IUzRjrRGqdd84+CjLZcKy
         yqPeB/kXAmczljB11nm3lbY8pNf/QYEyCmMCo=
Received: by 10.91.145.13 with SMTP id x13mr254151agn.16.1276269494902; Fri, 
	11 Jun 2010 08:18:14 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Fri, 11 Jun 2010 08:18:14 -0700 (PDT)
In-Reply-To: <20100610183019.GR14847@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148954>

On Thu, Jun 10, 2010 at 18:30, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Peter Kjellerstedt <peter.kjellerstedt@axis.com> wrote:
>> And what if my hook output is localized? Now there is an English
>> "remote:" in front of every line... Or even worse, what if the
>> "remote:" string is localized in a future version of git, then I
>> have no way of knowing how wide it is and cannot take measures to
>> format my hook output so that it will look right.
>
> Don't localize "remote:"? =C2=A0Or pick a shorter translation?
>
> If its really a problem, maybe "remote: " prefix should turn into
> something shorter and language agnostic, like "<< ". =C2=A0But thus f=
ar
> we hadn't had to worry about it, since we didn't have translation
> support in Git... =C2=A0(though yes, I see that is changing now).

Is there any reason for why the "remote:" output needs to be echoed
verbatim to the user instead of being passed through some filter.

If not, then it could be treated as part of a protocol, parsed, and
localized however the user wants.

">" isn't as language-agnostic as you might think, in a RTL language
the arrow ends up facing the wrong way.
