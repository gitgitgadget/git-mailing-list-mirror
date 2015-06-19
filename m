From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 19/19] fsck: support ignoring objects in `git fsck` via fsck.skiplist
Date: Fri, 19 Jun 2015 13:40:14 -0700
Message-ID: <xmqqsi9n5t5d.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<692a41377d0bd47934170ea9b22a68f9dd893f38.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:41:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z635z-0003xd-SE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381AbbFSUk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:40:58 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33608 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbbFSUkR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:40:17 -0400
Received: by igbqq3 with SMTP id qq3so24833128igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hoFhyYYg+H0voz3hg/K9XZqe8Lp9lAZeDedn9ICga/w=;
        b=prnE/41zHMnp5lp6JLtkHf9DxnZz9qFJtMx0ctSmMfCsGqMs+FoGcSt4JYRgcJlKJ9
         DSjBOd/k3e8a70SH6BsJgvbqN0Z8UCLWTf72i7LVQc3qJs/0yZnW+ajEa1FXg560YHru
         qJzXsTox7riJ3LOO6oGwhyOpWICQVkxLJrQqMxiNzaee0cZYh1fRJ/ZIfx0rh3urnU9E
         j0mZlPvYpo7e716WSed6hl7kHAp3aRg+lGUgbhdUvkNJKudC1ghifozbDgMZNmUfGtU/
         y4oEd+ULh2N6tT1OVZUG2e52HXnVl7X6CAGJTINs98ZvEtE5m/p5RxVle8e70R2yD0vN
         DvVA==
X-Received: by 10.107.132.16 with SMTP id g16mr2226102iod.25.1434746417148;
        Fri, 19 Jun 2015 13:40:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id s28sm6371491ioi.31.2015.06.19.13.40.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 13:40:15 -0700 (PDT)
In-Reply-To: <692a41377d0bd47934170ea9b22a68f9dd893f38.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:35:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272200>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	if (strcmp(var, "fsck.skiplist") == 0) {
> +		const char *path = is_absolute_path(value) ?
> +			value : git_path("%s", value);

Same comment as 18/19.
