From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fix "git log --diff-filter" bug
Date: Tue, 25 Dec 2007 14:44:29 -0800 (PST)
Message-ID: <m3r6hao0nu.fsf@roke.D-201>
References: <1198580807-18802-1-git-send-email-arjen@yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Tue Dec 25 23:45:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7IWE-00020g-6B
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 23:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbXLYWof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 17:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbXLYWof
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 17:44:35 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:4627 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbXLYWoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 17:44:34 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2487874fkz.5
        for <git@vger.kernel.org>; Tue, 25 Dec 2007 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=kqvnBKYilkpCrloU19ynhfEonXGvb6JstNiH93yXY/8=;
        b=e4Uhuqnqkd0NikxcuVUyDFnSbRV83aQuaVkMqaxBO3D0KPEA44XtQeGYjS7uX26AO5CUUZbc24ZYmfv2C2c+9sIdZuFWE2Om+4JEYPwt5LjFMXbEdnof79GNKxfzmhxoK8zk9FNa/zy2v5unaZV9fUZqIVOHXeS3ZaUGwepUzAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=ndwTCl/u84Cb5hz+LWzNJMhB/Tskc9SBlyhEBKs5paOcnlR/+ERAlJuc2G5KktGLFB8N9wwC5xFvIM35JgN/TOq2vcAxjhMaQ1PAbWyJ5gEQqKsUT5M0PJbSB+mpUcn4GWLKZ/wyt8QNdMQ/swFik5zU08M4JqiQ0KgRochGWYw=
Received: by 10.78.168.1 with SMTP id q1mr7468596hue.76.1198622671416;
        Tue, 25 Dec 2007 14:44:31 -0800 (PST)
Received: from roke.D-201 ( [83.8.190.186])
        by mx.google.com with ESMTPS id d2sm2765514nfc.11.2007.12.25.14.44.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Dec 2007 14:44:29 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBPMiHfV031470;
	Tue, 25 Dec 2007 23:44:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBPMhn2p031465;
	Tue, 25 Dec 2007 23:43:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <1198580807-18802-1-git-send-email-arjen@yaph.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69238>

Arjen Laarhoven <arjen@yaph.org> writes:

> In commit b7bb760d5ed4881422673d32f869d140221d3564 an optimization
> was made to avoid unnecessary diff generation.  This was partly fixed
> in 99516e35d096f41e7133cacde8fbed8ee9a3ecd0, but obviously the
> '--diff-filter' option also needs the diff machinery in action.

Thanks a lot! I was wondering why 'git log --diff-filter=M' didn't
find anything...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
