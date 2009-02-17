From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 01:21:00 -0500
Message-ID: <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
	 <7veixxaale.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 07:22:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZJLp-0000Un-O8
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 07:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbZBQGVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 01:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbZBQGVF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 01:21:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:40585 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZBQGVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 01:21:03 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1882674rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 22:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1ZgVsXDlc8TRLlsPW/d6ilvn21pRlgGGsVdpWkL42Vo=;
        b=po55EfP4vCrOaA2jnBjgdo5jwg0XSkqX92eST3sC/drYaQ3TGU+zdauIwXCS/6wrSc
         4sUs48pU06Rx0CVD5jNIIBVhneSMwABu3CH6ACHT9XZvfWInA5YosDNURzZgx5FOISN1
         4Boep6oJKT2dVZ/mXWV+mwGoPxDvMyCpSeU/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oI2x/Lzvrpbkf0/8khKQy31/Dsf4Btla+dx5X0CiZE609Oun6LH4KZfguNj4NjU0mv
         0wzMx4/HhZh7mp8GaRzpgaGOlSpwmH0d0OHS9w8Ln8yKB9iA/R7JWHC2o3dn78lyFK/V
         HFv2ejaRM2WY+BOy3qC8CA/589pVf4YrTuKME=
Received: by 10.140.134.15 with SMTP id h15mr2064591rvd.190.1234851661175; 
	Mon, 16 Feb 2009 22:21:01 -0800 (PST)
In-Reply-To: <7veixxaale.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110315>

On Tue, Feb 17, 2009 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> [... explanation of how git pull and git fetch communicate via FETCH_HEAD...]

I'm aware of all that, and I apologize for not making that clear,
since I made you do lots of extra typing. :-(

> Having said that, being able to directly use FETCH_HEAD as an extended
> SHA-1 is often useful when somebody asks an integrator to pull one-shot
> with git-request-pull.  Upon receiving such a request, the integrator can
> say:
>
>        $ git fetch git://repo.or.cz/his.git for-linus
>        $ git log -p ..FETCH_HEAD ;# to inspect
>        $ git merge FETCH_HEAD
>
> to take advantage of the fact that the commit object name that appears at
> the beginning of resulting FETCH_HEAD file is actually the commit we would
> want, because by definition FETCH_HEAD records only one commit when we are
> fetching only one branch.

That makes sense, but I was confused why git merge goes through the
trouble of stripping out the not-for-merge tag which in the above use
case wouldn't be there.

j.
