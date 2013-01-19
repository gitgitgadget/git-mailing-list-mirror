From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: tar-tree.c dereferencing pointer to incomplete type
Date: Sat, 19 Jan 2013 13:28:51 -0800
Message-ID: <20130119212851.GA4009@elie.Belkin>
References: <CAPy7p-45-E-vWcjBTXSLpjoQLic54JdAoKqB3jz4RA6GzAkw8w@mail.gmail.com>
 <CACsJy8DfOYRmF6FqTLCAYgXGpECX-VhpXGK5CfcmVvKXQ+DpuA@mail.gmail.com>
 <CAPy7p-7V6y4hfLrYYi_3zGkzGTw2BeF5wh3zPYzumrp+Pbqr+Q@mail.gmail.com>
 <CAPy7p-5vZKzznSny97BZMWHxHPJupO3in7tvjyFOTxBYzw5D4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?55m944GE54aK?= <ShiroiKuma@ShiroiKuma.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 22:29:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twfyd-0001Eo-LF
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 22:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128Ab3ASV3B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 16:29:01 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:43052 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3ASV3A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 16:29:00 -0500
Received: by mail-da0-f53.google.com with SMTP id x6so2126833dac.40
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 13:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=V+WH/zzTO06z3mVvHBurpBvaTiHzrkPUcOCCQwtrTbA=;
        b=eHeMuTHJBq/7fZOyN502Vlolp13QXv+OXIvAhgYlRrHI/2FC/HjN4ZWQjJ5H2xSQFu
         J0brkFZW5Chu4wj6OwEeE9dHOIkCYZNFxKSsBW3Ze1MlN49oH5Yd4TZyPPpXFLIq49gv
         TDQ9HIAR/ihXTYVmnrQKkkRuVKllXcWUVnkFkdqVuYsncSiT4DPm1NlLWke3dxu1qCzi
         UdzQbyvPxXvGLxfWuhS7w5/Zi6edVVR36nntZzOi82cN91K8JB4UBm4ULb5cy6Je5WLI
         m9JcbDsWmPZBYAp3JPQ3sBu9EDOxE+03SKRn0pNBdfFUjl8sIIGs8Va7zF4f6VKuT9n8
         vPXw==
X-Received: by 10.68.136.73 with SMTP id py9mr17576975pbb.43.1358630940112;
        Sat, 19 Jan 2013 13:29:00 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id hs2sm5578396pbc.22.2013.01.19.13.28.57
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jan 2013 13:28:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPy7p-5vZKzznSny97BZMWHxHPJupO3in7tvjyFOTxBYzw5D4Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213987>

=E7=99=BD=E3=81=84=E7=86=8A wrote:
> On Sat, Jan 19, 2013 at 6:26 PM, =E7=99=BD=E3=81=84=E7=86=8A <ShiroiK=
uma@shiroikuma.org> wrote:

>> Moved it and compiles fine. In fact I moved it back now, so it shoul=
d
>> be finding it again and it still builds fine, no trace of the prior
>> error. I'm dumbfounded! But at least it compiles...
>
> OK, figured it out. It was indeed the wrong tar.h, the one that was
> making it bomb was the kernel headers tar.h from the Android source.
> That explains it quite well.

Hm.  Is there anything to do to make our headers specified with -I
take precedence over unrelated system headers when processing
'#include "foo.h"' directives?

Thanks,
Jonathan
