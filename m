From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed
 <paths>
Date: Sun, 15 Aug 2010 14:49:13 -0500
Message-ID: <20100815194913.GB1856@burratino>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
 <20100814210505.GA2372@burratino>
 <7vvd7chcj4.fsf@alter.siamese.dyndns.org>
 <87tymwzjbk.fsf@catnip.gol.com>
 <AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
 <7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Ralf Ebert <info@ralfebert.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 21:50:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkjEQ-0000bC-0z
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 21:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab0HOTuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 15:50:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57990 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab0HOTuu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 15:50:50 -0400
Received: by iwn7 with SMTP id 7so918894iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M4o7P8jvxnbvgVXeNM/e40RW9Jf0KYnRhIMV77tWkGs=;
        b=MfBXk7b3OXng0qMUuFD7PBaNtWgoOompBDz1yli80Vn7BmBoViSecYK7fRs0HSjYcS
         uX60DBbdUUnQC2e4EfIYReFK1GPMg0TRi+EOYGwjayT53lr83OOnROC7c77eDBTY5B0J
         o1kZF3mNrV8Z+juZgrE042AYMd0kXuNYkcOIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ncEKzZb1+/ehMPOMveqHWZ65olUh/Jj8hD33eILlX6QKuVbUx+yb7hd9vnxPfmnvqG
         Bs9IxtGQLhbFV0U0HSFefJh7s7vyxP28EYDhQmYseA42nCzGK9DslA8/2miP0CvJaq35
         +5IrjADtVN9P5xPPHCrT0Ar+Y8Sdrmkv/NFJ8=
Received: by 10.231.174.72 with SMTP id s8mr4922176ibz.41.1281901849753;
        Sun, 15 Aug 2010 12:50:49 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm3726636ibe.23.2010.08.15.12.50.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 12:50:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153617>

Junio C Hamano wrote:

> If you want to reset the index at selected paths, don't use any optio=
n, as
> nothing but --mixed makes sense.  Hence we deprecated use of --mixed =
when
> used this way.  But if _it_ makes sense, why deprecate it?  What harm
> would it do if we took it silently?

Nothing major.  It would be the same inconsistency as we currently have
between "checkout <commit> -- <pathspec>" and "checkout <commit> --":
one updates the HEAD (or rather, for "reset", the current branch),
while the other doesn=E2=80=99t.

So my preference is to make "reset --foo" not take a pathspec, but it
is not a strong one.
