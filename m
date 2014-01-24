From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] ewah: support platforms that require aligned reads
Date: Thu, 23 Jan 2014 16:15:39 -0800
Message-ID: <20140124001539.GG18964@google.com>
References: <20140123212036.GA21299@sigill.intra.peff.net>
 <20140123212752.GC21705@sigill.intra.peff.net>
 <20140123234456.GF18964@google.com>
 <CAFFjANR=ZKmrf6QjkbiD3z1waoYjWV3eWR_1E-qJU9Nr65bFsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Vicent =?iso-8859-1?Q?Mart=ED?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 01:15:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6UR4-0006vk-NI
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 01:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbaAXAPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jan 2014 19:15:46 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:37971 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbaAXAPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 19:15:46 -0500
Received: by mail-bk0-f54.google.com with SMTP id u14so766465bkz.41
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 16:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SK8srpTB7o35BdQVLAB96xPlVAqJXUcs1xCZeQaO9ts=;
        b=RKPN3qT1gBnwNKKkOh0+6MtDBPs0sllXK0jK0EK2Pe1n9XvPQKW30r0bpRy7wOK8bl
         /h24g64AljzGhcr1TUYK8YdAps3X0M6NtfIy3GY7S88YX3SWMxqR+SdwcCuYSPRLAVJN
         nmTOhn2TbNLsS07mydPTTeK13T9KEdjwU1UtNjsSZH4SvGNXzP7nkxHtr29GHCWomBkD
         10LopUBBBPzoorW5lkw2sl1ZzRX6MCCpOqqGHpUn4puvijjvaLWccmZE1VN3AZcIzT7T
         mUDky4Gc2XKtk4hwvXewHaaZqRGxX/mBqhRzR0D9nDAmP6mntwW1ududLxR1eIJziH+1
         uHaA==
X-Received: by 10.204.81.14 with SMTP id v14mr6001199bkk.3.1390522544967;
        Thu, 23 Jan 2014 16:15:44 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sx5sm788322bkb.0.2014.01.23.16.15.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 16:15:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFFjANR=ZKmrf6QjkbiD3z1waoYjWV3eWR_1E-qJU9Nr65bFsw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240980>

Vicent Mart=ED wrote:
> On Fri, Jan 24, 2014 at 12:44 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:

>>> +#if __BYTE_ORDER !=3D __BIG_ENDIAN
>>
>> Is this portable?
>
> We explicitly set the __BYTE_ORDER macros in `compat/bswap.h`. In
> fact, this preprocessor conditional is the same one that we use when
> choosing what version of the `ntohl` macro to define, so that's why I
> decided to use it here.

Ah, thanks.  Sorry I missed that.  So feel free to add my reviewed-by
to the patch without my tweak, too.
