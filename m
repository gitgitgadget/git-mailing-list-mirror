From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git-receive-pack doesn't understand objects/info/alternates?
Date: Mon, 16 Apr 2007 15:13:25 +0200
Message-ID: <8aa486160704160613t3ac17e4co9177ad91fda8eb36@mail.gmail.com>
References: <E1HdQDl-0005ia-Bn@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 16 15:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdR1g-0000lC-6L
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 15:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbXDPNN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 09:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbXDPNN2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 09:13:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:47141 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030582AbXDPNN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 09:13:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1105721uga
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 06:13:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nJFqAQgho1dKXAFi8ZIhT8Y83bDBpjuIttzckXyqNf5Vl2cUKqfUEXOBqyH+zV4ZkS6gfsIiwmxV7OKz7v5OqsKtuTejTeM9BoP4n8Vp6Ie/HkwizA5eSAwFS08aSwpdXv6VixP+MTBpZmYzv8lhJiTBAsta3c+mqcK3r+51C3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U1H5+houx8RQF3sxzNearJbNbhgphlF3Tn89qCqcBbP/5iBjzTkBRsGacEfdNUY3IzNF1Ts3CLXgk6LyK8adbQ72pJtDwkeHXf3EUHcVJO19H5IERzDC6hXczUploB5LysCLA6giNUz9pz9zhhYrtjFo6geLwOGzqR02iyYQVWw=
Received: by 10.78.200.3 with SMTP id x3mr1064067huf.1176729205682;
        Mon, 16 Apr 2007 06:13:25 -0700 (PDT)
Received: by 10.78.131.7 with HTTP; Mon, 16 Apr 2007 06:13:25 -0700 (PDT)
In-Reply-To: <E1HdQDl-0005ia-Bn@candygram.thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44645>

On 4/16/07, Theodore Ts'o <tytso@mit.edu> wrote:
>
> When I push a kernel repository to master.kernel.org, where the
> repository only has at most a dozen changes on top of 2.6.21-rc7, I
> noticed that it tried to push a *lot* of objects over ssh.  As in:

This is because git only trusts the the commits in $GIT_DIR/refs.
Since commit v1.5.1-107-ge3c6f24 (in next) git-fetch first checks if
we have all the objects that we are going to fetch available locally.
This could be added for the push. But for now you could add a branch
in your repo in master.kernel.org to track linus' master branch.

Santi
