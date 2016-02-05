From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 14/15] git-am.sh: replace using expr for arithmetic
 operations with the equivalent shell builtin
Date: Fri, 5 Feb 2016 13:50:45 +0100
Message-ID: <CA+EOSBk=hPs6oLeDT6w-qgwogOq8eSt6Qzs_M3Uwjs87popMpQ@mail.gmail.com>
References: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqoabwi83q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 13:50:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRfqc-0001q8-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 13:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbcBEMuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 07:50:46 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34279 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbcBEMup (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 07:50:45 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so2480056vkh.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 04:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YZ92dtKBz7avn2BBKHfFeXm6L+8Hz7RIVtDjBM+Rbqk=;
        b=zdR4uNZgDvOMpPnvLXsPetBE1QD1egOjP+vAPal/aD44VHCejqm0h6VerLyrwx45F3
         Km8SeI7+2l+XQI0lu3QLFU4q91kevx5P1Js63sWopb2ddjK6n7U0AVksAn409iTTnbQ5
         yZ5xkgl20TjWhsJZtxO4/b0JlAI+91qlcSe5HQHYcwjriQGR1Nr6y+WOBnZGYTS4SslR
         VG39vLRDnCNKgqEKQZsRikhs4b43RiyFFlnqC+ajTzJnXJybYdwG0cDsQfEKhUz+UmQv
         kDPCLEeCYae7dC63OQX0WJmYL3lTGW/P983//dakAWC+K43t3Fwou4nvEb7qjyKi74sF
         pyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YZ92dtKBz7avn2BBKHfFeXm6L+8Hz7RIVtDjBM+Rbqk=;
        b=X/5kt7AqeYG7kfHxt4A6+b9k5+d7AlSm99pkizPpmoUjAcHH9CPIDiM0nNiIDM1oUO
         6lHOaI7n8kjgltsqqV6dged0SWb4yFdV3mqVLuMgXZrTOvrvi4Cg1LeVjS7Gyl7lgGqI
         dd2qW3StvsOPeUzonarPpJLl3cQuzcogNvcoRNJrzI0muDPnpztsKLLX9W4yyXc/4ygd
         HFE58dkIzlxEidrL2gKBfLhSANcd9vJnVP/7GbXaz3nqS/KjLyjXYMHhsxbgPbwqZlCN
         F86V/BKk7r7F97blvECds7mf4lpNSwtAUyQo+Yegs0UaxA2BUierEGX6k37/JZ+KR7tG
         cn0g==
X-Gm-Message-State: AG10YOTgJXRAlhU+QjW1W9wiqG9ftSd5PhdwCrvfqdPjJvp/4GdE7hkbu41F4HtboL6mJuqT0epM3T+56tvy5A==
X-Received: by 10.31.180.85 with SMTP id d82mr8268229vkf.83.1454676645131;
 Fri, 05 Feb 2016 04:50:45 -0800 (PST)
Received: by 10.31.56.10 with HTTP; Fri, 5 Feb 2016 04:50:45 -0800 (PST)
In-Reply-To: <xmqqoabwi83q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285574>

2016-02-04 20:33 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> As pointed out already, quoting of "$this" inside the arithmetic
> expansion would not work very well, so [14/15] needs fixing.
>
> I do not see 01/15 thru 13/15 here, by the way.  Is it just me?

Excuse me, everyone. Yesterday was a bad day. I did a bit of confusion :=(.
But this is not a patch series, yes. The patch is for git-am in
contrib: so it is not important.

Thank you
>
