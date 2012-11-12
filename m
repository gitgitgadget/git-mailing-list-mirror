From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/log: fix description of format.pretty
Date: Mon, 12 Nov 2012 07:38:55 -0800
Message-ID: <20121112153855.GA3546@elie.Belkin>
References: <CALkWK0=hdmYF2VoOZY4F7+yPD8D0rBnPY-tvp5pryRWp-0WBeg@mail.gmail.com>
 <20121112080527.GB3581@elie.Belkin>
 <CALkWK0nR_9mWDKzKygR379x3L=d4bGKKo27AP-2Y=+coc7H+sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXw6Z-0003MR-RX
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 16:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab2KLPjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 10:39:06 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41571 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab2KLPjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 10:39:04 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4365036pad.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7/bpTV5AmQQMxZMgLjAyUtJ3OfrmkeaOxz3oE/fh4uE=;
        b=HO0+91cGK7+p93a1HWQmohmeqc82uphbis5z7dF8A4Q2X55VYU8JYlYdKTdGX1e7f0
         QwlWEoiIHykZ05ZOeptL/7/QCIvvrZfYof4zMDwZOiFjm/kwrWji69uv1ClVqqwArbx2
         Jhg9n4ZcihnoO4/NHyW9KjAdOK/SS5OwHKFMd18k8opQALilO2smJggYJPHIkq76R6TQ
         VM1GrvsaK/q9TCN9FHCwTzqKO9uuUzlWutdJ303GnK5YBPGkQnrHgsKtsUPZ0+rcIzbG
         TRodNHjfT+5wQMA3fv+ZvooWpUo3CUsQCowk05DuCsh5i5mUX5erWiinKEpMvu2pMYTw
         ElUQ==
Received: by 10.68.227.162 with SMTP id sb2mr59672667pbc.4.1352734742757;
        Mon, 12 Nov 2012 07:39:02 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ve6sm4347480pbc.58.2012.11.12.07.39.00
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 07:39:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0nR_9mWDKzKygR379x3L=d4bGKKo27AP-2Y=+coc7H+sQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209480>

Ramkumar Ramachandra wrote:

> Oops, I read about `--pretty` in pretty-formats.txt and didn't realize
> that `--format` existed.  However, your patch is still wrong because
> there seems to be a subtle (and confusing) difference between
> `--pretty` and `--format`.  In the latter, you can't omit the format,
> and expect it to be picked up from format.pretty:
>
>   $ git log --format
>   fatal: unrecognized argument: --format

You can do

	$ git log

and format.pretty will still take effect.  In other words, setting
format.pretty to "foo" is somewhat like making

	$ git log

do

	$ git log --format=foo

which is what the text is supposed to explain.  It is based on the
following text from Documentation/config.txt:

	format.pretty::
		The default pretty format for log/show/whatchanged command,
		See linkgit:git-log[1], linkgit:git-show[1],
		linkgit:git-whatchanged[1].

I do imagine it can be made clearer.  s/--format/--pretty/ does not go
far enough --- it only replaces one confusing explanation with
another.

Hoping that clarifies,
Jonathan
