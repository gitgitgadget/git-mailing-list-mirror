From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-diff cr/nl files on linux
Date: Mon, 26 May 2008 08:34:37 +0200
Message-ID: <483A59FD.6020906@viscovery.net>
References: <fcaeb9bf0805240554j71693d5eo2a425ee0efe2f364@mail.gmail.com>	 <483811BF.3090302@dirk.my1.cc> <fcaeb9bf0805252115q60f784aax6b1f267c476960b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 08:36:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0WJd-00067g-Dj
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 08:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbYEZGer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 May 2008 02:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbYEZGeq
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 02:34:46 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:17133 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbYEZGek convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 May 2008 02:34:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K0WI1-0001JF-Gj; Mon, 26 May 2008 08:34:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1F387AFCC; Mon, 26 May 2008 08:34:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <fcaeb9bf0805252115q60f784aax6b1f267c476960b4@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82904>

Nguyen Thai Ngoc Duy schrieb:
> On Sat, May 24, 2008 at 8:01 PM, Dirk S=C3=BCsserott <newsletter@dirk=
=2Emy1.cc> wrote:
>> Nguyen Thai Ngoc Duy schrieb:
>>> Hi,
>>>
>>> Is there any way that can make git-diff show cr/nl ending files on
>>> linux without ^M at the end?
>>>
>>> Thanks
>>>
>> What about 'git diff -w'? It drops any whitespace changes, including=
 ^M's.
>> Not sure whether that is what you meant.
>=20
> That won't help. Here is a snippet of what I see:
>=20
> diff --git a/abc.c b/abc.c
> index 064a769..647b9ae 100644
> --- a/abc.c
> +++ b/abc.c
> @@ -859,7 +859,10 @@ int def
>      )
>      {
>      FAST int asdsa;
> -    FAST int dsdsad;
> +    FAST int dsadadd;          /* ERROR also means AASAS */^M
> +#ifndef JHASHJJH^M
> +    struct sdddd dasdada;^M
> +#endif^M
>      union sddd asdsdad;
>      FAST STATUS dsadadad;
>      unsigned int sdadadad =3D 0;
>=20
> With color turning off, it does not show ^M so probably something to
> do with the coloring. less is at version 394.

less does not show \r if it comes right before \n. But with diff-colori=
ng
turned on, the 'reset color' sequence is inserted between \r and \n; no=
w
less shows ^M for the \r because it's not next to the \n anymore.

-- Hannes
