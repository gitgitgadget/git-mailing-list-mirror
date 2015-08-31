From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] date: allow any format to display local time
Date: Mon, 31 Aug 2015 12:57:35 -0700
Message-ID: <xmqqlhcrut74.fsf@gitster.mtv.corp.google.com>
References: <d3b9f8f6524e45c9fc7a3e104669572c8c4ddd8a.1440942688.git.john@keeping.me.uk>
	<xmqqtwrfweo7.fsf@gitster.mtv.corp.google.com>
	<20150831185018.GA20555@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:57:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVD3-000471-S0
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbbHaT5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:57:38 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33243 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbHaT5h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:57:37 -0400
Received: by paczk9 with SMTP id zk9so1074904pac.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dPFv5egXxAstfwHe+CRDod7ft6eJUgTfonBhGzOYp4A=;
        b=JiCuteR9nJg2wAont5dM9uej+Ikzu94Wqk4hzzF69znm5WxSZ71FJC1rcovAh6Le18
         o3Qv+GlvPNwFgGHGEkmpPX2nNpFQuMwe08r94xLQ0D7JbpQITKnsUADV2rSp38GjcyVF
         MuhM/JMbMRXaS+iEkfRxQ1QMJRPdA2E6zuIIN08S7IaQc6QqitUR2Eeho4h+bTl++aU6
         LZvObNl7Q9kxA+rPHmmqxiPnQbS+fv6wXrRTOGRsWUvHtD0ylS75tbRyvIqsVKGeOXoQ
         p+Y7kxxWWjBLJT6UwJtpJnoSd3DLumTqDzSoodSTTY7soEj6/7bNplrfxFqXf/alKFrq
         9Xlw==
X-Received: by 10.66.249.166 with SMTP id yv6mr40487545pac.126.1441051057029;
        Mon, 31 Aug 2015 12:57:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id uk6sm15647755pac.27.2015.08.31.12.57.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 12:57:36 -0700 (PDT)
In-Reply-To: <20150831185018.GA20555@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 31 Aug 2015 14:50:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276928>

Jeff King <peff@peff.net> writes:

> Yeah, my first instinct on seeing the bitfield was that it would
> probably be much simpler to keep the enum pure, and add a bit to the
> struct. A patch in that direction is below. ...

I found it a much cleaner approach from my cursory look.  John, what
do you think?
