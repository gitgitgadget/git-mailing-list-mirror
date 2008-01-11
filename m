From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 6/6] Use new compress helpers in builtin-pack-objects.c
Date: Fri, 11 Jan 2008 07:10:49 +0100
Message-ID: <e5bfff550801102210g181a091s28725e24922b9b12@mail.gmail.com>
References: <e5bfff550801101334p5df5adaerf0eeae02ddf28334@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 07:11:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDD6t-0000B0-LG
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 07:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbYAKGKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 01:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbYAKGKv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 01:10:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:7953 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbYAKGKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 01:10:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so829023rvb.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 22:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gilFzDLTxhHTRiSNTxwFOZ+RpDSkBfz8QnpmTTfVElc=;
        b=U25SLqsSmh0NSJlirpb+PoRUr9Tz4UOWl8vSeXEo8c7SotOWPfdMAH17Xb/B/Uw/gA3kgqcoM4fvrkc0Nl2XbKsjIxcv3GtupsUdvY5lLUSJ/CGoHavi3G8G87UyCFByi7hpVgJvC1BbR9C28Ar7XDbRaHtPhC1oj3hXsMCoxpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eSKule0M406MAyiONF1gAkqDAo4rj6bwmpMy6DqXTB+8qS8GDRmA8i3nYWNSOR9tAMKNWWBiFJLF+7w8CiW9jRZboFAw8IFRoMYvi6vYLoWyp7Vui/94lF4zi45vjnwFfE8jutmQF8YWsElGJ+z6w+ZetDWPO2XVHOTV5SyjP3s=
Received: by 10.141.71.8 with SMTP id y8mr1775087rvk.10.1200031849110;
        Thu, 10 Jan 2008 22:10:49 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 10 Jan 2008 22:10:49 -0800 (PST)
In-Reply-To: <e5bfff550801101334p5df5adaerf0eeae02ddf28334@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70122>

On Jan 10, 2008 10:34 PM, Marco Costalba <mcostalba@gmail.com> wrote:
>
> -               while (deflate(&stream, Z_FINISH) == Z_OK)
> -                       /* nothing */;
> -               deflateEnd(&stream);
> -               datalen = stream.total_out;
> -               deflateEnd(&stream);


One thing I would like someone to clarify is why deflateEnd(&stream)
is called two times ?

With my patch is called only once as I have seen in all the others places.

Thanks
Marco
