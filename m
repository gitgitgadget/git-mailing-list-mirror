From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jk/tag-contains (Re: What's cooking in git.git (Jul 2010, #05;
 Wed, 28))
Date: Sat, 31 Jul 2010 01:07:03 -0500
Message-ID: <20100731060703.GA21207@burratino>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
 <20100730183709.GC18544@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 31 08:08:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5FH-000069-Rm
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781Ab0GaGI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 02:08:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56386 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab0GaGIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:08:25 -0400
Received: by iwn7 with SMTP id 7so2054096iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 23:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Jw72baveDitcNovvwJm9doZpBhqrU3u+7/pkHiLEqTY=;
        b=gdlBdS2qPg13BcPI5J6oLu0hPk9o1V9XRN73GFZUo18NfRr620T9+8NGm9/4PEaKUO
         m9Zn9wZz3bW9+OaCc3UQUa4tZ0sxV15IkFPkw/E73MsrSxe3YE77THwwgBey0ORQgVc2
         IoK6Tc6LLsA8/fQr2CFztckalHnC3jk0USDXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MFgaJx9A2XpomPWFCyXOf5svhJ79ar10e7d8t8oFhMXdvm/siBQcHU2oR28RcdwUag
         PYcS62Pyj9TyGakziP0kad7YDxGLLaEO4MinvH3Zd9GtgQYaS5hjSfQcSkscbCsPe377
         q9CG2OkKePpslG0U/H5wvb/xkMLE6gaOOqYuw=
Received: by 10.231.59.1 with SMTP id j1mr3154406ibh.55.1280556501114;
        Fri, 30 Jul 2010 23:08:21 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm2735110ibk.3.2010.07.30.23.08.20
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 23:08:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100730183709.GC18544@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152308>

Jeff King wrote:

> What do we want to do with this?

Probably I have already said too much about this topic, but here I go:

> The third one is where we start defaulting things to "assume no more
> than 1 day of clock skew by default", which can cause incorrect answe=
rs
> in the face of skew.

I think the default should be something that (just barely) works
correctly for linux-2.6.git.

> The fourth is just an illustrative patch for per-repo skew detection.

I have been hoping for a chance to look these over, time hasn=E2=80=99t=
 come my
way yet.

>                                                          I can work u=
p a
> "detect clock skew on clone and gc" patch based on it if we want to g=
o
> that way.

That sounds very sane.

Additional things to do (this is mostly a note to myself):

 - refuse to commit with a timestamp long before any parent

 - refuse to make a commit that would make the total slop too high?

 - check slop and warn about it in fsck (maybe your patch does this
   already)

 - document the maximum-total-slop and maximum-single-commit-slop
   rules!
