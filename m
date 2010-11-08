From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: add UTC option for pretty-formats
Date: Mon, 8 Nov 2010 02:41:50 -0600
Message-ID: <20101108084150.GB2430@burratino>
References: <AANLkTikN_B-bUTyy5440AVwTD=KkUWdkf_ukRszTuhYG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Carr <basilarchia@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 09:42:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFNIq-0000GK-H7
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 09:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab0KHImG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 03:42:06 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64468 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab0KHImF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 03:42:05 -0500
Received: by gyh4 with SMTP id 4so3173013gyh.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 00:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TASnfESlCVASdASQat3OPKliv+TOcWvMtEMKtXuP5+E=;
        b=Jn+lKyVq2TzUVwQH6C5i1t85QKpXFfdFQwWPRYoxhgGmoo+f+AU3EnnNPRgMi36MVL
         rz+AxSjgxd/OaKeEQtvUuC9viD6Q1tjR2QrTVYbWMfdkqjtaO7IsICaMf66HuLmdGqI+
         jw5LxwbAHmtsj9B6H2u5R9tyPx0BuQCHk6Pgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=E8R/UpaB+GU1Ld3nPYM0ToRs81hYVsXIcyOliXLJLRI1tv5aRD4P33toWWT2U+t00W
         u1hUztogF5H0dmbVr+5luWj3i58LkIIGOvYsdTP1EauPqSbfag2rwjJVFuJwKbcojFQe
         NDrxQqbdnlJ0gHmxdGgvkzhxnv5nQlOBdV030=
Received: by 10.150.225.14 with SMTP id x14mr3314562ybg.433.1289205723956;
        Mon, 08 Nov 2010 00:42:03 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m25sm3518980yha.43.2010.11.08.00.42.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 00:42:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikN_B-bUTyy5440AVwTD=KkUWdkf_ukRszTuhYG@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160915>

Hi Jeff,

Jeff Carr wrote:

> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -114,6 +114,7 @@ The placeholders are:
>  - '%ar': author date, relative
>  - '%at': author date, UNIX timestamp
>  - '%ai': author date, ISO 8601 format
> +- '%au': author date, UTC

Why not:

	TZ=UTC git log --format=%ad --date=local

or something like:

	git log --format=%AD(rfc2822,tz=UTC)

?  In other words, why should we provide this feature with date=rfc
dates and not date=iso ones?
