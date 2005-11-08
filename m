From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Tue, 8 Nov 2005 15:37:29 +1300
Message-ID: <46a038f90511071837g474bdc44vf60dd0758511f24c@mail.gmail.com>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com>
	 <46a038f90511061852h5cdf9539o34f69b4deb9f041a@mail.gmail.com>
	 <20051107043737.GI3001@reactrix.com>
	 <46a038f90511062050geee7e73qddcd52e3a2ec86df@mail.gmail.com>
	 <20051107171446.GA4070@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 03:38:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZJMc-0003uh-71
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 03:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965668AbVKHChb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 21:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965675AbVKHChb
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 21:37:31 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:42588 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965668AbVKHCh3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 21:37:29 -0500
Received: by zproxy.gmail.com with SMTP id z31so450618nzd
        for <git@vger.kernel.org>; Mon, 07 Nov 2005 18:37:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DIW9RZ6qyJMtT6LxmxI8raPAKJF/n8rBiF1fedTng8c5bQ7sP3OHkaIfTabrS8Ium9LD7iQOHgAB7qmjsdb4c3I+ZwGYYyKC5vUatoVlLfwmKqfdFlX9CcLZtUsn7A1CFKWQyP6YpwyBAApoAhqjI1BPo85Z5fm6safgu2Qs0uw=
Received: by 10.65.235.11 with SMTP id m11mr6093574qbr;
        Mon, 07 Nov 2005 18:37:29 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Mon, 7 Nov 2005 18:37:29 -0800 (PST)
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051107171446.GA4070@reactrix.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11304>

On 11/8/05, Nick Hengeveld <nickh@reactrix.com> wrote:

> You might try this to see exactly what request/response headers
> curl thinks are passing back and forth.

It definitely looks like it's doing a few requests in parallel and
getting them mixed up. BTW, this repo is public and sitting on a box
that doubles up as kernel mirror -- feel free to hit it ;-)

> GET /git/moodle.git/objects/f0/6a06d24eee0b7819e2aaf48ad0e255301394e0 HTTP/1.1
Host: locke.catalyst.net.nz
Accept: */*

* Connected to locke.catalyst.net.nz (202.78.240.39) port 80
* Couldn't find host locke.catalyst.net.nz in the .netrc file, using defaults
* About to connect() to locke.catalyst.net.nz port 80
*   Trying 202.78.240.39... > GET
/git/moodle.git/objects/d9/6d5ee03a225ab4e750fb864dbea35d42c51b8b
HTTP/1.1
Host: locke.catalyst.net.nz
Accept: */*

* Connected to locke.catalyst.net.nz (202.78.240.39) port 80
* The requested URL returned error: 404
* Closing connection #0
* The requested URL returned error: 404
* Closing connection #0
> GET /git/moodle.git/objects/5e/0e0d41f781d53344fa67b5e5a0138b586e2946 HTTP/1.1
Host: locke.catalyst.net.nz
Accept: */*

* The requested URL returned error: 404
* Closing connection #0
* The requested URL returned error: 404
* Closing connection #0
error: Unable to get pack file
http://locke.catalyst.net.nz/git/moodle.git//objects/pack/pack-9cbe4a5eb777d4ee535f08feb471e812208ed3a5.pack
The requested URL returned error: 404
error: Unable to find 7004cdf821ab5ddcded7819dea34015b0e84cd9a under
http://locke.catalyst.net.nz/git/moodle.git/

Cannot obtain needed blob 7004cdf821ab5ddcded7819dea34015b0e84cd9a
while processing commit b065a5cb7f757dd6e271249cb49e19e8c34b26ce.
cg-fetch: objects fetch failed
cg-clone: fetch failed

cheers,


martin
