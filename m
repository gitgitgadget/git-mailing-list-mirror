From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Mon, 29 Jun 2015 10:04:48 -0700
Message-ID: <xmqqvbe6bg3z.fsf@gitster.dls.corp.google.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
	<xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
	<CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
	<CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 19:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9cUd-0005Oi-2c
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbbF2RFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 13:05:04 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:32808 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbF2REv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:04:51 -0400
Received: by igcur8 with SMTP id ur8so42195989igc.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gxJJlqUzrKZHAo8AF1X6dpWDIFef71c8WNNq7DNTHZw=;
        b=ZqvZc0o4Aw8R1IA4noIhP2nnRPEfuODzj3naNH4VGCGNrJKhcAsVhkcEaZshaU7pal
         U2QcQCZMS9SdFRWYj4WS7RAR4p/gXN7pZdlboKUq/vewFfAfP5HmRXdseUzXVfBJXnYh
         xMZXMTM/8yb5ylkkBteR5eKRQsN7RyxdwgnPKSq9J0/PhoMgp+jY29mU+Of41/64xfbz
         zHJX/l4lEE1YX8bkGOU6XDdKU1j3aqQNI6xy37i6aaXq4k2VmvrrRD8aoL5/1DiOaaLK
         Tf9SXIU1lKZl0i0W3z0AVnCe1DFwQkbZ6iS15kXo+s/tD0BLHoYR0oUFx5IBy6Sr8Oib
         PWbA==
X-Received: by 10.107.3.227 with SMTP id e96mr22037882ioi.50.1435597490809;
        Mon, 29 Jun 2015 10:04:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id rr5sm5837075igb.7.2015.06.29.10.04.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 10:04:50 -0700 (PDT)
In-Reply-To: <CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
	(Lawrence Siebert's message of "Mon, 29 Jun 2015 09:46:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272975>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> I was using it to sort files
> by commit count when provided a list of files, which git rev-list
> doesn't really work for.

What makes you say rev-list does not work (perhaps 'really' is the
key word there?)

    git rev-list --no-merges maint..master -- Makefile
    git shortlog --no-merges maint..master -- Makefile
    git log --oneline --no-merges maint..master -- Makefile

all gives me results that are consistent among them.
