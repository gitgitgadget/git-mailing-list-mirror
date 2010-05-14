From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Thu, 13 May 2010 23:56:46 -0500
Message-ID: <20100514045646.GA2433@progeny.tock>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
 <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
 <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
 <961B7250-F65E-4C67-8C5C-6701F68C2FC0@gmail.com>
 <alpine.LFD.2.00.1005131438330.3711@i5.linux-foundation.org>
 <AANLkTil1i_vFAvT1CotYdK47LnufVKc17-1168rOVcMX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 06:57:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCmxO-0000Ba-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 06:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab0ENE47 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 00:56:59 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:37651 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab0ENE46 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 00:56:58 -0400
Received: by ywh36 with SMTP id 36so1006025ywh.4
        for <git@vger.kernel.org>; Thu, 13 May 2010 21:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=f333Ho/aecxlV5SIJSwRIuE5nJRZVNjY30v9GGC9wlo=;
        b=Gjs5/Le1lge8eU/+enkBY8LTQ+Le2YM1wTsLhypLcko/3qGT8vm63N8GRj2gp47NGB
         9vNAPYd1P0qaqfAXYjg01N86Tu997rRl+bSLz6yG63+qnE1C/uDOaOcUKwGeQmlJ/R/s
         45XFwgo+71UWnrb1ATfhQCEHQGd3RZvVHIJ3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HoH3AFXOJfDHltwI1CpZc3QIOxBxz6RiBoeE5pq+bUybScqFBtSG1Y1ZWsdqdlqJ72
         d+6ORelGDvQ1ddpI4OjMjT5ueh9elD3pkflHDQF8aGQLE2jFu7SvxPJMXvkcIxKmiZ3t
         Hs2WIRRTAFKKDjRrSnFhhk35sYd0E7UhCpO+E=
Received: by 10.150.120.9 with SMTP id s9mr1373623ybc.299.1273813017857;
        Thu, 13 May 2010 21:56:57 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a26sm14925870ybd.5.2010.05.13.21.56.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 21:56:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTil1i_vFAvT1CotYdK47LnufVKc17-1168rOVcMX@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147048>

Hi Bob,

Robert Buck wrote:

> *   text
> *.foo  binary
>=20
> means autoconvert everything regardless of the autocrlf setting,
> except for .foo files ? So now we can dispense with the autocrlf
> attribute altogether if we so wish?

If I understand correctly, there is no autocrlf attribute, just a
configuration item.  If you put

 * crlf
 *.foo -crlf

in your .gitattributes with current git, this means:

 - if the '[core] autocrlf' configuration is not set, do not convert
   anything;

 - otherwise, convert everything except for .foo files

Eyvind=E2=80=99s series improves that in a few ways.

 - [from Finn Arne Gangstad] If the in-repository copy of a file
   contains any carriage returns, do not try to convert it.  This
   makes it easier to deal with mistakes.

 - For files with crlf enabled through attributes, always convert,
   whether '[core] autocrlf' is enabled or not.

 - Use the '[core] autocrlf' setting to determine the desired
   line-ending for checked-out files (\r\n if true, \n otherwise).
   A new eol attribute is provided to override that setting.

 - The crlf attribute gets a new synonym "text" to avoid confusion.

There is also some change to the result of file type autodetection,
but as long as your .gitattributes uses '* crlf' or '* -crlf', there
is no need to worry about this.

Hope that helps,
Jonathan
