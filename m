From: Chris Packham <judge.packham@gmail.com>
Subject: Re: change in behaviour of git status and/or gitk bug
Date: Fri, 7 May 2010 09:47:16 -0700
Message-ID: <i2qa038bef51005070947w489883f2n510bb824e667fd5@mail.gmail.com>
References: <n2na038bef51005061820o581b2f0aq940282264b7f083f@mail.gmail.com>
	 <20100507050054.GA25987@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 18:47:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAQhw-0002tD-2N
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 18:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab0EGQrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 12:47:18 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61674 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0EGQrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 12:47:18 -0400
Received: by vws17 with SMTP id 17so216946vws.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8WbaOaPRdAPaYeZnCBeW/QiE/7k56egg3/7U0IEsKNo=;
        b=MTriOxW8cyvASDC7XKMrwBrSInl8DSzCIsJxKJvcP82z2tfMzeBue1H8nOW/SbVVao
         DH9q8hrDRjIsHYCNiy2AW8JefFxPlKxnAblUElZc7G+43eay59RprEQcQKDxksppK9f1
         rOZrTK9tzFXoGuGXnyyi6jwLxIboPiwX2gNF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rdZDBwbEGORzmOEbBwLieAU+bo71sMZOv8WV6IgYlEhF8Vk2T0xFV7d++KApQnMaK6
         NMuceDbf+Kt+M/unE2asbMGBS156q8Hi2PQv1Vsc8JeNqIF7Q6a/7CQkOrpr3Yr/HRCp
         EmnXwG6hRyqUwUumd17oEQgjYsWtubrURGrnQ=
Received: by 10.229.227.10 with SMTP id iy10mr188013qcb.48.1273250836956; Fri, 
	07 May 2010 09:47:16 -0700 (PDT)
Received: by 10.229.28.3 with HTTP; Fri, 7 May 2010 09:47:16 -0700 (PDT)
In-Reply-To: <20100507050054.GA25987@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146541>

On Thu, May 6, 2010 at 10:00 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 06, 2010 at 06:20:34PM -0700, Chris Packham wrote:
>
>> I noticed a while back that with gitk I kept on getting files shown =
as
>> "Local uncommitted changes, not checked in to index" when I'd made
>> modifications to them then backed them out so the working tree conte=
nt
>> was the same as the index. I used to (with git 1.6.x) fix / work
>> around this by running git status.
>>
>> Now, with git 1.7.1, that workaround has stopped working. No doubt
>
> This was lost in v1.7.0, but should be back in v1.7.2. The actual fix=
 is
> 4bb6644 (git status: refresh the index if possible, 2010-04-02).
>
> You can run "git update-index --refresh" to get the same effect. Runn=
ing
> "git diff" also works.
>
> There was some talk (and a patch) recently about gitk running
> "update-index --refresh", but I don't know if it got picked up. See:
>
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/144182
>
> -Peff
>

OK good to know its not just me.

I'd add my vote for gitk running "update-index --refresh" in response
to a user asking it to refresh, which should satisfy the "gitk doesn't
touch anything unless you ask it to" requirement.
