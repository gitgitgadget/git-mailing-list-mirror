From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 13:18:16 -0800
Message-ID: <CA+55aFy_63YEaYa4KYEiMP+pR0-MKrf2nd1PgnJ2Ez2XJuVGhQ@mail.gmail.com>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
	<xmqqiof163kk.fsf@gitster.dls.corp.google.com>
	<54E31405.5040502@gnu.org>
	<xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>
	<54E3A5E2.6060806@gnu.org>
	<CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com>
	<54E3AA41.5070209@gnu.org>
	<CA+55aFxdxzeHmckgn5ZSvXKr9VOztNApif+=5xmZ+4v=RhUryQ@mail.gmail.com>
	<1957798859.18730760.1424207408147.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 22:19:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNpY5-0004Nd-3p
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 22:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbbBQVTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 16:19:12 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:40511 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbbBQVSR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 16:18:17 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so32529578igd.4
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 13:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FuGnSX6a0t66wk4G/Iz76AM1YyRGS9aZwG1w5X7XGN4=;
        b=kpqWpWUlkqZGO36/hO6rjgFp417Saa85RKBaNLmdMktBG13QfhcS77T2rliskbX97T
         zAR+v7wLtJC1LzrCUStCk+ROcdxI7U8i0KlI0i06+8e4k0iOZuXCJWHQXyqS9hiaFec8
         JLCl0YRaSNRy69blLs+cqjce7B3pJF3Sk3KymnNZTAyWq3ueZVIU7iQ2Ioyjiq6nDRJf
         ndTP9y+WfMACsBUJshTXh7G6adMRE1D8DIx2umwLbr7PXM3Wi9gyqGQgoYh43acilVjF
         0oh9T6NwRKtxxt21uytYQ7+/VDrbkwBbaJNKLrDyqAcxv1af+DVbAjtzCgHSjXOtojSF
         PIRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FuGnSX6a0t66wk4G/Iz76AM1YyRGS9aZwG1w5X7XGN4=;
        b=hutAUjt6/lTFb/Eb2EdBlS/vpRhJ+yWmLlL/cja7os+iGBeRC9zz3lhoKnRK60LExO
         dSO2cEJzzadiV/AffLipnaeDnU2CXkH1yNPmUUF3Ua5BRAy6rD5qUzwdK8ITa9D3W7kZ
         k2BygYIefCEAhx49oLDDPAfuQTcWBmBiM+BmM=
X-Received: by 10.107.7.154 with SMTP id g26mr28610271ioi.64.1424207896753;
 Tue, 17 Feb 2015 13:18:16 -0800 (PST)
Received: by 10.36.60.10 with HTTP; Tue, 17 Feb 2015 13:18:16 -0800 (PST)
In-Reply-To: <1957798859.18730760.1424207408147.JavaMail.zimbra@redhat.com>
X-Google-Sender-Auth: CvyXMbrH8v8BHc6_j39Uox4ZNbA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263988>

On Tue, Feb 17, 2015 at 1:10 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Sure.  But if I got a pull request saying "please pull
> git://example.org/foo.git HEAD" I would think that the sender
> messed up the pull request.  So *in the context of git-request-pull*
> ${remote:-HEAD} makes little sense to me.

Umm. If somebody actually leaves off the third argument THAT IS NOT AT
ALL what it prints.

It will show

    The following changes since commit <base>...

        .. base commit description ..

   are available in the git repository at:

      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

    for you to fetch changes up to cc4f9c2a91b7be7b3590bb1cbe8148873556aa3f:
    ...

IOW, it does exactly the right thing. It gives the contents of HEAD,
but it doesn't actually say HEAD anywhere.

And just look at lkml. The above kind of branch-less and tag-less pull
requests are still fairly common. It's the original git model, and it
may be a bit archaic, and I much prefer people to send me signed tags,
but hey, that's what "don't mention a branch or tag" means.

And no, I don't think git request-pull is at all different from other
git commands. "git log" means the same thing as "git log HEAD". Exact
same thing, and nobody would actually write out that HEAD (except
inside scripts, perhaps).

So basically I agree that git request-pull has changed behavior, but
the new behavior is *more* in line with other git commands, and the
old behavior was actually really really odd with that whole extensive
"guess what the user means". No other git command ever did that
guessing thing (ok, famous last words, maybe somebody can come up with
one), and not mentioning a branch/tag/commit explicitly pretty much
always means "HEAD".

                      :Linus
