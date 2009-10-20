From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git hang with corrupted .pack
Date: Tue, 20 Oct 2009 10:23:39 -0500
Message-ID: <fabb9a1e0910200823h280a875p98c61eb5e5e6018a@mail.gmail.com>
References: <20091014042249.GA5250@hexapodia.org> <20091014142351.GI9261@spearce.org> 
	<alpine.LFD.2.00.0910141208170.20122@xanadu.home> <20091014161259.GK9261@spearce.org> 
	<alpine.LFD.2.00.0910141234540.20122@xanadu.home> <20091014180302.GL9261@spearce.org> 
	<alpine.LFD.2.00.0910141435040.20122@xanadu.home> <7vbpk985t1.fsf@alter.siamese.dyndns.org> 
	<81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 17:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0GZC-00033a-Cr
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 17:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZJTPX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 11:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbZJTPX4
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 11:23:56 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:17783 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbZJTPXz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 11:23:55 -0400
Received: by ey-out-2122.google.com with SMTP id d26so853436eyd.5
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bUgYSn2uFq54mAxMFO5BPOVy/aCpTikmcMX8OWadcmk=;
        b=oppE+9MLgxv1IlKmPLRlXbevF9NIbRkTXDGtSGlQzjpK+dQ6ReZjoOUISa7l0p+LS0
         S56cnkL1IePuaTznDZ30Ft6c2yu8U80jBoSRspan5YW/4gnjhVAWUD9boNN4APKanbrr
         i+sABr8iCT3GRMN9YG5ZI/D4+dasNwaKa9DxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=f3PZcTLNzWibSZiBFNjqCxXXgzxu0hPGphBLyYUg77clM/0rZvm6R54n6ViPAv2maN
         4RaiMeVluFYLNSLH/l8qWBPmYKAKGgLTv3vrU9KoHO+ZVL15rx1q49xmVR21e5Im/ijt
         xfV7Xft0j2rVidJHg62mBRQFwkI1bCFpw0TTY=
Received: by 10.216.90.208 with SMTP id e58mr2418211wef.57.1256052239076; Tue, 
	20 Oct 2009 08:23:59 -0700 (PDT)
In-Reply-To: <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130802>

Heya,

On Tue, Oct 20, 2009 at 10:14, Alex Riesen <raa.lkml@gmail.com> wrote:
> - =A0 =A0 =A0 buffer =3D xmalloc(size + 1);
> + =A0 =A0 =A0 buffer =3D xmalloc(size + 8);

> - =A0 =A0 =A0 stream.avail_out =3D size;
> + =A0 =A0 =A0 stream.avail_out =3D size + 8;

That seems wrong at first glance, you go from '+1' to '+8' on the
first part, and then from '+0' to '+8' in the second part, am I
missing something obvious?

--=20
Cheers,

Sverre Rabbelier
