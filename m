From: Phil Miller <mille121@illinois.edu>
Subject: Re: [PATCH/resend] CVS Server: Support reading base and roots from 
	environment
Date: Wed, 30 Dec 2009 11:12:26 -0600
Message-ID: <81f018ac0912300912g25887523g1bdf29fd6e31d011@mail.gmail.com>
References: <81f018ac0911200805g55bd1607u651334c1ed7f1303@mail.gmail.com> 
	<7vocmwvmvr.fsf@alter.siamese.dyndns.org> <20091230224108.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 18:15:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ28V-0008Mg-NY
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 18:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbZL3ROG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 12:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbZL3ROF
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 12:14:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:50339 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbZL3ROD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 12:14:03 -0500
Received: by ey-out-2122.google.com with SMTP id 25so1765853eya.19
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 09:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=1taq+X6lUJsifbzGmP2qvIsHxE69WkeAOzM1r7DrY+U=;
        b=HQLW5EGnIR4c88mlY9J/5ye5LpwqE0Qm/3qQezhRLntZVv2ddcAilc8kgzewug4ScV
         4qp5lcDSpwqMEUnzR/MhpqJxUGTLr91CY2C6fbQsxNAZS4pP9imY1/uOtc5uvP1CCeaV
         qHbqJsdmgQgqVamxGVkNp8dwE77jo4tYQ+pMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=RARxx2PQ1rD9Bk/br6PFVJXdyNnyOt2+gTb6odiCE/q30uNNEWEzZ9CC4rp9sgwcFV
         iBU9RFMOkvRORW/8O9IMRLB5yHS0pLGBkFQuzYQtwO7XIUjgb2DdetcwiLSNoQCuO6Lg
         vi1O3nz32rF0gr7yKolcODrSwdFw9Hro8k/UM=
Received: by 10.216.86.16 with SMTP id v16mr1255270wee.162.1262193241925; Wed, 
	30 Dec 2009 09:14:01 -0800 (PST)
In-Reply-To: <20091230224108.6117@nanako3.lavabit.com>
X-Google-Sender-Auth: 9a8504dc5562869d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135908>

On Wed, Dec 30, 2009 at 07:41, Nanako Shiraishi <nanako3@lavabit.com> w=
rote:
> Junio, could you tell us what happened to this thread?
>
> Phil Miller's patch to help gitosis installation. =C2=A0No response f=
rom
> git-cvsserver users.

I never resent with modifications as Junio requested. I've been busy
with some end-of-year close-out stuff, and actually wanted to
dramatically simplify part of the patch before the resend. I'll do
that shortly.

Since Gitosis wants to do repository-level access control before
running any Git commands, I figured out a CVSROOT format that would
let it do this. Given that, there's only one repository that an
invocation of git-cvsserver should be allowed to access, and so the
issue of "list separator" and so forth is moot. The resultant CVS
command line looks something like

cvs -d ":ext;CVS_SERVER=3Dcvs
'/path/to/module':charmgit/path/to/module.git" co -d module

Note that I have had to modify Gitosis to make this, and various other
things, work. I had wanted to clean up my work before announcing it,
but if it would help you now, it is publicly available from github
now:

git://github.com/PhilMiller/gitosis.git

The documentation hasn't been updated, but the recent history makes as
least some usage clear. I'll send more details in a follow-up.

Phil
