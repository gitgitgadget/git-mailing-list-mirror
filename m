From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] builtin-branch: improve output when displaying remote 
	branches
Date: Fri, 13 Feb 2009 03:06:25 -0500
Message-ID: <76718490902130006r4f125752wa207056d72630e84@mail.gmail.com>
References: <7vhc30qki2.fsf@gitster.siamese.dyndns.org>
	 <1234503271-78569-1-git-send-email-jaysoffian@gmail.com>
	 <7v7i3ug7y9.fsf@gitster.siamese.dyndns.org>
	 <76718490902122245q6f530bb5sc85a65e065966eda@mail.gmail.com>
	 <7veiy2eptb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 09:09:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXt7D-0007SL-Sj
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 09:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbZBMIG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 03:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbZBMIG2
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 03:06:28 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:41620 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbZBMIG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 03:06:27 -0500
Received: by rv-out-0506.google.com with SMTP id g37so604978rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 00:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3vnwetuOclpwcaKhwt15ah/cVTW82y3QBnKAkcpXqkE=;
        b=bmyDYIsnYNMMyTwTLqlMo5gfybJVQB7J7U3LSaXbvQajUo+WJW5lZRtS91LB93EzAD
         awACTbpDcHBH5WP9CN7M2ibFmhiSH5O9A5GU2KUq9z7hccl0od/hmDm1yojOe6sMyl9d
         Y9sgdq36bdUMmZ6QY94mOd60/ZvBr54IUWJS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UGbIV08P/gAyZF6yzjIwhA8K/kbqP8VmkNmok7/YpqAO6O5C5ZLBnZiVDpGrA+0TF+
         91/7RQffClCizsTp5bmWvAacgd4o/IiuWcFYcTTCy1jglX29Q/tO6qsQmv7PTMc5PWva
         SdPXooy4sNjtBSyNeadTFtc06SFw2hNSiWZwI=
Received: by 10.140.165.21 with SMTP id n21mr1019793rve.86.1234512385429; Fri, 
	13 Feb 2009 00:06:25 -0800 (PST)
In-Reply-To: <7veiy2eptb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109725>

On Fri, Feb 13, 2009 at 2:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> This strikes me as premature optimization.
>
> It is *not* an optimization.  It is reduction of code duplication to
> improve maintainability before copy-and-paste gets out of hand.
>
> The proper adjective for it is not "premature" but "preemptive".

I'll re-roll the patch again. However, if you look at the rest of
builtin-branch.c, you'll see there are more places than that which are
structured similarly (e.g. delete_branches). So if someone wanted to
add another branch type, that would be the time (IMO), to refactor the
statement at the top of append_ref().

j.
