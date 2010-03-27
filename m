From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 22:33:44 -0400
Message-ID: <32541b131003261933m940ad70g19b3961d20f5a165@mail.gmail.com>
References: <20100326215600.GA10910@spearce.org> <4BAD3C6E.4090604@gmail.com> 
	<20100326230537.GC10910@spearce.org> <7v7hoyabiv.fsf@alter.siamese.dyndns.org> 
	<32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com> 
	<4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org> 
	<alpine.LFD.2.00.1003262125120.694@xanadu.home> <20100327013443.GE10910@spearce.org> 
	<alpine.LFD.2.00.1003262142121.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Mar 27 03:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvLqo-0005jY-6b
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 03:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab0C0CeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 22:34:08 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:60272 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab0C0CeF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 22:34:05 -0400
Received: by ywh2 with SMTP id 2so3899443ywh.33
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 19:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ghbA9ejAvpirJdFWkHrih/058pqTm5bGNNO0vB8zhMY=;
        b=Q2Q8EJ6NLzcWj/rk45qJqKmo4jEyjDT7PeWjc/OObxaey3ERfrPINO7x9WakdF+q89
         N01UqNsIXWJGf512FJObcfSN+wLZG/Y9Gm8au1rwvg75LkiYqEVZUl501XbNYxEVkJkY
         Pjhyu7MpyruqJN2P/ZCKAffwVRUC69L6juaVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P+t6o/EkayYGDM81RFF4rQDKliy1EMOpyQ9c7KijODCX9Alz3QM4kBkbT6mvvBW8iX
         NieRwpOZZ7wYvl1RcHSkYNvkDFBrDwBYnszVrqTDuSEm8C3VDuQE3gRkMhpDbURZozPJ
         Y/BFYTPuRUn/kHHrKITa6sWXGPWOH/eHQvGZU=
Received: by 10.150.148.18 with HTTP; Fri, 26 Mar 2010 19:33:44 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003262142121.694@xanadu.home>
Received: by 10.150.1.14 with SMTP id 14mr2297424yba.12.1269657244224; Fri, 26 
	Mar 2010 19:34:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143314>

On Fri, Mar 26, 2010 at 9:56 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Fri, 26 Mar 2010, Shawn O. Pearce wrote:
>> Its *NOT* fine. =A0But Avery and Junio might disagree with me. =A0:-=
)
>
> FWIW I agree with you.

I would also like to remove my name from the "disagree" list. :)

Producing nonstandard output isn't fine at all - I mentioned Postel's
Law, but the neglected half of that law is that you're supposed to
produce valid data in the first place.  This is why (as I mentioned
earlier) bup's automated tests now run 'git fsck' explicitly to verify
that it gets it right.  It was only the very first versions of bup,
which thankfully nobody used for anything important, that screwed this
up.  Barring any new and improved screw-ups, anyway.

I only brought it up to say that it's actually easy to make this
mistake undetected.  Very few people run git fsck nowadays.  The world
might benefit if git complained (albeit non-fatally) *whenever* it saw
such an incorrect tree.

> In fact, my position is that pack v4 would simply refuse to optimize =
the
> encoding for such tree objects, period. =A0Only the non ambiguously
> encoded tree objects would benefit from the v4 improvements.

This sounds very wise to me.

Have fun,

Avery
