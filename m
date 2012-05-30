From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Thu, 31 May 2012 01:57:52 +0200
Message-ID: <CAKD0UuwGptoOQOT9eBEpd_aXes76CdaijYvnvyWGU99ZNz=v2g@mail.gmail.com>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com> <7vehq18c82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lanny Ripple <lanny@spotinfluence.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 01:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZsmR-0003X7-4v
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 01:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006Ab2E3X6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 19:58:15 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:52372 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab2E3X6O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 19:58:14 -0400
Received: by qadb17 with SMTP id b17so2224111qad.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=T5PsdKVxOZNqsmP/+iegclAUcGsxONi2rTEhr0eikug=;
        b=VHDhwPaj1r+4F0oAMufPHtCdmNLRr3uVxaeuFno9J0aHC9Qr1LBRX27qY8Oj/sJwV9
         NelyUlRR/SaHnTCMrLMKQMCCAcSva9VWcaRaIxY8qZxfPid7L4fI6mC7Q8bdFsDKOXUu
         gH0yrAumRaRAXbUal9Y58LanjRzIzRQN0YWPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=T5PsdKVxOZNqsmP/+iegclAUcGsxONi2rTEhr0eikug=;
        b=oaGDRMkBOzMVEuxznTHy78an7+iaB6kPggvYtxT+k8j3HbEXCa5UXFxc1ZhTzEjLg2
         khxJHw6g+2XmTOyootsQJpvq/r9+X4yxk17/UflqZWxBQ0oEHMhVRShWhvGH42L48ca3
         op+ekC7I0gRli9xanJ8QKNfqdJhRl3A4xVg5YjE4inP4BMi0OfDVBQ8529qWAEAczYbx
         IiKgPX/Iqf4NCAZXYCw7UTG3wsk596STuz5lLZS0I4Cpz/vMDLalHIyRvbC1lFK5oIr6
         p4zNGUjD6PrKukqQ4dvNFsjWvB8PHf0bP+NHToM/FOqsXXdg/eXaldBwa/27nRATC8oh
         Y44g==
Received: by 10.224.116.203 with SMTP id n11mr13347520qaq.61.1338422293028;
 Wed, 30 May 2012 16:58:13 -0700 (PDT)
Received: by 10.229.18.82 with HTTP; Wed, 30 May 2012 16:57:52 -0700 (PDT)
In-Reply-To: <7vehq18c82.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlAZd5QOSMJvzKnD1eLyJpoALF5bxu/sYZRXqKkTEVLd/g93zAvF5SX2CMHasqhKpKKOM0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198853>

On Thu, May 31, 2012 at 1:45 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Lanny Ripple <lanny@spotinfluence.com> writes:
>
> > =C2=A0 lanny;~> echo "R=C3=A9mi Leblond" | LANG=3DC LC_ALL=3DC sed =
-ne 's/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
> > =C2=A0 GIT_AUTHOR_NAME=3D'R'=C3=A9mi Leblond
>
> So in C locale where each byte is supposed to be a single character,
> that implementation of "sed" refuses to match a byte with high-bit
> set when given a pattern '.'?
>
> That is a surprising breakage, I would have to say.

=46WIW, the command above correctly returns GIT_AUTHOR_NAME=3D'R=C3=A9m=
i
Leblond' for me on OS X 10.8.


J=C3=BCrgen

--
https://blackdown.de/
http://www.flickr.com/photos/jkreileder/
