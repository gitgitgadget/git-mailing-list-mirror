From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch command is incompatible with bash
Date: Tue, 28 Jul 2015 08:23:40 -0700
Message-ID: <xmqq4mkogvb7.fsf@gitster.dls.corp.google.com>
References: <20150727121253.GC17338@2vizcon.com> <55B69E68.90306@kdbg.org>
	<xmqqh9opgtjz.fsf@gitster.dls.corp.google.com>
	<55B72F09.3030000@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anatol Rudolph <a.rudolph@2vizcon.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 17:23:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK6jN-0004BC-67
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 17:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbbG1PXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 11:23:44 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33419 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbG1PXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 11:23:43 -0400
Received: by padck2 with SMTP id ck2so71491533pad.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pUovIfTpp4fA0joK+INrLPnMcrTYD8S+pCb6VWga9Wk=;
        b=V4fn01Cgnm0LbYML1kmDlf/wXIsTwvIxtC1pe4KrZBb9EVFWzGALjtAGrGLcfQn6fi
         Szf7h8tI+RVN9b99AQaeEuEa5MCL9PUnKi1doUCfBA2dOV7/Xc79xU0KiJ29dw77Xo2o
         uo0bP8jS5Ac9FbuZsztQZUV6o2Z8FGtAFUvIUdkVjypBNIFNrH2FWChfRFw615POvI3N
         RFBpor0elDeo14KMhJ0LEdkq5feQZf6JuCANbxkU7OISnkOyd+R5NVHT7SOUc653U8IU
         uE+qo+/QdiPijdYqShOYArq/UUBPTcptmNra0ZgLt2l48l5gp70SoIK4a/+8kSOYPSlT
         k1yQ==
X-Received: by 10.66.222.41 with SMTP id qj9mr83195066pac.139.1438097022578;
        Tue, 28 Jul 2015 08:23:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id nx9sm35838455pdb.12.2015.07.28.08.23.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 08:23:41 -0700 (PDT)
In-Reply-To: <55B72F09.3030000@kdbg.org> (Johannes Sixt's message of "Tue, 28
	Jul 2015 09:28:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274775>

Johannes Sixt <j6t@kdbg.org> writes:

> Are you trying to say that the result of 'rev-parse --abbrev-ref HEAD'
> is suboptimal and that of 'symbolic-ref --short HEAD' is OK?

My "Interesting" was primarily about that I wasn't aware of the
"--abbrev-ref" option.

Yes, I am sure some time ago I accepted a patch to add it, but I
simply do not see the point, especially because the "--short" option
to symbolic-ref feels much more superiour.  "What branch am I on?"
is about symbolic refs, rev-parse is about revisions.

I can see that "symbolic-ref --short" is much newer than the other
one, so addition of "--abbrev-ref" to "rev-parse" may have been a
mistake made while being desperate (i.e. not having a way to do so
with plumbing, we wanted "some" way to do so and chose poorly).
