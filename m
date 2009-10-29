From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 7/7] Factor ref updating out of fetch_with_import
Date: Thu, 29 Oct 2009 08:53:59 -0700
Message-ID: <fabb9a1e0910290853p49070443v6d6bf2bf75faf80@mail.gmail.com>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com> 
	<1256798426-21816-8-git-send-email-srabbelier@gmail.com> <20091029142232.GS10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 16:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3XKU-0006fb-6S
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 16:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbZJ2PyQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 11:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbZJ2PyQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 11:54:16 -0400
Received: from mail-ew0-f209.google.com ([209.85.219.209]:37794 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbZJ2PyP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 11:54:15 -0400
Received: by ewy5 with SMTP id 5so134482ewy.37
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4FMa58mPImTVX9SoDHA8WLqpEMJNi9qF2Apg7RexsJA=;
        b=UIKqAxiBYA+1vRS4VvKXJXwZn83sG+qRWiVB36X2/yAPQ0YDIjWxHJgswj5KgkUnHb
         5mVI6i1+oyQzN5E1Mldo8JYI+wHKs/ctVQi/lNOmXj5oyiYfLkKwLg9ml1D4tIZWxsGL
         B0XS4epqZY0SdM+0C8maEHTcwC7dNxCnMLW5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h8bPaeg0S+okbhKIKr3FDyvat24RZ/iu485aAoJIlNfTfTgmPg84FKzpAOojzvH5F8
         QCEiYpsaVgN7UDFQYISzdIuj8uqfryDowfjtfH9OzRbwWcrzmBY3IvB0QHNKMX8DcrHW
         XBIn6ceNlapLOViiw413qN0fD6VHyW0etku+Y=
Received: by 10.216.87.67 with SMTP id x45mr99178wee.18.1256831659118; Thu, 29 
	Oct 2009 08:54:19 -0700 (PDT)
In-Reply-To: <20091029142232.GS10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131604>

Heya,

On Thu, Oct 29, 2009 at 07:22, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Please define a transport_update_refs wrapper function to implement
> this method invocation on the transport instance. =A0Callers should
> not be reaching into the struct transport directly.

With pleasure, should the transport_update_refs wrapper simply 'return
1' without doing anything if transport->update_refs is not set?

> I certainly have to wonder... if this is done in both fetch and
> clone, why isn't it just part of fetch_refs?

Because clone does not use fetch_refs, or am I missing something?

> Please set this before the disconnect method (move it up one line).

Will do.

--=20
Cheers,

Sverre Rabbelier
