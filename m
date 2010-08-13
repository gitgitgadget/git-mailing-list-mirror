From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] hash binary sha1 into patch id
Date: Fri, 13 Aug 2010 16:37:26 -0500
Message-ID: <20100813213726.GB2516@burratino>
References: <20100813094027.GA20906@localhost>
 <20100813200031.GD2003@burratino>
 <20100813212331.GA24127@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marat Radchenko <marat@slonopotamus.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1y0-0002Vy-Tu
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679Ab0HMVjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 17:39:03 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46923 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0HMVjC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 17:39:02 -0400
Received: by gwj17 with SMTP id 17so154397gwj.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wTI2dPSDmVLyff8vngGVhm/SdzhDm3zwclXAIJ3SSHc=;
        b=ax/UdbebTvMTRjn0teJg0/c5/VTsAlrlmC6b16fyiDcNu6xBjgOmK+SCCOOZJ19bLF
         wYl+UkBX6qI0Dg5ZZztLKcXb9W8GQmFRp/QJQHRyrNqgiSMqMvH5rKg/wlsx7lI3hO+k
         d5vGtSAtaKiV7lxYVuBpzfI6x2GSqJ1nljdTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HaQL7cahA1CZv2ukurUZtVyt/y7mnjaLgnXas61D3M0I9qhXEmy4khJnfpocCnfgGA
         Z2rJJhiXNS2jZGSdA1y9ydgzeop8ps5CYhiC9lljhLT+l7vKMC9SRwuj8o0TyeK7z8hv
         CICXbz/gWBlf15/20CqsoeYiCqMmYML+OJh7M=
Received: by 10.151.8.8 with SMTP id l8mr1798569ybi.231.1281735540984;
        Fri, 13 Aug 2010 14:39:00 -0700 (PDT)
Received: from burratino ([66.99.3.225])
        by mx.google.com with ESMTPS id n20sm1667067ibe.11.2010.08.13.14.39.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 14:39:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100813212331.GA24127@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153513>

Clemens Buchacher wrote:
> On Fri, Aug 13, 2010 at 03:00:31PM -0500, Jonathan Nieder wrote:

>> Maybe it should use both the pre- and post-image?
[...]
> So I think we get better behavior if we ignore the pre-image.
> Although the difference is probably minuscule.

As long as you=E2=80=99ve thought it over, I=E2=80=99m happy with it.  =
As you say, the
postimage matching without the preimage matching should be a rare
event.

=46WIW what I was imagining was some structured binary format:

With A some long string, patch 1:

 A  --> AAA

Patch 2:

 AA --> AAA

Ideally one would want an attempt to apply patch 2 to result in a
conflict.  Probably that is far-fetched.
