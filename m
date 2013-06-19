From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 00:38:22 -0400
Message-ID: <51C135BE.4030506@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com> <1371607780-2966-3-git-send-email-rhansen@bbn.com> <CALkWK0mo2SG+Eh1Qmy58Xo-taG_EGEj9RSx65EYhvs2CLK9dUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 06:38:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpAAE-0003pE-Po
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 06:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939Ab3FSEib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 00:38:31 -0400
Received: from smtp.bbn.com ([128.33.1.81]:35826 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778Ab3FSEia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 00:38:30 -0400
Received: from socket.bbn.com ([192.1.120.102]:39101)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1UpAA3-000If2-QD; Wed, 19 Jun 2013 00:38:23 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 33CC83FE94
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CALkWK0mo2SG+Eh1Qmy58Xo-taG_EGEj9RSx65EYhvs2CLK9dUA@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228338>

On 2013-06-19 00:19, Ramkumar Ramachandra wrote:
> Is master~3 a committish?  What about :/foomery?

Yes; as documented, both of those are refs that point to a commit.

> Look at the other forms in gitrevisions(7); master:quuxery,
> master^{tree} are notable exceptions.

gitrevisions(7) says that master:quuxery is a ref pointing to a blob or
tree, so it is not a committish.  However, if quuxery is a submodule, I
would expect master:quuxery to point to a commit object and thus be a
committish.  So perhaps the <rev>:<path> description in gitrevisions(7)
should be updated to accommodate submodules.

master^{tree} is guaranteed to be a tree (if such a tree exists), so it
is not a committish.

-Richard
