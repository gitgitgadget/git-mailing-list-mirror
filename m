From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: [PATCHv2 1/3] git-sh-setup: introduce say() for quiet options
Date: Mon, 15 Jun 2009 00:21:53 +0100
Message-ID: <18071eea0906141621t676a965aqc3056b481b8e8796@mail.gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
	 <1245021374-8430-1-git-send-email-bebarino@gmail.com>
	 <1245021374-8430-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 01:22:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFz1X-0002Y4-Fu
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 01:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbZFNXVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2009 19:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbZFNXVx
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 19:21:53 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47897 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZFNXVw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2009 19:21:52 -0400
Received: by bwz9 with SMTP id 9so3026628bwz.37
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iN5uBCYiQSEwxhspRbL433OUkSUErV+QvXKaOZkAn0E=;
        b=ksLpGIMiPU3joTc7AuwjEnPRfZPldEnkl1W2O2QSLe6RF6QNEjf15gy4TXv51/u++t
         5WdOacBtIzijwhHr2K15rZUsTOBQfnFKumX+FhxIKaudEblYar5sWnvTxK0TIKsdjhm5
         dTcC60VLppwOFEgzKPVB6ShcYTllHlZJJiynE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZqkUYqPhEA4ACvOjLp2KlXKFAV+vi44hu4wrbz+AP3ehhMR8MDoJCQLvp09w2AF1/7
         3pI/fUH4wiGstrARZlHbC2sCYbr6MvvUZeNwqKcq6R5RICZKgIcs6Fg2MQn+uqrwofC8
         HXJ3Lbp3XwXriGrBnnPkgGfV48vALvFT6YC+w=
Received: by 10.204.100.11 with SMTP id w11mr6378429bkn.32.1245021713407; Sun, 
	14 Jun 2009 16:21:53 -0700 (PDT)
In-Reply-To: <1245021374-8430-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121571>

2009/6/15 Stephen Boyd <bebarino@gmail.com>:
> Scripts should use say() when they want to echo to stdout. Setting
> GIT_QUIET will mute say(), allowing scripts to easily implement a qui=
et
> option.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
> =A0git-sh-setup.sh | =A0 =A07 +++++++
> =A01 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 80acb7d..f88184e 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -44,6 +44,13 @@ die() {
> =A0 =A0 =A0 =A0exit 1
> =A0}
>
> +say () {
> + =A0 =A0 =A0 if test -z "$GIT_QUIET"
> + =A0 =A0 =A0 then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "$@"

Except that where you've then replaced various calls with say() they
were originally using printf.  Please use printf here also, and not
echo.

-- Thomas Adam
