From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re: Re: [Bug report] 'git status' always says "Your branch is
 up-to-date with 'origin/master'"
Date: Mon, 6 Jan 2014 07:45:52 -0800
Message-ID: <20140106154552.GA22189@google.com>
References: <CAGyf7-FX1sPjwvKdxeEXopffFPiftgDRqoe7NRWyM1Cm=5n6Sw@mail.gmail.com>
 <1963290835.719443.1388996669450.JavaMail.ngmail@webmail15.arcor-online.net>
 <1283978462.720554.1388999328222.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bturner@atlassian.com, worldhello.net@gmail.com,
	git@vger.kernel.org, gitster@pobox.com
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 06 16:46:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0CNT-0008TO-4m
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 16:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbaAFPqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 10:46:01 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:56869 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaAFPqA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 10:46:00 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so3665448yho.30
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 07:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/ZtJMaXeBNhkaMOk01OIFQgd6G/eAvyQ2Cf5XZ99jLI=;
        b=uY+QV8Oy5yCG2E0bARjFSMQr226MUO45NG5xdqVktFXks+rY4B54QkDAscREygiRqc
         I2DbptW+zcQ0Kis5w1vL5FvP/LLX5kKatVKChEEWR+kht5Ffe2YtwPJWu5YsVW9+b56X
         UMAVds0c/2EWm85ckY0vNJYbFBswgXrv91DzbyQzG0YraY/eICG84I7oqfxFz/qCmliW
         7U36LNmltv6oQpYwTC3EAHCD+Dcv9PgIxO0T2kZOwGUrQK4G6vpA5D4p6K8vefsRPFg8
         ApU+OzvjOhkMSrYHjYI1qKHb1mGhsyj2FCedG/z/qCUr8hZaxpgeyuAMzmceQy4i8R/X
         ucmQ==
X-Received: by 10.236.131.19 with SMTP id l19mr63894687yhi.0.1389023159736;
        Mon, 06 Jan 2014 07:45:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id d32sm19611045yhq.27.2014.01.06.07.45.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jan 2014 07:45:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1283978462.720554.1388999328222.JavaMail.ngmail@webmail15.arcor-online.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240017>

Hi,

Thomas Ackermann wrote:

>>                                In repo_b your ref for origin/master
>> has not moved. It has remotely (meaning refs/heads/master in repo_a
>> has moved), but git status is not hitting the remote to find out; it
>> only looks at the local state.
[...]
> But for the simple use case where you only have a master
> branch I consider it not really helpful and - at least for me -
> misleading.

I see what you mean, and you're not the only one.

Git follows a rule of "never contact another machine unless explicitly
asked to using a command such as 'git pull' or 'git fetch'".  To
support this, it makes a distinction between (1) the remote-tracking
ref origin/master and (2) the actual branch "master" in the remote
repository.  The former is what is updated by 'git fetch', and the
latter is something git does not know about without talking to the
remote server.

What documentation did you use when first starting to learn git?
Perhaps it can be fixed to emphasize the distinction between (1) and
(2) earlier.

Thanks,
Jonathan
