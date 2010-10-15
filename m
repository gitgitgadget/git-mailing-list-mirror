From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add memrchr()
Date: Fri, 15 Oct 2010 10:56:57 +0200
Message-ID: <AANLkTi=MbSeeUcPpPt_yLyeTv10pNzHqGUu3ihXf8jb+@mail.gmail.com>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org> <20101015051750.GA21830@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 10:57:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6g6g-0000aD-Rr
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 10:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab0JOI5Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 04:57:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49186 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab0JOI5T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 04:57:19 -0400
Received: by vws2 with SMTP id 2so340561vws.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=0i7HWmRPILmNKbaQ2eGoRLJAaC+xOnSlOFmUTz/HLyU=;
        b=tbHkXIgM2+MQgm20Yq+v1OfUAKj2x1RwFy7NhuUF9ekkLO2oecpA6mzkqjc2wmCY5V
         qt+xv35PSURmG3UIzmYK0S3XoA6ZkDYZP3tkYGqLChSSagh/3PEIKE5UodhPRYJ1/M5n
         BT5rSJc+bJl6efobtP8CBIP1q2NCGOgl0LB6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=udu5Gcan1tjBuDV8dtmC+TBYY5hurIWmsLPwZjByO8cpuB48EFXHXefiXyDyQv6GKt
         qPrTaSYdPc+p0CM6ugk4SlE7kEM+K9JTBi1jMaCF/9JZuss5eUQtELOeuilILTYUbSsJ
         Xi99BScan7au11v9f4V03fqSXwLs5EoCGElmI=
Received: by 10.220.199.193 with SMTP id et1mr3505521vcb.56.1287133038508;
 Fri, 15 Oct 2010 01:57:18 -0700 (PDT)
Received: by 10.220.170.21 with HTTP; Fri, 15 Oct 2010 01:56:57 -0700 (PDT)
In-Reply-To: <20101015051750.GA21830@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159106>

On Fri, Oct 15, 2010 at 7:17 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Reimplement another handy convenience function from glibc. =A0memrchr=
()
> searches from the end of a memory area for a particular character. =A0=
It
> is similar to strrchr() but takes a length argument and is
> binary-safe.
>
> The whole-directory rename detection patch could use this to find the
> last directory separator in a (possibly truncated) pathname.
>

Are you sure this would work on Windows where both '/' and '\' are
valid directory separators?
