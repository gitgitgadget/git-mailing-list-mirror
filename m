From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] enter_repo: avoid duplicating logic, use is_git_directory() instead
Date: Mon, 21 Sep 2015 15:42:37 -0700
Message-ID: <xmqqfv278kde.fsf@gitster.mtv.corp.google.com>
References: <20150715132552.GA28574@lanh>
	<1440204002-7638-1-git-send-email-pclouds@gmail.com>
	<1440204002-7638-3-git-send-email-pclouds@gmail.com>
	<xmqq8u8i9okf.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CD+cNdM5EppcStJViRA7yPpyAHyUX=ct4LEK6RCrJrFw@mail.gmail.com>
	<xmqqlhcbxh7l.fsf@gitster.mtv.corp.google.com>
	<CACsJy8D+3o-SKq-MAC1+KzRzMjcU6GUij1OokLWznfZ8V7zUmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, bjornar@snoksrud.no
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 00:42:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9nH-00028Y-HU
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbbIUWmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:42:39 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34987 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932434AbbIUWmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:42:39 -0400
Received: by pacfv12 with SMTP id fv12so131276411pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xSE8q94X1faDB8Vg0d8m5ByJU0epDW3nU1V0cKy2edM=;
        b=iqKdRfxgEnBwoQYuJqG442EMyOvMP391qE8sGIMqjHBmaSbifvuf2K5w57rz2USRMl
         6asPnKxL49epbQDNF3qjYWq0apj431gQzp/Fkpg4CDjYVHBBVdAfZjDjxCErNxpZZ3Vl
         i0gUCrveBsjQGT7nwj59xjYil73dcDEmPiQbU3pEr7qy3H0FnvvA5AG78YJeCvdGlHR7
         gVG6zWuGrBFoPROQKbeY+Ybpj3tWcdPKkbmLaVGS0JjcSxcc8Z7kZxEjmIVBCp8SNmH0
         M77Zf0apnHQUN/aHTOCGszjJX429Js3xQuJnYzLP6MBQhqDeZmXPWRYK8QjdapTKHdx5
         pZZA==
X-Received: by 10.66.251.136 with SMTP id zk8mr27845236pac.143.1442875358594;
        Mon, 21 Sep 2015 15:42:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id f5sm26618537pas.23.2015.09.21.15.42.37
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 15:42:38 -0700 (PDT)
In-Reply-To: <CACsJy8D+3o-SKq-MAC1+KzRzMjcU6GUij1OokLWznfZ8V7zUmA@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 14 Sep 2015 18:57:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278358>

Duy Nguyen <pclouds@gmail.com> writes:

> I know. I sent the re-roll before receiving this. I think I still
> haven't mentioned the impact on remote case. Another update coming,
> maybe next weekend.

Thanks.
