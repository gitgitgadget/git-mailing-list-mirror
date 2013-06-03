From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC v2] reflog: show committer date in verbose mode
Date: Mon, 3 Jun 2013 15:30:48 +0530
Message-ID: <CALkWK0k-cikpwue4iQDGJgP4NrGdkCw2r=dzzP78+QbsA5BiMA@mail.gmail.com>
References: <517a09251fbbc81073fbd53f04a3f4b58cb8b3f7.1370224175.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 12:01:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjRa1-00052o-Bu
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 12:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756758Ab3FCKBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 06:01:30 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56478 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab3FCKB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 06:01:28 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so9565136iec.5
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 03:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KFF2ZKXQHGYapiPpmR/FSyJVKCBgxK+hrVIshIBAtuI=;
        b=QGK9VborldU62AFGzaLOhKLikMbvSQ5iB/qg+vy5k+Rh3vS1IpxEOit+1Ma2qu90Hy
         cpKSRSVTp6YiMHgyTs9kEJkQo3uYvghxzRIpliyJSHeSovIA3OMoDNKfogJMoPDKE9ui
         nqAk8cjuHTLtBvkBvQVEpmcT4xomi2iMha/smvz8xnSyKECUOcq3z65YHgbnu/fuIWBp
         GtyQi9iPp1EGfM2W5GFujJgszkRL1ITxxASuu69arMugQjJayrxikTal2aY/ESDrLxVE
         znvu6vplz5O+JRpyWcamIP1GRXK/PoINOFVUd7QP6V/7KS84nyrhZNz8dTJ4mfbmhqB4
         hnKQ==
X-Received: by 10.50.32.8 with SMTP id e8mr7522976igi.89.1370253688360; Mon,
 03 Jun 2013 03:01:28 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Mon, 3 Jun 2013 03:00:48 -0700 (PDT)
In-Reply-To: <517a09251fbbc81073fbd53f04a3f4b58cb8b3f7.1370224175.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226210>

Jiang Xin wrote:
> It will be nice to add this pretty formatter automatically when run
> `git reflog` in verbose mode. And in order to support verbose mode, add
> new flag "verbose" in struct rev_info.

Sorry I missed earlier revisions of this patch.  Generally speaking,
"verbose" is a bad way to control format-specifiers.  Why not add to
the list of pretty-format specifiers (like oneline, short, medium,
full)?  Also, this patch is extremely pervasive in that it teaches a
poorly defined "verbosity" to a very low layer: revision.c/revision.h.
