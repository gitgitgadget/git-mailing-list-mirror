From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: MIME problem when using git format-patch / git am
Date: Tue, 27 Apr 2010 10:32:50 -0500
Message-ID: <20100427153250.GA14756@progeny.tock>
References: <20100425233549.GA8737@triton>
 <20100426014941.GA29220@progeny.tock>
 <alpine.DEB.2.00.1004260948070.22806@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?B?2Hl2aW5kIEEu?= Holm <sunny@sunbase.org>,
	git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Apr 27 17:36:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6mpM-0003lp-FK
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 17:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421Ab0D0Pbx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 11:31:53 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:33444 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0D0Pbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 11:31:52 -0400
Received: by pzk42 with SMTP id 42so8958462pzk.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CKjFudiGYMdcyYb8xv1+d3nYu5RpmjrmN7uMFbMVUWg=;
        b=sH5Uk/BA54zj79nWNzPHLpO6Y8hoEX5YXHevrN+hxAgp3x31wu2HuHtrcIELCLv9XR
         nsgDvhB9+OLPaWGXRBblz8Jjb70gyLfMK5EIMKXTXpajNEkmQwf8JE6imw8VeSG/ILNt
         vLl8dUocN3ekj2DoCFbQ/0HwxQr//+2nFQOVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EncHxK5idElM2j1GyiljpS+LQ4jBTOY7FSjPbnuvknRbM2J47emUG0kmzLYmzvPbdg
         rATqq6zJDkYOuxKtpLABes44YMZ0Zv6qMR0BT6KAgGy0ovC4h+OyzUFWPGbAMxf1WU0P
         upuaUMs2db56Jp//QI0ZaS04mW+B5GAERSLck=
Received: by 10.114.248.9 with SMTP id v9mr1985972wah.164.1272382309343;
        Tue, 27 Apr 2010 08:31:49 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4061845iwn.11.2010.04.27.08.31.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 08:31:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1004260948070.22806@ds9.cixit.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145926>

Peter Krefting wrote:
> Jonathan Nieder:

>> This leads to a question: what if one wants to include a word that
>> quotes to more than 75 characters?
>
> You just split it into two encoded words. The whitespace between the
> encoded words is there for syntactic reasons only, it is not
> included in the final result if both parts are encoded words (look
> at the "Examples" section of the RFC for some examples of how it
> works).

Thank you.  He explains it before then, too; I should be reading more
carefully.

I=E2=80=99ve been working through a full implementation of that RFC, bu=
t it
seems that to support breaking words, Git would need to learn where the
character boundaries are.  Which means encodings would not be just opaq=
ue
strings as far as git cares any more.

On the bright side, the only encoding I care about is UTF-8, and that
one=E2=80=99s easy.

Jonathan
