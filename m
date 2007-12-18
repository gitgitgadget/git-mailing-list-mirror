From: "Gerald Gutierrez" <ggmlfs@gmail.com>
Subject: RE: git with custom diff for commits
Date: Tue, 18 Dec 2007 14:29:55 -0800
Message-ID: <000e01c841c5$8c9e0c70$762a14ac@na.acco.com>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com><Pine.LNX.4.64.0712172300510.9446@racer.site><vpq1w9kaphg.fsf@bauges.imag.fr><Pine.LNX.4.64.0712172310090.9446@racer.site><7vbq8o6gxw.fsf@gitster.siamese.dyndns.org><vpqk5ncz8fn.fsf@bauges.imag.fr><7vodco1him.fsf@gitster.siamese.dyndns.org><000001c841b5$89fcef00$762a14ac@na.acco.com><7vzlw7ybx7.fsf@gitster.siamese.dyndns.org><000101c841b7$5f1d1060$762a14ac@na.acco.com> <vpqsl1zfz8r.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>
To: "'Matthieu Moy'" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:29:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kwE-0005RH-0r
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbXLRW26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbXLRW26
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:28:58 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:42688 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbXLRW25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:28:57 -0500
Received: by py-out-1112.google.com with SMTP id u77so4316580pyb.16
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 14:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        bh=FC5DLi/2tT4KdHHLGV2GoBz8qzRvPyLnsVY+qT6LKjE=;
        b=qe/D11Af9HST4rXWHd/PhYLUkNLpdc7tF8HvvYWTjT2h9DjHwbGOReB1hKwg6+tTpVr3kjYxDxlsBpWWU2B4jNyUiwgtUYaKjNI+cO601q+0kZE4FBR5w2CTjzm2x5NSFobtasn8U9jF0GghadiEW5Rcv/cF8Fw5SEHZ1PTZ1H0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=a+moefW6EI1PdFs5zMdnlDej39ps6wIVnVOlBvYee48FtJsqjXm9A73qynDmFQGq9cRFGB9lFbedF/BMTFgE0Ikj1Lf+WTTcMZtKivUvqDMKGDi8RPaNiE4ujskTHCdZ0Z1I619tEU5w68k2Os+ohGSXpH8lPUyS+SGH7Uwn4Ag=
Received: by 10.35.111.14 with SMTP id o14mr9060427pym.24.1198016934619;
        Tue, 18 Dec 2007 14:28:54 -0800 (PST)
Received: from BURGXGUTIERNB ( [63.87.154.251])
        by mx.google.com with ESMTPS id n67sm14498377pyh.2007.12.18.14.28.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Dec 2007 14:28:53 -0800 (PST)
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: 
Thread-Index: AchBwDUSR6tc9ZbMTe2tF1KKsV9vhQAAs5NgAACWtKA=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68835>

 
> if (user_redefined_changed)
>   if (user_defn_of_changed(work, head)) commit(work); else
>   if (builtin_changed(work, head)) commit(work);

That didn't come out quite right. It should be:

if (user_redefined_changed) {
  if (user_defn_of_changed(work, head)) { commit(work); }
} else {
  if (builtin_changed(work, head)) { commit(work); }
}
