From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] pretty-print: add --pretty=noexpand
Date: Thu, 17 Mar 2016 22:36:16 -0700
Message-ID: <CA+55aFw=obdDSTS98GQi6ER3RgAxD61xDmXYVeEX=a3GKM6SOg@mail.gmail.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	<xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
	<xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
	<xmqqoaacy9tm.fsf_-_@gitster.mtv.corp.google.com>
	<20160318050807.GC22327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:36:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agn5D-0004iC-3t
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbcCRFgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 01:36:18 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34344 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbcCRFgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:36:17 -0400
Received: by mail-ig0-f194.google.com with SMTP id av4so2140031igc.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 22:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=vM3gZ4Ql2BQfmdRo0N5qJ6N8WK9DLUEt1jRmO0w0zrQ=;
        b=0bCqXPkzGVwgeC+JXdpTGfoRUWLwKbLhSxZIvvV6i7wJ5hgyXYq04z54pfGKnYHOJo
         qfeOM9Oj8wM0R3FtSDWnmZ8yVohqSqRQ2FcXjV3HH0mBAspU5xv8xoVcbc3UmpY7rM2a
         N3gal39DTfoyA5x9iidl9CfJME8Xw/RKJUS6QBP+pbJ6yKivEmX7IRFnTfci5L8MEv4x
         NIhIlJMRz+7av33m0mvqoElmdmNpbnahJUX8QqhqSY4ZnlXO3Se8DW+ec6bAuFW/JdpH
         QL4U1tzwPjW6fbZV38jPZFEBqc7udU/TJuzYGEjQ2gTgp4Z5mCry1tbDFkbeuX6AxNYU
         VSKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=vM3gZ4Ql2BQfmdRo0N5qJ6N8WK9DLUEt1jRmO0w0zrQ=;
        b=AKsQlmsxigLSnkhC55GxtVfPk4uwkNjG+V3Rh4EW+F6+5IABDfjOssZzNGMp79LDF8
         eYezlc+w2FYGx6/JKctYupDQCArjjE+0U7u2DFet+4j6WMz2ujNH3fzLRZLYjZeLrwCo
         d/3lK7kyA1jpiVS1rbdCZ+Ph2bc4cymqvaDMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=vM3gZ4Ql2BQfmdRo0N5qJ6N8WK9DLUEt1jRmO0w0zrQ=;
        b=LtD6wQf8El6O6+8ZQUeYDJZa9+ynwzkAIlQjMCqxUnPDQTQcaJJzIY2dAhpmjHA9eL
         zAFTxCenM2reOfhu7m4S4tCg5Se+4AeqFxpFtvgKncwp/zoqazHnUAqMELIPPZZDDMny
         0noPz5k/UENTcskd8TcHloQULK19pNCc9i2zi08vBOsWlxy6Z4plAtSv/itC3pQ3b/9H
         h/FF/TAF0RTkBa8IvwCDNiFrjoGdU9h/bZPJ13abo+McyIS9cYbLDOLHCqPev/C6dPRB
         /rcPfyrxsdwRxbsV55qHqXg538Tj8ssiNXNBisCTO0gbnnvt+cnRTPL6OYw+vhTNpQTL
         C9Sg==
X-Gm-Message-State: AD7BkJJPgcaclMmspLuLXkd3mkWn2VAQq75Wh5UEPhbVS6vlGn+uGehdYpfpLSnZKqZ+zl/4KfgObBKkCHiEwg==
X-Received: by 10.51.17.38 with SMTP id gb6mr15500852igd.45.1458279376473;
 Thu, 17 Mar 2016 22:36:16 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Thu, 17 Mar 2016 22:36:16 -0700 (PDT)
In-Reply-To: <20160318050807.GC22327@sigill.intra.peff.net>
X-Google-Sender-Auth: WLIVza5OAsfmEmXZso-CGnaf62g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289192>

On Thu, Mar 17, 2016 at 10:08 PM, Jeff King <peff@peff.net> wrote:
>
> Hmm. Isn't "expand tabs" orthogonal to the rest of the pretty format?
> That is, couldn't one want "--pretty=fuller, but with tabs expanded"?

Yeah, you are right, one easily could. And in fact I end up doing
"fuller" myself occasionally, because I check peoples commit
timestamps (some people have a nasty habit of rebasing when they
shouldn't).

So it's not just the medium format that would want detab by default,
it's "full" and "fuller" too (but probably not "raw": that indents the
message too, but the only real reason to use "raw" is for scripting).

So it would probably be better to make it a separate flag, and not tie
it to a particular log format (and just make the log format set the
default).

               Linus
