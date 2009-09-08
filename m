From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Tue, 8 Sep 2009 21:18:50 +0800
Message-ID: <be6fef0d0909080618t53e5efa0ne182707b7f35ba80@mail.gmail.com>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
	 <0016e6470f36315b8a0472bc75a8@google.com>
	 <20090904212956.f02b0c60.rctay89@gmail.com>
	 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
	 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
	 <7vocpn44dg.fsf@alter.siamese.dyndns.org>
	 <20090907172751.6cf38640.rctay89@gmail.com>
	 <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
	 <m3ocplvbmj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Tom Preston-Werner <tom@mojombo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 15:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml0bF-00046j-Tc
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 15:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbZIHNSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 09:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbZIHNSt
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 09:18:49 -0400
Received: from mail-iw0-f175.google.com ([209.85.223.175]:39578 "EHLO
	mail-iw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbZIHNSr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 09:18:47 -0400
Received: by iwn5 with SMTP id 5so1128044iwn.4
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=U+FskZP+IUg+z7bZNGYaVe+LA2KRQL0217Jdh4gXEgU=;
        b=wlGUZkVw5EVqAxUo8mBceuJSK45tT+MGBzEKej29huxexdoDyRbF2WP7uspHfIWPVa
         GzIb54n53GSxtAHd4hT2k5nvN+kZR9JMrk1X9DFnIDdVFF2930F+f2SrGeFSUhGV7T54
         Q60SYkPo4WR7qOMWh1Xk/HugH0xEqJEhACs30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=I4psrIEqwbuZ2Yh9UqqE+bOMAwhCQYSU3P/ode/hT9qnUcqxd86zF/8EKuBZTaE8H2
         K6e+V78rjy898F7VHZEVhcprRew+k8hWQX3sZb+yHM0H+HyBBDmuRiH3iBWmdvLfwkcY
         GY/kgZHAZiFc2ef9uxy9WPazQq177dxZHHT9g=
Received: by 10.231.25.233 with SMTP id a41mr13162846ibc.52.1252415930140; 
	Tue, 08 Sep 2009 06:18:50 -0700 (PDT)
In-Reply-To: <m3ocplvbmj.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128006>

Hi,

On Tue, Sep 8, 2009 at 8:57 PM, Jakub Narebski<jnareb@gmail.com> wrote:
> 500 Internal Server Error doesn't look right (well, it can indicate
> bug in server code), but would git respond to correct error code other
> than 404 Not Found, like 405 Method Not Allowed, or 501 Not Implemented?

I believe you're referring to git response to such error codes for GET requests?

For 404, we'll try using alternates (objects/info/http-alternates,
objects/info/alternates).

For the rest, we'll just abort the request. I'm not really sure of the
specific responses by git, like if we do ask for authentication, in
the case of 401s.

-- 
Cheers,
Ray Chuan
