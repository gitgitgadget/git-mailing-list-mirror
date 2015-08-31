From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add "--path-encoding" option
Date: Mon, 31 Aug 2015 14:08:28 -0700
Message-ID: <xmqqsi6ztbcj.fsf@gitster.mtv.corp.google.com>
References: <1441053833-63790-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 31 23:08:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWWJf-0000d1-QU
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 23:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbbHaVIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 17:08:31 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35541 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbbHaVIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 17:08:30 -0400
Received: by pacdd16 with SMTP id dd16so150864516pac.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tTkoFpFAGthH5jRD13n4YJ5Yq7SAEwI1Lkc+JHgCi2I=;
        b=J8Nt32i1xuwhrHJGpoSnYh8Y6iQziECXIkA4qd9aSY7E8feDc7P4hVji9cmrU5oxuT
         6tl/zL71QGjyVqsvT1sfRvjGgdjF0hiPPhgnm5AwEof1jpQxhXC13BvZAoBvTAGFMoBe
         9jcbqhPXEn8duLCiUX3gxaP3UIAWPCJI0dRCUglhMIh93YMe17DPWrhyLvy4Mb27Piw5
         0VAgRPvqKIn89Ihnm4T1kTaPD7LBBt7Ltnid7uMe7bCpNCWuZdka+D32k3uzEQox9urh
         uUotRbYg4MwNQTRV4AUi2oD+cpfHdA/y8GPa+bvNfsIbJW4XVA1+RShH4DeHDXE5+ofQ
         VTIg==
X-Received: by 10.66.158.65 with SMTP id ws1mr41003741pab.18.1441055310128;
        Mon, 31 Aug 2015 14:08:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id yt2sm521044pbb.84.2015.08.31.14.08.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 14:08:29 -0700 (PDT)
In-Reply-To: <1441053833-63790-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Mon, 31 Aug 2015 22:43:52
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276942>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Diff to v1:
> * switch example conversions from cp1252 to iso8859-1 (thanks Torsten!)
> * fix git-p4.txt line length and double dashes (thanks Junio!)
> * remove bare UTF-8 sequence (thanks Junio!)
>
> As with v1, I ensured the unit test runs on OS X and Linux.
>
> I noticed one weird point, though. "git ls-files" outputs the UTF-8 characters escaped on Linux and on OS X. Is there a problem with my setup or this a Git bug?

There is no bug, there is no misconfiguration on your part.  It is
very much deliberate, I think.  core.quotepath defaults to false.

Asking is very good, but please don't do so in in-code comment.
