From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 0/5] pseudorefs
Date: Mon, 27 Jul 2015 16:08:35 -0400
Message-ID: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
X-From: git-owner@vger.kernel.org Mon Jul 27 22:08:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJohe-0003vP-Oq
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 22:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbbG0UIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 16:08:46 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35619 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbbG0UIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 16:08:45 -0400
Received: by qgii95 with SMTP id i95so60335294qgi.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 13:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=KgyGCZz6WjOQMMcBcSdfmG986fUF+gtGl7PzAc6D9B0=;
        b=RnAY+NqTIkY5lfwvxDm/QKVUt9VtC4OQjTumqazNmdYOuwSwCWEIz2vyuowwHDJrT5
         ma3FxM0ELLH8rBYRxeWDMoY/doIkETGLiTDdQEDARvBr1VTA+g1JZtuJST+XOWizyud/
         JXNagHePv7+by39JOgcaLLdu1CEWbTf+to0RyTldaomEfajKmCvpPJl56Ez0BfEo2bKy
         aKKy1WjvboXrqQ2eaoy4f1Y+0EM97g8Lwoiy6sVPrvKclYgRZBdGK1+jEqTbcUkt8KjJ
         wXA5O//MG/22g0o+XTv9KBvbAwBEWMw4nFnn1x5ANRa2ywvFE5RUFkKSfi9aLmYadXex
         z+dA==
X-Gm-Message-State: ALoCoQmax2zxdpZWsUNt2KEww+6zTnHWEYvSskLARGC4DAkqMcVujj4KoRPSqKSpoG7Tdo9YOhMx
X-Received: by 10.140.30.100 with SMTP id c91mr43296771qgc.81.1438027725089;
        Mon, 27 Jul 2015 13:08:45 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm9893690qkz.38.2015.07.27.13.08.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 13:08:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274701>

This version of the pseudorefs patch series is much simpler.  Instead
of forbidding update_ref and delete_ref from updating pseudorefs,
these functions now just special-case pseudorefs.  So we can use
update_ref to write pseudorefs in a rebase and sequencer, and
we don't need to rewrite so much code.

In addition, I made typo fixes suggested by Eric Sunshine and Philip
Oakley.
