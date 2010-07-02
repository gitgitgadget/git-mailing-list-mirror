From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported
 commit
Date: Thu, 1 Jul 2010 22:41:25 -0500
Message-ID: <20100702034125.GA7209@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <AANLkTim2DnettF2gNTQVaJvrpzwrTP_-HWTp8l6R5TVc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 05:42:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUX8a-0001Tu-2x
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 05:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210Ab0GBDlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 23:41:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43031 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756188Ab0GBDly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 23:41:54 -0400
Received: by iwn7 with SMTP id 7so2774583iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SM/N3LXsaX3C+XCxmGBglbBamoSzANXt4z/+sAp00XA=;
        b=KlpWdkeQEtirFXLAV/Rqf9LI6baRhaNRJphWDa7LMA8ckPkNaCR/h5FtNQmUeRAyPT
         DCpAHLQYu81cXz72Wuf6R9nt58Ce3KU9GDSBM0d8SH8eEa68HevsyRziRvi0NWWcJNEm
         2hw1gaOHNgUoJLlgCbkqz0XQBggKQGezb1nXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pgM+OuefFTkMNef6QxdMQKsqjwBb2IEj0lftVWLRsyTWxfXxGq26EfcWESFUf8gA0v
         N/+YDAY9F9Q7vtggVis/Wu3puMo3ctaqT9VBy3H0IMM5Zlx99s+eaxz3cqXCf4ETmVn5
         HNpL2mD8sRN7LKV2fcF1Y8g/AuGQBdh9JrOX4=
Received: by 10.231.33.76 with SMTP id g12mr103313ibd.199.1278042113521;
        Thu, 01 Jul 2010 20:41:53 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm873044ibk.19.2010.07.01.20.41.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 20:41:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim2DnettF2gNTQVaJvrpzwrTP_-HWTp8l6R5TVc@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150104>

Sverre Rabbelier wrote:

> This I don't understand, as soon as the object is written wouldn't it
> be available in .git/objects?

fast-import writes objects directly to pack --- part of the secret to
its speed.

See store_object() in fast-import.c, or you can play around with the
test from my WIP patch to try it out (removing the =E2=80=98sleep 1=E2=80=
=99).
