From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Mon, 5 May 2014 11:44:41 -0700
Message-ID: <20140505184441.GS9218@google.com>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
 <1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	David Kastrup <dak@gnu.org>, d9ba@mailtor.net, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue May 06 18:55:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi6v-0006KZ-UF
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbaEESoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 14:44:46 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48344 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbaEESop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 14:44:45 -0400
Received: by mail-pa0-f47.google.com with SMTP id fa1so10152863pad.20
        for <git@vger.kernel.org>; Mon, 05 May 2014 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=epqWG/udIhpnwIA7cwF8SJJsOCq+9Ef43mEy1Hq0aew=;
        b=G+W1rB9P9IFLKBqX9OSQktEGnmCCO9WvxlokE3JGpBaOapDX6ozUJy11LUiIXBn0ZX
         5p18LIXSgljIAtmY/SWf9xeg8ehJOiGymAIgQ3pUESQGk1IgSyYMnM4knGHnX/3MD2xA
         KZVAx3wH03iNAKFa2u+4q9hAQ0ss+Z27RnRCBh3cXP3GD8Xlz7oqMlgWpVDgMgYWcZQx
         xjzTOiKUm6+Rezfl81sptWKua+2HA8lD4QH1vyXJaGu62wmF3TgkBLbCIJqr0lJCEWWR
         JdJZIcsG5I63gVWZrNqlqUhvP3TDMNxPZLeylvnQeMknsjz2k0ZGhXxDTrbfNGblewOM
         vVYA==
X-Received: by 10.66.140.6 with SMTP id rc6mr15109458pab.87.1399315485169;
        Mon, 05 May 2014 11:44:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dy7sm77519050pad.9.2014.05.05.11.44.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 May 2014 11:44:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248161>

Hi,

Matthieu Moy wrote:

> By default, Git used to set $LESS to -FRSX if $LESS was not set by the
> user. The FRX flags actually make sense for Git (F and X because Git
> sometimes pipes short output to less, and R because Git pipes colored
> output). The S flag (chop long lines), on the other hand, is not related
> to Git and is a matter of user preference. Git should not decide for the
> user to change LESS's default.

Thanks!  Sounds like a very good change.

(Nit: instead of "because Git sometimes pipes short output to less",
it would be clearer to say something like "when Git pipes short output
to less it is nice to exit and let the user type their next command".)

[...]
> The documentation in config.txt is made a bit longer to keep both an
> example setting the 'S' flag (needed to recover the old behavior) and an
> example showing how to unset a flag set by Git.

Interesting.  Looks good.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
