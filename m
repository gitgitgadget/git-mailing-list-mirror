From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/17] path.c: drop git_path_submodule
Date: Mon, 10 Aug 2015 15:50:40 -0700
Message-ID: <xmqqfv3qu5a7.fsf@gitster.dls.corp.google.com>
References: <20150810092731.GA9027@sigill.intra.peff.net>
	<20150810093627.GJ30981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 00:50:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOvu2-0000k3-Mv
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 00:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbbHJWun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 18:50:43 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36147 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbbHJWum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 18:50:42 -0400
Received: by pdco4 with SMTP id o4so76141903pdc.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=x83074VjHOsnKWJhb/AILs7evBn+eBTHMSEnncw/3gQ=;
        b=MqwQcW5u4xD9vZPPFL0hXMtTnBQLQnd11nvTB9lbJ1PkCfNlx+nglYt61CGD+SnGLv
         LU/iBsMObLyZLWBjTQle7BDvViutwi1vbATPz3uyUGHriyR6MHck8IvmWhFnE9hw3jnq
         7879LYaH02A78wiPi8bcSkYeHMy2Kw3pGzEWsc6hH6uu/DBLKx4gVmIf1wyk4mHPAawM
         v26QZ4jywAwO2IxyA4IMNM/NSo+R8fFZEgplygDaArvInT74u7/MrYulxr8ZjrwaoeSa
         yaTxGMcR0lPKUAV7AscE9nIHwOoUKhELeGHWY1mVR9j2HobhPWdA7ZRr0LfWGWj2vz2k
         y4Sw==
X-Received: by 10.70.65.99 with SMTP id w3mr49808318pds.132.1439247041826;
        Mon, 10 Aug 2015 15:50:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id x2sm1397pdx.63.2015.08.10.15.50.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 15:50:41 -0700 (PDT)
In-Reply-To: <20150810093627.GJ30981@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Aug 2015 05:36:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275662>

Jeff King <peff@peff.net> writes:

> There are no callers of the slightly-dangerous static-buffer
> git_path_submodule left. Let's drop it.

There are a few callers added on 'pu', though.
