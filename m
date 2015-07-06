From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 06 Jul 2015 10:59:58 -0700
Message-ID: <xmqqbnfp180x.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
	<xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
	<CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
	<xmqqegkl2qu2.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
	<xmqq615x2ph1.fsf@gitster.dls.corp.google.com>
	<CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
	<xmqqwpyd19dy.fsf@gitster.dls.corp.google.com>
	<CAD0k6qQhER7cDsSG21CnnMxZE+B1BbQh1AkcAgiS3Jpm6WEMcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 20:00:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAga-0007gt-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 20:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbbGFSAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 14:00:04 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34456 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbbGFSAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 14:00:00 -0400
Received: by iebmu5 with SMTP id mu5so118317009ieb.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vMHF6gqaWXDBLORqFtHq2qwPXyTHKcPyRHXas3GHp3I=;
        b=jHqY6T/8cr9szdzdRDh9VszRBG3+opW0o9QDP3nNzqlq9uhvkB+hmfvUVloyszYORq
         Mmk0OOsY+ouT4hoXphcUq6f9f24Zqj4NPbb//h9HbL+yyHdq48AQn73CvQ0VMt4NwtKj
         idVKnro64HSggqu2sL5R5OmEU7m8JM+EJZ8jqs7/CmrWcOc0NfzvvF2ypI5U1sUjq1Pm
         B9GHL0S1M3mV8g/1gg6eMG6KLujRKSxyFdcPsXz4MBHQ6sKs6gSYplFaGO0yPjVBIJj5
         FY9ChZo62Bq72fQBGHNJ4Dsghz8HCrVZ+e5/9OR5W09O8cAMyYWFgcEkg9D/QZn3fk0K
         0etQ==
X-Received: by 10.43.89.72 with SMTP id bd8mr25335919icc.20.1436205600249;
        Mon, 06 Jul 2015 11:00:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id c12sm12885034ioj.39.2015.07.06.10.59.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 10:59:59 -0700 (PDT)
In-Reply-To: <CAD0k6qQhER7cDsSG21CnnMxZE+B1BbQh1AkcAgiS3Jpm6WEMcQ@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 6 Jul 2015 13:35:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273443>

Dave Borowitz <dborowitz@google.com> writes:

>> That existing implementations of the receivers treat an empty packet
>> (i.e. "0004")
>
> or "0005\n" ;)

Is that true?  I think

	len = pkt_line();
        if (!len)
        	break; /* flush */

would give you len == 1 and would not confuse it with a flush.
