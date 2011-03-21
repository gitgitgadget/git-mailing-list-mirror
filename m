From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: PATH_MAX (Re: [PATCH] system_path: use a static buffer)
Date: Mon, 21 Mar 2011 18:19:09 +0700
Message-ID: <AANLkTimAD9BurpAZnAjMLvr_wCV-ScS2tsBFY_fs9Jen@mail.gmail.com>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
 <1300371853-8965-1-git-send-email-cmn@elego.de> <AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
 <20110318113818.GA6049@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 12:19:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1d9F-0001sH-Qn
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 12:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab1CULTl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 07:19:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37619 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab1CULTk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 07:19:40 -0400
Received: by wya21 with SMTP id 21so5650300wya.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=b+fT6OjQvoAiLUAhYty7FrTlg2wIr7LfcbjrwyON6ek=;
        b=Y3qL7HKbaRGk57xjs6o4bfV3fiyWkFAcPcq1h/Yg0i+rRvp9vlAgE1jhMDvn1N5/dS
         gDEeapwStZndRPQYVW4e5xubEglBK1stHWZPwIgpp0ILjL8v9vV/CDqs2aSqxLSABLXi
         2cpHNoCLbPxAyRehlUyEKk4Xg2J7lGZanPRPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HoApOT29GQmlwB5JyfpaNB2JcjXhP2qoCTmmf3QtUcnj30E2003bdZXsyKhy+UlD8g
         EWGMkADafc6dWiN+uh0MNIGgqzohgcA0NBSXy3DwEFAjd03B/Ao4i8D3JPFWknqnSuwe
         PeiSN3te2f3UljXwmSNfYb6D/jmZZgFNo1KeM=
Received: by 10.217.2.73 with SMTP id o51mr5339838wes.66.1300706379102; Mon,
 21 Mar 2011 04:19:39 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Mon, 21 Mar 2011 04:19:09 -0700 (PDT)
In-Reply-To: <20110318113818.GA6049@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169584>

On Fri, Mar 18, 2011 at 6:38 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> It is indeed possible to have paths with length longer than that. =C2=
=A0The
> way to support that is to use relative paths wherever possible, which
> does sound to me like an interesting long-term goal (mostly because I
> suspect the result would be easier to read and, especially, to reason
> about with respect to race conditions).

A shorter-term goal is to set a path limit config on trees inside the
repo, so people on Linux won't accidentally make paths longer than the
limit their Windows fellows have. I think it would be easy to do the
check around index (old trees in repo are left alone, inspecting
history does not have such a limit).
--=20
Duy
