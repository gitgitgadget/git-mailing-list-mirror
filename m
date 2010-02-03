From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Wed, 3 Feb 2010 13:19:41 -0500
Message-ID: <32541b131002031019l42d3903cs58303a546f019898@mail.gmail.com>
References: <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com> 
	<394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com> <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com> 
	<77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com> <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com> 
	<32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com> 
	<76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com> 
	<32541b131002021540g7a2834c9hacf2be5962f66515@mail.gmail.com> 
	<20100203061535.GA6566@cthulhu> <20100203093150.GA23956@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>,
	"Larry D'Anna" <larry@elder-gods.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncjpj-0000RK-3H
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab0BCSUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 13:20:06 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:65435 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0BCSUE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 13:20:04 -0500
Received: by ywh36 with SMTP id 36so1535555ywh.15
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 10:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q3F6TEDfh39YlgOLB/5hmMrT8/2vClKPZKt9ghn+bqE=;
        b=H+nHtOovhzxuRSJuBr92nXfVY1AK6LMKypX9Z81OnPbP0EkfkTxUtl2NKfxGeT2Jeg
         xaHxx7m27AOkAMHwfzuz1CA0Ox63j+YaVPjeKWLy8BIadvmnLxi8aus+Hwgc5mNirnBs
         6rqMIP7Z3k0awdSJLhAtxCF4Jk++f/+JTllps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=APnOHBqVqBqwwJX+vVJ2tqMHvlckAW86kkFXlZjS6rsXGzPzNA5Ka/NlpFeucpNjWb
         MGs5lJHx16NRJo7/3usGQZTvgQYdSm7O3Kxrl0MuSXXtx5rTTZb9hd4n0WIjRXPGX4zM
         mGkTLS069ZNmMEESmJuFEzO/0JFPQdpV2w3DQ=
Received: by 10.150.116.5 with SMTP id o5mr268892ybc.336.1265221201095; Wed, 
	03 Feb 2010 10:20:01 -0800 (PST)
In-Reply-To: <20100203093150.GA23956@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138853>

On Wed, Feb 3, 2010 at 4:31 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 03, 2010 at 01:15:35AM -0500, Larry D'Anna wrote:
>> * Avery Pennarun (apenwarr@gmail.com) [100202 18:41]:
>> > You can however add *new* stuff. =A0That's why I suggested adding =
an
>> > option. =A0You could even make it a config option so you only have=
 to
>> > set it once (just like setting your preferred editor).
>>
>> Or, he can set his $EDITOR to a script that checks the mtime.

Nice.

> Do note, though, that there is a subtle race condition in using the
> mtime. If you make a change and save within a second of the editor
> starting, it will be ignored. To be thorough, you would probably want=
 to
> check the size and inode, as well.

Or just the file contents.

Avery
