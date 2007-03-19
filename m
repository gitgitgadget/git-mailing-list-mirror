From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 4/5] cvsserver: Make the database backend configurable
Date: Tue, 20 Mar 2007 07:47:12 +1200
Message-ID: <46a038f90703191247y6b70c272s2473ab28acd63682@mail.gmail.com>
References: <11743197614111-git-send-email-frank@lichtenheld.de>
	 <11743197611364-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 20:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTNpn-0004FA-Vn
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 20:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbXCSTrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 15:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbXCSTrP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 15:47:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:35471 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbXCSTrO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 15:47:14 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1638284wry
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 12:47:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nGa0gjvS0Ezg1JO3YH7lMKGcMkRawoLsFiXo3meU+DyhzQwZoLu7u7piwg5y/QLaN0hIdG6gS1726C2usEFUncUNx3yWH6pWWB6LVdrrBDUbN7AeixPl6I34zTcMPcKUBzbL7TGM1JLh01+e9I04oSSi6Eao1w4HhZ9bvqXulyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wmvc6IR0dxP0/VYHeUuI8BAYxQfAbjKh8iVHXPkt9DPVvluXc52b4IiUPZi6MtE9DTIF4Q2eiXfnwZvXkAWrx+PqwKRDgR8Wn0YnSpXBh/1oNU5TvE8OiHnqdIMh8ldtumblYeLcChtJ0sFzu0wGaPgbLwLGKexZ2sdgyKhR4gw=
Received: by 10.90.120.13 with SMTP id s13mr4627075agc.1174333633021;
        Mon, 19 Mar 2007 12:47:13 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Mon, 19 Mar 2007 12:47:12 -0700 (PDT)
In-Reply-To: <11743197611364-git-send-email-frank@lichtenheld.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42659>

On 3/20/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> Make all the different parts of the database backend connection
> configurable. This adds the following string configuration variables:

Nice. I guess the hard part of this is going to be creating DB schemas
that are reasonably portable. The SQL we use is as vanilla as it gets
;-)

> Both dbname and dbuser support dynamic variable substitution where
> the available variables are:
> %m -- the CVS 'module' (i.e. GIT 'head') worked on
> %a -- CVS access method used (i.e. 'ext' or 'pserver')
> %u -- User name of the user invoking git-cvsserver
> %G -- .git directory name
> %g -- .git directory name, mangled to be used in a filename,
>       currently this substitutes all chars except for [\w.-]
>       with '_'

It's missing from the POD though ;-)

Good to see patches coming to cvsserver -- I haven't been able to do
much on it lately, and my pet projects are pretty hard. If anyone
cares, they are:

 - mimic CVS branch support
 - allow skewing version numbers to match an existing repo

with those 2 in place, we'd have a means of applying a "vampire tap"
to an existing cvs server and take over without anyone noticing. But
tehy are both hard, hard hard.

cheers.


martin
