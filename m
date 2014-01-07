From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH] git-submodule.sh: Support 'checkout' as a valid update command
Date: Tue, 7 Jan 2014 02:16:28 +0100
Message-ID: <CALas-ijKQgDQsoNd0yrFOntnV8cuQGz8KL2xNWtYqGxXLH9q=w@mail.gmail.com>
References: <1389034726-8744-1-git-send-email-ceztko@gmail.com> <xmqqtxdgfz8a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 02:17:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0LI5-0004Qo-OI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 02:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbaAGBQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 20:16:49 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:51671 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbaAGBQt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 20:16:49 -0500
Received: by mail-oa0-f47.google.com with SMTP id i7so1604168oag.34
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 17:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NUdKfxdLn/2BrB9DVxuSZWbzWVtXDXutLyr0fCgVyoo=;
        b=W5YnMsSmcwwwhmItvNIYHFj8b/FM6OJng+ehhucP2Uso3UQMscWeujKGjxXuZi3SDn
         7SvgFyiLhTnSc4hZehRbO0XxZunX3Rp2TY3PLi6CpRSm5L/hEdYw0+DK3ZKSASCUUOND
         fOkdC14kN/NeyssES2TOYGvWIDbRLre1sPKXK93fn6vuY1vFH3/N6gsgfWHtUzOwbaRk
         tuCr+QQ3YydQGemSJRkHqVep7afN5MqENB4GRUdg8L5hkbJtnsxo+9kHIEKxdx6RbKlK
         BUbBsD5zWO5ZsjOTgUhKKx/nJvxuCJDwGSJ3C3VYxxDE4q+Dc0y7LAsZXC6G5EutIcSe
         W3ag==
X-Received: by 10.60.161.4 with SMTP id xo4mr74771531oeb.5.1389057408583; Mon,
 06 Jan 2014 17:16:48 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Mon, 6 Jan 2014 17:16:28 -0800 (PST)
In-Reply-To: <xmqqtxdgfz8a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240092>

2014/1/7 Junio C Hamano <gitster@pobox.com>:
> Sorry, but -ECANNOTPARSE.
>

A bird told me what -ECANNOTPARSE means. Tell me if this comment sounds better:

According to "Documentation/gitmodules.txt", 'checkout' is a valid
'submodule.<name>.update' mode. Also "git-submodule.sh" already refers
to it and handles it correctly. Fix cmd_init() to also accept 'checkout' as
valid update mode and add a similar validation in cmd_update(), issuing
an error if the value read is unknown.
