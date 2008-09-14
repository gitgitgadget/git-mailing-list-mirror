From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 13/16] ls-files: add --narrow-match=spec option for testing narrow matching
Date: Sun, 14 Sep 2008 11:58:14 -0700 (PDT)
Message-ID: <m3vdwymu63.fsf@localhost.localdomain>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	<1221397685-27715-2-git-send-email-pclouds@gmail.com>
	<1221397685-27715-3-git-send-email-pclouds@gmail.com>
	<1221397685-27715-4-git-send-email-pclouds@gmail.com>
	<1221397685-27715-5-git-send-email-pclouds@gmail.com>
	<1221397685-27715-6-git-send-email-pclouds@gmail.com>
	<1221397685-27715-7-git-send-email-pclouds@gmail.com>
	<1221397685-27715-8-git-send-email-pclouds@gmail.com>
	<1221397685-27715-9-git-send-email-pclouds@gmail.com>
	<1221397685-27715-10-git-send-email-pclouds@gmail.com>
	<1221397685-27715-11-git-send-email-pclouds@gmail.com>
	<1221397685-27715-12-git-send-email-pclouds@gmail.com>
	<1221397685-27715-13-git-send-email-pclouds@gmail.com>
	<1221397685-27715-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 20:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kewoe-0001qR-SA
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 20:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbYINS6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 14:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbYINS6S
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 14:58:18 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:14355 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbYINS6R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 14:58:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so166784and.103
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=mxnjI6Sd+9mcExDKR8cIvFKZdiI7d9rCIsCHOpnDw7A=;
        b=EJ/vZPtSjY7nn9/C6zexReUf2TMxzUhieGyn6ckEf135AIuRtGrbBIwovse6CqTlXx
         otSoQ/QsDuKeXDkBnjkqkioe0i12mZtJ9ymtrPuIUNdXRomCvwrnNuRE7wTqqTK5mI/f
         44zDIvkYUCq8tZQ0yfFssqnvapMrk6Qksk8Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=SF1TO6RbZa4njneHW2jJDMA7nH+Q2LrpYG8zFH7gMa4ceES0WroBYhxty7dCF/I23q
         DTUVG3PnAnndBd5wMyFBTgOaFU45IQRl7/5Qm8Dyb8gTDbWhHgPe1xqJVHzU+1rWyVHm
         zdqXrh623jJMsn+W65WJIiwX6Z2UronuJU9ek=
Received: by 10.86.76.16 with SMTP id y16mr3383577fga.10.1221418695217;
        Sun, 14 Sep 2008 11:58:15 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.193])
        by mx.google.com with ESMTPS id 12sm13873440fgg.0.2008.09.14.11.58.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 11:58:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8EIwC8O014146;
	Sun, 14 Sep 2008 20:58:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8EIwCeh014143;
	Sun, 14 Sep 2008 20:58:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1221397685-27715-14-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95855>

I will comment only on documentation?

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +--narrow-match=3D<narrow_spec>::
> +	Narrow spec can be applied on ls-files output so that you can test
> +	your spec. Can only be used with --cached. See linkgit:git-checkout=
[1]
> +	for more information about narrow spec.
> +

Where were those changes to Documentation/git-checkout.txt?

I think it would better read if you said first what for is this option,
i.e. first that this option is to test <narrow_spec>.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
