From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 4 Mar 2011 19:26:16 +0700
Message-ID: <AANLkTiksQg1U=uAEVJG8fyjd7HpsTqgBOdyh6wrEMSED@mail.gmail.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
 <4D700469.7090807@gmail.com> <7vhbbj93yb.fsf@alter.siamese.dyndns.org> <AANLkTin8Gnbyji4sz6cnWLcAzC2RAS_wnd_o3avDvsvG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 13:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvU5u-0003s5-N8
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 13:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759409Ab1CDM0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 07:26:49 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41921 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1CDM0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 07:26:48 -0500
Received: by wyg36 with SMTP id 36so2018028wyg.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 04:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=pdMvAMgjvuc+dfvEMauhQSXkziDabTA9HHVmZdwemOY=;
        b=Y7GdD5kajpg8m9RGARUSPWtW3wPFHLfv6zxn1Pd85PZYmT07mynEqXgTfSypfeEjhD
         0P9Y+vFirMjlKns6JnSbmhzlHSStYp0eG72q+IKpxzSZNTFLdVGMZkWRY/oowUUSExgw
         6Nxpc+Da0223HuPggKc55JBmV+HzOHxReZcTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WpZb2sU58y64vHUVwFtxYRf0Paoa0BtT3MBMzF3q/sAmbtdE3DEGQqdVTHUeMDMuV1
         KFta+IVg2tabu37B4BsRJscjQHgBSnkpwvhvG0o6Xt1BFSsa4/bUANmoRuiwcVTUeU5l
         +C0sJW6GHLbJBZhurQtLnF27UTYIILJn9aHJs=
Received: by 10.216.35.82 with SMTP id t60mr515794wea.46.1299241607103; Fri,
 04 Mar 2011 04:26:47 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Fri, 4 Mar 2011 04:26:16 -0800 (PST)
In-Reply-To: <AANLkTin8Gnbyji4sz6cnWLcAzC2RAS_wnd_o3avDvsvG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168437>

2011/3/4 Piotr Krukowiecki <piotr.krukowiecki@gmail.com>:
> I thought it was user-level file, like $GIT_DIR
>
> I'm not into data duplication, but in this case the message is next t=
o the
> previous use:
>
> =C2=A0 =C2=A0 =C2=A0 if (prefixcmp(buf, "gitdir: "))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Invalid gitfile=
 format: %s\nUse gitdir: <PATH>", path);
>
>
> BTW I think it might be enough to have just path in the .git file. If
> .git has path
> to a correct git repo then chances it's coincidence are quite low.
> (The format does not matter if it's internal file of course)

It's actually good that path is prefixed by gitdir. I imagine once
superproject is supported, .git file in subprojects will have another
line

supergitdir: /path/to/superproject
--=20
Duy
