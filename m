From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: How to capture date/time of push vs. local commit?
Date: Thu, 08 May 2008 16:06:48 +0200
Message-ID: <1210255608.6737.12.camel@futex>
References: <6844644e0805080648g72c4b767l4bcf48ade319bf77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Doug Reiland <dreiland@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 16:09:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju6mi-0003oU-Vi
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 16:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbYEHOGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 10:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753848AbYEHOGx
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 10:06:53 -0400
Received: from mail21.bluewin.ch ([195.186.18.66]:32821 "EHLO
	mail21.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbYEHOGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 10:06:51 -0400
Received: from futex.feinheit.ch (83.78.107.78) by mail21.bluewin.ch (Bluewin 7.3.121)
        id 480C94D600364C6B; Thu, 8 May 2008 14:07:30 +0000
Received: (nullmailer pid 10344 invoked by uid 1000);
	Thu, 08 May 2008 14:06:48 -0000
In-Reply-To: <6844644e0805080648g72c4b767l4bcf48ade319bf77@mail.gmail.com>
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81529>

Doug,

On Thu, 2008-05-08 at 09:48 -0400, Doug Reiland wrote:
> I have a main repository that folks clone and push to. Using git-log
> for example on the main repository can show some confusing (too me at
> least) date.
> 
> For example, I clone. I make changes to my repository and commit on
> Monday. I don't push my changes to the main repository until
> Wednesday.
> 
> git-log on main repository show changes made on Monday.
> This makes it hard to determine when folks really got stuff into the
> main repository.
> 
> Is there way to change this so (in my example), I can determine those
> changes weren't in place until Wednesday? Something in configuration
> file or perhaps just a different option to git-log.
> 
> Thanks in advance.

This is the nature of a distributed version control system. The
timestamps cannot be used to establish a ordering of commits.

If you have reflogs enabled on the server (see man git-reflog) the
information there can help you find out when the pushes have been made.
There is no mechanism to transfer these reflogs into your local
repository, since reflogs are always local to a single repository. If
you have access to the server, you can examine the reflogs there. (f.e.
using git log -g or git reflog)

-- 
http://spinlock.ch/blog/
