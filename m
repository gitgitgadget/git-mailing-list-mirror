From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confirm my false error suspicions of Gitweb query injection
Date: Mon, 10 Sep 2012 10:37:42 -0700
Message-ID: <7vlighok2h.fsf@alter.siamese.dyndns.org>
References: <CAMOg_eUjmnisevN+AaArz+6TMpWYJL660xwG0ptEaTO7stcL6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joseph Leong <josephcleong@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 19:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB7vs-00022g-9d
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab2IJRhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 13:37:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50369 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab2IJRhp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 13:37:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C0ED97DB;
	Mon, 10 Sep 2012 13:37:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ap2aDlKnYaTTj6rs1OFQIC/4Fw0=; b=S4uWaF
	SOOhCwelftIyGV4e4v9Ir/oahDODs0h6oDybk+ljrFhJCEJt/VvRkVKyCxdh/vF4
	pyLqAkdeW1a9BZd3DqkpicUiQ4xC+DjJBtq5ROmJ35eOc4vxqCFikAMVgMJjYj9u
	hb0wSZljHOrzQr41EYv8THrXTOisLfPbAKnxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XobHexivL49mLrGLve4oWVhxq6aHyIgo
	9n+DnKXBplmes/p3D8V9UQiuPhpdIjq6/x9s9FVA4KgioJkoZsJNve4bLoSxQUrW
	6u16FfYBjvTI5Ig3aqUijlMh1dsPMcCDM8jtDTcXwA9OJ5r9vGv57uiIrUc4XjOk
	C1tFhw9Hesc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEFDF97DA;
	Mon, 10 Sep 2012 13:37:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E6AE97D6; Mon, 10 Sep 2012
 13:37:44 -0400 (EDT)
In-Reply-To: <CAMOg_eUjmnisevN+AaArz+6TMpWYJL660xwG0ptEaTO7stcL6A@mail.gmail.com> (Joseph
 Leong's message of "Mon, 10 Sep 2012 09:45:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A84F4D6-FB6E-11E1-8ED7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205153>

Joseph Leong <josephcleong@gmail.com> writes:

> Hi Everyone,
>
> I'm using Gitweb (Based on Git 1.7.9 on RHEL 5.8).
>
> I was poking around and tried a GET Request (REQ) with some SQL
> statements as a search query and noticed a 500. Can i just confirm
> with anyone here that the error message I'm seeing in the Response
> (RESP) is basically saying that the search parameters are invalid
> because of it's funny chars are breaking the regex search and that
> it's not anything database related.

Yes, I think this was fixed in v1.7.9.4 if not earlier, with e65ceb6
(gitweb: Fix fixed string (non-regexp) project search, 2012-03-02).
