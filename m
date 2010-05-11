From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: Multiple line ranges and files in line level history browser
Date: Tue, 11 May 2010 14:16:04 +0800
Message-ID: <AANLkTim0MUq7JiKQavArUcxZxu7hvXUrO_AdEX6JbcVv@mail.gmail.com>
References: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
	 <20100509210654.GA1637@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 08:16:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBila-0001E3-NM
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 08:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300Ab0EKGQY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 02:16:24 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:47456 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab0EKGQX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 02:16:23 -0400
Received: by qyk13 with SMTP id 13so7578088qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gLxFDL3A7CSl7ACi9Gd7alXHiqKE6UHn+A8scKp6IA8=;
        b=YjxyhtmRzq6sVXcnF7WuBVL5RPEAuMaHZcI672e5B6ldjCyBHsHBnx33bl5bX/couZ
         CZ89tfO1qWmWscHQcVKu8VD7MP6r9ejTbAV75qBNmJxecDm3VqTZZAFg84iKoCSdWmIF
         9uvxlN6hjzBLjX1aC7LfhPBy87hbfgfRuEJXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VA8YqDsyR5TqBSkB3cI7FHFpqQS3CGsQ6UNrmPSBJudec5ye5LJzumgeRNh7slgkQm
         9Alk5hPFgbxZVXDpdmNrRgmkiw4woIqPyGhkFGTWq7xuUH9pjBWAf4y8tfO6jovit86v
         Lo7jFyAVGwVWFyLmBXdZD7X+apWlqhtUmaGcw=
Received: by 10.229.181.142 with SMTP id by14mr4319325qcb.18.1273558564312; 
	Mon, 10 May 2010 23:16:04 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Mon, 10 May 2010 23:16:04 -0700 (PDT)
In-Reply-To: <20100509210654.GA1637@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146870>

Hi,
On Mon, May 10, 2010 at 5:06 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> I like it. =A0It looks like paranoid script authors would have to che=
ck
> for paths like =91--=92 and =91-L=92 and quote them as =91./--=92 and=
 =91./-L=92, a
> small price to pay for a nice syntax.
>
> Unfortunately, this is completely incompatible with the existing blam=
e
> option syntax. =A0i.e., existing scripts might do things like this:
>
> =A0git blame -L1,8 -C <file>
>
> or
>
> =A0git blame -L1,8 <rev> <file>
>
> Maybe there should be a line range required before every file
> specifier in this syntax, to avoid trouble. =A0Borrowing syntax from =
sed,
> this makes
>
> =A0git log <rev> -L1,8 -L45,+6 <file1> -L/some/,/end/ -L9,29 <file2> =
-L1,$ <file3>
>
> which is also a little clearer to look at, I think.
>
>> 'git log -L1,8 <revision> -- -L1,8' .
>
> This provides a single line range specifier for all files? =A0Sounds
> convenient.

Ah, I don't mean that...
I just want to provide a way to let the users view the line range
history of files like '-L1,8'. But since you remind me users can
always use 'log -L1,8 ./-L1,8' to do this, I think we should abandon
this kind of syntax.

> =A0# who wrote the opening comments?
> =A0git blame -L '/^[/][*]/,/^ [*][/]/' -- '*.c'

I think users can always use a little shell script to achieve this, we
should not bother to implement such a complex thing which can be
easily done by shell script.


Regards!
Bo
--=20
My blog: http://blog.morebits.org
