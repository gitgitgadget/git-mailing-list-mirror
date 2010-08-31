From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] tests: make test_must_fail fail on missing commands
Date: Tue, 31 Aug 2010 18:14:14 +0000
Message-ID: <AANLkTimpaD7gW56sLqFzHOe+32QkXMOCkpQqJuaZNZav@mail.gmail.com>
References: <20100831155457.GB11014@sigill.intra.peff.net>
	<20100831155652.GB11530@sigill.intra.peff.net>
	<20100831172657.GP2315@burratino>
	<20100831180847.GC15020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:14:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVLi-0001iZ-4g
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab0HaSOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 14:14:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45365 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab0HaSOP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 14:14:15 -0400
Received: by fxm13 with SMTP id 13so4150403fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IAkbh6b3aBpWB/D/YaBrBMg2wmMrjaKHJcoX12whVoU=;
        b=UOITpEnLtEJjiXV972TdB/bk+kHYeCPbShXB38hWO/RjuyBpCWbwQNda2iBzNASb3k
         UJUoWJW16ps3ArHokAmw63dGmbcvr96ZdcWoGzAT/toPapg8BG8DE9q5mvdajRb51ovG
         NTsDCOIXWZv39BB+Ca/CxJGdBZ40KBPnf/gxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FHwCOXPUsnFftWgZWnVpKCzMhfPvFXu06pFtAieZxoMo47wvqqn094/iYYE2349sAl
         t9w1fesXDa464DP63/uqdwvBxXQOw6hQXWm2B+XSsoP860wrqwYRoMiGeOs0UWkNzVBN
         vzYTCzFEiXDN1G/huqLq+aQwdX2r9akL8OIcI=
Received: by 10.223.117.14 with SMTP id o14mr1304063faq.5.1283278454189; Tue,
 31 Aug 2010 11:14:14 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 31 Aug 2010 11:14:14 -0700 (PDT)
In-Reply-To: <20100831180847.GC15020@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154954>

On Tue, Aug 31, 2010 at 18:08, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 31, 2010 at 12:26:57PM -0500, Jonathan Nieder wrote:
>
>> Jeff King wrote:
>>
>> > The point of it is to run a command that produces failure. A
>> > missing command is more likely an error in the test script
>>
>> Makes sense. =C2=A0Here's the corresponding change for test_might_fa=
il.
>
> I think this is probably worth doing. Unless somebody is doing someth=
ing
> silly like:
>
> =C2=A0test_might_fail command_that_might_exist
>
> But that seems a pretty contrived scenario (I am imagining something
> like "call sync now, but if we don't have it, don't fail". But in the
> test scripts that seems unlikely).

Yes, test_must_fail is only for git commands, not external stuff like
sync, although some naughty people have gone and used it for grep/test
in a few places instead of using "!" it seems.
