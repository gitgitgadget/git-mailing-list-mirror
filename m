From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 11:11:26 +0100
Message-ID: <40aa078e1001250211w2dcc5e97vf89f64f136bd2f0@mail.gmail.com>
References: <201001250155.47664.robin.rosenberg@dewire.com>
	 <fabb9a1e1001250136n2fb0043av7348db9177f4d096@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 11:11:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZLv3-00045J-8T
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 11:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab0AYKLa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 05:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120Ab0AYKL3
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 05:11:29 -0500
Received: from mail-ew0-f226.google.com ([209.85.219.226]:55862 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab0AYKL2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 05:11:28 -0500
Received: by ewy26 with SMTP id 26so2147255ewy.28
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 02:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+39gtRKDO/eOV3tHAW3ctM4kyRRA0TPSn/V+pcF5p4A=;
        b=hnOdFGuBnkDEMbdSUeR9rnOahNvhEsMzbIsptwfyctdfgWN80tA2W9yFc4JsWjijHg
         9d6ImQrIao1mwZwM5QBtBIM8mg7sz9MA3iBUpLMgeokIlfDuR8hnhBKLWa9Pp59gCfzF
         zWTT1BktOJuSo9X1/H5afkiDXWrhI60azScM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=RNyIO+yrMdDwPCJLWmoWhexU7xuErkLD6PMYuU/ND4y5CAQLA7/kMRvNmK2YWtzxdY
         Xvq5iNZqoGSurywXhbyAKx+5S56ZT6h6w85uSy6oqozQ8QYor9jKRDvqnhOxwET1wXwX
         2rEY8AgRwxit/tQYTWfz5rDbpCU2zr9ESfwjM=
Received: by 10.216.87.79 with SMTP id x57mr5466wee.83.1264414286790; Mon, 25 
	Jan 2010 02:11:26 -0800 (PST)
In-Reply-To: <fabb9a1e1001250136n2fb0043av7348db9177f4d096@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137945>

On Mon, Jan 25, 2010 at 10:36 AM, Sverre Rabbelier <srabbelier@gmail.co=
m> wrote:
> Heya,
>
> On Mon, Jan 25, 2010 at 01:55, Robin Rosenberg
> <robin.rosenberg@dewire.com> wrote:
>> In Windows paths beginning with // are knows as UNC paths. They are
>> absolute paths, usually referring to a shared resource on a server.
>
> Cute, but will it actually work? I've tried to use them // paths on
> windows before with MSysGit, and it's never worked, probably due to
> the same reason why it doesn't work in the cmd prompt (whatever reaso=
n
> that may be).
>

This works for me, Vista 64-bit:

C:\Users\kusma>dir \\mongo\code
The request is not supported.

C:\Users\kusma>explorer \\mongo\code
<login on the gui>

C:\Users\kusma>dir \\mongo\code
 Volume in drive \\mongo\code is Code
 Volume Serial Number is 04C3-0225

 Directory of \\mongo\code

10.01.2010  21:39    <DIR>          .
04.01.2010  01:28    <DIR>          ..
04.01.2010  00:51    <DIR>          qt-rocket
10.01.2010  21:38    <DIR>          very_last_64k_ever
11.01.2010  19:57    <DIR>          scratch
               0 File(s)              0 bytes
               5 Dir(s)  958=A0499=A0627=A0008 bytes free

C:\Users\kusma>

--=20
Erik "kusma" Faye-Lund
