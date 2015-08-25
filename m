From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Porting builtin/branch.c to use the printing options of ref-filter.{c,h}
Date: Tue, 25 Aug 2015 13:47:54 -0700
Message-ID: <xmqqbndvxfgl.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRpMsFr2p=X+Z7z95W+0wGd9i5XaSDeVSmS-BUFCj6dWw@mail.gmail.com>
	<xmqq4mjnyzfy.fsf@gitster.dls.corp.google.com>
	<vpqvbc3t9no.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:48:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUL8S-0002QW-Ud
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 22:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbbHYUr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 16:47:56 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36470 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbHYUr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 16:47:56 -0400
Received: by pacgr6 with SMTP id gr6so1946881pac.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/sg3XCJy2GQAAeJCDHmB1N+d7BeXBDRtJ8iCLf3DOJY=;
        b=Cj2mGdIjekf+aGegjePyteEwzEHyecWTUJ+H5Y8b7zjlTln7+j+uUo6SLGSTIsDTvg
         w4+BXmfCb/uKJpkqnG8K5cyS8UrMftEFFLYNa2H0T9KebarcHhKoHI09jKdprTce9tW1
         sKmO1003wy1PBETWjd29XskSbrWHe5z1HKa5blo7CTyqV85If3ry95cIZatVvl9oZQYS
         BTEXIL/JoUNRq7yHUVD8iHCbLYuPYUvnz/SmWpCB3okAClELgkDJndRJ305t1GBvn4zk
         OTQd4h8w6slX5W5vhXNXYnQupZH0n9AS+0Z1NyJTj/ienPrJ5fySkaPuk4BUIzW99IAN
         fjgw==
X-Received: by 10.68.196.233 with SMTP id ip9mr60789517pbc.139.1440535675707;
        Tue, 25 Aug 2015 13:47:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id z2sm10093836pdp.36.2015.08.25.13.47.54
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 13:47:55 -0700 (PDT)
In-Reply-To: <vpqvbc3t9no.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	25 Aug 2015 22:06:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276572>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Hmm, yes, colors would be difficult to get with this solution. Perhaps a
> %(refname:autoprefix,autocolor) that would pick the color and do the
> textual rendering?

Yeah, that's workable.
