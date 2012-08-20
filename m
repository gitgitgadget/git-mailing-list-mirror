From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Mon, 20 Aug 2012 15:52:02 +0200
Message-ID: <6231669.WggyDX4Xa3@flomedio>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <8572000.QUVXl8yetS@flobuntu> <7vzk5srm9w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 15:52:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3SOt-0004W3-DE
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 15:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab2HTNwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 09:52:09 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45962 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab2HTNwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 09:52:08 -0400
Received: by bkwj10 with SMTP id j10so1862213bkw.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=zXJJUxWHKxHabMOMZTcQ18q2Y/kkGwClt+syPheCa88=;
        b=KQNiD3wAsF4Uew3S2LVSY9/JA6vXySCTJYVENKkdXbciGs8+Jmnav7l3cTyfgfCesO
         gNa67+H56f9YbgJsf3hAhmyKPmpoMcZz5TG5QmUT3op3/Rg/bBBJzzEuTEvBiLVRTSDO
         gbdPtoN3SavKEc64dFvDswOS/LF73p1Z6xTB01O2x9uTzclxUMN46vD7oyZBs6BB4wn7
         Llo2c5D2fn5DrwG7wL51E18YjNt431D6lhF5VTRHEWn1UvCRzKeq/WFqB+A9cZ+9dYa2
         Xs8C4TiybzYbN9kSU7YoAdGZla/SZZ+f/CoeeV4deyDDttkxgT+jzIoiEIbk96yF9PI5
         qqnw==
Received: by 10.204.130.146 with SMTP id t18mr4368848bks.65.1345470726682;
        Mon, 20 Aug 2012 06:52:06 -0700 (PDT)
Received: from flomedio.localnet (93-82-147-129.adsl.highway.telekom.at. [93.82.147.129])
        by mx.google.com with ESMTPS id hg13sm6240004bkc.7.2012.08.20.06.52.04
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 06:52:05 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vzk5srm9w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203842>

On Saturday 18 August 2012 13:13:47 Junio C Hamano wrote:
> That indicates that one necessary patch to add logic to Makefile to
> go and build that subdirectory, at least before running the test,
> but possibly as part of the "all" target, is missing, isn't it?
> 
> Or you can add, at the beginning of your tests files that require
> the contrib bit, to have something like
> 
>         if test -e "$GIT_BUILD_DIR/remote-svn"
>         then
>                 test_set_prereq REMOTE_SVN
>         fi
> 
> and protect your tests with the prerequisite, e.g.
> 
>         test_expect_success REMOTE_SVN 'test svn:// URL' '
>                 ...
>         '
> 
> without changing the top-level Makefile.

What version would you prefer? Currently nothing in contrib/ is built by the 
toplevel Makefile..
