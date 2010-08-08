From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] test-lib: Add support for multiple test
 prerequisites
Date: Sat, 7 Aug 2010 21:03:33 -0500
Message-ID: <20100808020332.GA11894@burratino>
References: <1281129565-26124-1-git-send-email-avarab@gmail.com>
 <1281129565-26124-2-git-send-email-avarab@gmail.com>
 <20100808015729.GA9284@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 04:05:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhvG6-0007bz-8q
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 04:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab0HHCE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 22:04:59 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61242 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab0HHCE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 22:04:58 -0400
Received: by ywh1 with SMTP id 1so3155667ywh.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 19:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Fhau2DVbP5eFpbxWntpBrvxps5Dcz1ln/wx6Syci6ig=;
        b=xHQZI0XIXDL0fFDE/AQY+SMHO5uICZ+lf++46rSQzACtp0FUGmeb6FTd+UHPSSsOXK
         9TSTwnaerNTAPVAoHn2iHK7tzJ6nUMOLan6VFIVEyBuJ3GqujSAVmfqU8Vn6OSAYeH4b
         aP8wnCew1A+p8KFkLikXP+WW9cwHu0ea3lNKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uslF1sdRb4P6j/uV73ssYEDLXfv1dw/VjEEfhhpUGxYO2JqCTAerryoHaT6Z2Fkzwb
         Q75oevCX5uJdxzM1f7x9rcyrscIL++OhyakZRQYoyC2Fdj6SmR4Lfq7AUKTTQaOlQyLB
         QCNF4UlH+2Tg6+Dlj9Opq+o9DqPP4LJhhBOps=
Received: by 10.100.137.11 with SMTP id k11mr15867913and.103.1281233097668;
        Sat, 07 Aug 2010 19:04:57 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id r7sm5312151anb.35.2010.08.07.19.04.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 19:04:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100808015729.GA9284@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152876>

Jonathan Nieder wrote:

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -338,7 +338,7 @@ test_have_prereq () {
>  		*" $prerequisite "*)
>  			: yes, have it ;;
>  		*)
> -			! : nope ;;
> +			return 1

The ";;" is optional for the last arm in a case statement, but
it is probably simpler to include it.  Sorry about that.

(The only intended effect was only to use =E2=80=9Creturn=E2=80=9D that=
 terminates and
propagates out of the loop instead of =E2=80=9Cfalse=E2=80=9D that is o=
verridden by a
later =E2=80=9Ctrue=E2=80=9D.)
