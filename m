From: Mat Arge <argemat1010@gmail.com>
Subject: Re: signing commits with openssl/PKCS#11
Date: Thu, 25 Oct 2012 11:15:06 +0200
Message-ID: <5241827.QQWApXNz34@off17>
References: <1392235.RizYqAYdkC@off17> <CA+sFfMdSc30xmzFrqbPFYigLkW9v_YSrnTBtumhZiU5TKiBxqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 11:15:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJXE-0002yZ-SQ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934834Ab2JYJPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:15:13 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:52985 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933743Ab2JYJPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:15:11 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so430116eaa.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:content-type;
        bh=LoQpqBbDWOxN8Xz90hDQD2wE3ZGEhXq5l+2RcrGO1Uc=;
        b=Fju4w1IQHh3d5g+ecutMEYdsWUvN8vHWWpnPXaubYRHvbSyWPK9rz8QStUizh4oOP2
         Gb172CjMfwIoCESaVnKIb0O692QQShoEHQC18JgOSEbAyAjr/kQq8go0fDPwHmEhhlj4
         t1rx3X4yy8OJgW62iUG2SdAJCgMNudLe4cNuwyeDQs/oMOqWFrz1EmS8mV//t1rzeaDp
         6KPQHJyX0EwLPvTlg476p7P892q4xYROf0+DghlutFdfO0FXAl4dpxedog+080vlVCmQ
         0t8eU3WRXoE9LC5w0wZW91dqu8KIRAeUW9X3jIX7RAXrqto6TSmaDK2OHZhNsD5Hq3w7
         oiLQ==
Received: by 10.14.194.2 with SMTP id l2mr25556702een.12.1351156509507;
        Thu, 25 Oct 2012 02:15:09 -0700 (PDT)
Received: from off17.localnet ([188.118.223.98])
        by mx.google.com with ESMTPS id 7sm29567519eeg.5.2012.10.25.02.15.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 02:15:08 -0700 (PDT)
User-Agent: KMail/4.9.2 (Linux/3.4.11-2.16-default; KDE/4.9.2; i686; ; )
In-Reply-To: <CA+sFfMdSc30xmzFrqbPFYigLkW9v_YSrnTBtumhZiU5TKiBxqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208373>

On Thursday 25. October 2012 01:02:33 Brandon Casey wrote:
> On Mon, Oct 22, 2012 at 6:38 AM, Mat Arge <argemat1010@gmail.com> wrote:
> > Hy!
> > 
> > I would like to sign each commit with a X.509 certificate and a private
> > key
> > stored on a PKCS#11 token. I assume that that should be possible somehow
> > using a hook which calls openssl. Does somebody know a working
> > implementation of this?
> 
> Creating signatures from an rsa key on a pkcs11 token should be
> possible, but gnupg doesn't support pkcs11 for philosophical reasons.
> You need to use gnupg-pkcs11 which is maintained outside of the gnupg
> tree.
> 
> Once you configure gnupg-pkcs11-scd, you'll be able to use git and gpg
> to sign tags as usual.
> 
> I configured this a while back for use with CAC cards using the
> following resources:
> 
>    http://alpha.uwb.edu.pl/map/eToken_gpg_howto.shtml (dead)
>    http://alpha.uwb.edu.pl/amicke/eToken_gpg_howto.shtml (replacement
> for above?)
>    http://gnupg-pkcs11.sourceforge.net/man.html
> 
> Try those docs.  If you have questions, I'll try to find my notes.
> 
> -Brandon

Thanks for the tip, I will try them (though the appear to be very outdated).
Do you know, if gnupg-pkcs11-scd is able to cooperate with the standard pcscd 
from pcsc-lite, or is a one-or-the-other situation?

cheers
Mat
