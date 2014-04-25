From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Harmful LESS flags
Date: Fri, 25 Apr 2014 08:11:24 -0700
Message-ID: <20140425151124.GA11479@google.com>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
 <87lhuvb9kr.fsf@fencepost.gnu.org>
 <xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
 <vpqfvl1rj7i.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, David Kastrup <dak@gnu.org>,
	d9ba@mailtor.net, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 25 17:12:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdhnW-0005Op-1n
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 17:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaDYPLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 11:11:36 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55155 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaDYPLb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 11:11:31 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so3298537pbb.22
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y97NDLXsUXPNidMqmBhKKf2ITvYM7EC2LCgi5Genbo4=;
        b=nVXTz0T/315+P6yb6+tdAb7xXjT++1nlX07l8YhJVZPWrf4G3lYLnXsCNdEy5z+Jyu
         yu0se8LTwHFLQJed0M+QRHN4gEfvHRmkfWmob+oRQ7epRpV33IBkLBNDv/P5a/LQPpa7
         C99pgCrBWhmflW0VLcOIkLm+1Uuf15XseSkpLp2PRyI49avVdX5v8OgKwCQeaPoObUGy
         DOD0l6iyX5c8BWw1ilW8bjBnMgibOhRf8kiFteXda9+oVLxqba/1aCXGGEekdx4QxDnA
         JKTzDI0dHuFjBAcTJzGjtdI55MwbIWI/tu1fUpGUwsbN1ySp4x05/eS6IVdnkYJ/FLoH
         n4fA==
X-Received: by 10.68.189.68 with SMTP id gg4mr12136733pbc.42.1398438690689;
        Fri, 25 Apr 2014 08:11:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xx4sm16527993pbb.51.2014.04.25.08.11.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 08:11:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqfvl1rj7i.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247044>

Hi,

Matthieu Moy wrote:

> I am personally in favor of changing the default to drop the S. Silently
> hiding stuff from the user's eyes is really bad. With good coding
> standard and reasonable terminal size, it actually doesn't matter.

Just for clarity: no, when we are talking about well formatted code,
-S is actually a way better interface.

That's because indentation matters and makes it easy to take in code
structure at a glance, long lines that get cut off by the margin stick
out like a sore thumb already, and lines wrapped at an arbitrary
character are even more distracting to the point of being useless.

In practice I believe the "Silently hiding stuff" concern is much
harder to solve.  In the case of malicious code that opened this
thread, I think a marker on the right margin would reveal the
whitespace more clearly than wrapping that the reader may or may not
notice.

Luckily, it is very easy to switch between the two views on the fly
--- in an already-open "less" window, you just type '-' + 'S'.  In the
spirit of not overriding tool defaults when there is not a strong
reason to do so, I agree that if someone writes a patch to drop
the 'S' I would probably like it.

[...]
> I do not think we particularly need a transition plan here: it's purely
> a user-interface thing, not something that may break any script or other
> tool.

Agreed ---- a note in release notes and making sure the documentation
reflects the new default should be enough.

Thanks and hope that helps,
Jonathan
