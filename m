From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] help: reuse struct column_layout
Date: Wed, 9 Feb 2011 01:39:53 -0600
Message-ID: <20110209073953.GB2135@elie>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
 <1297178541-31124-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 08:40:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn4ei-0003EO-1i
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 08:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab1BIHj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 02:39:59 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63842 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab1BIHj6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 02:39:58 -0500
Received: by iyj8 with SMTP id 8so4077668iyj.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 23:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZveK9jC/zUJYHhnXGqBv8dhcvNdBnO+gOjEb8V5mG0Y=;
        b=tNN5ooawmzRJWrDbxBKfVG8W1V/P1j9B6jPyPEb0urif2aS7GsC4q7LvAaI9ZhInwQ
         sMyDfBwx9Cp3kEyzygTsLLlEJzfra9rtcdt3S0kWsg+mIJ5atW2imoeQK6VLBhrM7GkT
         XS1FgiIDnQiGghmdR+h/EhUyraDCczbgB6CmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=M8jsvHGVg4sWeXkAPEGIxZNf3DI7W+qAPNoGW1hPJhzZV5XuQAUcDOCpmi23Tm1lHD
         s1uZwJI5UnC21o34F7Kd6HqcYXlUOukAjzDohHYIlMVnYuFOcp0vh2Lwz/qQR0iMqfW3
         MLYp6qdElsCQkKZXgsfzbiw6fSNnHZ8m7kVts=
Received: by 10.42.217.197 with SMTP id hn5mr1939744icb.529.1297237197750;
        Tue, 08 Feb 2011 23:39:57 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id d21sm23399ibg.3.2011.02.08.23.39.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 23:39:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297178541-31124-6-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166395>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

[...]
> +++ b/help.c
> @@ -72,29 +73,17 @@ void exclude_cmds(struct cmdnames *cmds, struct c=
mdnames *excludes)
[...]
> +	struct column_layout c;
> +	int i;
> +
> +	memset(&c, 0, sizeof(c));

Might be nice to have a COLUMN_LAYOUT_INIT, I suppose.

Looks sane.  What output changes would be noticeable, if any?
