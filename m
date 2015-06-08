From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 01/11] for-each-ref: extract helper functions out of grab_single_ref()
Date: Mon, 08 Jun 2015 11:02:11 -0700
Message-ID: <xmqqlhfuaxjw.fsf@gitster.dls.corp.google.com>
References: <5572F904.1080608@gmail.com>
	<1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:02:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z21NL-0007EK-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbbFHSCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:02:15 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34728 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbbFHSCN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:02:13 -0400
Received: by igbhj9 with SMTP id hj9so65498529igb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GneTbOJEkAGXtwnRZMMbxbvQtDegZg/kJ7j3TJ796gk=;
        b=n6aNobpnGTPY5OqNTjCLZDGZneY0WuEzFcOGLGqi6Mx3vkKNtE3ln4kfOUlzxUs1qA
         97jZTYN4/PT8jyUPgQKuG8Pyj+RjL11dNky4m6B3pUe3pngXafW9TpjMY/Uq5s4yrRED
         XloJuXeuVPwGsJpUlW25JfCCl/QKHYbH1OOx4CiOmrHgBklqgpuxqn7PKGy7hdiBfx3k
         qbEVtue+XOPRZfX1e5OELB9PqyaKjok8ql4EB+euMSMLgq98X4bfh97M+P8YuNZb6mhF
         Bl5uyyCB4CM8EjLLRmidj6nAV/F0nCE8YJmFMQ7fhjkhyxBclIiERfFj2I0rPi/iyiF0
         R8PQ==
X-Received: by 10.42.81.201 with SMTP id a9mr25674354icl.9.1433786533373;
        Mon, 08 Jun 2015 11:02:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id r4sm821780igh.9.2015.06.08.11.02.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 11:02:12 -0700 (PDT)
In-Reply-To: <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 6 Jun 2015 19:18:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271099>

Karthik Nayak <karthik.188@gmail.com> writes:

> + * Given a refname, return 1 if the refname matches with one of the patterns

You can "match refname with pattern".  But "refname matches the
pattern" without "with", I think.

I am not a native, though.

> + * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
> + * and so on, else return 0. Supports use of wild characters.

s/wild/wildcard/.

	Return 1 if the refname matches with one of the patterns,
	otherwise 0.  The patterns can be literal prefix (e.g. a
	refname "refs/heads/master" matches a pattern "refs/heads/")
	or a wildcard (e.g. the same ref matches "refs/heads/m*",
	too).

perhaps?
