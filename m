From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Makefile: Remove usage of deprecated Python "has_key" 
	method
Date: Mon, 29 Mar 2010 08:23:41 +0800
Message-ID: <be6fef0d1003281723h4f8788bdi3c5baa3f92724c11@mail.gmail.com>
References: <1269737112-21631-1-git-send-email-davvid@gmail.com>
	 <7vy6hc4d0h.fsf@alter.siamese.dyndns.org>
	 <20100328215442.GA31195@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 02:24:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw2lu-0001DU-4y
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 02:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438Ab0C2AXp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Mar 2010 20:23:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47764 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381Ab0C2AXo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Mar 2010 20:23:44 -0400
Received: by gwaa18 with SMTP id a18so3722895gwa.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 17:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+UYhuWZnOGbDFcylpUP1ol1QV2gpxN9ruMSzlnvJoxE=;
        b=MACnYPxo2oSVq5+dOe7ooLQc2dh3+IDvfobG8EXUnDeQ8LrcYV0xFxFNyNud8XTOIz
         udP+jL/UXUtHPOfyW5X3agEngdkUN6nMYLbehQ6JluyJUzYBaJuFlEntObvPEItKG/tF
         8aW2J1Lr1UoSHgduINmKNWZBQ0kafGX0pIiCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fjxOMzJw9TsxoA6OMoY+juQBnGz2NkByiEes41IlzpUhQgjIcXZ4WI0snyzB6uLlQ+
         II/FvYUZGyVMSFEOwfsYtfqNPFi1GDx8/jLovxQQX9d0KYjUt/SQr/ipXcj1HeNtb4Cy
         pDHgRX7tE4Tw5GXTFOIelJzolru0v9wTzTRLE=
Received: by 10.231.37.5 with HTTP; Sun, 28 Mar 2010 17:23:41 -0700 (PDT)
In-Reply-To: <20100328215442.GA31195@gmail.com>
Received: by 10.151.4.12 with SMTP id g12mr4336229ybi.319.1269822221734; Sun, 
	28 Mar 2010 17:23:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143424>

Hi,

On Mon, Mar 29, 2010 at 5:54 AM, David Aguilar <davvid@gmail.com> wrote=
:
> On Sun, Mar 28, 2010 at 09:38:54AM -0700, Junio C Hamano wrote:
>> David Aguilar <davvid@gmail.com> writes:
>>
>> > "has_key" is a deprecated dictionary method in Python 2.6+.
>> > Simplify the sys.path manipulation for installed scripts by
>> > passing a default value to os.getenv().
>>
>> It looks like the old code was replacing sys.path[0] but you are
>> prepending this. =A0Doesn't that change also make a difference?
>
> The original code replaced sys.path[0] which is ''
> (aka the current directory). =A0It's a little odd to
> rely on the 0th element being something that is safe
> to remove.

more accurately, it's "directory containing the script that was used
to invoke the Python interpreter":

  http://docs.python.org/library/sys.html#sys.path

--=20
Cheers,
Ray Chuan
