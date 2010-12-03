From: Patrick Doyle <wpdster@gmail.com>
Subject: path/to/some/file: needs update
Date: Fri, 3 Dec 2010 13:34:24 -0500
Message-ID: <AANLkTinsUZCUJamUHWN=H7tyL5nKACmEcyvG6hpsTDtv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 03 19:34:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POaT5-0001G2-MW
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 19:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748Ab0LCSeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 13:34:46 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45361 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab0LCSeq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 13:34:46 -0500
Received: by fxm20 with SMTP id 20so2478969fxm.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=8ohWBD3QWHi7XOYjog+qqWAkT+gW9jYzQohbGscG0jA=;
        b=F912MeCIvucmqw95bylpiFp5KGZHZIVv05JGH196LpFaC/Jr7UvIWnxgKaSasywQfa
         /SSjvETybzyEmNBYIVFnEp98QGNSk0CjHnRmosrFlosIdobaM11cNMdxGrowFWxrWdfK
         aLR8DquCSatlK0HQ9GI2dTRtldmNq3oII9TSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=v7ePuCOmKVq0mc4ibTPxH2AuYs3CzITNFwslH6MdqGRSknL+t6gokRDwvzlAIQERXX
         Za13tEfJDmz2vypqLLQakYJEZF8TmJV1e7LUyGrQf4FuQOqCaksTBVAXY+Go/lnx6XVN
         GCYNUF92Go2PqQoZk5IUfR6iNV5r48sVUpvjw=
Received: by 10.223.118.132 with SMTP id v4mr2524743faq.87.1291401284813; Fri,
 03 Dec 2010 10:34:44 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Fri, 3 Dec 2010 10:34:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162822>

Would it make sense to change the "needs update" message to read
"locally modified"?

I walked out of the office yesterday afternoon little knowing that the
two folks left there, who are both VCS neophytes in general, were
about to enter what they described as "version control H#@@".

It all started when one of them tried to pull the latest version of
our repository from the server.  He was quite startled by all of the
messages that read

path/to/some/file: needs update.

Then things got worse... one of the messages said:

error: Entry 'path/to/some/binaryfile' not uptodate.  Cannot merge

"Huh?!?!", they exclaimed to each other.  "I wasn't doing a merge.  I
was doing a pull.  Well, I guess that's kinda like a merge.  But why
did it generate an error?  Shouldn't it have generated a conflict
message?".  At least, I'm imagining that's what they said to each
other.  I wasn't there.  I just got the phone call an hour later when
I was on the train going home.

Needless to say, I was able to calm them down.  But it occurred to me
that "needs update" isn't necessarily the most helpful message and
that "error: ... Cannot merge" could offer a little more explanation.

I'm happy to submit the trivial patch changing "needs update" to
"locally modified".  I suspect there might be some ramifications in
terms of scripts that expect the old message to be there, but
hopefully not.

What do folks think?

--wpd
