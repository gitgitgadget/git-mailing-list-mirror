From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] inline constant return from error() function
Date: Sun, 11 May 2014 02:13:01 -0500
Message-ID: <536f22fd76455_6535d01308cb@nysa.notmuch>
References: <20140505212938.GA16715@sigill.intra.peff.net>
 <20140506151441.GA25768@sigill.intra.peff.net>
 <xmqqppjqczhq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 11 09:13:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjNwg-0005X0-UC
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 09:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbaEKHNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 03:13:11 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33220 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882AbaEKHNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 03:13:08 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so6828106obc.27
        for <git@vger.kernel.org>; Sun, 11 May 2014 00:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/EYGgtZz4y32ycZICFjYV1SnvcZm/r5VW1izpNdEpTk=;
        b=CFgeRLejXYbetsBlGCm+rk7c8iDccHG9ColJmTBlAeaQJlA5ZaHblM9BnhUw/RdiiF
         Hz1TRPoVh2ROlKVRjQyNvh68MJZuRDYLDsd/JMWYSlD9zT6yOHpK4U+djREbJDV5l2eD
         QasNvbafVLjsMamfRnFvJzv5sdfMZTbZGP95sARluB73LlxQxfj5GkMwT8GWRxVxCoF8
         fqr2A2Tv5Lle40app6ABndRoZ4gFwvmRgX2DT6iti6W+trQPZ1horp8qOaa9+OJsHvQe
         gdbh3QputhAWHhta1BukvIGABE1ElIcemqS4tv6M/NrL2pyVPWb0mYgoZ/wHgDkqGhtT
         phIQ==
X-Received: by 10.182.205.135 with SMTP id lg7mr25792299obc.32.1399792388042;
        Sun, 11 May 2014 00:13:08 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm35358191oeb.3.2014.05.11.00.13.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 May 2014 00:13:06 -0700 (PDT)
In-Reply-To: <xmqqppjqczhq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248673>

Junio C Hamano wrote:
> That's kind of W*A*T magic, and I generally try to avoid magic, as
> long as it solves your "can we make both -O2 with new compilers and
> -O3 happy?" I wouldn't complain ;-)

In case anybody is looking for a non-hacky way of doing this that
doesn't depend on the gcc version of the week, this is how I silenced
the warnings in git-fc:

https://github.com/felipec/git/commit/e14ca39ba0092f0305d5fb347e20b829f736b29b

-- 
Felipe Contreras
