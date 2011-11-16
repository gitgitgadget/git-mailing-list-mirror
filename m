From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Wed, 16 Nov 2011 20:33:26 +0700
Message-ID: <CACsJy8A2=qBiyY3SD-PZo+E=U+Dfjm1UQidgq6khQARZ3d41WQ@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com> <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org> <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net> <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com> <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 14:34:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQfcq-0000Sq-Lr
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 14:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102Ab1KPNd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 08:33:59 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62038 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655Ab1KPNd6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 08:33:58 -0500
Received: by fagn18 with SMTP id n18so1464030fag.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 05:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GZu0vfATNm6jB6BgatUZ/hFwQnspWH+bYeIAgL60Qr4=;
        b=FUUkGhteqm/u6skgOTG2KBISA8XW7yg1h664VqVWMJA1R5kk1bJfocTLjBc6lxHpZD
         RGpJJF8m9nyKJD2Pe0Aogh4Ha+DCKh9U1b766lBn7wgtoYz/PVmobE6QAs5K6oe4GjCj
         fBEhr1UtcdGKWqxMc1By44NhS6IQQ1SThMC4I=
Received: by 10.204.154.77 with SMTP id n13mr28865760bkw.83.1321450437117;
 Wed, 16 Nov 2011 05:33:57 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 16 Nov 2011 05:33:26 -0800 (PST)
In-Reply-To: <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185545>

2011/11/16 Jonathan Nieder <jrnieder@gmail.com>:
> Jokes aside, here's a rough series to do the git_path ->
> git_path_unsafe renaming. =C2=A0While writing it, I noticed a couple =
of
> bugs, hence the two patches before the last one. =C2=A0Patch 2 is the=
 more
> interesting one.

Another approach is do nothing and leave it for a static analysis tool
to detect potential problems. I'm looking at sparse at the moment,
although I know nothing about it to say if it can or cannot detect
such problems. We can at least make sparse detect return value from
git_path() being passed to an unsafe function, I think.
--=20
Duy
