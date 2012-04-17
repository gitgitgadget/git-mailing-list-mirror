From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] fetch: Use the remote's ref name to decide how to
 describe new refs.
Date: Tue, 17 Apr 2012 10:18:27 -0500
Message-ID: <20120417151826.GA21534@burratino>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-4-git-send-email-marcnarc@xiplink.com>
 <20120416223429.GA13440@burratino>
 <4F8D2195.9030507@in.waw.pl>
 <4F8D7CD5.3080508@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:18:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKAB0-0001Ip-1K
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 17:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148Ab2DQPSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 11:18:37 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44104 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab2DQPSg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 11:18:36 -0400
Received: by ghrr11 with SMTP id r11so3113785ghr.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7stisEiVjwXA+Evzme+sja9AUPwSFvlrY/ahmOVczr0=;
        b=BMZaeHM73QAKPVyggCFElrNm5V6PX6t4p5Ixe+B3/VzZSYLhHipDkz8I7suRqyFl0F
         1/SIqlp48jLY7j4dzNPJl2M9Ps5/+7ChjP8XKlEMACMHWFBCuCLZzbap3nBdIuoiVfKs
         iEAr5w/3brwHbs5K3Z5SOraENqWhQeqxfgEA0V6Hx22k8puT6iCkQYMRArdIK7RxzpUg
         0VaagNOIIdjTbKgaJ6i0+T2xvrndcapRzQ5Po4n2ZhXA5YxRVqxjJnk2UBKOvnXsqKlf
         DJf0L1UU0LYYj6SRy40R5dbf/qEfW1TuWXy0mxqwL7nkvjE3UP8nevY+eQGILAPSCjq4
         7nhQ==
Received: by 10.50.197.233 with SMTP id ix9mr9900067igc.26.1334675915669;
        Tue, 17 Apr 2012 08:18:35 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i6sm35235420igq.3.2012.04.17.08.18.34
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 08:18:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F8D7CD5.3080508@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195762>

Hi again,

Marc Branchaud wrote:

> Jonathan, I figured regexps aren't an issue with plain "grep" (unlike "egrep"
> or "grep -e").  I take it this is a portability concern -- are there systems
> that actually replace plain "grep" like a "egrep"?

No, "grep" always means to globally match against a regexp and print.
There is an "fgrep" command to search for a fixed string, but why not
take advantage of regexps while they're available and use one grep
instead of two?

> Also, in my test's pipes I believe only the second "grep" needs to be
> "test_i18ngrep", right?  (Only strings like "[new branch]" are
> internationalized.)

I'm not sure what the point would be.  The exit status from the
upstream of a pipe doesn't affect the outcome of the test, so no one
would be able to tell the difference.

[...]
> Thanks guys!

Thank you.

Sincerely,
Jonathan
