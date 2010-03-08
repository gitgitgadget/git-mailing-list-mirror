From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Mon, 8 Mar 2010 21:32:43 +0700
Message-ID: <fcaeb9bf1003080632o622c8c79x85b816edcf893bc3@mail.gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
	 <4B9504C9.5000703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 08 15:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Noe0s-0003rq-Cu
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 15:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab0CHOct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 09:32:49 -0500
Received: from mail-pz0-f200.google.com ([209.85.222.200]:40203 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab0CHOcs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Mar 2010 09:32:48 -0500
Received: by pzk38 with SMTP id 38so1046295pzk.33
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 06:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SYJE4AXBBu3CjIBWi8NcX64UcqPTFkuURFhXFm03Hwg=;
        b=D4M3V37LydeOTdWQf3Rzp3fbspSTfFGolU7W4OCH0yoQBNHBvJDagjazAU5tINNycn
         3HG8LpzWG8RII+9ye8Ja1fg5McIZHAOyqQLBuTJibgQnIEOQAOjt+Jw+DrQYfWw2kJ9X
         /Dg1Cp59Kszd7cWMo1Mm8oHDp3Uc5djylYXDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x/EO8kTvnjFBnNUTR7BC+E8+wOhR2HJHnTIn/D7o8N/TAeuRHgQlNHpuRVox+WDn4i
         1uNM2zDyUMBJfXx9F4xURQpcfv5LRG14cxr51/dip+QA27sz9aV5RA7C9M7SHBLVeT0J
         ELvpZxzRfxZpcowjxie3U3DLtd0opFIArGDZc=
Received: by 10.114.188.23 with SMTP id l23mr3301650waf.40.1268058763790; Mon, 
	08 Mar 2010 06:32:43 -0800 (PST)
In-Reply-To: <4B9504C9.5000703@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141768>

On 3/8/10, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> Am 07.03.2010 13:09, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
>
> > This adds support to show columnized output in the mentioned comman=
ds.
>
>
> That's a good idea.
>
>  I'm not so sure about the interface, though.  Does the task really
>  warrant adding a new git command?

Several reasons:
 - Can be reused outside of git (I was surprised Solaris did not have "=
column")
 - Easier to test
 - Minimum code change in modifed commands
 - I can play with more complicated column layout, with minimum code
change in git (ok, that's the third reason).

>  If a --column parameter is added, I think it should expose the full
>  range of options, i.e. fill columns first (ls -C style), fill rows f=
irst
>  (ls -x style) as well as off (ls -1 style) and auto.

Maybe an env variable would be better, so you can pass abitrary
arguments to git-column. "--column=3Dauto" should be supported, of
course.

>  Shouldn't the columnizer use utf8_width() instead of strlen(), like
>  strbuf_add_wrapped_text() in utf8.c?

Right. I missed that.
--=20
Duy
