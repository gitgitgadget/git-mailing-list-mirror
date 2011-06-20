From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 08/20] remote-curl: accept empty line as terminator
Date: Mon, 20 Jun 2011 08:35:51 +0600
Message-ID: <1308537351-23209-1-git-send-email-divanorama@gmail.com>
References: <1308496725-22329-9-git-send-email-srabbelier@gmail.com>
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 20 04:39:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYUOG-0002w0-UT
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 04:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab1FTCfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 22:35:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51179 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab1FTCfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 22:35:20 -0400
Received: by bwz15 with SMTP id 15so1902261bwz.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 19:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=PR9cIoRRTl7z/vJBv1o726nXbYa2aHSL6Fwk89o2tcc=;
        b=ZaVAoRr1J2CfvYsJB0Td+/bSbGk4Pn8qDBj8NlFLyCyl6wrbRLgdcsjS1W1esinOn0
         wZp5bZKgEw04/9ho3hPafxefKMXsqCf//eCji3vqAvJd7Dte7l5w9k/5PUjb5GQeDaYL
         PlEta74nXgdN1TVZi+ne7tguvfhAkJpPqTb7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KcffCBAZ65QscN8qzKmp51OW224gkEsDEjfZirEsFZ4MKRbWi10SSsWWWB99mSq+vR
         AiQB5Zv0nAU4ETJr8484PPGe9Glo2x8dwwT9l07lSECdaVCWnv4hPg4deutPUOTPDHqD
         Yj/2LeOm/7X+N7wymEcBvwFi09MkH2dme7zlM=
Received: by 10.204.7.6 with SMTP id b6mr3646944bkb.177.1308537312897;
        Sun, 19 Jun 2011 19:35:12 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id g13sm2186268bkd.22.2011.06.19.19.35.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 19:35:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1308496725-22329-9-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176047>

As a next step, won't it be better to use "exit\n" or "quit\n"
as a terminator? I don't see a convention of terminating on a
blank line in docs, only on EOF. Also I can imagine a blank
line being read in a case of communication error, I mean a
helper can miss the error and see "exit normally" terminator.
