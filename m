From: matt mooney <mfmooney@gmail.com>
Subject: Re: [PATCH V2] git-send-email.perl: Add --to-cmd
Date: Thu, 23 Sep 2010 12:57:35 -0700
Message-ID: <AANLkTin7KKqtvJrioiAspGiN8-Gpe+gzd0eC48LaNa7P@mail.gmail.com>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	<AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	<1285227413.7286.47.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	<20100923090931.GA29789@albatros>
	<20100923120024.GA26715@albatros>
	<1285253867.31572.13.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	<1285262237.31572.18.camel@Joe-Laptop>
	<AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
	<1285263993.31572.25.camel@Joe-Laptop>
	<AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
	<1285267520.31572.34.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Julia Lawall <julia@diku.dk>, git <git@vger.kernel.org>,
	Vasiliy Kulikov <segooon@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 21:57:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyrvN-00074z-3j
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 21:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab0IWT5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 15:57:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61248 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab0IWT5h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 15:57:37 -0400
Received: by wyb28 with SMTP id 28so1251433wyb.19
        for <multiple recipients>; Thu, 23 Sep 2010 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ky1hqO43bAAv0twbOak3BWOwlTqRlCaCDJTaQnFqxNw=;
        b=ItzNljpeZVb5AB3M78lt2KPTZYc7dIe4NTCclAySUtpSJ0fez6kDh2rxW346M3w8DN
         +4WFCoI/y6JLlrCIANKs21llWqpMbwgndMVD2ibEfuyparSHh8/2+/powPL5iRwwnnaW
         uf7+miAJ4xtb0pshGVfJZNGRvMNLY3Xo5Jyew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GZAF+H8HIX3UFzWGvBETrVUdNGmGQblqa/hkJuug7MwDt6gy1Ui1hRDGvIbgspSen3
         VZiUmVA430UfRK3bPONdtBrQiWkytXzN8XexHY4qQHxIf2RpOyUc+GNg+pFacR/3xSrp
         jJfQzR7g6kQtQt66E1XRi64rfxCt8gWNrMcvI=
Received: by 10.216.90.132 with SMTP id e4mr1897865wef.73.1285271855740; Thu,
 23 Sep 2010 12:57:35 -0700 (PDT)
Received: by 10.216.236.17 with HTTP; Thu, 23 Sep 2010 12:57:35 -0700 (PDT)
In-Reply-To: <1285267520.31572.34.camel@Joe-Laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156898>

On Thu, Sep 23, 2010 at 11:45 AM, Joe Perches <joe@perches.com> wrote:
> Add the ability to use a command line --to-cmd=3Dcmd
> to create the list of "To:" addresses.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> =A0Documentation/git-send-email.txt | =A0 =A08 +++++++-
> =A0git-send-email.perl =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 25 ++++++++++=
+++++++++++++--
> =A0t/t9001-send-email.sh =A0 =A0 =A0 =A0 =A0 =A0| =A0 18 ++++++++++++=
++++++
> =A03 files changed, 48 insertions(+), 3 deletions(-)

Looks reasonable to me. Nice work getting on this quickly ;)

-mfm

--=20
GPG-Key: 9AFE00EA
