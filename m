From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 01 Sep 2015 12:06:27 -0700
Message-ID: <xmqq613urmbw.fsf@gitster.mtv.corp.google.com>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com>
	<1441059026-66814-2-git-send-email-larsxschneider@gmail.com>
	<xmqqk2sbt5kv.fsf@gitster.mtv.corp.google.com>
	<523D2C52-893E-4A54-9DD1-2DDBCEA29960@gmail.com>
	<xmqqmvx6rqk7.fsf@gitster.mtv.corp.google.com>
	<1243E147-EFEC-4D0B-9872-6B9A8BBE7737@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 21:06:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqt8-0000KN-9t
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 21:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbIATGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 15:06:30 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34439 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbIATGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 15:06:30 -0400
Received: by padhy1 with SMTP id hy1so4719521pad.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 12:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VnnxOU3WxU87i9vCsjvjkLgrfJoy8mvVb5MefvRDyXo=;
        b=HxVbk2z5p5jgUqkXsFKfTqpNakN5j5nu+CDVH3tgPOqzygD0ts6K6en+VpbbgmIX/6
         wzeS2i9NGbp8fIgIZzCpzMjFJ06zg/9GdRDSjfKCANyBF4EMN/ok1O0+kvqOK8J7zbyc
         4M00ZYX2OxE2vb75fgxtV3Ol4/G743yEILO2JQy9ywC8AdpprVDMgYjcMr5Bx0bZ4ttK
         qVefimVOa5QfaoAlAXKH775/G1duf7YmGIpnU0TSIRVoX9wZdksFvPF7NAoc7kjKV4KD
         ScScZj7MO+MwqgIgynZqSHTcXgL54CqPy499EdMzUwSKCPl5C3YYkNNBPKLfvbtbCcEy
         QYQQ==
X-Received: by 10.68.142.200 with SMTP id ry8mr48742976pbb.136.1441134389551;
        Tue, 01 Sep 2015 12:06:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id qe2sm19027349pdb.27.2015.09.01.12.06.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 12:06:28 -0700 (PDT)
In-Reply-To: <1243E147-EFEC-4D0B-9872-6B9A8BBE7737@gmail.com> (Lars
	Schneider's message of "Tue, 1 Sep 2015 20:55:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277031>

Lars Schneider <larsxschneider@gmail.com> writes:

> I searched the Internet for clues around cp1252 and found that a
> similar patch was submitted to Mercurial just a month ago. The author
> seconds my cp1252 observation:
> http://mercurial.808500.n3.nabble.com/PATCH-stable-convert-use-original-local-encoding-when-converting-from-Perfoce-tp4025088p4025094.html

Thanks for a pointer.  I see this bit in that thread:

     If P4CHARSET is not set explicitly when connecting to a Unicode
     mode server, a default charset will be chosen based on the
     client's platform and/or code page.

So I would guess that it is reproducible for you as you are always
on a client with the same platform and/or code page, and it would be
more honest to phrase it as "As an example, Perforce on my Windows
box uses..."  or something along that line.

Thanks.
