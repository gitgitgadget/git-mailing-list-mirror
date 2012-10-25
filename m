From: Brandon Casey <drafnel@gmail.com>
Subject: Re: signing commits with openssl/PKCS#11
Date: Thu, 25 Oct 2012 01:02:33 -0700
Message-ID: <CA+sFfMdSc30xmzFrqbPFYigLkW9v_YSrnTBtumhZiU5TKiBxqQ@mail.gmail.com>
References: <1392235.RizYqAYdkC@off17>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mat Arge <argemat1010@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 10:02:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRIOv-0001NC-2b
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 10:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933623Ab2JYICg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 04:02:36 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37257 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252Ab2JYICe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 04:02:34 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so1554535vcb.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l6oStcu74wlFCz0twtNldesizz+tEGjl508xILdf8Bk=;
        b=M1pxG1/yM4tRHlSb1ceLRhTCi2xqrhY2i8LKiLnLcAfGIDM0TcdtvmJ+ZZUC8keV95
         TZtpRRTHz671JessbwhpPjtdhgEnsgPJ9q1gClNUr0ZdlZmjeQD+PPSZTleigDngo0xE
         bcEZhSN5Wa7RVgB4UHrD3Ea+m131VnjS4WSxzpSvM5z6fnPDTzVn5zV2DalGvFKikcpG
         TNErxAXNYU7RQfaZIs0yKqMTJOzEUy3jsFtVltkCQnmqkmxhscF7H9JhaZGxXWWByK4Y
         kWTdzm1NPVgn0AwtOdvL+lfoEA7OCHym/U1oVWCiYGAAJQ07dvCZkbWAjsY8lHG7g/4g
         gUFQ==
Received: by 10.221.0.212 with SMTP id nn20mr12570607vcb.32.1351152153699;
 Thu, 25 Oct 2012 01:02:33 -0700 (PDT)
Received: by 10.58.220.9 with HTTP; Thu, 25 Oct 2012 01:02:33 -0700 (PDT)
In-Reply-To: <1392235.RizYqAYdkC@off17>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208362>

On Mon, Oct 22, 2012 at 6:38 AM, Mat Arge <argemat1010@gmail.com> wrote:
> Hy!
>
> I would like to sign each commit with a X.509 certificate and a private key
> stored on a PKCS#11 token. I assume that that should be possible somehow using
> a hook which calls openssl. Does somebody know a working implementation of
> this?

Creating signatures from an rsa key on a pkcs11 token should be
possible, but gnupg doesn't support pkcs11 for philosophical reasons.
You need to use gnupg-pkcs11 which is maintained outside of the gnupg
tree.

Once you configure gnupg-pkcs11-scd, you'll be able to use git and gpg
to sign tags as usual.

I configured this a while back for use with CAC cards using the
following resources:

   http://alpha.uwb.edu.pl/map/eToken_gpg_howto.shtml (dead)
   http://alpha.uwb.edu.pl/amicke/eToken_gpg_howto.shtml (replacement
for above?)
   http://gnupg-pkcs11.sourceforge.net/man.html

Try those docs.  If you have questions, I'll try to find my notes.

-Brandon
