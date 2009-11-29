From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Sun, 29 Nov 2009 13:48:55 +0200
Message-ID: <94a0d4530911290348mf3b713aq15fe45ce92743b9d@mail.gmail.com>
References: <20091125203922.GA18487@coredump.intra.peff.net>
	 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
	 <20091125222037.GA2861@coredump.intra.peff.net>
	 <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
	 <20091127062013.GA20844@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
	 <20091127095914.GA4865@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
	 <6839293b0911270827x54947c64q5f93e37664bc20f3@mail.gmail.com>
	 <7vk4xbn7nl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uri Okrent <uokrent@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 12:49:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEiGz-0003jr-8S
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 12:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbZK2Lst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 06:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbZK2Lst
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 06:48:49 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:49625 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbZK2Lss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 06:48:48 -0500
Received: by iwn1 with SMTP id 1so1650106iwn.33
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 03:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qaCzECSacehkovS70HlrEOTqVs9FvEzSEVYS8WFtLjM=;
        b=iq06HizWCX9tsuia+Q5uMvtaB4j1fERFBi3cx3VJeKVnuuxx8WmYjQBoVbLfNZmXKw
         z0l8clQRil38NFVhXjofUJpqdCgqEK17bR/5m6dIDFkls9qLxYIg9cAPDc9uqCfgnoL1
         S/ZlMNaXo6iGFdFKRIpfueNjRhrtS0DrrEdl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kpS0q7qLN+JmGNKlQajFcFHr3pU6FMu6+bkx7QMyMp/C/y7u+okZoM4Hhjgkou4WIw
         xBUvIlj8Uk8LN8DArT3bmjDwMmOqR/Fqzkecgesee1qUAMseG15uerIpWeqjQNdPBWKM
         KQeublmZfo6tsez+j06dQbNqq9rbKAf7k5LBI=
Received: by 10.231.73.131 with SMTP id q3mr3891916ibj.6.1259495335161; Sun, 
	29 Nov 2009 03:48:55 -0800 (PST)
In-Reply-To: <7vk4xbn7nl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134013>

On Fri, Nov 27, 2009 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> That is exactly how we work and what people have been working hard fo=
r
> 1.7.0. =C2=A0Check the planned changes listed in the recent (and not =
so recent)
> "What's cooking" summary reports.
>
> Changing "grep" is too late for 1.7.0, but we are trying to find an e=
asy
> migration path like you mentioned in your message and that is exactly=
 what
> this thread is about.

How about this. For now, make --full-tree available, and that's it.
Then, on 1.8.0, add the configuration option, and if there's consensus
make it default (-1 from me).

However, in order to ease the transition I think Jeff's GIT_PLUMBING
(I would call it GIT_SCRIPTING) should be introduced on 1.7.0 so
people can start exporting it in their scripts. That way people don't
have to worry about adding --(no-)full-tree on their scripts (nor any
other argument that depends on configurations) and when 1.8.0 comes,
there's no script breakage.

--=20
=46elipe Contreras
