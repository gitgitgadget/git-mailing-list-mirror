From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Tue, 26 Feb 2013 22:32:16 +0200
Message-ID: <CAHXAxrOcC7GX-rhT793t4vcF68TvrE9w9OW856+7cGDBGMx0VA@mail.gmail.com>
References: <20130226201305.GA3502@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 21:32:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UARCc-00030y-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab3BZUcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:32:18 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:59657 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab3BZUcR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:32:17 -0500
Received: by mail-qa0-f42.google.com with SMTP id cr7so2759695qab.8
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 12:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=Aqx82I1NEVYQiL7XdDmC9/jSwgv/Ya8urEZ3aVNitNA=;
        b=SeDoys62wN2KuxfNjcGyp0oMSi3H/zEOEhrobGL1CQoRKHyUg6yTbgMNQXRAddEOFG
         m52ABeHDgzNhaA2CXBzkMLaK+h5hERc/wSgV8tsZv4J3FiwMhHHU2Y/HuvC/gZossWkx
         HhDQSAKM8l/RODZOklbBfceZdxI8JJdt8huywTumzO5Iu4uonsm6nARiYi0QsB3jyQbl
         3j6blUcfuembmbetYDX3D6q6pSd59sdjsVSXX9RXTipLAP3MTI0fl7rlVKdphPIUaypZ
         Zjg3zQkVE+iX97q8uetFFOoQpEtR3EGm3UgFoV4ZJzfdOsmCC/S60t5Z0c76G+bR0gwj
         H1PQ==
X-Received: by 10.229.107.33 with SMTP id z33mr4674402qco.144.1361910737045;
 Tue, 26 Feb 2013 12:32:17 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Tue, 26 Feb 2013 12:32:16 -0800 (PST)
In-Reply-To: <20130226201305.GA3502@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217179>

> If I remove the call to pthread_create, it doesn't output anything and
> exits successfully.

I see. Most resource managers use procmgr_daemon(), which has no such
limitation. Anyway, as far as I can see current git sources do not use
fork together with pthread, except for daemonize() function.
