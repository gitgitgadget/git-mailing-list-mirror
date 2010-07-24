From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] Makefile: Include subdirectories in "make cover"
 reports
Date: Sat, 24 Jul 2010 18:41:05 -0500
Message-ID: <20100724234105.GA14277@burratino>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
 <1280004663-4887-3-git-send-email-avarab@gmail.com>
 <201007250037.57086.trast@student.ethz.ch>
 <AANLkTim8UIiplPxUdcEWnDpevOUUZARgObhIFCkfO3zl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 01:42:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcoMW-0002wN-1G
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 01:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab0GXXmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 19:42:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33043 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab0GXXmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 19:42:21 -0400
Received: by iwn7 with SMTP id 7so1536194iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=s8hGVsbnNWswpsUuDrNbYpbiP14kiQ6jXh+WnbojrWo=;
        b=pZ4Hj5ZyC2N/xlHjBEohbWW+C1JsaLhsMd3RSp2AF2MT3IVaGtNBZAKyWneo1C6MTI
         trjPQeNTYhm0UuvAmcoafWsvY62abjlJySKpMeXDUp7zjDoePqbRcoLiErcfNCA0q6js
         6nPg+dczPlhKRPg8DJo8GjlK4flL74RRXno0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lVGWICvtnjN6+8BtXiG8AEzvt8OeWzhSEUgihNd0yXtyWbI+VF71eUr5kriEysoHyV
         6S6GnPsw5A6mwg/rc2zv7OaeEPV/W6tZnlIX8X9posYN4gQwEFZ+Woe3RI+Q3WSf91Cg
         Fe1tb7GQcZ8GsRwWzqyfJ0PIc7AyD3ShXcFjI=
Received: by 10.231.161.73 with SMTP id q9mr6257223ibx.70.1280014940199;
        Sat, 24 Jul 2010 16:42:20 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm1855675ibi.0.2010.07.24.16.42.19
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 16:42:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim8UIiplPxUdcEWnDpevOUUZARgObhIFCkfO3zl@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151690>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Sat, Jul 24, 2010 at 22:37, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>> =C6var Arnfj=F6r=F0 Bjarmason wrote:

>>> =A0coverage-clean:
>>> - =A0 =A0 rm -f *.gcda *.gcno
>>> + =A0 =A0 $(RM) *.gcov *.gcda *.gcno
>>> + =A0 =A0 $(RM) builtin/*.gcov
>>> + =A0 =A0 $(RM) builtin/*.gcda
>>> + =A0 =A0 $(RM) builtin/*.gcno
>>
>> By the same logic, the xdiff and compat directories should also be
>> included here. =A0Maybe also block-sha1?
>
> Yeah, actually now that I think about it any C code we compile could
> spew those *.gcda *.gcno files, which means:

You can find a list of directories where the Makefile was thinking abou=
t
building things with "dirs :=3D $(sort $(dir $(OBJECTS)))".  See
dep_dirs for an example.

Hope that helps,
Jonathan
