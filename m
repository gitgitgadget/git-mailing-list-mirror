From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 13:58:48 +0200
Message-ID: <200903301358.48864.brian.foster@innova-card.com>
References: <200903301024.08848.brian.foster@innova-card.com> <49D09207.9080407@op5.se> <49D0A133.80503@viscovery.net>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>, Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 30 14:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoGAX-0000Bq-T0
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 14:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbZC3L7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 07:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbZC3L7N
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 07:59:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:25363 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbZC3L7M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 07:59:12 -0400
Received: by ey-out-2122.google.com with SMTP id 4so588748eyf.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=lkiuhNkmEVEHVzqoNtkCCmJ8pMV+ozyrFK0TkfyfUh8=;
        b=OLxEOhMn8rseMJENpgd4kL13dMPRI9bonJfzrvN7dfX1mG16j09GY9/fBQMwhp3+kb
         bD/KwLhcvfu/9N/SFVrnvZn61hWgWoWaEewDn18Ujo6N1NXjejT9Q+3gBLJRjpunamtL
         qaroZGjXZQnxKA59WVnRPd2hJUkTiYZbduEDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ud/XRHtBxT5kYgc1wwmPz0FYWpkz1tU2zGtkA3Whan0cs7/grDxhCFz6kKnMLWF6yj
         DKYDBEaswokEJNgI6d4I40sUj8qNHdYAEHlSMP3xON72riMypnhJ1ofN3TCJReNiH69g
         oQicbkUKVWv/Q55Ophjl3Luq5SCaDXjcHgMv4=
Received: by 10.210.128.10 with SMTP id a10mr4060786ebd.53.1238414349584;
        Mon, 30 Mar 2009 04:59:09 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 12sm5199623ewy.103.2009.03.30.04.59.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 04:59:08 -0700 (PDT)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
In-Reply-To: <49D0A133.80503@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115141>

On Monday 30 March 2009 12:38:43 Johannes Sixt wrote:
> Andreas Ericsson schrieb:
> > A possibly better approach for you is to "git format-patch"
> > your own changes and apply them to a clean 2.6.26.8 tree
> > instead of trying to merge 2.6.26.8 into 2.6.21.
[ I'm going from .21 to .26.8, so I think you've got that reversed? ]
>=20
> After you have successfully done *that*, you know how the resulting
> tree must look like, and you give it a tag, say "like-this".
> If you really want to have a merge, then you can just repeat the
> merge with your original branch, at which time you will get tons
> of conflicts.  Now you just 'git checkout like-this -- .' and you
> have all your conflicts resolved in the way you need them.

Andreas & Hannes,

  Thanks for the suggestion.  I'll have to experiment,
 but off-the-top-of-my-head, I think I do want a merge,
 so that it's easier to track the history of individual
 local changes.  Having said that, I'm not entirely sure
 I follow your suggestions.  What I think you mean is:

  (1)  Create a patch which is all (local) changes
         (n=C3=A9e diffs) from linux-mips.21 to our.21;
  (2)  Checkout linux-mips.26.8 (e.g.);
  (3)  Apply the patch created in (1), above;
  (4)  Tag the result `like-this';
  (5)  Checkout our.21;  and
  (6)  Merge with `like-this'.

 I admit that now that I write the steps out, it seems
 to make sense ....?   Am I understanding correctly?

  Thanks for the suggestions.  Other suggestions are also
 quite welcome.
cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
