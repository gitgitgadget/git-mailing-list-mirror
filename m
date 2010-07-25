From: Jens Seidel <jensseidel@users.sf.net>
Subject: Re: [PATCH 2/1] git svn: remove extraneous newline from log output
Date: Sun, 25 Jul 2010 19:35:56 +0200
Message-ID: <20100725173549.GA7930@merkur.sol.de>
References: <20100423134611.GA3440@merkur.sol.de> <20100426132710.GA9930@progeny.tock> <20100427112656.GB16323@merkur.sol.de> <20100725023114.GB18606@burratino> <20100725081057.GA22373@dcvr.yhbt.net> <20100725081344.GB22373@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 19:37:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od58M-00049w-6x
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab0GYRhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 13:37:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34023 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab0GYRg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:36:59 -0400
Received: by bwz1 with SMTP id 1so2451068bwz.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:mail-followup-to:references:mime-version
         :content-type:content-disposition:in-reply-to:sender:user-agent;
        bh=RqI7HdkBi0cszHRHX5zLqK91yDf2B+7aKyXRjBUvePQ=;
        b=he16yTujUUtpDMt4PTotrHIZUKebhag+NxQG8PgCzB0G6xiKwwU22tNLa9MkqWk+QL
         J7QMKTBVWP/lFUGLTvBfK25PSi15rZp96Kw5bbC58vzgS7gADo/ZQP4q+uVJraccD9SS
         6NZctpJO+o5rk8wOtuRrUkGZ7ZG09LcEdD2As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to:sender
         :user-agent;
        b=Fr89Dj1EzJLtHpeGYS09KZddnRkvzjE19zfaXyxNmtYWbWctx7QODZ8faSgeYAFunz
         2mn9o/v5KNsF0ZplZyfS8wxsbYsVaPYWNvCKl34A0rq8Ce7tDmd4JNb8MVyZOb8HRz8m
         eUXdKZ8V48PjI1H/1JCiJAvBHYIHSYvc+Wtt8=
Received: by 10.204.126.196 with SMTP id d4mr4810287bks.100.1280079417603;
        Sun, 25 Jul 2010 10:36:57 -0700 (PDT)
Received: from merkur.sol.de (p4FD7103F.dip0.t-ipconnect.de [79.215.16.63])
        by mx.google.com with ESMTPS id g11sm2134382bkw.22.2010.07.25.10.36.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:36:56 -0700 (PDT)
Received: from jens by merkur.sol.de with local (Exim 4.69)
	(envelope-from <tux-master@web.de>)
	id 1Od57G-00025d-9L; Sun, 25 Jul 2010 19:36:00 +0200
Mail-Followup-To: Jens Seidel <jensseidel@users.sf.net>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20100725081344.GB22373@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151768>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Eric,

On Sun, Jul 25, 2010 at 08:13:44AM +0000, Eric Wong wrote:
> This is to match the output of "svn log", which does not
> add an extra newline before the next log entry.

thanks for the patch but it doesn't work in the general case.

I attached a sample Subversion repository dump where the output of
git svn log and svn log still differs by empty lines.

I also noticed the following error:
Can't use an undefined value as an ARRAY reference at                                                                                            
/usr/lib/git-core/git-svn line 5717, <$fh> line 53.

