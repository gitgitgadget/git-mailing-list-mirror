From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Proposal for pruning tags
Date: Wed, 11 Jun 2014 11:25:56 +0200
Message-ID: <539820A4.6090708@alum.mit.edu>
References: <CAHd499BLX3q2FHLfFpq_14w2mmosywfRqMHVjkke0BRhAAjx7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 11:26:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuenG-0001eO-Ew
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 11:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbaFKJ0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 05:26:01 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43874 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751287AbaFKJ0A (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 05:26:00 -0400
X-AuditID: 12074413-f79bc6d000000b9e-0a-539820a7bf26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C7.30.02974.7A028935; Wed, 11 Jun 2014 05:25:59 -0400 (EDT)
Received: from [10.1.225.95] ([178.19.210.162])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5B9Pvna004340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Jun 2014 05:25:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <CAHd499BLX3q2FHLfFpq_14w2mmosywfRqMHVjkke0BRhAAjx7g@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqLtcYUawQddsfouuK91MFjPPPGVy
	YPLYOesuu8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bk3p3QxFUzkqfixrpOlgfEiZxcjJ4eEgInE
	rbXXWCBsMYkL99azdTFycQgJXGaUeLR4N5Sznkli28ZWNpAqXgFtiWdt84A6ODhYBFQlDi9W
	AAmzCehKLOppZgKxRQWCJGZ/nscOUS4ocXLmE7AFIgLuEkt+PwSzhQXUJK6fW84MYgsJBEh8
	OPsbzOYUCJSYc+0KI8h4CQFxiZ7GIBCTWUBdYv08IZAKZgF5ie1v5zBPYBSYhWTBLISqWUiq
	FjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzRS00p3cQICVHhHYy7TsodYhTgYFTi
	4a3YNT1YiDWxrLgy9xCjJAeTkijvV6kZwUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeHcKA+V4
	UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK89fJAjYJFqempFWmZOSUI
	aSYOTpDhXFIixal5KalFiaUlGfGgGI0vBkYpSIoHaG8DSDtvcUFiLlAUovUUozHHqTvH2pg4
	PvSeaWMSYsnLz0uVEueVAikVACnNKM2DWwRLTq8YxYH+FubtAaniASY2uHmvgFYxAa167Tkd
	ZFVJIkJKqoFx7exQITuv72k7ZeUszmXP2zNhUlHCiYi3Z/o5D3sIyOjfLlh4cZXGp1v7pI++
	nea39tb5zdveO3if0maPu/X1OHuu2Sy5Rx/+LTGWWsyzucJiqZxzLZNNS/i1mTMK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251348>

On 06/05/2014 04:51 PM, Robert Dailey wrote:
> I've never contributed to the Git project before. I'm a Windows user,
> so I use msysgit, but I'd be happy to install linux just so I can help
> implement this feature if everyone feels it would be useful.
> 
> Right now AFAIK, there is no way to prune tags through Git. The way I
> currently do it is like so:
> 
> $ git tag -l | xargs git tag -d
> $ git fetch --all

Junio explained some limitations of tags (namely that there is only one
tags namespace that is shared project-wide) that makes your wish
impossible to implement the way it works for branches.

Local tags are awkward for the same reason.  It is too easy to push them
accidentally to a central repository and too hard to delete them after
that has happened.  They kindof spread virally, as you have noticed.  I
recommend against using local tags in general.

Recent Git does have a feature that might help you.  *If* you have a
central repository that is "authoritative" WRT tags, then you can sync
the tags in your local repository to the tags in the central repo using

    git fetch --prune $REMOTE +refs/tags/*:refs/tags/*

You might also be able to use a pre-receive hook on the central repo to
prevent tags from being pushed by people who shouldn't be doing so, or
to require that tags have an approved format (like
refs/tags/release-\d+\.\d+\.\d+ or whatever) to try to prevent a
recurrence of the problem.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
