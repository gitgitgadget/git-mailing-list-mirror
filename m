From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] clone: do not accept --depth on local clones
Date: Mon, 23 Aug 2010 08:43:31 +1000
Message-ID: <AANLkTinqO=zB9JKUwYV6wKuRspKKX1j22Y62_6Z1nN7z@mail.gmail.com>
References: <1282269067-5527-1-git-send-email-pclouds@gmail.com>
	<7vwrrk95eg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, mikachu <mikachu@gmail.com>,
	computerdruid <computerdruid@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 00:43:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnJGN-0003ni-58
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 00:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab0HVWnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Aug 2010 18:43:35 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:62630 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0HVWnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Aug 2010 18:43:33 -0400
Received: by wwb22 with SMTP id 22so142658wwb.1
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 15:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RaaNA7JtpEIsuJSAiqn+NxVByPWrcFvGBMZa3rPBci4=;
        b=eFO7GqReQEOEi5K3BpXn5kHHcwB9tJJEwsV/CEBHFbWOpc5As5OHxEfz8OOJc2LX8j
         Dpu87IcI/1QmsPzRvK99rvmAWdtmJu25s1ob93zmTw0StnTpZF3oxYz70DhCwM0nNTHI
         coBtDV/2Sz9nXH2HofjNdgSk/wTKR7XIitvg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TcekteseGOEBUeMeVxGiONatj30FbLiHM3a7vHJVhFfOwNnR8/dh9VrA4vQ5MUONfi
         pZnp4lYvO4011zvJ3e0Y6+WwZdljRClYDofSnfw0FsBYQg2zGp/1T4wqjXfKSElN/gV6
         OrHDOA1dLuviR5WUDw3GpwzHjbJzoNiZDsgrM=
Received: by 10.216.21.204 with SMTP id r54mr3732349wer.95.1282517011847; Sun,
 22 Aug 2010 15:43:31 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Sun, 22 Aug 2010 15:43:31 -0700 (PDT)
In-Reply-To: <7vwrrk95eg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154198>

On Sat, Aug 21, 2010 at 10:27 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> clone_local() function disregards --depth. Make it more apparent.
>> Also hint users that file:// works with --depth.
>
> Hmm---why?
>
> The "--depth" option is an ugly hack that tries to conserve network
> bandwidth and disk usage, which is not necessary if you are doing a l=
ocal
> hardlinking clone. =C2=A0Without this patch we allowed people to clon=
e with the
> option without a downside (allowing it didn't result in broken reposi=
tory,
> for example), but with it, what has long been allowed suddenly stops
> working. =C2=A0Is the breakage justifiable?

I also expect it to cut down history too. Maybe it's just me, when I
say --depth=3D3, 'git log' should give me more or less 3 commits
regardless what kind of transport I use to clone. Or we could make it
a warning, "--depth is ignored in local clone"?
--=20
Duy
