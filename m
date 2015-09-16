From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 52/67] use sha1_to_hex_to() instead of strcpy
Date: Wed, 16 Sep 2015 14:59:24 -0700
Message-ID: <xmqqd1xim3er.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915160535.GZ29753@sigill.intra.peff.net>
	<xmqq1tdyowxa.fsf@gitster.mtv.corp.google.com>
	<20150916215429.GA23667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:59:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKjp-0000Gg-EE
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 23:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbbIPV7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 17:59:30 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34298 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbIPV70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 17:59:26 -0400
Received: by padhy16 with SMTP id hy16so220374976pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=X/qLgXFfiQp56saD3s5DFV+AYHeBOE+nrtMy2c+U/BY=;
        b=pF4F+xh3utm+k0D+o/jZUiBBZUNCFnMYyu6NLD7SfuxxofgJ0xNW9oJsyArlalXz3E
         UO1jXp/ljLKkbcnuZ9Fzn6YbCRnXfioITXKfZnYZ/dMRpJBD/Qx6qAqn73lO9jTiCJ0s
         XJTEka8e4T2qywmilMQRwh+YRENw7K+Cni+265uzBIXwCpgxt3ShZX4Vj0XyrPY20vbt
         YQ2kyEcgPXJ/RpHoLU2RpDTJMcn2grApTtWJEfO302KSZ8yk0SL94/LrvGNpVdTJZMDk
         g+Q/sT4VOj+pSd026Fw439lP40vBaV84xsexH2+Y8L8XN7yrjLI9gisZpd403KjHJ153
         mo4g==
X-Received: by 10.66.124.229 with SMTP id ml5mr63705676pab.77.1442440766094;
        Wed, 16 Sep 2015 14:59:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id fu4sm54350pbb.59.2015.09.16.14.59.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 14:59:25 -0700 (PDT)
In-Reply-To: <20150916215429.GA23667@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 17:54:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278075>

Jeff King <peff@peff.net> writes:

> I think we can save even more in ownbuf, which holds only octal
> modes. That was out of scope for this patch, though. :)

Sure.  Also the variable is misnamed.  It is modebuf[], I think.
