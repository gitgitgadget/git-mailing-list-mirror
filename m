From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Error when cloning with weird local directory
Date: Mon, 10 Aug 2015 11:16:07 -0700
Message-ID: <xmqqegjbuhzs.fsf@gitster.dls.corp.google.com>
References: <CAFOYHZByteuPZwRvw9tzFWOD6vguw4wPK1J6rLZZvHzyZRBtSA@mail.gmail.com>
	<55C2F54A.7070702@web.de>
	<xmqqtwsczws6.fsf@gitster.dls.corp.google.com>
	<xmqqpp30zwhu.fsf@gitster.dls.corp.google.com>
	<55C5A111.6050902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 20:16:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOrcN-0002pt-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 20:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbbHJSQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2015 14:16:12 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36575 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197AbbHJSQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 14:16:09 -0400
Received: by pacrr5 with SMTP id rr5so108791732pac.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=8lPAynYHTvS+3SB+udwV1m10N/chUcn4dR51Un+zcbY=;
        b=flD5TW0DDbY3NFBp91mYFogB/v8isAzSsMx7c5FA9SOXG4KSLjb7UaPKdBQfbD0HLl
         s1FJNZRVQxrsvvi1ychGMIlmvHY/GnwR3ManHGTvLPLXzMc/j5vfoDMe+Zn5cXzi4brb
         Ok11StvjvBiqWsIFb/rXwFm9dw+1quTsid6RoefI8cITq9pg+3JSPp4MO3wx58oPxP+A
         NXNuBvhlkqzMtKhsowte6bPvm126xc+v/dqnT8puf2OczTpl6mm7KR7GD0/WaZzEo9D0
         tiy6UPaOgz/6Ycr3tbBNUh+AobAy9pAwvNcCFfO9rv0UeRhK52F8GRUMKMcnj4VbK3uR
         EXSA==
X-Received: by 10.68.104.67 with SMTP id gc3mr47123721pbb.103.1439230569031;
        Mon, 10 Aug 2015 11:16:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id x11sm20950051pas.46.2015.08.10.11.16.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 11:16:08 -0700 (PDT)
In-Reply-To: <55C5A111.6050902@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 8 Aug 2015 08:26:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275646>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> So I think that git clone can be slighty more consistant here.

Sure.

>> I _think_ taking notice of "word://" (with doubled slashes) and
>> treating it specially will not introduce any new issue; while it is
>> still OK for users to have a local directory called "word:", if they
>> meant a subdirectory of it, they wouldn't have typed double-slashes
>> there.
