From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --follow for directories
Date: Tue, 19 May 2015 09:16:17 -0700
Message-ID: <xmqqsias8rvy.fsf@gitster.dls.corp.google.com>
References: <CAOMwXhP-BRd356xpfdLgZ0zKYTMVryt8jtmi3T2jhVh91hY04Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Laszlo Papp <lpapp@kde.org>
X-From: git-owner@vger.kernel.org Tue May 19 18:16:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YukBs-00031z-RK
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 18:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918AbbESQQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 12:16:20 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34019 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbbESQQT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 12:16:19 -0400
Received: by igbhj9 with SMTP id hj9so37792648igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jOJlb5dyfZvm/bqT65dsh0wlNCz2+kYpGB2SvvUobh0=;
        b=UUISAtygYHEIzwESW8UcCQ7dWK8T6kF/HH1dRjxNR8mxYSQL1TnbNllDsbR7KgrTOR
         PFEr/B2eCjbe1hSXNpoHQ5NKWguGlV8IvtPez0Q6jD+Scou9BsN5f0LULoYciUfmZf2E
         z/ODg0PjnmZfzt45FD6Q8jbOIIxni4usHpIxy8ybO+/Tr+8c66Bmx7ousuzYL8k6QVc7
         jpDYNX/8zK+d/nk+GenrZjXPcR4RE7zoc5pAj7k9YU5gOd5OM0R2Fm7Y7Zhf4S83Pyxl
         FP0EAckI7GBMDh7pzio/VStue4iHxAI0iBBbAiogSpttdxFwSpFQySFeOYO+rY/578R7
         ltWg==
X-Received: by 10.107.154.70 with SMTP id c67mr36634931ioe.22.1432052179058;
        Tue, 19 May 2015 09:16:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id f126sm10303574ioe.21.2015.05.19.09.16.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 09:16:18 -0700 (PDT)
In-Reply-To: <CAOMwXhP-BRd356xpfdLgZ0zKYTMVryt8jtmi3T2jhVh91hY04Q@mail.gmail.com>
	(Laszlo Papp's message of "Tue, 19 May 2015 14:56:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269368>

Laszlo Papp <lpapp@kde.org> writes:

> Is there any benefit about having it like it is today or is it just
> the usual "no one has implemented it yet"?

It actually is even more sketchy than that.  A single file following
was done merely as a checkbox item that works majority of the time,
and any mergy history that renames the file on one side of the side
branch but not on the other may not truly follow it.
