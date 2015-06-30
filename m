From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/4] More helpful 'git status' during 'rebase -i'
Date: Tue, 30 Jun 2015 16:03:25 -0700
Message-ID: <xmqqpp4cbxz6.fsf@gitster.dls.corp.google.com>
References: <1435669275-32102-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 01 01:03:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA4Yx-00081Z-Ka
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 01:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbbF3XDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 19:03:30 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35287 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbF3XD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 19:03:28 -0400
Received: by iecuq6 with SMTP id uq6so23069775iec.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vcBv05pMbiOc4PeVOODrw426Xxv+4CRxURaiMlC7G2g=;
        b=ttTrSy9KYmvYXQCugI1fhRo6TfC2FSF9XpaK9nCRhZ2Y/F6DNK7q8Tk82iz+/cGJyG
         xiptEmKXyamF7briAIeD/2fvolTR6dwUDm2PDZJFZEIPMSocrcVo7SGkF7fkCIHxCcpA
         HXYMTFKkIdRIjwQTgArP83ZoWU6aXLQNOos3+h5T+uKN3R0fDC/6qbWoKhourUQ/TfbQ
         qxs68FHDqtnDSTo3dMUngEvwws9ewgjemoHlElC6IXk+wyMMk5bWGFctz2V2g/D5eYw8
         sIm8XbgsNKaYiomKznDw5JZ67jebrZyKitXjxWHY5z/BUXDDUWsV82NepuAoce0uhWwb
         7LaQ==
X-Received: by 10.43.66.5 with SMTP id xo5mr121868icb.57.1435705407311;
        Tue, 30 Jun 2015 16:03:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id k74sm31104153iok.30.2015.06.30.16.03.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 16:03:26 -0700 (PDT)
In-Reply-To: <1435669275-32102-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 30 Jun 2015 15:01:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273111>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This series makes "git status" provide an output like
>
>   interactive rebase in progress; onto $ONTO
>   Last commands done (2 commands done):
>      pick $COMMIT2 two_commit
>      exec exit 15
>   Next commands to do (2 remaining commands):
>      pick $COMMIT3 three_commit
>      pick $COMMIT4 four_commit
>     (use "git rebase --edit-todo" to view and edit)
>
> in addition to the existing output, when ran during an interactive
> rebase.

I'd prefer to see these $COMMITn abbreviated, just like $ONTO.  Look
what I just got while squashing two adjacent patches ;-)

# interactive rebase in progress; onto a04bfc2
# Last commands done (2 commands done):
#    pick c186b073f46a3298f2e6f63a8c1becb07bedc4f0 rerere: explain what 'want_sp' does to is_cmarker
#    squash 17c5b40b46c0e171ed49907e6cb91c2a1d7f7113 rerere: drop want_sp parameter from is_cmarker()
# Next commands to do (3 remaining commands):
#    pick 8fc64c4c1024006e71cf0b6c2e3d0ad403f263f8 t4200: rerere a merge with two identical conflicts
#    pick 094950cdc51599f6fec1b1c0098816888a648bf8 rerere: document internal I/O abstraction
# You are currently editing a commit while rebasing branch 'jc/rerere' on 'a04bfc2'.
