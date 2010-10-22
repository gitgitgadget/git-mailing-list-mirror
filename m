From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as
 UTF-8...?
Date: Fri, 22 Oct 2010 12:12:48 -0500
Message-ID: <20101022171248.GA11794@burratino>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
 <20101022161851.GH9224@burratino>
 <1287766916.31218.71.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 22 19:16:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9LER-0004LD-WC
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab0JVRQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:16:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33830 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab0JVRQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:16:38 -0400
Received: by gyg4 with SMTP id 4so812712gyg.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RdEwiypPkWAuWNIBW4ZKaUlxmHI2NxY4frG072a61BA=;
        b=ILihG+FOTowIS8KHvHc7id3Gex7vWV1CrndxDsPYyxI7N3/vsO3P4cCAS9iDH/nZ9V
         a6Sjhq8Bpvg9KP6lbfHmZjDvWIbSGGwZ58ek1pTe5FlOBHn2AnnDhyntPiF2+deJWrgv
         wCOSOv/td61h2198UGTX6GSSKfcx+CVV9eKU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=csA+DLFxGHKfLUuGueLjoIzO/33adpsA60UJcgpO+/geIq/G86fOP062Vw54BBroAo
         30tMd7EBHxHolsfjARrC/FEzGLwa1Ug+afuHhnCEBL3+u0RvgoNRy3/CGsXkKcXJ+6Uf
         noxNYePtIC/MsC1/9dfVoYIZHQdxig5hzgS7M=
Received: by 10.42.216.12 with SMTP id hg12mr2286308icb.117.1287767797330;
        Fri, 22 Oct 2010 10:16:37 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm2802740qck.13.2010.10.22.10.16.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 10:16:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287766916.31218.71.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159714>

Hi again,

Drew Northup wrote:

> That still doesn't fix the crlf issue, for starters. Also, I would like
> to be able to email patches for files that are in UTF-16 and properly
> re-import them. Unless I'm missing something really big there's not much
> that a display filter is going to do for me there.

Right, I think you're missing something big.  textconv is a display
filter.  clean/smudge convert between internal and external
representation (and your clean/smudge scripts could take care of CRLF
themselves if desired).

That said, I wouldn't be surprised if clean/smudge filters don't do
everything you want.  If you do go that way, please keep the list
posted so the mechanism can be improved.

And longer term, maybe people will want something tailor-made after
all?  I just imagine it would be more productive to try out the
generic mechanisms first.
