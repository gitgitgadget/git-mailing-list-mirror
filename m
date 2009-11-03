From: Pascal Obry <pascal@obry.net>
Subject: Re: git hang with corrupted .pack
Date: Tue, 03 Nov 2009 22:31:30 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AF0A132.1060103@obry.net>
References: <20091014042249.GA5250@hexapodia.org>	 <20091014142351.GI9261@spearce.org>	 <alpine.LFD.2.00.0910141208170.20122@xanadu.home>	 <20091014161259.GK9261@spearce.org>	 <alpine.LFD.2.00.0910141234540.20122@xanadu.home>	 <20091014180302.GL9261@spearce.org>	 <alpine.LFD.2.00.0910141435040.20122@xanadu.home>	 <7vbpk985t1.fsf@alter.siamese.dyndns.org> <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:31:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5QyX-0002Qa-9T
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 22:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbZKCVbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 16:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbZKCVbN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 16:31:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:59266 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbZKCVbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 16:31:12 -0500
Received: by fg-out-1718.google.com with SMTP id 16so746755fgg.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 13:31:17 -0800 (PST)
Received: by 10.86.235.14 with SMTP id i14mr3473032fgh.52.1257283876881;
        Tue, 03 Nov 2009 13:31:16 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-81-3.w86-205.abo.wanadoo.fr [86.205.111.3])
        by mx.google.com with ESMTPS id d6sm7451348fga.25.2009.11.03.13.31.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 13:31:13 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132000>

Le 20/10/2009 17:14, Alex Riesen a =C3=A9crit :
> I seem to have problems with this change (on Cygwin). Sometimes
> accessing an object in a pack fails in unpack_compressed_entry.
> When it happens, both avail_in and avail_out of the stream are 0,
> and the reported status is Z_BUF_ERROR.
> Output with the second attached patch:
>
> error: *** inflate error: 0x862380 size=3D1256, avail_in=3D0 (was 697=
),
> avail_out=3D0 (was 1256)
> error: *** unpack_compressed_entry failed
> error: failed to read object 3296766eb5531ef051ae392114de5d75556f5613
> at offset 2620741 from
> .git/objects/pack/pack-996206790aaefbf4d34c86b3ff546bb924546b7c.pack
> fatal: object 3296766eb5531ef051ae392114de5d75556f5613 is corrupted

I have this problem on some repository on Cygwin too. For now I have=20
reverted to Git 1.6.4 which seems to be working fine.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
