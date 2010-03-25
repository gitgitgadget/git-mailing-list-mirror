From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Thu, 25 Mar 2010 10:02:49 +0100
Message-ID: <81b0412b1003250202m67dc4d2m9042d1242800cd27@mail.gmail.com>
References: <4BAB2234.4070202@drmicha.warpmail.net>
	 <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 25 10:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nuixt-0002lN-Sv
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 10:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab0CYJCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Mar 2010 05:02:52 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:54513 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab0CYJCv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 05:02:51 -0400
Received: by bwz1 with SMTP id 1so641234bwz.21
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MdJjBc+2T/Q4P0BLfLsXI2De5QlD1BJBE7SdyjlTbmc=;
        b=PBr6GHjHVLmpOQBejAdh4plcnn7WdLbKmp8Ka0LvXsq5GbyCJ+vGWJ1gIQtWVARnB1
         Ya/zQdWnhD7GOTJcurZbfOog7+iR75zjAD2OgLXt5N9y0AU8ysRiCElF184c+/7S8zZb
         6DTZ5GDB1I0KvBw5/1WkhIdMV91KUDpxZN2Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RVaGqP4IVe2v5AyUDYabMGe1veC9qj6d7U90ItVgYmmZ1D/ejF7kV1y1jU50jsBCVA
         MhO4inxdWCku3paG7IX/+iyX8+ivOduijWa2CjVBX+0amq3+prZ4bvroyuyBF6TinLPZ
         udR6LPL/fXBwU+LQBwCloBA/gocfcLr2P6S6c=
Received: by 10.204.14.84 with SMTP id f20mr483852bka.209.1269507769984; Thu, 
	25 Mar 2010 02:02:49 -0700 (PDT)
In-Reply-To: <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143172>

On Thu, Mar 25, 2010 at 09:46, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Currently, we really have two philosophies:
> - report only on error
> - be chatty on success
>
> I don't think that's a problem, but "simple" commands (e.g. branch, i=
nit,
> add) should be in the former camp.

Right. Everytime add scrolls out the current terminal buffer I wish I
had it sent to /dev/null.

> =C2=A0builtin/clone.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)

Sometimes I think a statistics like "1 byte inserted" are more appropri=
ate :)

> - =C2=A0 =C2=A0 =C2=A0 init_db(option_template, (option_verbosity < 0=
) ? INIT_DB_QUIET : 0);
> + =C2=A0 =C2=A0 =C2=A0 init_db(option_template, (option_verbosity <=3D=
 0) ? INIT_DB_QUIET : 0);
