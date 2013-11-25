From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] bash prompt: add option to disable for a repository
Date: Mon, 25 Nov 2013 15:43:44 -0800
Message-ID: <20131125234344.GA4212@google.com>
References: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
 <5290BEE7.2070901@kdbg.org>
 <CAOpY_XvN9GJw592MpbcZZ2hzUvSvTHNLebwMmQBK+N-Ez4xM_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	szeder@ira.uka.de
To: Heikki Hokkanen <hoxu@users.sf.net>
X-From: git-owner@vger.kernel.org Tue Nov 26 00:44:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl5ot-0007lm-Hl
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 00:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab3KYXnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 18:43:52 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:36415 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3KYXns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 18:43:48 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so3479320yha.12
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7JSy5YyBwyzboQhlgOKPRNEZi6iTnIjV6vBj7sOSikw=;
        b=R4DncDQ1DYt9oHfJ+vj7vihVoWH/AzWtu0uajPFSnVkoIi8RKR2JCspc1yggubpyg2
         +A6XsLTqNhRgFXB4dQdKoMqEjisA54E6zKQIOwkp/QUOQdA4/t0jxggOWS7UUKUcpN5a
         Ehqv6Ps5nqNTxdXnxa+16pwhOPoRIUbCUUQ1/GelLf/B7hiIdyCWB3HZSI5BiL8cKYZK
         j0JRXeAlqwrHBsaRujQhohC8RneXwBPczCc591jFRlGKlj0GphI/ZTjnFjduaQO8lzmM
         cg4konT1rgyV5neex07RZ0tsCmUzOhaGE9Fos7ACTNEOkM9ahgcqcXVA7eUzY7rAdOII
         jX0g==
X-Received: by 10.236.194.136 with SMTP id m8mr3021688yhn.60.1385423027992;
        Mon, 25 Nov 2013 15:43:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e10sm78934477yhj.1.2013.11.25.15.43.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 15:43:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOpY_XvN9GJw592MpbcZZ2hzUvSvTHNLebwMmQBK+N-Ez4xM_Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238365>

Heikki Hokkanen wrote:

> If running git config on each prompt seems too expensive, do you have
> any better ideas?

Perhaps a GIT_PS1_NOT_FOR_THESE_REPOS=repo1:repo2:repo3 setting would
work.

__git_ps1 would do the one 'git rev-parse --git-dir --...' to find the
repo corresponding to the cwd and then could match against the
configured list to decide whether to return early.

Hope that helps,
Jonathan
