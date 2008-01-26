From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: I'm a total push-over..
Date: Sat, 26 Jan 2008 14:16:29 +0200
Message-ID: <e51f66da0801260416p5f5ffb98w16fe832fe62dc7c9@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4797095F.9020602@op5.se>
	 <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
	 <4797518A.3040704@op5.se>
	 <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
	 <4798B633.8040606@op5.se>
	 <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>
	 <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
	 <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com>
	 <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 13:17:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIjyF-0005z1-SH
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 13:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbYAZMQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 07:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYAZMQd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 07:16:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:50301 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbYAZMQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 07:16:31 -0500
Received: by fg-out-1718.google.com with SMTP id e21so986935fga.17
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 04:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mJQkXb0Ipq/t0WWY6JHn90fNCyZSkD5CA1l/FaQo294=;
        b=BA0+4+XIhP91iEMVEgF2CvCFHE/frKHG/ok9eUeW9PNXwp3FQ8MSF7+3hi5t///LfO1jwWAmyCtdGp03aCPUqIyUIwTn5hz3Vhslg86FSgDizHhlC4BJb+PtRNsazbZZ1GioYgWEPNKKVeuElo0SlNnvC/p26Jvcsi9ZX9fMU/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vgSDXzHAoiCE2OK7pdktARRsyrgb2BaRhxD+MXXbYathSvhFxRpZZp876gMcewfC3fMU0y9vj9T2egMDz9btTy8ZA0D1buSnm8mo1iglXOAONtYDljT4o2cdQagy2pumpNnd2u76zT/YJK3qresyzHo3MSZcWX2jipLgzXpM85c=
Received: by 10.78.204.7 with SMTP id b7mr4325827hug.74.1201349789794;
        Sat, 26 Jan 2008 04:16:29 -0800 (PST)
Received: by 10.78.200.6 with HTTP; Sat, 26 Jan 2008 04:16:29 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71778>

On 1/26/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, 25 Jan 2008, Marko Kreen wrote:
> > Well, although this is very clever approach, I suggest against it.
> > You'll end up with complex code that gives out substandard results.
>
> Actually, *your* operation is the one that gives substandard results.
>
> > I think its better to have separate case-folding function (or several),
> > that copies string to temp buffer and then run proper optimized hash
> > function on that buffer.
>
> I'm sorry, but you just cannot do that efficiently and portably.
>
> I can write a hash function that reliably does 8 bytes at a time for the
> common case on a 64-bit architecture, exactly because it's easy to do
> "test high bits in parallel" with a simple bitwise 'and', and we can do
> the same with "approximate lower-to-uppercase 8 bytes at a time" for a
> hash by just clearing bit 5.
>
> In contrast, trying to do the same thing in half-way portable C, but being
> limited to having to get the case-folding *exactly* right (which you need
> for the comparison function) is much much harder. It's basically
> impossible in portable C (it's doable with architecture-specific features,
> ie vector extensions that have per-byte compares etc).

Here you misunderstood me, I was proposing following:

int hash_folded(const char *str, int len)
{
   char buf[512];
   do_folding(buf, str, len);
   return do_hash(buf, len);
}

That is - the folded string should stay internal to hash function.

Only difference from combined foling+hashing would be that
you can code each part separately.

> And hashing is performance-critical, much more so than the compares (ie
> you're likely to have to hash tens of thousands of files, while you will
> only compare a couple). So it really is worth optimizing for.
>
> And the thing is, "performance" isn't a secondary feature. It's also not
> something you can add later by optimizing.
>
> It's also a mindset issue. Quite frankly, people who do this by "convert
> to some folded/normalized form, then do the operation" will generally make
> much more fundamental mistakes. Once you get into the mindset of "let's
> pass a corrupted strign around", you are in trouble. You start thinking
> that the corrupted string isn't really "corrupt", it's in an "optimized
> format".
>
> And it's all downhill from there. Don't do it.

Againg, you seem to keep HFS+ behaviour in mind, but that was
not what I did suggest.  Probably my mistake, sorry.

-- 
marko
