From: Ehud Shabtai <eshabtai.lkml@gmail.com>
Subject: trying to figure out this git thing - some questions
Date: Thu, 14 Apr 2005 22:02:21 +0300
Message-ID: <68b6a2bc05041412025f1cb7c9@mail.gmail.com>
Reply-To: Ehud Shabtai <eshabtai.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 14 20:59:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9YO-0003mT-8M
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVDNTCZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVDNTCZ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:02:25 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:7020 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261526AbVDNTCW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:02:22 -0400
Received: by zproxy.gmail.com with SMTP id 13so321804nzp
        for <git@vger.kernel.org>; Thu, 14 Apr 2005 12:02:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V6kjjkQdWXyGX34S8ULkKM6iJXBcul5YmeiCbomrsgDjqiYnJ3zJpE1q6F8iTPqCc5z1EvCwGAsYUHMHYnEBMqptHZljKYB3y4mpnxtZObLQ4264yOhG7skUJKBEuGOeD3Ez+XdI5rxwD7KEmXPy3Kyf5+0Oba9L1xQSBsHW1Q0=
Received: by 10.36.61.11 with SMTP id j11mr137655nza;
        Thu, 14 Apr 2005 12:02:21 -0700 (PDT)
Received: by 10.36.55.3 with HTTP; Thu, 14 Apr 2005 12:02:21 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm trying to understand how it works and I'll appreciate if someone could help.

1. git uses object abstraction for the different types and so
everything is in one directory (objects). From what I've seen in the
implementation, the different kind of objects are not of the same type
(there aren't any operations which work on two different types) and
thus in each step when an object is used its type is verified.
What's the benefit of having them all in the same tree? An alternative
would be to separate the different object types into different
directories which trivially allows getting a list of all commits, or
trees or blobs.

2. A commit can have more than one parent. Can anyone draw an example
of such a case? When do we get a commit graph which is not linear?

3. How does git handle binary files? I guess it doesn't really care if
it's binary or text, but how would the diff and merge scripts handle
them?
