From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 19 Mar 2010 07:16:43 -0700
Message-ID: <20100319141643.GA16211@spearce.org>
References: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com> <be6fef0d1003190213m48b6c91dx5cbd489cf798dacc@mail.gmail.com> <alpine.DEB.2.00.1003191033022.15750@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsd6m-0007nX-94
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231Ab0CSOXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 10:23:23 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:56774 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab0CSOXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 10:23:23 -0400
Received: by qw-out-2122.google.com with SMTP id 8so585215qwh.37
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 07:23:22 -0700 (PDT)
Received: by 10.224.19.9 with SMTP id y9mr1210362qaa.353.1269008207563;
        Fri, 19 Mar 2010 07:16:47 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm830879qyk.14.2010.03.19.07.16.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 07:16:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1003191033022.15750@tvnag.unkk.fr>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142602>

Daniel Stenberg <daniel@haxx.se> wrote:
> On Fri, 19 Mar 2010, Tay Ray Chuan wrote:
>>> When an HTTP request returns a 401, Git will currently fail with a  
>>> confusing message saying that it got a 401.
>>
>> how are you getting 401s? Recently, git set the CURL_AUTH_ANY option, 
>> so if the correct credentials are passed, curl should have "hid" the 
>> 401 from us.
>
> That's correct. It should hide the 401 in the sense that it should try to 
> continue and do the correct authentication procedure and only if that 
> fails it should end up with an actual 401 end result.

If the URL didn't contain a username, and the server returns a 401,
Git just aborts with an error.

What Scott is trying to do here is teach Git to request a
username/password if there was no username in the URL and
authentication is required by the server.

In the case of GitHub, this means they can advertise one http:// URL
for the repository.  Anonymous fetch just works, and using that same
URL to push will ask for your username/password, and then complete.

-- 
Shawn.
