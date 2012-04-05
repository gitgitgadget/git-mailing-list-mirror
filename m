From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: error out when the "upstream" semantics does not
 make sense
Date: Thu, 5 Apr 2012 15:23:27 -0500
Message-ID: <20120405202327.GB6885@burratino>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
 <20120405124706.GA3921@sigill.intra.peff.net>
 <7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
 <20120405184345.GA6448@burratino>
 <7vlima5591.fsf@alter.siamese.dyndns.org>
 <7vhawy54nd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:23:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFtDe-0001uZ-RT
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 22:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab2DEUXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 16:23:38 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55978 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778Ab2DEUXg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 16:23:36 -0400
Received: by obbtb18 with SMTP id tb18so2220057obb.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JUVzp8RgbYJL8+02WJQv3cK4rvvnHlS5F82WoZLhLLc=;
        b=05E47ZFRzK9U78U4QanE61pK115r4a9IUvpXJ357s93Ci60utYGPDJlFtDuud++8kQ
         wxrn8Z/4uOmWFbrBFhB+RQ6W2q+72kD5wDrCXL75y1BjfXnMXbwU6itrp/tRJYfhghff
         3N9Fx+E8x9sYYPkq2ZMJKVwgYX+aYLsd94AQgzDpuUD+bQDwOJgWXOeDoNqm735REbI2
         5rJjsKKfVUa/eWEulOcxc7AbhCZ+zi+ZPJycHryS78myLX4lNx6y+d+PxMkAtij9gmqa
         wTmvBaddEQoAD9Tk6+tSJ5wvzpvi9Ovujy9smB5BWyiCWKKq7us5M+yAIgxalexkWOHr
         RjRg==
Received: by 10.60.13.36 with SMTP id e4mr5869451oec.22.1333657416135;
        Thu, 05 Apr 2012 13:23:36 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm5151695obr.20.2012.04.05.13.23.34
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 13:23:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhawy54nd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194805>

Junio C Hamano wrote:

> How about phrasing it this way?
[
	fatal: You are pushing to remote '%s', which is not the upstream of your
	current branch '%s',
	without telling me to push which local branch to
	 update which remote branch with.
]

I think some words got jumbled a little.  But in that spirit, maybe
here's a start:

	fatal: You are pushing to remote 'somethinglong',
	which is not the upstream of your current branch 'something/very/long',
	without telling me which local branches to use to update which
	remote branches.
