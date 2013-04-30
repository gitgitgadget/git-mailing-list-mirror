From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 22:53:04 +0530
Message-ID: <CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh> <7vehdsf19m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEHO-0002ug-LK
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672Ab3D3RXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:23:46 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:47086 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932652Ab3D3RXp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:23:45 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so917275iec.8
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yEvkFUmIiuBkRACXUG/b2kZU/0p6rdJGi+lhvRRVDWo=;
        b=pZlu7w6iqn34fvzAo/A8GeBddkdoG6IivWIBsaUv1h3HdnFPqv5IBGBjo/L3dZcRyZ
         v+TmNoO4BAYrWl1h4apwrlwrxCOz9vzuNhTK7buYfz/fM9dsN/uFrhMNDCbqS0GHK5xd
         2WxHukUm9QK7cy3ygmQTp1vZi63JVBmR4gztf6bwocR+cK0LvTRuWoVg6htvSekJxMDC
         v/PFg2TbYsZGa8sKdmNwjl+EkaDQb4J3XzXt7MVy0MHUJh3MGjh/2uWdQoDIP1wv9Ol3
         OZqNB2uwrg3f4eDxzdQgu3ce5OqXfcWzgtP1TxhfeR2quXY8m6qaOxwTzCNWA7p61B6M
         ufcA==
X-Received: by 10.50.66.197 with SMTP id h5mr10587737igt.63.1367342625124;
 Tue, 30 Apr 2013 10:23:45 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 10:23:04 -0700 (PDT)
In-Reply-To: <7vehdsf19m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222954>

Junio C Hamano wrote:
> "git update-ref HEAD $commit" is accepted.  If @ is a synonym for
> HEAD, "git update-ref @ $commit" should work exactly the same way,
> but is it desirable?

>  Would we have $GIT_DIR/@ as the result?  How
> about "git symbolic-ref"?

Yes, it is a valid refname that can be overridden [*1*].

> Would @@{4} and HEAD@{4} be the same?

No.  Why should they?

[Footnotes]

*1*: In the current implementation, git update-ref fails.
