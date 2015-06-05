From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t: Add test for cloning from ref namespace
Date: Fri, 05 Jun 2015 09:46:42 -0700
Message-ID: <xmqqtwumrtl9.fsf@gitster.dls.corp.google.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
	<1433513531-13423-1-git-send-email-johannes@kyriasis.com>
	<1433513531-13423-3-git-send-email-johannes@kyriasis.com>
	<xmqqk2vitbjh.fsf@gitster.dls.corp.google.com>
	<20150605161225.GA23368@leeloo.kyriasis.com>
	<20150605162523.GA25914@leeloo.kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uld-0008Nd-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423135AbbFEQqp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 12:46:45 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33607 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030211AbbFEQqo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:46:44 -0400
Received: by iebgx4 with SMTP id gx4so61593604ieb.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=zHZD0nTfOtv9RIYMfQYoi5Hswr3UDJARYMAZa7qmcJg=;
        b=K/Vih/yurvEIHE05A79AcJQcyAv3U7KTIXetwa/2sWHW7bdZGCImLdHI4B/tw4Pr2D
         OjCb++ph+RxNTyNkyMb29C9TzCLL96dJ89okI+dXjLaUEA2IjQSLmgbtlpy6DbP+F28b
         /LesJ7WzLHHF2hc9+Ns19bCFbK8eDYtmul77i4EqHQq5YlZIqIjVWKRHHfGgBXFZjVEA
         r1ZLnZYImJNPpIzuab3c9hKBBYlRp/VhC+jnKMGa/FQqcb4l8R2TOVPA7X6Tk2625Cbf
         7+hoc+V0eklABO2n/104eRpWwRTD36ZNw8eD9/nLezSfD6nyltmuyoxps2ASt7IkFyD6
         A6Og==
X-Received: by 10.107.9.66 with SMTP id j63mr5775179ioi.37.1433522804137;
        Fri, 05 Jun 2015 09:46:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id ot6sm1685444igb.11.2015.06.05.09.46.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 09:46:43 -0700 (PDT)
In-Reply-To: <20150605162523.GA25914@leeloo.kyriasis.com> ("Johannes
	=?utf-8?Q?L=C3=B6thberg=22's?= message of "Fri, 5 Jun 2015 18:25:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270856>

Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:

> Would it be acceptable to check against
> ../bare/refs/namespaces/new_namespace/HEAD and
> ../bare/refs/namespaces/new_namespace/refs/heads/master instead, unti=
l
> rev-parse is thaught about namespaces?

Yes.

Because I do not immediately see any legitimate reason for the rest
of the system (including rev-parse) to ever start paying attention
to GIT_NAMESPACE, I think that is not even "instead, until" but is
the right solution.

Thanks.
