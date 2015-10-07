From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Wed, 7 Oct 2015 13:42:30 -0700
Message-ID: <CAGZ79kZmon6xwDE2reSOjM87HfG_dqc6-Rk2KzxnePLAN=BiQw@mail.gmail.com>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
	<632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
	<20151006135101.GA11304@distanz.ch>
	<ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
	<xmqqfv1mvawu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Tobias Klauser <tklauser@distanz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 22:42:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjvXo-0007xI-AH
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 22:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204AbbJGUmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 16:42:32 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34056 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbbJGUmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 16:42:31 -0400
Received: by ykdg206 with SMTP id g206so30159278ykd.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vTcr51pEdxoGDCYGnofIYoLymgp3sHPDV50XBhjUjKU=;
        b=FpNX5j+6YylmTUFHS+owc1rwJrFRxAvGGkpJO7dguj1ErdibZpffv2mI9mSBt+Monj
         +ir/8m0+6EdXQSj+pm44qtlCK1W3l8WABf5nEwAj0xL1wCQO4Qe0H20mTAHCrkHuJrsB
         haLM6ZE0r8YP3uAeeSaqLKoHfkylEmiZmqd3UQOkNr+AD2r3vvDtNrrQFN88xGSxXyTH
         Gizyy0SsPqD2nfV1EWZloSTr7v2AHBtCdxJ0v/ONBNVue5GpT+g6Gwo4/1aS+tyH9PZT
         szIedhA+kcZmnuayebAAIr2dJH9612FPHdDw2Mto5HB1MuiscvjVAviMobYXvQtbgpz7
         uT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vTcr51pEdxoGDCYGnofIYoLymgp3sHPDV50XBhjUjKU=;
        b=bt2auuQf9fQyXompMB/tl7AlnN1/fLeqAaxKsDm7gjWW2i08qv1CaRTFijOuCRCTNk
         j679GBaffkJ2TzzKqx+Am4nKY052Pfi3DAknuEPv5LTmwBrivlz5PFUxf/sPsxvjGLpB
         DXohEH2w/dk3khuF/NWgG/FZ93eGJO4+GQ2THJJc5J7cyytsNt7U+bdZPMGs87P0RMen
         0voWZN3H+8TF8tePCjeai7fY+W70E5u7QDOZY9V6+pFTdMNZxdf2ycGfm5ppdC+Hkqzk
         dPCbVa04ACbFuTdnIA4l4eiwq7QkXfu+0RYIztdyS/h/NvkThwomh1QCwanMzhZ6tQnL
         fVjQ==
X-Gm-Message-State: ALoCoQk9W1kSnKrQVWRDujaSVm2kR982nHiT9+1U80Pszb4qlfps3tW2JfYR6rz2+Dq45Qrkl2rW
X-Received: by 10.129.4.207 with SMTP id 198mr2990215ywe.320.1444250550377;
 Wed, 07 Oct 2015 13:42:30 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 7 Oct 2015 13:42:30 -0700 (PDT)
In-Reply-To: <xmqqfv1mvawu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279196>

Compare to a patch[1] I sent a while back and the discussion on it.

[1] https://www.mail-archive.com/git@vger.kernel.org/msg70474.html
