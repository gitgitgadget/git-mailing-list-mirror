From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 09:40:03 -0700
Message-ID: <20130424164003.GB4119@elie.Belkin>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:40:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2jz-0001Et-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756103Ab3DXQkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:40:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55895 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016Ab3DXQkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:40:10 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so1303988pad.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=L/Atl6VH9ErLUILsPLNhJJhpWwOL9cpgGEduO9EiA/s=;
        b=c+XdwFqBDTwje8P6UdLR6v9ggpQCbkmnOu76Tt3+V5uR6XBxF3UAy8xTTpzW9T0vs4
         xHNO+9Eb3V0YyMMmyY5RX439i9oZV2gKFSAcEC9oKPIb1NjiQ9Klj3fzEMnfx4SLhE6J
         RAoIi/tcB6cnukaGQRSpxPxu7b3vVwrpuNdNEWho33ej5SKokzcf2xMHmTqT5LRW73kV
         yk2kIxswig9Qwa34Y1BF5YpCjaf5Ub38WZUQ+JqDk1JAXNAj7gAZB/opy7H2YSdhD185
         /Dv6VVyW3sXHOZV50EQ38TwpdKoSW8+/EkHwo5wCUsat3MkPX/GKir3g9VWc4nrKLnTD
         DSuw==
X-Received: by 10.66.9.100 with SMTP id y4mr20614036paa.189.1366821610169;
        Wed, 24 Apr 2013 09:40:10 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id br2sm3621627pbc.46.2013.04.24.09.40.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 09:40:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222266>

Hi,

Ramkumar Ramachandra wrote:

>                    A..B and A...B do not correspond to the meaning
> specified in gitrevisions.txt.  There's a note in the documentation
> saying this, but I'm very unhappy.

What would it mean for A..B to be treated as a revision range?

Suppose I do a revision walk and come up with the commits x, y,
and z.  What is the resulting diff?

The common syntax is just a mnemonic: in the same situations as I
might use "git log A...B", it can be handy to use "git diff A...B".

[...]
> What about other things like 'git diff ^A ^B' and 'git diff A^!'?  Why
> is diff so inconsistent with everything else?

"git diff ^A ^B" is invalid syntax.  It's a bug that it doesn't
complain.

"git diff A^!" is a very convenient shorthand for "git diff A^ A".

"diff" is fundamentally about comparing two endpoints.  It is not a
command for listing commits.

Hoping that clarifies,
Jonathan
