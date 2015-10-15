From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use the alternates of the source repository for dissociating clone
Date: Thu, 15 Oct 2015 14:59:13 -0700
Message-ID: <xmqqbnbzhjym.fsf@gitster.mtv.corp.google.com>
References: <561F8DE9.4040703@cetitec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Alexander Riesen <alexander.riesen@cetitec.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 23:59:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmqYT-0006xD-Iz
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 23:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbbJOV7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 17:59:16 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36121 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbJOV7P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 17:59:15 -0400
Received: by pacfv9 with SMTP id fv9so677515pac.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0ENauveMCTC6m3j/HOC0O3YHHbilb0AEb8SgiJ+bmI4=;
        b=1CusIcawh+kAOUdEHbVCnolw1dy/+kRAa1zVI9lHw4mM1HIr9sfjcVOAmc4OEl3gzD
         /Mu64z8fGfr/FLhprWGCg41Q1GpnimEEglqitMisxiZltAbDSGG6vhNwjfVUKlNpiJzE
         IH17O3wNSiV4t8XPfJbOdOnGsDgX4OLnhIz8R9ux/yFFgSnSToE8ms5wk7MY131FDxCn
         +uCYMFayO4GiZeRI5uEzm5o/byhIABZx2LHL/YzcV/XvfT9iFeYb78FwLEn7/iEMbY6+
         CL69LT6TpUcyEixM6BL10tL0v7bhAIinpaiFG58Io+ZrL1Lz2a1p7VCpV+eWywveRIft
         IPSA==
X-Received: by 10.66.101.106 with SMTP id ff10mr12675072pab.100.1444946355253;
        Thu, 15 Oct 2015 14:59:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id po7sm17207903pbc.56.2015.10.15.14.59.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 14:59:14 -0700 (PDT)
In-Reply-To: <561F8DE9.4040703@cetitec.com> (Alexander Riesen's message of
	"Thu, 15 Oct 2015 13:28:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279711>

Alexander Riesen <alexander.riesen@cetitec.com> writes:

> The "--dissociate" option required reference repositories, which sometimes
> demanded a look into the objects/info/alternates by the user. As this
> is something which can be figured out automatically, do it in the
> clone unless there is no other reference repositories.

I do not quite get this.

Before "clone" with or without "--dissociate" there is no
objects/info/alternates (before "clone", there is no ".git" to find
that file in the first place).

Are you talking about making a clone of a repository that was
created with "clone --reference", to borrow from the same
third repository the original is borrowing from?
