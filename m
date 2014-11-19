From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Tue, 18 Nov 2014 18:21:22 -0800
Message-ID: <20141119022121.GU6527@google.com>
References: <20141118003426.GA6528@glandium.org>
 <20141118014028.GF4336@google.com>
 <20141118023112.GA14034@glandium.org>
 <20141118025131.GH4336@google.com>
 <20141118031147.GA15358@glandium.org>
 <20141119021824.GA9094@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:21:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqutY-0005Fl-BV
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 03:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbaKSCVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 21:21:20 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34046 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbaKSCVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 21:21:19 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so5894704ieb.12
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 18:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dSmm87DqjZdLWYVnYR8j+pE7AwkQ9E5K1F0b5PoZPDg=;
        b=Sae+xLKW7LP1glYKQwj1jc4MzFcWxhjsacp3UoJnffxhgR4OMcGMjdZXWfw/moYFp/
         V3ClBaeNfpZAC332DOLoXYBhwq0G03m4eOXhZNzwnia1N/hXXok1J8sP85Ytf93bN7Zq
         dq9n2FW1gfVBXC4kakCqku3PqbFTrSZPLXe8c/xDzboa/qP11FZkA1teVkq9jB/y+YLp
         QzxxC7JT0tv9tw5yZ9WeA0WhKZY11gaZb9zmPCw9StcZ/BngD0i1BbVP9Zk1guHqBgUC
         Cju7nkXJVJP6JmuR46u7kueFgeft9NEFwJw57wqOlsJgADqUs0tg2UByBxXjfeM9cOpy
         amlw==
X-Received: by 10.43.127.73 with SMTP id gz9mr594403icc.6.1416363679081;
        Tue, 18 Nov 2014 18:21:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:48de:79f7:30eb:4507])
        by mx.google.com with ESMTPSA id b123sm185435iob.4.2014.11.18.18.21.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 18:21:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141119021824.GA9094@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey wrote:

> So, in the end, I was able to do everything with what's currently
> provided by git fast-import, but one thing would probably make life
> easier for me: being able to initialize a commit tree from a commit
> that's not one of the direct parents.

IIRC then 'M 040000' wants a tree object, not a commit object, so
you'd have to do

	ls <commit> ""
	M 040000 <tree> ""
