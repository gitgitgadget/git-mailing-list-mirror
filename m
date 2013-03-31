From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Mon, 1 Apr 2013 02:21:22 +0530
Message-ID: <CALkWK0=a0wmUe-rjK8Gg8izc0FdXYzChSrgp+W-JNsECsDf+yA@mail.gmail.com>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com> <20130328153547.GA3337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 31 22:52:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMPF8-0007Ul-NG
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 22:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab3CaUwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 16:52:05 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:57958 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845Ab3CaUwE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 16:52:04 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so1824548iea.38
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mx1pkgVuYGj3eMD9LUYDhBy2HN5pu8Ao/tnFWxRD4Ew=;
        b=QLlE9OcLaTZAEhmKYbLWUP2QyVLMl2VancFbQNhFl5GvA28ZuEMdw5KZvDriSlYHSo
         L26b5Mr5QaG2WQRZdb5IbgbEirZNJdM8wQm0axR5fm1DQiU9YyZCjXsmX+D7Ohv6g8Xo
         Jh09oIVnUsqYY9m4TvzZeWasQTbgIStN8/8+e3gSnfNaFTo2i+s/hjroYZSX5qNbZuom
         4NndCJkYPxENd+MpTw6cxhgsRzNcmmgGxtx3BYXZNf2k94p2uhS5uzqOUmRYgpAVohr8
         RFqagbd1qVjoK/wAgqLKfnMU5srelw9Rr8dUB2oX2WX1LWpGqpqHrtNL9CNGhJ1tj8U4
         IKcA==
X-Received: by 10.50.108.235 with SMTP id hn11mr2449827igb.107.1364763123112;
 Sun, 31 Mar 2013 13:52:03 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sun, 31 Mar 2013 13:51:22 -0700 (PDT)
In-Reply-To: <20130328153547.GA3337@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219640>

Jeff King wrote:
> [...]

So, you're saying: don't test compound statements for failure, since
anything in the chain could fail and propagate failure.  I should only
test simple git-foo commands for failure?

> Sometimes it's annoyingly verbose to break down a compound function. But
> I think in this case, you can make your tests more robust by just
> checking the affirmative that the ref is still where we expect it to be,
> like:
>
>   check_push_result up_repo $the_first_commit heads/master

Doesn't that change the meaning of the test though?  I really like how
the original tests read.