I'm not sure whether I introduced this error once I patched
git-svn ...
The affected line is the second one in:
           } elsif (/^${esc_color}    (git-svn-id:.+)$/o) {
                        if (@{$c->{l}} && $c->{l}->[-1] eq "\n") {
                                pop @{$c->{l}};
                        }
(is -1 valid?)

Jens 

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="svn.log"

------------------------------------------------------------------------
r5 | jens | 2010-07-25 19:08:18 +0200 (So, 25. Jul 2010) | 4 lines

2 trailing newlines



------------------------------------------------------------------------
r4 | jens | 2010-07-25 19:07:42 +0200 (So, 25. Jul 2010) | 3 lines

trailing newline


------------------------------------------------------------------------
r3 | jens | 2010-07-25 19:06:58 +0200 (So, 25. Jul 2010) | 3 lines

one linebreak
line 2

------------------------------------------------------------------------
r2 | jens | 2010-07-25 19:06:05 +0200 (So, 25. Jul 2010) | 1 line

linebreak
------------------------------------------------------------------------
r1 | jens | 2010-07-25 19:05:21 +0200 (So, 25. Jul 2010) | 1 line


------------------------------------------------------------------------

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-svn.log"

------------------------------------------------------------------------
r5 | jens | 2010-07-25 19:08:18 +0200 (So, 25. Jul 2010) | 2 lines

2 trailing newlines

------------------------------------------------------------------------
r4 | jens | 2010-07-25 19:07:42 +0200 (So, 25. Jul 2010) | 2 lines

trailing newline

------------------------------------------------------------------------
r3 | jens | 2010-07-25 19:06:58 +0200 (So, 25. Jul 2010) | 3 lines

one linebreak
line 2

------------------------------------------------------------------------
r2 | jens | 2010-07-25 19:06:05 +0200 (So, 25. Jul 2010) | 1 line

linebreak
Can't use an undefined value as an ARRAY reference at
/usr/lib/git-core/git-svn line 5717, <$fh> line 53.

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=base64
Content-Disposition: attachment; filename="repos.dump"

SVN-fs-dump-format-version: 2

UUID: 83f09cc9-4635-489b-9736-9fad07b44175

Revision-number: 0
Prop-content-length: 56
Content-length: 56

K 8
svn:date
V 27
2010-07-25T17:03:46.899612Z
PROPS-END

Revision-number: 1
Prop-content-length: 98
Content-length: 98

K 7
svn:log
V 0

K 10
svn:author
V 4
jens
K 8
svn:date
V 27
2010-07-25T17:05:21.869208Z
PROPS-END

Node-path: file
Node-kind: file
Node-action: add
Prop-content-length: 10
Text-content-length: 0
Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
Content-length: 10

PROPS-END


Revision-number: 2
Prop-content-length: 107
Content-length: 107

K 7
svn:log
V 9
linebreak
K 10
svn:author
V 4
jens
K 8
svn:date
V 27
2010-07-25T17:06:05.643604Z
PROPS-END

Node-path: file
Node-kind: file
Node-action: change
Text-content-length: 13
Text-content-md5: dcf4e97bd1c01e863bf8989b23429f9c
Content-length: 13

no linebreak


Revision-number: 3
Prop-content-length: 120
Content-length: 120

K 7
svn:log
V 21
one linebreak
line 2

K 10
svn:author
V 4
jens
K 8
svn:date
V 27
2010-07-25T17:06:58.264468Z
PROPS-END

Node-path: file
Node-kind: file
Node-action: change
Text-content-length: 21
Text-content-md5: 4e70c8b04910e92f9cc7fbd6424352f0
Content-length: 21

one linebreak
line 2


Revision-number: 4
Prop-content-length: 117
Content-length: 117

K 7
svn:log
V 18
trailing newline


K 10
svn:author
V 4
jens
K 8
svn:date
V 27
2010-07-25T17:07:42.901800Z
PROPS-END

Node-path: file
Node-kind: file
Node-action: change
Text-content-length: 19
Text-content-md5: b20aeff36821448c3bc3c85942bc1fc5
Content-length: 19

trailing newline




Revision-number: 5
Prop-content-length: 121
Content-length: 121

K 7
svn:log
V 22
2 trailing newlines



K 10
svn:author
V 4
jens
K 8
svn:date
V 27
2010-07-25T17:08:18.343554Z
PROPS-END

Node-path: file
Node-kind: file
Node-action: change
Text-content-length: 23
Text-content-md5: e1314ce7619ef512653071d690dbd789
Content-length: 23

2 trailing newlines






--UlVJffcvxoiEqYs2--
