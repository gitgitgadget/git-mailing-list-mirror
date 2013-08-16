From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/6] shallow: only add shallow graft points to new shallow file
Date: Fri, 16 Aug 2013 19:50:50 -0400
Message-ID: <CAPig+cS1y5cuM6zg0k=rKF3O28krdoNe4ghKtttZt74DENJB+g@mail.gmail.com>
References: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
	<1376646727-22318-1-git-send-email-pclouds@gmail.com>
	<1376646727-22318-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 01:57:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VATtK-0004jU-Jy
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 01:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab3HPX5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 19:57:08 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:48477 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab3HPX5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 19:57:07 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so1823003lbd.10
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=dA9dELrY3i1trzyL4HUTqc9WpwGTSfoYo7TdkOj3qpw=;
        b=Wj0SL4my9WcklBG2Pt2GIPPsLaBClkE8aw6fTYht7IFQqlE6JUVP/sp8BEHw1l5i/j
         2NtbA1QyDZTZABgWkrxtGjkG2W3Qdso2CRKFqlHSLQ7TIXykzg/1/ojbM2kfkVzG5ZTQ
         Q//oJXH0ctAGRvbBtXbpVKzgyYY4S16YlfqM886Of7pHjyG78DohpOoTmUy0vUqjE7sw
         JVI96rTrY8nc31XsSzDSEsxPWOvTqwG2315us1mR6PrxvJEK6du9IqOAVsLnjawo6vrJ
         FIwSGs1dL8zwrQg26NXqOUqHyffzvOogsmFA+dyROqntip7P78ttVUYFwnQbO/yJaqX/
         bM3Q==
X-Received: by 10.152.29.201 with SMTP id m9mr170828lah.6.1376697050353; Fri,
 16 Aug 2013 16:50:50 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 16 Aug 2013 16:50:50 -0700 (PDT)
In-Reply-To: <1376646727-22318-2-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: QuMgvyOoKWNeP4wn4qmpe4eUSmU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232445>

On Fri, Aug 16, 2013 at 5:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> for_each_commit_graft() goes through all graft points and shallow
> boudaries are just one special kind of grafting. If $GIT_DIR/shallow

s/boudaries/boundaries/

> and $GIT_DIR/info/grafts are both present, write_shallow_commits may
> catch both sets, accidentally turning some graft points to shallow
> boundaries. Don't do that.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
