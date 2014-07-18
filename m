From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Fri, 18 Jul 2014 10:16:35 -0700
Message-ID: <20140718171635.GR12427@google.com>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com>
 <20140717221056.GO12427@google.com>
 <8E3CD89B-2E47-4CA8-8F3D-598A9BE2AD9F@gmail.com>
 <20140718022208.GQ12427@google.com>
 <50047EE8-4EF8-49E3-9067-1C88B2FB9D58@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:16:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Blz-0003Ax-BV
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 19:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965722AbaGRRQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 13:16:39 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32783 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbaGRRQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 13:16:38 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so5301947pab.0
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ccb2SnC5BkjbbC7dVskoTM2uQhqDbuNxjYXTmqG4Fps=;
        b=cSc7DmOT0QNMnEcGt/z85b+lx738OZ29/KMTLTTSvBekPcEULtjNDjSyhGZfeNVAm+
         /gnUZNaKzBexYsSU54P0LXwuS6Js+w26c3RoRDt9/vDt/H8AFiiLQsEGjTDAGO6Js6II
         Euz99gThhkgtsD8hvgQrCuXMfbdKECnnjjss8qZx977PIqcWJjwue2NFwKRsJ9Mk7A4e
         NQiCkAsacBpBEWqM2dT9uDLaumc6afGv+GX/5d+h3UPfg4ZA8WoaNWKBvUPT8LnYUAsL
         3nVgpzIc2Un7sL+LShi8jBu7HKtCaLC2jPhwjSOMe8XtYUGC5RXaasLjZIDUrcSf3274
         p5ag==
X-Received: by 10.68.167.133 with SMTP id zo5mr6884334pbb.21.1405703797729;
        Fri, 18 Jul 2014 10:16:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:6d3d:4f:6892:efc2])
        by mx.google.com with ESMTPSA id pm7sm8155464pdb.77.2014.07.18.10.16.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 10:16:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50047EE8-4EF8-49E3-9067-1C88B2FB9D58@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253830>

Kyle J. McKay wrote:

> You might also want to take a look at [1] which suggests that when
> doing SRV lookups for URLs they should be done regardless of whether
> or not a port number is present (which then eliminates the RFC 3986
> issue the current SRV lookup code has).

"Git URLs" as described e.g. in git-clone(1) weren't intended to be
actual URIs.  What would be the interoperability advantage of making
them URIs?

This has come up before, with e.g. people asking to introduce a
git+ssh:// and git+http:// syntax to refer to repositories accessed
using those transports without conflicting with the usual meanings of
ssh:// and http://.  If there's a good use case for that, maybe it
would be worth doing some day.

Curious,
Jonathan
