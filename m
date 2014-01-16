From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] revision: mark contents of an uninteresting tree
 uninteresting
Date: Wed, 15 Jan 2014 16:16:07 -0800
Message-ID: <20140116001607.GN18964@google.com>
References: <1389830384-22851-1-git-send-email-gitster@pobox.com>
 <1389830384-22851-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 01:16:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3ad6-0001Sv-40
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 01:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbaAPAQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 19:16:13 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:41404 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbaAPAQL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 19:16:11 -0500
Received: by mail-yh0-f42.google.com with SMTP id z12so479177yhz.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 16:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=r+gTzKR41PDHhgNeuONMA1FNOSn8Dh/43IGH0dgmLA4=;
        b=i/Qwx1OtJ+MEOH9+CMmp1tByHZbIeoZvwjrTYKk5fXGR7xZyBlZS4qQ4afJQ9j5pRN
         2GISgRv+fOni0H3c6m+NUDw6nXt4xTJ6N1CiYxshAJI4MmX7AtXBbWNF6ceW449bNfY1
         9db9W9CDxg7m3b7zG+wUF7DsSXKTW+RJ43h2aq9fLopMWPjPJHz0Gnp78iKe+q+fOJvr
         LE4/vTKV8c3+F8tQwzLpM2sKY6kFXw7GW5ghsVUnIDK9DxLWhVt+/J5oQ5UMGbE/psJ7
         fpBkJ1XBYpXhRoAjY1gsocVL9bs8qbMP01RARSU/snKubIWMoVzPnFYOARWEqkqszY6/
         8GJQ==
X-Received: by 10.236.63.5 with SMTP id z5mr6172255yhc.49.1389831370852;
        Wed, 15 Jan 2014 16:16:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id k3sm8730204yhc.13.2014.01.15.16.16.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 16:16:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389830384-22851-2-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240494>

Junio C Hamano wrote:

> we see the top-level tree marked as uninteresting (i.e. ^A^{tree} in
> the above example) and call mark_tree_uninteresting() on it; this
> unfortunately prevents us from recursing into the tree and marking
> the objects in the tree as uninteresting.

So the tree is marked uninteresting twice --- once by setting in the
UNINTERESTING flag in handle_revision_arg() and a second attempted
time in mark_tree_uninteresting()?   Makes sense.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
