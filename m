From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: RFD: a submodule-like facility that tracks branches rather than 
	commits
Date: Sun, 2 May 2010 17:04:35 +0100
Message-ID: <q2j86ecb3c71005020904kf543e987s19cd396ef672bd79@mail.gmail.com>
References: <w2n2cfc40321005020402gdc210b79v2652afa849cf7a60@mail.gmail.com> 
	<7veihuuwdj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 18:05:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8bfG-0000U5-Rn
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 18:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab0EBQE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 12:04:58 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44532 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab0EBQE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 12:04:57 -0400
Received: by pxi17 with SMTP id 17so884715pxi.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=onoh9cguPMRQswlk0MNPlDeKWXy19HqZvJ6ABrlX6HI=;
        b=lORFuGzMjB9/7e2mzh/fkzC49UX6Xz5A/R8oVCdByPb4itzkyBKWXAPGOvx2PaLQ1d
         dYtbeeS3Y4Ky49uWn9UVcWyXZmkmvy2VWHun3Vrk5FX8y6AfUvYHnceWmA8tKrPdwsUw
         DC0HCrMgo8X4BIKjje+IR1YUgMyVE6k8AN6jI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=Xrq4pQyOIAYwL+i2WD0w2Os91RLt8vOZax25cDRGxPPYPeevZ6e2jnkXkt4q3a6pi/
         ZANKDVqjyzmu425trDelD/Z8ot885ULR8+i3YiLps86giAOFPAfjRAFXOEiRu0D3Jk4U
         sG5vV3iK+rJ0lnGPw4hwRrsHz4tua+QECFXl0=
Received: by 10.143.24.14 with SMTP id b14mr8301563wfj.346.1272816295641; Sun, 
	02 May 2010 09:04:55 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Sun, 2 May 2010 09:04:35 -0700 (PDT)
In-Reply-To: <7veihuuwdj.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: f821a44f52050ee0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146189>

On 2 May 2010 17:00, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Has consideration ever been given to a submodule-like facility where
>> the configuration information maintained in the supermodule for the
>> submodule is not a gitlink but is instead the name of a branch (or
>> generally, a symbolic reference within the nested submodule).
>
> I think this comes up from time to time, and there was an even a slightly
> more concrete suggestion to us 0{40} in the tree object to denote such an
> entry.
>
> But once people realize that there is no single canonical authoritative
> repository whose branch heads point at the same commits for everybody in a
> distributed environment, the line of thought to touch gitlink entries gets
> retracted or discarded as a misguided idea.
>
> I however don't think it would hurt to enrich .gitmodules with not just
> the repository information but with branch information to help clones
> decide which commit (other than what is recorded in the tree of the
> superproject's commit) on the named remote tracking branch to try out with
> the superproject's commit.
>


Gnome uses jhbuild to build out of git, tarballs and other vcs's. It
has quite a bit of code of recursivly finding & updating all
submodules to the latest tip.

This is want you generally want when you integrate.

When you actually want to lock on a particular revision and not track
upstream branches I believe subtree merge strategy should be used
instead of submodules.

I beleive you should be able to specify symbolic references for the
git submodule to store.
