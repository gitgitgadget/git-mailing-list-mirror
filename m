From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v4] commit: add a commit.verbose config variable
Date: Fri, 11 Mar 2016 04:32:19 +0530
Message-ID: <CAFZEwPNmMB5ggCFRV913wEhGTkZaGLaJgY9b_Rm_2Ho866fiUA@mail.gmail.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
	<xmqq60wuc5ev.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 00:02:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae9b6-0003R1-MN
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 00:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbcCJXCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 18:02:21 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36727 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbcCJXCU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 18:02:20 -0500
Received: by mail-yw0-f193.google.com with SMTP id p65so5219762ywb.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 15:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GqwqzkS2Mk8S3MyLu5FtnEOmo8RADKyoC/bHLW12d9s=;
        b=CNF58Lt99AMZ+T2kLHWID5TQKlMOlf/OnZhxDKXpK6ECEDfmjuu8WnkR5y3HWqhdvw
         ZI0S5ou4P1uPHMB5yb378Sk3mKnkmC2jbLcNLBCho6e1PXwXafkJ0DGURWN64mVJmyt8
         8oFQSoIzVRP0rVyhHOOQDeWesWrejrhsgbuFk+UbdVGCOXqEwgT58YG/JNLnFIOnPRIp
         2chbYdGxBOXCRPHnRs89lanUVRqttv9wdtlNyNrNs4/986whTu+w1e+zZL3uOOgEjScw
         3ZdvCCl4vYcdwhFZ2d/oq/tcWICs8GLeM9YZ0S5V/43C4HEW8q2+zrfrN8z8Df5dcZGh
         VO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GqwqzkS2Mk8S3MyLu5FtnEOmo8RADKyoC/bHLW12d9s=;
        b=Pu5mjOVshuy6O5oq0fKftiXpZyUajLqrqkSITx6Hymo+VL9oPsD+WU5kX4cVqvMVek
         h5Q1srAXC7OOVL4VgnhCFrpJtjafhm7kq2ifK1aDQOVzabqxfTaKzbZpcc0zevLrEpF5
         7dCAeIiVAumEO6GLIKE+JiLBEyziRqyTu2EhHt3z289p2ZzxNQcqj08l7Tvfu9MwuAo7
         fDWpGGAx14n0AqgEIsE+TPXeUce7RnNjfdi3Hyer72Y+w8/lBEWhjDialhiK9axhQrrF
         RXvYXTeKlGqtNZPpXy3E8EMsfP+FEgnVfLC/gi/2xqSsTl1BvWJXjBB6joCEXkP6CLy1
         qMhA==
X-Gm-Message-State: AD7BkJLtCJueabOgnJUYKyi7DgZJvqqUAKBwRo2+w53JSaxfnoze3kXEKSIvs6EONOKUwF5bfNRTe5QyXOk5MA==
X-Received: by 10.129.91.6 with SMTP id p6mr3346258ywb.325.1457650939369; Thu,
 10 Mar 2016 15:02:19 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Thu, 10 Mar 2016 15:02:19 -0800 (PST)
In-Reply-To: <xmqq60wuc5ev.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288659>

> +     if (!strcmp(k, "commit.verbose")){

> v3 did this line correctly but you somehow lost the SP between
> "){".  What happened?

I will include the SP between )) and { .

> Don't you need a test that status is not broken when the variable is
> set?

I will include the test for status too. But I am a bit confused where
should I place them? This patch triggers the possibility of a breakage
in status related to verbose but other tests related to status are in
different files. Could you tell me the filename where I should place
these test?
