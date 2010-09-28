From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv2] Makefile: implement help target
Date: Tue, 28 Sep 2010 22:51:36 +0200
Message-ID: <AANLkTinvPobg4vB-aDS23THXHExMo5wmRSo6yF0us1bU@mail.gmail.com>
References: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com> <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 22:52:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0h9j-0008Si-IJ
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 22:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab0I1Uv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 16:51:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35619 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0I1Uv5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 16:51:57 -0400
Received: by gwj17 with SMTP id 17so32851gwj.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8tkj658k91NrwpfyeqMSG6xM5kWBCUJQtgF+U44tN6g=;
        b=AiTwGgXfiVJ1wo6OXsgprh1S3pG57vbDjRKJuV+S644y5TNZo8Yvqx1w4abmdS0Pfc
         JyitaGV6jBhpMVOcFlXMdZS573ggD4GrjakUqyP3UymZoxTRIr5EAF3eigAooNSyoBSr
         /nUdTuffXtzjm+T3MYd2kWcgNdbZp6TYjix1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dlOv59KTSS1KxU7vrO4MtgxeG92AKSTmQ+6k77fkfop0X+W/QEmC7g+Qor06ldILej
         V0/xOKlupe2ubF8T5W05dArwXEBcj8zZTu8zvMTm5vebJceC+wXuBnhX/d2tv1NrNCvz
         sqotbzA7AfXujimZ35MZ3Z6nj3cIiP80RU0Nw=
Received: by 10.150.206.10 with SMTP id d10mr700748ybg.350.1285707116331; Tue,
 28 Sep 2010 13:51:56 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Tue, 28 Sep 2010 13:51:36 -0700 (PDT)
In-Reply-To: <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157468>

Heya,

On Tue, Sep 28, 2010 at 22:38, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Now how's this for portability and such?

I applaud your leet awk skills :).

> Clean targets:
> =C2=A0 =C2=A0clean: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0R=
emove generated files but keep the configure script
> =C2=A0 =C2=A0distclean: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Remove gene=
rated files and the configure script
> Develop targets:
> =C2=A0 =C2=A0cscope: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Genera=
te cscope index
> =C2=A0 =C2=A0tags: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G=
enerate tags using ctags
> =C2=A0 =C2=A0TAGS: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 G=
enerate tags using etags

Perhaps an extra newline after the end of a category? Otherwise, looks =
nice.

I haven't looked at the awk script itself wrt portability though.

--=20
Cheers,

Sverre Rabbelier
