From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/3] pretty: add conditional %C?colorname placeholders
Date: Mon, 26 Apr 2010 08:30:55 +0200
Message-ID: <z2y81b0412b1004252330m189e68bcv19d7d1cb988820b6@mail.gmail.com>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
	 <1272210175-20484-2-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 08:31:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6HqS-0006VL-I3
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 08:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab0DZGa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 02:30:58 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40667 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab0DZGa6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 02:30:58 -0400
Received: by gwj19 with SMTP id 19so3770773gwj.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UJXd0vhDveR3vAHIj1Bsm6FuHpF3fRaZbNYWS5pOGWY=;
        b=IyQPTmbGBO6J9H9ja4nS4b83rH8Eb+4fz9bdh86LSkKCYyMotrMk+NjgVrqu0hqUKP
         vwwrz6pe0XlVZqLNsql6fqFo2bKo4Z1GxsnO9SHXnj6uXUG7m9InB4p9uWGnw5DQt0N/
         l36Nkmq6LyRMSN8p6rGOE3V/qpNTZ4/inUuAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rc7ydauRecQhf6wb9LRCLfvtn60nxrVkyM6XPBb9ajd/gDtAwIt/C7Mr8IEmB4Z3gg
         +EEiObO40KN1JfNGwSEfHd7e5gUaFwZtI9tGwTc981KGRUImRPjeUy6bnbRMd49Fo/8B
         Fe9WzcrSrIqGYX4CYtxlYZV0dkNvJsgWoDsV8=
Received: by 10.101.170.38 with SMTP id x38mr4272846ano.101.1272263455364; 
	Sun, 25 Apr 2010 23:30:55 -0700 (PDT)
Received: by 10.100.120.9 with HTTP; Sun, 25 Apr 2010 23:30:55 -0700 (PDT)
In-Reply-To: <1272210175-20484-2-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145792>

On Sun, Apr 25, 2010 at 17:42, Will Palmer <wmpalmer@gmail.com> wrote:
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-=
formats.txt
> index 1686a54..53eb903 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -132,6 +132,7 @@ The placeholders are:
> =C2=A0- '%Cblue': switch color to blue
> =C2=A0- '%Creset': reset color
> =C2=A0- '%C(...)': color specification, as described in color.branch.=
* config option
> +- '%C?...: switch to specified color, if relevant color.* config opt=
ion specifies that color is ok

You missed the closing quote character. Besides, how do you think to
distinguish between "%C?diff.color" and "%C?diff.colorcontinuation text=
"?
The "%C(...)" has a placeholde termination rule (the closing bracket), =
yours
does not seem to have one (unless something is missing in the documenta=
tion).

Ah... I see. Definitely something missing. The spec should be: '%C?(...=
)'.
