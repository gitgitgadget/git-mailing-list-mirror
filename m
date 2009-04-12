From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 3/6] send-email: Handle "GIT:" rather than "GIT: " 
	during --compose
Date: Sat, 11 Apr 2009 21:36:48 -0500
Message-ID: <b4087cc50904111936r6cbde773scbe5e7243442dc79@mail.gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
	 <7vprfjf11h.fsf@gitster.siamese.dyndns.org>
	 <b4087cc50904111345v4787f38al9d7d234de8a6d24e@mail.gmail.com>
	 <7v3aced6vr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 04:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LspaS-0003Sj-8A
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 04:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbZDLCgv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 22:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZDLCgv
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 22:36:51 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:47650 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZDLCgu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 22:36:50 -0400
Received: by qyk16 with SMTP id 16so3121592qyk.33
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 19:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D7myBbR7vdeoLM8f9VknXVyjDXhP5N4srdK3qphP+kI=;
        b=RfAKGkGRDh2C9kIewgejartJH7ljehSBJ68Obs3rtSfFk11LTT0ByT/U00jbmNdm8P
         6HG3T94HZuOBBrUXCFBBDyuxsxlOMmmo5ZceGz7ofICPzVHZt4ZJLCf1YgNw4RcTbBhf
         dCLt5Np16Zf2loL1Suy8ydmadDCzW/0Rmno1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pZ+h3usRkocejPBTUn9EIgJaFSdAtHwUp/uCJwNYR7x7n9UL8u0nHyLUVx6+cXCfe0
         oI6+XtjmTYV4McTxggI3cZMHM8ElhTVnHoX+pTupYYNH9WxxMfCW6tgXy201FcQ7ciH7
         AfAFSHbtL4LxjD89g07kOEXPqQgb3xsF1piSE=
Received: by 10.224.20.77 with SMTP id e13mr5081569qab.186.1239503808756; Sat, 
	11 Apr 2009 19:36:48 -0700 (PDT)
In-Reply-To: <7v3aced6vr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116364>

On Sat, Apr 11, 2009 at 19:59, Junio C Hamano <gitster@pobox.com> wrote=
:
> Special variables like $_ cannot be made into lexicals, unless you kn=
ow
> you will only run with a very recent version of Perl (5.9.1, I think)=
=2E

Ah. I wish Perl's docs were a little more forthcoming about such
things. I ended up just trying it out, and indeed I am running 5.10.0.

> If you do not want to worry about portability, typically it is easies=
t to
> say "local ($_)" upfront in the beginning of a sub.
>
> I do not understand why you want to change the original
>
> =A0 =A0 =A0 =A0while (my $line =3D <$fh>) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0}
>
> though.

I'm not terribly bent on it; I had already reshaped that function and
I was curious about making what I had done work out of intellectual
curiosity. In fact, my commits no longer have the refactored version.
