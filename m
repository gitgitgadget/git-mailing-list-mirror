From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (for maint)] gitweb: Fix fixed string (non-regexp)
 project search
Date: Mon, 05 Mar 2012 15:27:50 -0800
Message-ID: <7vhay2y6fd.fsf@alter.siamese.dyndns.org>
References: <20120228183919.26435.86795.stgit@localhost.localdomain>
 <201203041035.03133.jnareb@gmail.com>
 <7vfwdn631i.fsf@alter.siamese.dyndns.org>
 <201203050959.47966.jnareb@gmail.com>
 <7vd38r2d8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:27:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4hJt-0007y2-LP
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 00:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703Ab2CEX1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 18:27:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56184 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757472Ab2CEX1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 18:27:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 857996BE0;
	Mon,  5 Mar 2012 18:27:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k6u9wa+zQ/15I7PnrzTfwgX4MW0=; b=OTVlOX
	HTZfcSi3PKL8e2yXcathf/yob47RdKJgVhb9YHT/0n/HB+scRdvE6T8xfOePu+TT
	HCYC2MYsBSxjDOX/wC/mqKh0smbj97Xd7cRlk7n28SD8FvVEte0qnbE3VtwNEFFE
	6WxH9yIeDkjOjAwxUyUd4ahuYrbug0g16E+Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uAvVh0yYK0sCxMsRaVu3KZplx2f6scjQ
	kiy8DovygFZPeDsep1abyV8Goow4/rQlTiDYs+6FxXs1qeuHEr6X24IdfdUD8x+2
	AECXaa9Ddt2ktDx7nUu2OYnczL3GEe6zet/36rDbZe3ha3voktaXAlb3VMLbsPHa
	xG2+l8B5Aqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CB376BDF;
	Mon,  5 Mar 2012 18:27:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 107B66BDE; Mon,  5 Mar 2012
 18:27:51 -0500 (EST)
In-Reply-To: <7vd38r2d8y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 05 Mar 2012 09:01:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3F66020-671A-11E1-8FE3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192287>

Junio C Hamano <gitster@pobox.com> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>>> Hmph, didn't you already call fill_project_list_info(\@projects) before
>>> search_projects_list() already?
>>
>> True.  Sorry about that. 
>>
>> Can you fix that, or should I resend?
>
> Could you check the following two diffs?
>
> $ git show debd1c2
>
> This is jn/maint-do-not-match-with-unsanitized-searchtext that
> should be merged to maintenance track that lack the lazy filling.
>
> And then
>
> $ git show --first-parent d4b52c2
>
> This is how the above was merged to 'pu' and the conflict resolution
> should be the same when we merge it to 'master'. As our @projects may
> still be only sparsely filled when search_projects_list() returns,
> we do call fill_project_list_info(\@projects) ourselves with the
> lazy filling codebase.

The latter is now

$ git show --first-parent 657c6d0

on today's 'pu'.

Thanks.
