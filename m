From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 12:57:38 -0700
Message-ID: <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
References: <20100323161713.3183.57927.stgit@fredrik-laptop> 
	<20100323173114.GB4218@fredrik-laptop> <20100323184309.GA31668@spearce.org> 
	<4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com> 
	<alpine.LFD.2.00.1003231945480.31128@xanadu.home> <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com> 
	<alpine.LFD.2.00.1003241133430.694@xanadu.home> <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com> 
	<alpine.LFD.2.00.1003241435300.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Mar 24 20:58:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuWiN-0003vu-Gu
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 20:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588Ab0CXT6A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 15:58:00 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:33039 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0CXT57 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 15:57:59 -0400
Received: by pzk38 with SMTP id 38so1196868pzk.33
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 12:57:59 -0700 (PDT)
Received: by 10.142.247.7 with SMTP id u7mr2863970wfh.95.1269460678868; Wed, 
	24 Mar 2010 12:57:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003241435300.694@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143110>

On Wed, Mar 24, 2010 at 11:54 AM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> Another solution could be for xmalloc() to use a function pointer for
> the method to use on malloc error path, which would default to a
> function calling release_pack_memory(size, -1). =A0Then pack-objects.=
c
> would override the default with its own to acquire the read_mutex aro=
und
> the call to release_pack_memory(). =A0That is probably the easiest
> solution for now.

Yea, that sounds like the most reasonable solution right now.

--=20
Shawn.
