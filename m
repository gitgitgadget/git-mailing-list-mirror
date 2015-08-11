From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/16] lockfile: add accessors get_lock_file_fd() and get_lock_file_fp()
Date: Tue, 11 Aug 2015 12:29:51 -0700
Message-ID: <xmqqpp2tr5cg.fsf@gitster.dls.corp.google.com>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
	<4676c6a550fecceb921cc71b3cc5320004c6b0c8.1439198011.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 11 21:30:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPFFr-0003oj-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 21:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbbHKTab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 15:30:31 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36574 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbbHKT3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 15:29:53 -0400
Received: by pacrr5 with SMTP id rr5so133973757pac.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Q29XvkHP/tdN48eaT6359gzHKAc444DtOjomM/WK7/A=;
        b=cuN0YP8uCBruQ/zB/CNf1SwdaWTeoPQvq27W/sbdKI+hNm/ATvF/KPwBnIznSiA+yc
         GIECBY8UOki7tP1Tylb0i8IDyW248pf3XwbJzKgPaBRTmjmTh8uKGG7am/2IdCEX5ZJX
         vSFLZmm2aLUueR+Uw1FHiOixB8fRoO0yKyU6yV4/VHG3jrDAQ2epGfopFlWfpAs/ioIz
         TqM/SuYqV2Rwh2mWrZbFH6T+rBdVh7GJxyU9WJNCAtvjdxppnlOJPnx1xzljO7vdhcQ/
         B5HewhR1Azzh66peCwzVPOs8f242U2axRHEbngJU7O47y/XODP0i29izS7DV0TqD4spg
         rLIw==
X-Received: by 10.66.220.5 with SMTP id ps5mr60420311pac.157.1439321393060;
        Tue, 11 Aug 2015 12:29:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id vg4sm3602223pbc.90.2015.08.11.12.29.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 12:29:52 -0700 (PDT)
In-Reply-To: <4676c6a550fecceb921cc71b3cc5320004c6b0c8.1439198011.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 10 Aug 2015 11:47:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275713>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> We are about to move those members, so change client code to read them
> through accessor functions.

Hmph, _fp() variant does not seem to be used at all at this step, though.
