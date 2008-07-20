From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sat, 19 Jul 2008 21:20:09 -0700
Message-ID: <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
	 <20080717155538.GE11759@fieldses.org>
	 <alpine.DEB.1.00.0807171915420.8986@racer>
	 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807171940160.8986@racer>
	 <48806897.1080404@fastmail.fm>
	 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
	 <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
	 <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>,
	"Jay Soffian" <jaysoffian@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 06:21:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKQQF-0005ij-UP
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 06:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbYGTEUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 00:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbYGTEUN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 00:20:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64420 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYGTEUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 00:20:11 -0400
Received: by nf-out-0910.google.com with SMTP id d3so307946nfc.21
        for <git@vger.kernel.org>; Sat, 19 Jul 2008 21:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=k16vF0q4byI5YMQIX021HpfxdZFiZFTsQK03GA6dKrA=;
        b=YtQKYsnqaKZW1B+ec31GjafRw6G0lNkvypNK7QvUwFI17CF+Jdfotp6opsu4m6yUT/
         nQ4+sz4FH9Gewd1ZyxXyI83ITdrv13cSPTm7+zsRt0wgVduG/J1+n8+eVpywZcK/aTa1
         W1JRFfUeZBjKKTGyZDIZ20UtxFzUg9QWEjw7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=cHtZyeTHg80D2TQ37KgfakpPluA+PzAzviBzrCOPyE9NYepLCL/Q/GsHeEX7e1iuz6
         vIVeAAAV4z6oLH7cWxUHAUopJQ9Z37kxMVgKmvXepUSl+z+xxwjli4geE2sbXOczZ9nx
         W7Y0x+1AGQwnHFO7ck5qCnzTVl2XmoT0UII4M=
Received: by 10.210.46.12 with SMTP id t12mr1852088ebt.64.1216527609548;
        Sat, 19 Jul 2008 21:20:09 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Sat, 19 Jul 2008 21:20:09 -0700 (PDT)
In-Reply-To: <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: fce3a9c8966f1997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89157>

On Sat, Jul 19, 2008 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> People sometimes find that "git add -u && git add ." are 13 keystrokes too
> many.

It's too bad that 'commit -a' and 'add -a' will have different
meanings.  Are add and commit considered porcelain enough that their
short options could be changed?  Probably not, but it would be nice to
align 'commit -a' and 'add -a' or maybe 'commit -u' and 'add -u'.  I
can just hear people whining about inconsistent flags between
subcommands with this change.

> The support of this has been very low priority for me personally, because
> I almost never do "git add ." in an already populated directory, and if a
> directory is not already populated, there is no point saying "git add -u"
> at the same time.

Your reasoning for not using it (which is probably the case for most
people), combined with the inconsistent short options makes me dislike
the short option a little bit, but I like the long --add option.

Thanks,
Tarmigan
