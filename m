From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3] implement generic key/value map
Date: Thu, 14 Jul 2011 21:07:54 +0200
Message-ID: <CAKPyHN3VV4bmy2CF9vPsRG82EapFtUOCXNYO=mVAJs54QG===g@mail.gmail.com>
References: <20110714173454.GA21657@sigill.intra.peff.net>
	<20110714175105.GA21771@sigill.intra.peff.net>
	<CAKPyHN0-VbzjMaMJFZeGGrGX6HuGNEBHNVNf0cexB2vu21_13g@mail.gmail.com>
	<CAKPyHN3G41iMGmGgp6jTcWN=Rxt=RTUS7ktgVDhZEXPBRXvTDQ@mail.gmail.com>
	<20110714185539.GA27141@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:08:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRGT-0003NS-Es
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab1GNTH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 15:07:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55015 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab1GNTHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 15:07:55 -0400
Received: by vws1 with SMTP id 1so409686vws.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6m93o+SW1X03A7KV7PYj+PxXzaabz6PSLGH8tHlx+1Y=;
        b=pO2AkapS9c3pSlIwoG/jhT1O1BAXRWtpAz6HVkStFuu9IJc2ER7hpIoTD4/isgLx9H
         DUigAj3YOqBEp023M3Od5u55Pz6L5zfKkIogRULHfFwveZE2JEMdVEMIYJYd/ao4Legp
         sxVpAH5oxONOK5EqLJIgJKS4yvCd/hbHNoDV4=
Received: by 10.52.111.200 with SMTP id ik8mr2603461vdb.128.1310670475037;
 Thu, 14 Jul 2011 12:07:55 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Thu, 14 Jul 2011 12:07:54 -0700 (PDT)
In-Reply-To: <20110714185539.GA27141@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177157>

On Thu, Jul 14, 2011 at 20:55, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 14, 2011 at 08:54:07PM +0200, Bert Wesarg wrote:
>
>> On Thu, Jul 14, 2011 at 20:52, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> > On Thu, Jul 14, 2011 at 19:51, Jeff King <peff@peff.net> wrote:
>> >> +#define MAP_IMPLEMENT(name, ktype, vtype, cmp_fun, hash_fun) \
>> >
>> > This define should probably in the header too. Else this is completely useless.
>>
>> Ahh. One have to read patch 2/3, to see how to use this. Please feel
>> free to ignore this than.
>
> Yeah, you could treat this like a C++ template and assume random bits of
> code will instantiate a map of whatever types they need. But this is C,
> and we only want to instantiate once. So I just figured to keep the
> static list of whatever maps git needs in the map.[ch] files.

When I wrote such macros in the past, the 'generated' functions where
all static. So one could instantiate a map multiple times in different
compilation units where one need to access this type of map.

But I'm perfectly fine with your way, which is new to me.

Bert

>
> -Peff
>
