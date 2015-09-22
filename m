From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Tue, 22 Sep 2015 09:02:09 -0700
Message-ID: <xmqq8u7y5toe.fsf@gitster.mtv.corp.google.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
	<1442829701-2347-2-git-send-email-larsxschneider@gmail.com>
	<xmqqio73abl0.fsf@gitster.mtv.corp.google.com>
	<E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com>
	<CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com>
	<xmqqbncv6yym.fsf@gitster.mtv.corp.google.com>
	<9F835973-7045-4AA7-A0B0-D3D3C6F25D73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 18:02:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeQ1K-0008Rq-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 18:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758615AbbIVQCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 12:02:13 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36300 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758612AbbIVQCM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 12:02:12 -0400
Received: by pacgz1 with SMTP id gz1so10211747pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=AxLski/DISdIEAkx+DnUPLK4S0qaEv5F40m3OScEVa0=;
        b=h1rcHHs38FvOfLg5CRgfGZt678sWodrI/FYzcW62Jx2vqG2gglbLWGtLB4KVvrNboU
         j7G5QNA/gEbqUM5ctmOvROwUCE7xWhBnwXpC+nKjuSX8VdAbmOnHgXaVncDrMXW8j1ap
         Ij1p3rNHnzEQjKHZvf+dZJ/C4sFftSmJymEm62bncfJMbYc74hnNKP5uTZD19d5WwDw/
         uiiTKfCmKzD8gOBVx7uo26oeRei4NQJYZPcZ8ukQmATzB8mxs3MaVsrMU9kkbEr5sGtA
         9qo9zBbqSBdE/H0az2DMeM9YqhKzN0Ty1r4wRteCFZ25aUM5graMsiHZCu8uoPDYQ9MM
         dnJA==
X-Received: by 10.66.102.106 with SMTP id fn10mr26278383pab.156.1442937731430;
        Tue, 22 Sep 2015 09:02:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id bz4sm3134723pbd.6.2015.09.22.09.02.10
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 09:02:10 -0700 (PDT)
In-Reply-To: <9F835973-7045-4AA7-A0B0-D3D3C6F25D73@gmail.com> (Lars
	Schneider's message of "Tue, 22 Sep 2015 12:09:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278399>

Lars Schneider <larsxschneider@gmail.com> writes:

> This works.

OK, and thanks; as I don't do perforce, the squash was without any
testing.

> Do we need the =E2=80=9C-e=E2=80=9D option?

In syntactic sense, no, but our codebase tends to prefer to have
one, because it is easier to spot which ones are the instructions if
you consistently have "-e" even when you give only one.
