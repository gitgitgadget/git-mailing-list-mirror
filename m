From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Tue, 23 Apr 2013 02:09:44 +0530
Message-ID: <CALkWK0n20f+cBpKWo9E3OVu_OAxNqiz8tkfspFBTBEaQTfE8NA@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <7vk3nupltx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:40:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUNXK-0005VQ-GH
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab3DVUkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:40:25 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:38586 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab3DVUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 16:40:25 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so4046798iec.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JvmcCOeljsAlQhskUSvmJ6ZrnlNhb8PlqzIlWVmvwC4=;
        b=T4RVdXaKPwAArgF7sE470jN8odWxHfBEKj7zxx6nqGGAb5hrEa0UMW3zNit3DIh0Gl
         j1FIkZq2R+nscgFk8Z0KkiUyKzYxjDKlgutJvFuXe0WirOFFfIOa3OcVHRo8nJzSWP5g
         ExKXVHlGdK6qKUG1n4vD4WQwgdoZgyDUJd34ly+FVeIJVKvvPgWUqGOAPs6y4IsUrPZ+
         hKa4uPzmTuKnq7eR7nHVouywBrAm6lEtDs4H97C/NcEO7BFsH9WzeKsoPPYKJWvw3+JR
         AYsoIspL3E6diny80R2488lPsu8meUDylexTVGJh5lz03ZYutGT3hJQ0NfSPbBtGd+G1
         Yozg==
X-Received: by 10.50.50.71 with SMTP id a7mr22201293igo.14.1366663224715; Mon,
 22 Apr 2013 13:40:24 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 13:39:44 -0700 (PDT)
In-Reply-To: <7vk3nupltx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222086>

Junio C Hamano wrote:
>  (1) It uses the given pathname as single pathspec and drill down
>      the same way without "--follow" until it notices the path
>      disappears and until then there is no attempt to detect renames
>      is made.  And it only does -M variant of rename detection

On this.  It might be profitable to auto-follow at a low threshold
(and change --follow to a number  argument like -M, -C).  I'm not
asking you to do it for more than one-file at a time, but I often view
one file's history: I was just going through the history of
builtin/merge-trees.c (what I was looking for was mostly in the
builtin-* variant), and it would've been nice if I didn't have to quit
and come back with a --follow.
